#========================================================================
# Author: Benjamin A Thomas
# Author: Kris Thielemans
# Author: Edoardo Pasca
# Copyright 2017, 2018 University College London
# Copyright 2017 STFC
#
# This file is part of the CCP PETMR Synergistic Image Reconstruction Framework (SIRF) SuperBuild.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#=========================================================================

#This needs to be unique globally
set(proj siemens_to_ismrmrd)

# Set dependency list
set(${proj}_DEPENDENCIES "Boost;HDF5;ISMRMRD")
# TODO should add LibXml2, LibXslt

# Include dependent projects if any
ExternalProject_Include_Dependencies(${proj} DEPENDS_VAR ${proj}_DEPENDENCIES)

# Set external name (same as internal for now)
set(externalProjName ${proj})

if(NOT ( DEFINED "USE_SYSTEM_${externalProjName}" AND "${USE_SYSTEM_${externalProjName}}" ) )
  message(STATUS "${__indent}Adding project ${proj}")

  ### --- Project specific additions here
  set(siemens_to_ismrmrd_Install_Dir ${SUPERBUILD_INSTALL_DIR})

  set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} ${SUPERBUILD_INSTALL_DIR})
  set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} ${SUPERBUILD_INSTALL_DIR})

  ExternalProject_Add(${proj}
    ${${proj}_EP_ARGS}
    GIT_REPOSITORY ${${proj}_URL}
    GIT_TAG ${${proj}_TAG}
    SOURCE_DIR ${SOURCE_DOWNLOAD_CACHE}/${proj}

    CMAKE_ARGS
        -DCMAKE_PREFIX_PATH=${SUPERBUILD_INSTALL_DIR}
        -DCMAKE_LIBRARY_PATH=${SUPERBUILD_INSTALL_DIR}/lib
        -DCMAKE_INCLUDE_PATH=${SUPERBUILD_INSTALL_DIR}
        -DCMAKE_INSTALL_PREFIX=${siemens_to_ismrmrd_Install_Dir}
        -DBOOST_INCLUDEDIR=${BOOST_ROOT}/include/
        -DBOOST_LIBRARYDIR=${BOOST_LIBRARY_DIR}
        -DISMRMRD_DIR=${ISMRMRD_DIR}
	    INSTALL_DIR ${siemens_to_ismrmrd_Install_Dir}
    DEPENDS
        ${${proj}_DEPENDENCIES}
  )

    set(siemens_to_ismrmrd_ROOT        ${siemens_to_ismrmrd_SOURCE_DIR})
    set(siemens_to_ismrmrd_INCLUDE_DIR ${siemens_to_ismrmrd_SOURCE_DIR})

   else()
      if(${USE_SYSTEM_${externalProjName}})
        find_package(${proj} ${${externalProjName}_REQUIRED_VERSION} REQUIRED)
        message("USING the system ${externalProjName}, set ${externalProjName}_DIR=${${externalProjName}_DIR}")
    endif()
    ExternalProject_Add_Empty(${proj} DEPENDS "${${proj}_DEPENDENCIES}")
  endif()

  mark_as_superbuild(
    VARS
      ${externalProjName}_DIR:PATH
    LABELS
      "FIND_PACKAGE"
  )
