#! /bin/bash

# Usage:
#   bash resize.sh <size, default is 20>

start_size=10
size=${1:-20}
class=$(terraform output -raw class_name)

vols=$(aws ec2 describe-instances --filters "Name=tag:Class,Values=${class}" | \
       jq -r '.Reservations[].Instances[].BlockDeviceMappings[].Ebs.VolumeId' | \
       xargs aws ec2 describe-volumes --filters "Name=size,Values=${start_size}" --volume-ids | \
       jq -r '.Volumes[].VolumeId')

if [[ ! -z ${vols[@]} ]]; then
  echo && echo "Resizing..."
  for vol in ${vols[@]}; do
    aws ec2 modify-volume --volume-id ${vol} --size ${size} | jq -r '.VolumeModification.VolumeId'
  done

  while [[ ! -z $(aws ec2 describe-volumes-modifications --volume-ids ${vols[@]} \
                  --filters "Name=modification-state,Values=modifying" | \
                  jq -r '.VolumesModifications[].VolumeId') ]]; do
    echo && echo "Waiting for modifications to complete."
    sleep 1
  done

  changed=$(aws ec2 describe-volumes --volume-ids ${vols[@]} | jq -r '.Volumes[].Attachments[].InstanceId')
  if [[ ! -z ${changed[@]} ]]; then
    echo && echo "Rebooting..."
    aws ec2 reboot-instances --instance-ids ${changed[@]}
  else
    echo && echo "None to reboot."
  fi
else
  echo && echo "None to resize."
fi
