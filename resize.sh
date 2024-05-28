#! /bin/bash

# Usage:
#   bash resize.sh <size, default is 20>

size=${1:-20}
class=$(terraform output -raw class_name)

for vol in $(aws ec2 describe-instances --filters "Name=tag:Class,Values=${class}" --region us-east-2 | jq -r '.Reservations[].Instances[].BlockDeviceMappings[].Ebs.VolumeId'); do
  aws ec2 modify-volume --volume-id ${vol} --size ${size} --region us-east-2
done

aws ec2 reboot-instances --region us-east-2 --instance-ids $(aws ec2 describe-instances --filters "Name=tag:Class,Values=${class}" --region us-east-2 | jq -r '.Reservations[].Instances[].InstanceId')
