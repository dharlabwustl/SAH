#!/bin/bash
SESSION_ID=${1}
export XNAT_USER=${2}
export XNAT_PASS=${3}
export XNAT_HOST=${4}
TYPE_OF_PROGRAM=${5}
echo ${TYPE_OF_PROGRAM}::TYPE_OF_PROGRAM

if [[ ${TYPE_OF_PROGRAM} == 2 ]] ;
then
    /software/ct_segmentation.sh $SESSION_ID $XNAT_USER $XNAT_PASS $XNAT_HOST /input /output
fi

if [[ ${TYPE_OF_PROGRAM} == 3 ]] ;
then
    /software/ct_ich_segmentation.sh $SESSION_ID $XNAT_USER $XNAT_PASS $XNAT_HOST /input /output
fi

#if [[ ${TYPE_OF_PROGRAM} == 1 ]] ;
#then
#    /software/dicom2nifti_call_sessionlevel_selected.sh  ${SESSION_ID} $XNAT_USER $XNAT_PASS $XNAT_HOST
#fi
