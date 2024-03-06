#!/bin/bash
#This script uses subject-level beta coefficient maps to create a group-level general linear model using FSl randomise.

#Check if the inputs are correct
if [ $# -ne 8 ]
then
  echo "Insufficient inputs"
  echo "Input 1 should be the input folder for the beta coef maps in MNI space"
  echo "Input 2 should be the beta coef file suffixes"
  echo "Input 3 should be maximum number of permutations"
  echo "Input 4 should be the brainstem mask"
  echo "Input 5 should be the subject IDs"
  echo "Input 6 should be the output prefix"
  echo "Input 7 should be the output directory"
  echo "Input 8 should be the sensory stimulus tested"
  exit
fi

input_prefix="${1}"
beta_suffix="${2}"
perm="${3}"
mask="${4}"
sub_IDs="${5}"
output_prefix="${6}"
output_dir=${7}
stim="${8}"

#If output directory is not present, make it
if [ ! -d ${output_dir} ]
then
  mkdir ${output_dir}
fi

if [ ! -f ${output_dir}/"randomise_${output_prefix}_${stim}.nii.gz" ]
then

    # combine all beta coef maps into one file
    runMerge="fslmerge -t ${output_dir}/allbetamaps.nii.gz"
    for subject in ${sub_IDs}
    do
      bcoef="${input_prefix}/${sub_ID}_${beta_suffix}.nii.gz"
      runMerge="${runMerge} ${bcoef}"
    done

    eval ${runMerge}

    # run FSL randomise
    randomise -i ${output_dir}/allbetamaps.nii.gz -o ${output_dir}/randomise_${output_prefix}_${stim} \
      -m ${mask} -1 -T -v 5 -n ${perm} --glm_output

else
  echo "** ALREADY RUN: ${output_prefix}_${stim} **"
fi
