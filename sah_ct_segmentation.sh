#!/bin/bash
export XNAT_USER=${2}
export XNAT_PASS=${3}
export XNAT_HOST=${4}
sessionID=${1}
working_dir=/workinginput
output_directory=/workingoutput

final_output_directory=/outputinsidedocker

copyoutput_to_snipr() {
  sessionID=$1
  scanID=$2
  resource_dirname=$4 #"MASKS" #sys.argv[4]
  file_suffix=$5
  output_dir=$3
  echo " I AM IN copyoutput_to_snipr "
  /opt/conda/envs/pytorch1.12/bin/python -c "
import sys 
sys.path.append('/software');
from download_with_session_ID import *; 
uploadfile()" ${sessionID} ${scanID} ${output_dir} ${resource_dirname} ${file_suffix} # ${infarctfile_present}  ##$static_template_image $new_image $backslicenumber #$single_slice_filename

}

copy_masks_data() {
  echo " I AM IN copy_masks_data "
  # rm -r /ZIPFILEDIR/*
  sessionID=${1}
  scanID=${2}
  resource_dirname=${3} #str(sys.argv[4])
  output_dirname=${4}   #str(sys.argv[3])
  echo output_dirname::${output_dirname}
  /opt/conda/envs/pytorch1.12/bin/python -c "
import sys 
sys.path.append('/software');
from download_with_session_ID import *; 
downloadfiletolocaldir()" ${sessionID} ${scanID} ${resource_dirname} ${output_dirname} ### ${infarctfile_present}  ##$static_template_image $new_image $backslicenumber #$single_slice_filename

}

copy_allfiles_data() {
  echo " I AM IN copy_masks_data "
  # rm -r /ZIPFILEDIR/*
  sessionID=${1}
  scanID=${2}
  resource_dirname=${3} #str(sys.argv[4])
  output_dirname=${4}   #str(sys.argv[3])
  echo output_dirname::${output_dirname}
  /opt/conda/envs/pytorch1.12/bin/python -c "
import sys
sys.path.append('/software');
from download_with_session_ID import *;
downloadallfiletolocaldir()" ${sessionID} ${scanID} ${resource_dirname} ${output_dirname} ### ${infarctfile_present}  ##$static_template_image $new_image $backslicenumber #$single_slice_filename

}

#copy_scan_data() {
#		echo " I AM IN copy_scan_data "
## rm -r /ZIPFILEDIR/*
## rm -r ${working_dir}/*
## rm -r ${output_dir}/*
#sessionID=$1
#dir_to_receive_the_data=${2}
#resource_dir=${3}
#    # sessionId=sys.argv[1]
#    # dir_to_receive_the_data=sys.argv[2]
#    # resource_dir=sys.argv[3]
## scanID=$2
#python -c "
#import sys
#sys.path.append('/Stroke_CT_Processing');
#from download_with_session_ID import *;
#get_relevantfile_in_A_DIRECTORY()" ${sessionID}  ${dir_to_receive_the_data} ${resource_dir}
#
#}

