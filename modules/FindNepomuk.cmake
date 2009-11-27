# Once done this will define
#
#  NEPOMUK_FOUND - system has Nepomuk
#  NEPOMUK_INCLUDE_DIR - the Nepomuk include directory
#  NEPOMUK_LIBRARIES - Link these to use Nepomuk
#  NEPOMUK_QUERY_LIBRARIES - Link these to use Nepomuk query
#  NEPOMUK_DEFINITIONS - Compiler switches required for using Nepomuk
#
# Nepomuk requires Soprano, so this module checks for Soprano too.
#


# Copyright (c) 2008-2009, Sebastian Trueg, <sebastian@trueg.de>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.


if (NOT DEFINED Soprano_FOUND)
  find_package(Soprano)
  include(MacroLogFeature)
  macro_log_feature(Soprano_FOUND "Soprano" "Semantic Desktop Storing" "" TRUE "" "Soprano is needed for Nepomuk")
endif (NOT DEFINED Soprano_FOUND)

if (NOT DEFINED SHAREDDESKTOPONTOLOGIES_FOUND)
  find_package(SharedDesktopOntologies)
  include(MacroLogFeature)
  macro_log_feature(SHAREDDESKTOPONTOLOGIES_FOUND "Shared desktop ontologies" "Desktop ontologies" "http://oscaf.sourceforge.net" TRUE "" "Ontologies necessary for the Nepomuk semantic desktop.")
endif (NOT DEFINED SHAREDDESKTOPONTOLOGIES_FOUND)

# Check for the following stuff independent from whether soprano has been found
# or not. This will give a better error message at the end.
find_path(NEPOMUK_INCLUDE_DIR
  NAMES
  nepomuk/global.h
  HINTS
  ${KDE4_INCLUDE_DIR}
  ${INCLUDE_INSTALL_DIR}
  )

find_library(NEPOMUK_LIBRARIES
  NAMES
  nepomuk
  HINTS
  ${KDE4_LIB_DIR}
  ${LIB_INSTALL_DIR}
  )

find_library(NEPOMUK_QUERY_LIBRARIES
  NAMES
  nepomukquery
  HINTS
  ${KDE4_LIB_DIR}
  ${LIB_INSTALL_DIR}
  )

mark_as_advanced(NEPOMUK_INCLUDE_DIR NEPOMUK_LIBRARIES NEPOMUK_QUERY_LIBRARIES)

include(FindPackageHandleStandardArgs)
# List all nepomuk and also all necessary soprano variables here, to make it 
# easier for the user to see what was missing:
find_package_handle_standard_args(Nepomuk  DEFAULT_MSG 
                                  NEPOMUK_LIBRARIES NEPOMUK_INCLUDE_DIR
                                  Soprano_FOUND SOPRANO_PLUGIN_RAPTORPARSER_FOUND SOPRANO_PLUGIN_REDLANDBACKEND_FOUND SHAREDDESKTOPONTOLOGIES_FOUND
                                  )

#to retain backward compatibility
set (Nepomuk_FOUND ${NEPOMUK_FOUND})

