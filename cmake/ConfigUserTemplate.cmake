#
# $Id$
#
# Copyright (c) 1991-2011 by P. Wessel, W. H. F. Smith, R. Scharroo, J. Luis, and F. Wobbe
# See LICENSE.TXT file for copying and redistribution conditions.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# Contact info: gmt.soest.hawaii.edu
#-------------------------------------------------------------------------------
#
# Use this file to override variables in 'ConfigDefault.cmake' on a per-user basis.
# First copy 'ConfigUserDefault.cmake' to 'ConfigUser.cmake', then edit 'ConfigUser.cmake'.
# 'ConfigUser.cmake' is not version controlled (currently listed in svn:ignore property)
#
# Note: CMake considers an empty string, "FALSE", "OFF", "NO", or any string ending
# in "-NOTFOUND" to be false. (This happens to be case-insensitive, so "False",
# "off", "no", and "something-NotFound" are all false.) Other values are true. Thus
# it matters not whether you use TRUE and FALSE, ON and OFF, or YES and NO for your
# booleans.
#

# Enforce GPL or LGPL conformity. Use this to enable routines that cannot be
# redistributed under the terms of the GPL or LGPL such as Shewchuk's
# triangulation (valid values are GPL, LGPL and off) [GPL]:
#set (LICENSE_RESTRICTED off)

# Installation path [auto]:
#set (CMAKE_INSTALL_PREFIX "prefix_path")

# Install monolithic tree instead of distribution type layout (doc and share
# separated) [on]:
#set (GMT_INSTALL_MONOLITHIC OFF)

# Set share installation path [${CMAKE_INSTALL_PREFIX}/share/gmt-<version>]:
#set (GMT_SHARE_PATH "share_path")

# Set doc installation path [${CMAKE_INSTALL_PREFIX}/share/doc/gmt-<version>]:
#set (GMT_DOC_PATH "doc_path")

# Set path to GSHHS Shoreline Database [auto]:
#set (GSHHS_ROOT "gshhs_path")

# Install documentation files from this external location instead of creating
# new PDF and HTML documents from scratch [${GMT_SOURCE_DIR}/doc_release]:
#set (GMT_INSTALL_EXTERNAL_DOC OFF)

# Set build type can be: empty, Debug, Release, RelWithDebInfo or MinSizeRel [Release]:
#set (CMAKE_BUILD_TYPE Debug)

# Set location of NetCDF (can be root directory, path to header file or path to nc-config) [auto]:
#set (NETCDF_ROOT "netcdf_install_prefix")

# Set location of GDAL (can be root directory, path to header file or path to gdal-config) [auto]:
#set (GDAL_ROOT "gdal_install_prefix")

# Set location of PCRE (can be root directory, path to header file or path to pcre-config) [auto]:
#set (PCRE_ROOT "pcre_install_prefix")

# Enable compatibility mode [FALSE]:
#set (GMT_COMPAT TRUE)

# Enable file locking [FALSE]:
#set (FLOCK TRUE)

# Configure default units (possible values are SI and US) [SI]:
#set (UNITS "US")

# Enable Matlab API [FALSE]:
#set (GMT_MATLAB TRUE)
# If Matlab is not found, point MATLAB_ROOT to its installation path, e.g.:
#set (MATLAB_ROOT /Applications/MATLAB_R2010a.app)  # MacOSX
#set (MATLAB_ROOT /opt/matlab-7sp1)                 # Linux

# Enable running examples/tests with "make check" (out-of-source)
# Need to set either DO_EXAMPLES, DO_TESTS or both and uncomment
# the following line:
#enable_testing()
#set (DO_EXAMPLES TRUE)
#set (DO_TESTS TRUE)
# Number of parallel test jobs:
#set (N_TEST_JOBS 4)

# Directory in which to install the release sources per default
# [${GMT_BINARY_DIR}/GMT-${GMT_PACKAGE_VERSION}-src]:
#set (GMT_RELEASE_PREFIX "release-src-prefix")

# Extra debugging for developers:
#add_definitions(-DDEBUG)
#set (CMAKE_C_FLAGS "-Wall -Wdeclaration-after-statement") # recommended even for release build
#set (CMAKE_C_FLAGS "-Wextra ${CMAKE_C_FLAGS}")            # extra warnings
#set (CMAKE_C_FLAGS_DEBUG -ggdb3)                          # gdb debugging symbols
#set (CMAKE_C_FLAGS_RELEASE "-ggdb3 -O2 -Wuninitialized")  # check uninitialized variables
#set (CMAKE_LINK_DEPENDS_DEBUG_MODE TRUE)                  # debug link dependencies

# This is for gcc on Solaris to avoid "relocations remain against
# allocatable but non-writable sections" problems:
#set (USER_GMTLIB_LINK_FLAGS -mimpure-text)

# Do not warn when building with Windows SDK or Visual Studio Express:
#set (CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_NO_WARNINGS ON)

# Manually select runtime library when compiling with Windows SDK or Visual
# Studio Express:
#set (CMAKE_INSTALL_SYSTEM_RUNTIME_LIBS c:/Windows/System32/msvcr100.dll)

# If your NetCDF library is static (not recommended, applies to Windows only)
#set (NETCDF_STATIC TRUE)

# If want to rename the DLLs to something else than the default (e.g. to append the bitness - Windows only)
# if (WIN32)
#	set (BITAGE 32)
#	# Detect if we are building a 32 or 64 bits version
#	if (CMAKE_SIZEOF_VOID_P EQUAL 8)
#		set(BITAGE 64)
#	endif ()
#	set (GMT_DLL_RENAME gmt_w${BITAGE})
#	set (PSL_DLL_RENAME psl_w${BITAGE})
# endif(WIN32)

# vim: textwidth=78 noexpandtab tabstop=2 softtabstop=2 shiftwidth=2
