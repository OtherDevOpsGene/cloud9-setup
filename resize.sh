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
  for vol in ${vols[@]}; do
    aws ec2 modify-volume --volume-id ${vol} --size ${size}
  done

  reboots=$(aws ec2 describe-volumes --volume-ids ${vols[@]} | jq -r '.Volumes[].Attachments[].InstanceId')
  if [[ ! -z ${reboots[@]} ]]; then
    aws ec2 reboot-instances --instance-ids ${reboots[@]}
  else
    echo "None to reboot."
  fi
else
  echo "None to resize."
fi
