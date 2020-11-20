#!/bin/bash
#
# Update : Feb. 2019
# G. Cambon : Sept. 2016
#

#==========================================================================================
# BEGIN USER SECTION
#
#
SOURCES_DIR=${CROCO_DIR}'/croco/'
TOOLS_DIR=${CROCO_DIR}'/croco_tools/'
#
MY_CONFIG_PATH=${CROCO_DIR}
#
# Name of the configuration directory defined by the use
MY_CONFIG_NAME=${MY_CONFIG_NAME:-'Run'}
#
#
# END USER SECTION
#==========================================================================================
#set -x

while getopts :h V
do
  case $V in
    (h) echo "";
    echo " Script to setup your own croco configuration.";
    echo " ";
    echo " What is does :";
    echo " - Copy the original croco/OCEAN cppdefs.h, param.h and *.in files needed";
    echo " - Copy the original crocotools_param.m and start.m file from croco_tools/";
    echo " - Copy the original run_croco*.bash file from croco_tools/Pluriannual_scripts/";
    echo "";
    echo "Edit the USER SECTION of the script to define the following variables :";
    echo " - SOURCES_DIR     : location of croco directory";
    echo " - TOOLS_DIR       : location of croco_tools directory";
    echo " - MY_CONFIG_PATH  : location of the repository to store the configuration";
    echo " - MY_CONFIG_NAME  : name of the configuration ";    
    exit 0;;
  esac
done

# Check if source are there
if [ ! -d $SOURCES_DIR ]; then 
	echo 'Directory for croco not found ...'
	echo 'Check the SOURCES_DIR variable ...'
	echo 'Exiting ...'
   exit 1
fi

# Check if tools are there
if [ ! -d $TOOLS_DIR ]; then 
	echo 'Directory for croco_tools not found ...'
	echo 'Check the TOOLS_DIR variable ...'
	echo 'Exiting ...'
   exit 2
fi
 
# Create the directory
if [ ! -d $MY_CONFIG_PATH ]; then 
    mkdir $MY_CONFIG_PATH
    if [ ! -d $MY_CONFIG_PATH'/'$MY_CONFIG_NAME ]; then
	mkdir $MY_CONFIG_PATH'/'$MY_CONFIG_NAME
	copy_tag=1
    else
	echo 'Already a configuration exists ...'
	echo 'Check the configuration directory ' $MY_CONFIG_PATH'/'$MY_CONFIG_NAM
	copy_tag=0
    fi
else
    if [ ! "$(ls -A $MY_CONFIG_PATH'/'$MY_CONFIG_NAME)"  ]; then
	copy_tag=1
    else
	echo 'Already a configuration exists ...'
	echo 'Check the configuration directory ' $MY_CONFIG_PATH'/'$MY_CONFIG_NAM
	copy_tag=0
    fi
fi

if [[ $copy_tag == 1 ]] ; then
    
# Copy the files from croco/
    echo '=> Copy the file from '$SOURCES_DIR ' and ' $TOOLS_DIR 
    echo '   needed to setup your own simulations'
    echo '         '
    
    cd $MY_CONFIG_PATH'/'$MY_CONFIG_NAME
    mkdir Misc TEST_CASES NAMELIST_OANALYSIS CROCO_FILES SCRATCH DATA
    
    #OCEAN
    DIRO='OCEAN'
    cp -Rf $SOURCES_DIR/$DIRO/jobcomp .
    cp -Rf $SOURCES_DIR/$DIRO/param.h .
    cp -Rf $SOURCES_DIR/$DIRO/cppdefs.h .
    cp -Rf $SOURCES_DIR/$DIRO/croco.in .
    cp -Rf $SOURCES_DIR/$DIRO/croco.in.1 .
    cp -Rf $SOURCES_DIR/$DIRO/croco_inter.in .
    cp -Rf $SOURCES_DIR/$DIRO/sediment.in .
    cp -Rf $SOURCES_DIR/$DIRO/croco_forecast.in Misc/
    cp -Rf $SOURCES_DIR/$DIRO/croco_hindcast.in Misc/
    cp -Rf $SOURCES_DIR/$DIRO/croco_stations.in Misc/
    
    #PISCES
    cp -Rf $SOURCES_DIR/PISCES/namelist_pisces .

    # XIOS
    DIRO='XIOS'
    cp -Rf $SOURCES_DIR/$DIRO/iodef.xml* .
    cp -Rf $SOURCES_DIR/$DIRO/domain_def.xml* .
    cp -Rf $SOURCES_DIR/$DIRO/field_def.xml_full* . 
    cp -Rf $SOURCES_DIR/$DIRO/xios_launch.file .
    cp -Rf $SOURCES_DIR/$DIRO/README_XIOS .

    # TEST_CASE + NAMELIST_OANALYSIS
    cp -Rf $SOURCES_DIR/TEST_CASES .
    cp -Rf $SOURCES_DIR/SCRIPTS/NAMELIST_OANALYSIS .
    cp -Rf $SOURCES_DIR/SCRIPTS/Plurimonths_scripts/*.bash .
    
    echo '=> Copy from '$SOURCES_DIR ' done'
    echo '         '
    # Link the files from croco_tools/
    # for crocotools in matlab
    cp -Rf $TOOLS_DIR/start.m .
    cp -Rf $TOOLS_DIR/crocotools_param.m .
    cp -Rf $TOOLS_DIR/Town/town.dat Misc/
    #

    cp -Rf $SOURCES_DIR/create_run.bash create_run.bash.BCK
    cd -
    #
    echo '=> Copy from '$TOOLS_DIR ' done'
    
fi
