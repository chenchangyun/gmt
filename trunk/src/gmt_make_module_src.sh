#!/bin/bash
#
# $Id$
#
# Copyright (c) 2012-2013
# by P. Wessel, W. H. F. Smith, R. Scharroo, J. Luis, and F. Wobbe
# See LICENSE.TXT file for copying and redistribution conditions.
#
# Below, <X> is either core, suppl, or a users custom shared lib tag
#
# Run this script after adding a new GMT <X> module and updating the file
# gmt_<X>_moduleinfo.txt in order to generate two files:
# gmt_<X>_module.h and gmt_<X>_module.c.
#
# Note: gmt_<X>_module.h and gmt_<X>_module.c are in svn.
#

if [ $# -ne 1 ]; then
cat << EOF
usage: gmt_make_module_src.sh tag
	tag is the name of the set of modules.
	It is core or suppl for the GMT developers;
	It is whatever you call it for your custom extension.
EOF
	exit 0
fi
set -e

# Make sure we get both upper- and lower-case versions of the tag
U_TAG=`echo $1 | tr '[a-z]' '[A-Z]'`
L_TAG=`echo $1 | tr '[A-Z]' '[a-z]'`
FILE_MODULEINFO=gmt_${L_TAG}_moduleinfo.txt

if [ ! -f $FILE_MODULEINFO ]; then
	echo "gmt_make_module_src.sh: Cannot find $FILE_MODULEINFO - Aborting"
	exit -1
fi

FILE_GMT_MODULE_C=gmt_${L_TAG}_module.c
FILE_GMT_MODULE_H=gmt_${L_TAG}_module.h
FILE_GMT_MODULE_TROFF=explain_gmt_${L_TAG}_modules.txt
COPY_YEAR=$(date +%Y)
LIB_STRING=`grep LIB_STRING $FILE_MODULEINFO | awk -F= '{print $NF}'`
#
# Generate FILE_GMT_MODULE_H
#

cat << EOF > ${FILE_GMT_MODULE_H}
/* \$Id\$
 *
 * Copyright (c) 2012-${COPY_YEAR}
 * by P. Wessel, W. H. F. Smith, R. Scharroo, J. Luis, and F. Wobbe
 * See LICENSE.TXT file for copying and redistribution conditions.
 */

/* gmt_${L_TAG}_module.h declares the prototypes for ${L_TAG} module functions
 * and the array that contains ${L_TAG} GMT module parameters such as name
 * and purpose strings.
 * DO NOT edit this file directly! Instead edit gmt_${L_TAG}_moduleinfo.txt
 * and regenerate this file with gmt_make_module_src.sh ${L_TAG}. */

#pragma once
#ifndef _GMT_${U_TAG}_MODULE_H
#define _GMT_${U_TAG}_MODULE_H

#ifdef __cplusplus /* Basic C++ support */
extern "C" {
#endif

/* CMake definitions: This must be first! */
#include "gmt_config.h"

/* Declaration modifiers for DLL support (MSC et al) */
#include "declspec.h"

/* Prototypes of all modules in the GMT ${L_TAG} library */
EOF
gawk '
	BEGIN {
		FS = "\t";
	}
	!/^[ \t]*#/ {
		printf "EXTERN_MSC int GMT_%s (void *API, int mode, void *args);\n", $1;
	}' $FILE_MODULEINFO >> ${FILE_GMT_MODULE_H}
cat << EOF >> ${FILE_GMT_MODULE_H}

/* Pretty print all modules in the GMT ${L_TAG} library and their purposes */
EXTERN_MSC void gmt_${L_TAG}_module_show_all (struct GMTAPI_CTRL *API);

#ifdef __cplusplus
}
#endif

#endif /* !_GMT_${U_TAG}_MODULE_H */
EOF

#
# Generate FILE_GMT_MODULE_C
#

cat << EOF > ${FILE_GMT_MODULE_C}
/* \$Id\$
 *
 * Copyright (c) 2012-${COPY_YEAR}
 * by P. Wessel, W. H. F. Smith, R. Scharroo, J. Luis, and F. Wobbe
 * See LICENSE.TXT file for copying and redistribution conditions.
 */

/* gmt_${L_TAG}_module.c populates the external array of GMT ${L_TAG}
 * module parameters such as name, group and purpose strings.
 * This file also contains the following convenience function to
 * display all module purposes:
 *
 *   void gmt_${L_TAG}_module_show_all (struct GMTAPI_CTRL *API);
 *
 * DO NOT edit this file directly! Instead edit gmt_${L_TAG}_moduleinfo.txt
 * and regenerate this file with gmt_make_module_src.sh ${L_TAG} */

#include <stdio.h>
#include <string.h>

#include "gmt_dev.h"

/* Sorted array with information for all GMT ${L_TAG} modules */

struct Gmt_moduleinfo g_${L_TAG}_module[] = {
EOF

# $1 = name, $2 = ${L_TAG}, $3 = purpose
gawk '
	BEGIN {
		FS = "\t";
	}
	!/^[ \t]*#/ {
		printf "\t{\"%s\", \"%s\", \"%s\"},\n", $1, $2, $3;
	}' ${FILE_MODULEINFO} >> ${FILE_GMT_MODULE_C}

cat << EOF >> ${FILE_GMT_MODULE_C}
	{NULL, NULL, NULL} /* last element == NULL detects end of array */
};

/* Pretty print all GMT ${L_TAG} module names and their purposes */
void gmt_${L_TAG}_module_show_all (struct GMTAPI_CTRL *API) {
	unsigned int module_id = 0;
	char module_name_comp[GMT_TEXT_LEN64], message[GMT_TEXT_LEN256];

	GMT_Message (API, GMT_TIME_NONE, "\n" $LIB_STRING "\n\n");
	GMT_Message (API, GMT_TIME_NONE, "Program                 Purpose of Program\n");
	while (g_${L_TAG}_module[module_id].name != NULL) {
		snprintf (module_name_comp, GMT_TEXT_LEN64, "%s [%s]",
				g_${L_TAG}_module[module_id].name, g_${L_TAG}_module[module_id].component);
		sprintf (message, "%-23s %s\n",
				module_name_comp, g_${L_TAG}_module[module_id].purpose);
		GMT_Message (API, GMT_TIME_NONE, message);
		++module_id;
	}
}
EOF

exit 0

# vim: set ft=c:
