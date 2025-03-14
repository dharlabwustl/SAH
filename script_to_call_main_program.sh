#!/bin/bash
SESSION_ID=${1}
export XNAT_USER=${2}
export XNAT_PASS=${3}
export XNAT_HOST=${4}
TYPE_OF_PROGRAM=${5}
# Check if '::' is present
input=$XNAT_HOST ##"one::two::three::four"
# Check if '::' is present
if echo "$input" | grep -q "+"; then
  # Set the delimiter
  IFS='+'

  # Read the split words into an array
  read -ra ADDR <<< "$input"
  export XNAT_HOST=${ADDR[0]} 
  SUBTYPE_OF_PROGRAM=${ADDR[1]} 
else
export XNAT_HOST=${XNAT_HOST} 
    echo "'+' is not present in the string"
fi
echo ${TYPE_OF_PROGRAM}::TYPE_OF_PROGRAM

if [[ ${TYPE_OF_PROGRAM} == 1 ]] ;
then
  echo " I AM HERE ${0}"
  echo " I AM WORKING"
    /software/sah_ct_segmentation.sh $SESSION_ID $XNAT_USER $XNAT_PASS $XNAT_HOST /input /output
fi
##################
if [[ ${TYPE_OF_PROGRAM} == 'PROJECT_LEVEL' ]]; then
echo "I AM HERE"

if [[ ${SUBTYPE_OF_PROGRAM} == 'PROJECT_LEVEL_SAH_SEG' ]] ;
then
/software/project_level_sah_seg.sh $SESSION_ID $XNAT_USER $XNAT_PASS "${ADDR[0]}"  "${ADDR[2]}" "${ADDR[3]}" /input /output

fi
fi 

#if [[ ${TYPE_OF_PROGRAM} == 3 ]] ;
#then
#    /software/ct_ich_segmentation.sh $SESSION_ID $XNAT_USER $XNAT_PASS $XNAT_HOST /input /output
#fi

#if [[ ${TYPE_OF_PROGRAM} == 1 ]] ;
#then
#    /software/dicom2nifti_call_sessionlevel_selected.sh  ${SESSION_ID} $XNAT_USER $XNAT_PASS $XNAT_HOST
#fi