# #####################################################
get_nifti_scan_uri() {
  # csvfilename=sys.argv[1]
  # dir_to_save=sys.argv[2]
  # echo " I AM IN copy_scan_data "
  # rm -r /ZIPFILEDIR/*

  sessionID=$1
  working_dir=${2}
  output_csvfile=${3}
  rm -r ${working_dir}/*
  output_dir=$(dirname ${output_csvfile})
  rm -r ${output_dir}/*
  # scanID=$2
  /opt/conda/envs/pytorch1.12/bin/python -c "
import sys 
sys.path.append('/software');
from download_with_session_ID import *; 
call_decision_which_nifti()" ${sessionID} ${working_dir} ${output_csvfile}

}

copy_scan_data() {
  csvfilename=${1} #sys.argv[1]
  dir_to_save=${2} #sys.argv[2]
  # 		echo " I AM IN copy_scan_data "
  # rm -r /ZIPFILEDIR/*
  # rm -r ${working_dir}/*
  # rm -r ${output_dir}/*
  # sessionID=$1
  # # scanID=$2
  /opt/conda/envs/pytorch1.12/bin/python -c "
import sys 
sys.path.append('/software');
from download_with_session_ID import *; 
downloadniftiwithuri_withcsv()" ${csvfilename} ${dir_to_save}

}

getmaskfilesscanmetadata() {
  # def get_maskfile_scan_metadata():
  sessionId=${1}           #sys.argv[1]
  scanId=${2}              # sys.argv[2]
  resource_foldername=${3} # sys.argv[3]
  dir_to_save=${4}         # sys.argv[4]
  csvfilename=${5}         # sys.argv[5]
  /opt/conda/envs/pytorch1.12/bin/python -c "
import sys 
sys.path.append('/software');
from download_with_session_ID import *; 
get_maskfile_scan_metadata()" ${sessionId} ${scanId} ${resource_foldername} ${dir_to_save} ${csvfilename}
}

########################################################################
# GET THE SINGLE CT NIFTI FILE NAME AND COPY IT TO THE WORKING_DIR
#niftifile_csvfilename=${working_dir}/'this_session_final_ct.csv'
#get_nifti_scan_uri ${sessionID} ${working_dir} ${niftifile_csvfilename}
#######################################
call_download_files_in_a_resource_in_a_session_arguments=('call_download_files_in_a_resource_in_a_session' ${sessionID} "NIFTI_LOCATION" ${working_dir})
outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_download_files_in_a_resource_in_a_session_arguments[@]}")
echo '$outputfiles_present'::$outputfiles_present
########################################
yasheng_code_input_dir='/software/SAH_SEGMEN_FROM_YASHENG/images_input'
#cp ${yasheng_code_input_dir}/*.nii ${working_dir}/
for niftifile_csvfilename in ${working_dir}/*NIFTILOCATION.csv; do
  #  outputfiles_present=0
  echo $niftifile_csvfilename
  #  scanID=${array[2]}

  echo sessionId::${sessionID}
  #  echo scanId::${scanID}
  resource_foldername="SAH_SEGM"
  call_check_if_a_file_exist_in_snipr_arguments=('call_check_if_a_file_exist_in_snipr' ${sessionID} ${scanID} ${resource_foldername} _resaved.nii.gz _resaved_4DL_normalized.nii.gz _resaved_levelset.nii.gz _resaved_4DL_seg.nii.gz _resaved_levelset_bet.nii.gz manual_splits.txt _resaved_4DL_normalized.nii.gz_csf_3.nii.gz _resaved_4DL_normalized.nii.gz_infarct.nii.gz _resaved_4DL_normalized.nii.gz_csf_4.nii.gz _resaved_4DL_normalized.nii.gz_csf_8.nii.gz _resaved_4DL_normalized.nii.gz_csf_1.nii.gz _resaved_4DL_normalized.nii.gz_csf_6.nii.gz _resaved_4DL_normalized.nii.gz_csf_2.nii.gz _resaved_4DL_normalized.nii.gz_csf_5.nii.gz _resaved_4DL_normalized.nii.gz_csf_7.nii.gz _resaved_4DL_normalized.nii.gz_csf_9.nii.gz _resaved_4DL_normalized.nii.gz_csf_10.nii.gz)
  outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_check_if_a_file_exist_in_snipr_arguments[@]}")
  echo "outputfiles_present:: "${outputfiles_present: -1}"::outputfiles_present"
  if [[ "${outputfiles_present: -1}" -eq 0 ]]; then
    while IFS=',' read -ra array; do
      ### DOWNLOAD THE PREPROCESSED FILES
      resource_foldername=PREPROCESS_SEGM

      URI=${array[0]}
      filename=${array[1]}
      #      echo URI::${URI}
      scanID=${array[2]}
      #################################################
      #      URI=args.stuff[1] #sys.argv[1]
      # print("URI::{}".format(URI))
      #      URI=URI.split('/resources')[0]
      # print("URI::{}".format(URI))
      resource_dir="PREPROCESS_SEGM"                       #sys.argv[2]
      dir_to_receive_the_data=${working_dir}               #sys.argv[3]
      output_csvfile=${filename%.nii*}_PREPROCESS_SEGM.csv #sys.argv[4]
      call_get_resourcefiles_metadata_saveascsv_args_arguments=('call_get_resourcefiles_metadata_saveascsv_args' ${URI} ${resource_dir} ${dir_to_receive_the_data} ${output_csvfile})
      outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_get_resourcefiles_metadata_saveascsv_args_arguments[@]}")
      ################################################
      while IFS=',' read -ra array1; do
        URI_1=${array1[6]} #if [[ "$string" == *"$Substring"* ]]
        #          echo URI_1_1::${URI_1}
        if [[ ${URI_1} == *"seg.nii.gz"* ]] || [[ ${URI_1} == *"normalized.nii.gz"* ]]; then
          echo URI_1::${URI_1}
          filename=${array1[8]}
          echo filename::${filename}
          call_download_a_singlefile_with_URIString_arguments=('call_download_a_singlefile_with_URIString' ${URI_1} ${filename} ${yasheng_code_input_dir})
          outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_download_a_singlefile_with_URIString_arguments[@]}")

        fi

      done < <(tail -n +2 "${dir_to_receive_the_data}/${output_csvfile}")

      #      call_download_a_singlefile_with_URIString_arguments=('call_download_a_singlefile_with_URIString' ${URI} ${filename} ${yasheng_code_input_dir})
      #      outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_download_a_singlefile_with_URIString_arguments[@]}")
      #      /software/SAH_SEGMEN_FROM_YASHENG/ppredict.sh
    done < <(tail -n +2 "${niftifile_csvfilename}")
  fi

  #  /software/SAH_SEGMEN_FROM_YASHENG/ppredict.sh
  url=${URI_1%/resource*}
  echo "url::"${url}
    resource_dirname="SAH_SEGM"
    for x in /software/SAH_SEGMEN_FROM_YASHENG/results_cistern/*.*; do
      x_new=${x%.nii*}_cistern.nii.gz
      file_name=${x_new}
      call_uploadsinglefile_with_URI_arguments=('call_uploadsinglefile_with_URI' ${url} ${file_name} ${resource_dirname})
      outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_uploadsinglefile_with_URI_arguments[@]}")
    done
    for x in /software/SAH_SEGMEN_FROM_YASHENG/results_sulcal/*.*; do
      x_new=${x%.nii*}_sulcal.nii.gz
      file_name=${x_new}
      call_uploadsinglefile_with_URI_arguments=('call_uploadsinglefile_with_URI' ${url} ${file_name} ${resource_dirname})
      outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_uploadsinglefile_with_URI_arguments[@]}")
    done
    for x in /software/SAH_SEGMEN_FROM_YASHENG/results_ventri/*.*; do
      x_new=${x%.nii*}_ventri.nii.gz
      file_name=${x_new}
      call_uploadsinglefile_with_URI_arguments=('call_uploadsinglefile_with_URI' ${url} ${file_name} ${resource_dirname})
      outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_uploadsinglefile_with_URI_arguments[@]}")
    done
    for x in /software/SAH_SEGMEN_FROM_YASHENG/results_total/*.*; do
      x_new=${x%.nii*}_total.nii.gz
      file_name=${x_new}
      call_uploadsinglefile_with_URI_arguments=('call_uploadsinglefile_with_URI' ${url} ${file_name} ${resource_dirname})
      outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_uploadsinglefile_with_URI_arguments[@]}")
    done

    #  cp ${yasheng_code_input_dir}/*.* ${output_directory}/ ##*.
    #  cp /software/SAH_SEGMEN_FROM_YASHENG/results_cistern/*.*  ${output_directory}/
    #  cp /software/SAH_SEGMEN_FROM_YASHENG/results_sulcal/*.*  ${output_directory}/
    #  cp /software/SAH_SEGMEN_FROM_YASHENG/results_ventri/*.*   ${output_directory}/
    #  cp /software/SAH_SEGMEN_FROM_YASHENG/results_total/*.*  ${output_directory}/
done
#  #  outputfiles_present=0
#  ##  while IFS=',' read -ra array; do
#  ##    scanID=${array[2]}
#  ##
#  ###    echo sessionId::${sessionID}
#  ###    echo scanId::${scanID}
#  ##        echo ${array[3]}
#  ##        echo ${array[4]}
#  ##        echo ${array[1]}
#  ##    resource_foldername="SAH_SEGM"
#  ##    ### check if the file exists:
#  ##    call_check_if_a_file_exist_in_snipr_arguments=('call_check_if_a_file_exist_in_snipr' ${sessionID} ${scanID} ${resource_foldername} _resaved.nii.gz _resaved_4DL_normalized.nii.gz _resaved_levelset.nii.gz _resaved_4DL_seg.nii.gz _resaved_levelset_bet.nii.gz manual_splits.txt _resaved_4DL_normalized.nii.gz_csf_3.nii.gz _resaved_4DL_normalized.nii.gz_infarct.nii.gz _resaved_4DL_normalized.nii.gz_csf_4.nii.gz _resaved_4DL_normalized.nii.gz_csf_8.nii.gz _resaved_4DL_normalized.nii.gz_csf_1.nii.gz _resaved_4DL_normalized.nii.gz_csf_6.nii.gz _resaved_4DL_normalized.nii.gz_csf_2.nii.gz _resaved_4DL_normalized.nii.gz_csf_5.nii.gz _resaved_4DL_normalized.nii.gz_csf_7.nii.gz _resaved_4DL_normalized.nii.gz_csf_9.nii.gz _resaved_4DL_normalized.nii.gz_csf_10.nii.gz)
#  ##    outputfiles_present=$(/opt/conda/envs/pytorch1.12/bin/python download_with_session_ID.py "${call_check_if_a_file_exist_in_snipr_arguments[@]}")
#  ##  done < <(tail -n +2 "${niftifile_csvfilename}")
#  ##  ################################################
#  #  outputfiles_present=${outputfiles_present}0
#  #  echo "outputfiles_present:: "${outputfiles_present: -1}"::outputfiles_present"
#  #  #echo "outputfiles_present::ATUL${outputfiles_present}::outputfiles_present"
#  #  outputfiles_present="0000000000"
#  #  if [[ "${outputfiles_present: -1}" -eq 0 ]]; then
#  #
#  #    echo "outputfiles_present:: "${outputfiles_present: -1}"::outputfiles_present"
#  ##    copy_scan_data ${niftifile_csvfilename} ${working_dir}
#  #    working_dir=/workinginput
#  #    output_directory=/workingoutput
#  #
#  #    final_output_directory=/outputinsidedocker
#  #
#  #    while IFS=',' read -ra array; do
#  #      scanID=${array[2]}
#  #      echo sessionId::${sessionID}
#  #      echo scanId::${scanID}
#  #      echo ${array[3]}
#  #      echo ${array[4]}
#  #      echo ${array[1]}
#  #    done < <(tail -n +2 "${niftifile_csvfilename}")
#  #    #    resource_dirname='NIFTI'
#  #    #    output_dirname=${working_dir}
#  #    #
#  #    #    echo working_dir::${working_dir}
#  #    #    echo output_dirname::${output_dirname}
#  #    #    output_dirname=/software/SAH_SEGMEN_FROM_YASHENG/images_input
#  #    #    copy_allfiles_data ${sessionID} ${scanID} ${resource_dirname} ${output_dirname}
#  #    #    ####################
#  #    #    #/bin/bash -i -c
#  #    #    #/root/anaconda3/bin/conda activate tf
#  #    #    /software/SAH_SEGMEN_FROM_YASHENG/ppredict.sh  #${working_dir} ${output_directory}
#  #    #
#  #    ##    ######################################################################################################################
#  #    ##    #/root/anaconda3/bin/conda deactivate
#  #    ##    for file in ${output_directory}/*; do
#  #    ##      cp $file ${final_output_directory}/
#  #    ##    done
#  #    ##
#  #    ##    ######################################################################################################################
#  #    ##    # COPY IT TO THE SNIPR RESPECTIVE SCAN RESOURCES
#  #    ##
#  #    ##    snipr_output_foldername="SAH_SEGM"
#  #    ##    file_suffixes=(.nii.gz .nii .txt) #sys.argv[5]
#  #    ##    for file_suffix in ${file_suffixes[@]}; do
#  #    ##      echo "COPYING FILES TO ${snipr_output_foldername} "
#  #    ##      copyoutput_to_snipr ${sessionID} ${scanID} "${final_output_directory}" ${snipr_output_foldername} ${file_suffix}
#  #    ##    done
#  #    ##    ######################################################################################################################
#  #    ##
#  #    ##    ######################################################################################################################
#  #    ##    echo " FILES NOT PRESENT I AM WORKING ON IT"
#  #    ##  else
#  #    ##    echo " FILES ARE PRESENT "
#  #    ##  ######################################################################################################################
#  #  fi
#  #  #  rm ${final_output_directory}/*.*
#done
#################################################################################################################
##
#### GET THE RESPECTIVS MASKS NIFTI FILE NAME AND COPY IT TO THE WORKING_DIR
##
#######################################################################################
##resource_dirname='MASKS'
##output_dirname=${working_dir}
#
##echo working_dir::${working_dir}
##echo output_dirname::${output_dirname}
##copy_masks_data   ${sessionID}  ${scanID} ${resource_dirname} ${output_dirname}
########################################################################################################################
#### CALCULATE EDEMA BIOMARKERS
##nwucalculation_each_scan
########################################################################################################################
#### COPY IT TO THE SNIPR RESPECTIVE SCAN RESOURCES
##snipr_output_foldername="EDEMA_BIOMARKER"
##file_suffixes=(  .pdf .mat .csv ) #sys.argv[5]
##for file_suffix in ${file_suffixes[@]}
##do
##    copyoutput_to_snipr  ${sessionID} ${scanID} "${final_output_directory}"  ${snipr_output_foldername}  ${file_suffix}
##done
########################################################################################################################
