#FROM sharmaatul11/fsl502py369ltx-full:latest
#FROM sharmaatul11/yashengstep1withfsl:latest
#FROM yashengwustl/stroke_ct_segmentation:latest
FROM sharmaatul11/ct_segmentation_yasheng:latest
RUN apt update
RUN mkdir -p /callfromgithub
RUN chmod 755 /callfromgithub
#RUN chmod 777 /root/anaconda3/
#RUN chmod +x /root/anaconda3/envs/tf/bin/*
COPY downloadcodefromgithub.sh /callfromgithub/
RUN chmod +x /callfromgithub/downloadcodefromgithub.sh
RUN chmod +x /Stroke_CT_Segmentation/*.sh
#RUN cp -r  /usr/share/fsl/5.0/* /usr/lib/fsl/5.0/
RUN chmod 755 /Stroke_CT_Segmentation
RUN for x in  /Stroke_CT_Segmentation/*/* ; do chmod +x $x ; done
RUN for x in  /Stroke_CT_Segmentation/* ; do chmod +x $x ; done
RUN apt install -y \
  vim  \
  zip  \
  unzip  \
  curl  \
  git \
  tree  \
  python3-pip
 # software-properties-common
#RUN apt-get update
#RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN pip3 install \
  nibabel  \
  numpy  \
  xmltodict  \
  pandas  \
  requests  \
  pydicom  \
  python-gdcm  \
  glob2  \
  scipy  \
  pypng  \
  PyGithub
#SHELL ["/bin/bash", "-i", "-c"]
#RUN conda install numpy
LABEL org.nrg.commands="[{\"name\": \"ct_segmentation\", \"description\": \"Apply ct_segmentation\", \"version\": \"1.0\", \"schema-version\": \"1.0\", \"image\": \"registry.nrg.wustl.edu/docker/nrg-repo/sharmaatul11/ctegmentation:latest\", \"type\": \"docker\", \"working-directory\": \"/callfromgithub\", \"command-line\": \" /callfromgithub/downloadcodefromgithub.sh #SESSION_ID# \$XNAT_USER \$XNAT_PASS https://snipr.wustl.edu https://github.com/dharlabwustl/CT_CSF_INFARCT_SEGMN.git 2 \", \"override-entrypoint\": true, \"mounts\": [{\"name\": \"out\", \"writable\": true, \"path\": \"/output\"}, {\"name\": \"in\", \"writable\": false, \"path\": \"/input\"}, {\"name\": \"ZIPFILEDIR\", \"writable\": true, \"path\": \"/ZIPFILEDIR\"}, {\"name\": \"software\", \"writable\": true, \"path\": \"/software\"}, {\"name\": \"NIFTIFILEDIR\", \"writable\": true, \"path\": \"/NIFTIFILEDIR\"}, {\"name\": \"DICOMFILEDIR\", \"writable\": true, \"path\": \"/DICOMFILEDIR\"}, {\"name\": \"working\", \"writable\": true, \"path\": \"/working\"}, {\"name\": \"workinginput\", \"writable\": true, \"path\": \"/workinginput\"}, {\"name\": \"workingoutput\", \"writable\": true, \"path\": \"/workingoutput\"}, {\"name\": \"outputinsidedocker\", \"writable\": true, \"path\": \"/outputinsidedocker\"}], \"environment-variables\": {}, \"ports\": {}, \"inputs\": [{\"name\": \"SESSION_ID\", \"label\": null, \"description\": null, \"type\": \"string\", \"matcher\": null, \"default-value\": null, \"required\": true, \"replacement-key\": null, \"sensitive\": null, \"command-line-flag\": null, \"command-line-separator\": null, \"true-value\": null, \"false-value\": null, \"select-values\": [], \"multiple-delimiter\": null}, {\"name\": \"PROJECT\", \"label\": null, \"description\": null, \"type\": \"string\", \"matcher\": null, \"default-value\": null, \"required\": true, \"replacement-key\": null, \"sensitive\": null, \"command-line-flag\": null, \"command-line-separator\": null, \"true-value\": null, \"false-value\": null, \"select-values\": [], \"multiple-delimiter\": null}], \"outputs\": [], \"xnat\": [{\"name\": \"ct_segmentation\", \"label\": \"ct_segmentation batch\", \"description\": \"ct_segmentation\", \"contexts\": [\"xnat:imageSessionData\"], \"external-inputs\": [{\"name\": \"session\", \"label\": null, \"description\": \"Input session\", \"type\": \"Session\", \"matcher\": null, \"default-value\": null, \"required\": true, \"replacement-key\": null, \"sensitive\": null, \"provides-value-for-command-input\": null, \"provides-files-for-command-mount\": null, \"via-setup-command\": null, \"user-settable\": null, \"load-children\": false}], \"derived-inputs\": [{\"name\": \"project\", \"label\": null, \"description\": null, \"type\": \"string\", \"matcher\": null, \"default-value\": null, \"required\": true, \"replacement-key\": null, \"sensitive\": null, \"provides-value-for-command-input\": \"PROJECT\", \"provides-files-for-command-mount\": null, \"user-settable\": false, \"load-children\": true, \"derived-from-wrapper-input\": \"session\", \"derived-from-xnat-object-property\": \"project-id\", \"via-setup-command\": null, \"multiple\": false, \"parser\": null}, {\"name\": \"session-id\", \"label\": null, \"description\": null, \"type\": \"string\", \"matcher\": null, \"default-value\": null, \"required\": true, \"replacement-key\": null, \"sensitive\": null, \"provides-value-for-command-input\": \"SESSION_ID\", \"provides-files-for-command-mount\": null, \"user-settable\": false, \"load-children\": true, \"derived-from-wrapper-input\": \"session\", \"derived-from-xnat-object-property\": \"id\", \"via-setup-command\": null, \"multiple\": false, \"parser\": null}], \"output-handlers\": []}], \"container-labels\": {}, \"generic-resources\": {}, \"ulimits\": {}}]"
