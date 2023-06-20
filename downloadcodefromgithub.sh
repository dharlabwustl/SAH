#!/bin/bash
export MCR_CACHE_ROOT=/workinginput
export XNAT_HOST=${4}
cd /software/
rm -r /software/*
git_link=${5}
git clone ${git_link}
y=${git_link%.git}
git_dir=$(basename $y)
#find /software/${git_dir}/* -type f -exec sed -i "s/python/\/root\/anaconda3\/envs\/tf\/bin\/python'/g" {} \;
#find /software/${git_dir}/* -type f -exec sed -i "s/python/\/root\/anaconda3\/envs\/tf\/bin\/python'/g" {} \;
mv ${git_dir}/* /software/
cp -r  /Stroke_CT_Segmentation /software/
chmod +x /software/Stroke_CT_Segmentation/*.sh
chmod +x /software/*.sh
for x in  /software/Stroke_CT_Segmentation/*/* ; do chmod +x $x ; done
for x in  /software/Stroke_CT_Segmentation/* ; do chmod +x $x ; done
find /software/Stroke_CT_Segmentation/* -type f -exec sed -i "s/\/Stroke_CT_Segmentation/\/software\/Stroke_CT_Segmentation/g" {} \;
find /software/Stroke_CT_Segmentation/* -type f -exec sed -i "s/python/\/opt\/conda\/envs\/tf\/bin\/python/g" {} \;
#find /software/Stroke_CT_Segmentation/* -type f -exec sed -i "s/python/\/root\/anaconda3\/envs\/tf\/bin\/python/g" {} \;
##############################YASHENG'S HEMORRHAGE SEGMENTATION CODE ##################################################
git_link_yasheng='https://github.com/yasheng-chen/unet_ich_edema.git'
git clone ${git_link_yasheng}
y1=${git_link_yasheng%.git}
git_dir1=$(basename $y1)
cp /software/ich_IO.py ${git_dir1}/IO.py
cp /software/ich_ppredict.sh ${git_dir1}/ppredict.sh
chmod +x /software/unet_ich_edema/*.sh
#chmod +x /software/unet_ich_edema/*.sh
for x in  /software/unet_ich_edema/*/* ; do chmod +x $x ; done
#for x in  /software/unet_ich_edema/* ; do chmod +x $x ; done
#find /software/unet_ich_edema/* -type f -exec sed -i "s/\/Stroke_CT_Segmentation/\/software\/Stroke_CT_Segmentation/g" {} \;
find /software/unet_ich_edema/* -type f -exec sed -i "s/python/\/opt\/conda\/envs\/tf\/bin\/python/g" {} \;

#find /software/${git_dir}/* -type f -exec sed -i "s/python/\/root\/anaconda3\/envs\/tf\/bin\/python'/g" {} \;
#find /software/${git_dir}/* -type f -exec sed -i "s/python/\/root\/anaconda3\/envs\/tf\/bin\/python'/g" {} \;
#mv ${git_dir1}/* /software/
#/opt/conda/envs/tf/bin/python
#cd /software/
#rm -r /software/*
#git_link=${5}
#git clone ${git_link}
#y=${git_link%.git}
#git_dir=$(basename $y)
#mv ${git_dir}/* /software/
#cp -r  /Stroke_CT_Processing/* /software/
#chmod +x /software/*.sh

SESSION_ID=${1}
XNAT_USER=${2}
XNAT_PASS=${3}
XNAT_HOST=${4}
TYPE_OF_PROGRAM=${6}

/software/script_to_call_main_program.sh $SESSION_ID $XNAT_USER $XNAT_PASS ${XNAT_HOST} ${TYPE_OF_PROGRAM}
