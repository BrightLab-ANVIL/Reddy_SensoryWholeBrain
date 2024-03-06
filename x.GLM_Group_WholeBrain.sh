#!/bin/bash
#This script uses subject-level beta coefficient and tstatistic maps to create a group-level general linear model using AFNI.

#Check if the inputs are correct
if [ $# -ne 8 ]
then
  echo "Insufficient inputs"
  echo "Input 1 should be the input folder for the beta coef and tstat maps in MNI space"
  echo "Input 2 should be the beta coef file suffixes"
  echo "Input 3 should be the tstat file suffixes"
  echo "Input 4 should be the brain mask"
  echo "Input 5 should be the subject IDs"
  echo "Input 6 should be the output prefix"
  echo "Input 7 should be the output directory"
  echo "Input 8 should be the sensory stimulus tested"
  exit
fi

input_prefix="${1}"
beta_suffix="${2}"
tstat_suffix="${3}"
brain_mask="${4}"
sub_IDs="${5}"
output_prefix="${6}"
output_dir=${7}
stim="${8}"

#If output directory is not present, make it
if [ ! -d ${output_dir} ]
then
  mkdir ${output_dir}
fi

if [ ! -f ${output_dir}/"3dMEMA_${output_prefix}_${stim}.nii.gz" ]
then

    run3dMEMA="3dMEMA -prefix ${output_dir}/3dMEMA_${output_prefix}_${stim}"
    run3dMEMA="${run3dMEMA} -set ${stim}"
    for subject in ${sub_IDs}
    do
      bcoef="${input_prefix}/${sub_ID}_${beta_suffix}.nii.gz"
      tstat="${input_prefix}/${sub_ID}_${tstat_suffix}.nii.gz"
      run3dMEMA="${run3dMEMA} ${subject} ${bcoef} ${tstat}"
    done

    run3dMEMA="${run3dMEMA} -unequal_variance -verb 1"
    run3dMEMA="${run3dMEMA} -max_zeros 0.25 -model_outliers"
    run3dMEMA="${run3dMEMA} -mask ${brain_mask}"

    eval ${run3dMEMA}

else
  echo "** ALREADY RUN: ${output_prefix}_${stim} **"
fi
