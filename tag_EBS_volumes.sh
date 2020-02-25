#!/bin/bash
volumes=( $(aws ec2 describe-volumes --profile $1 --region $2 --query 'Volumes[*].Attachments[*].{volid:VolumeId}' --output text))
  # Populate the Application tag for all volumes
  for volid in ${volumes[@]}
    do
    echo "Volume found.  Adding tag data to volume-id: " ${volid}
    aws ec2 create-tags --profile $1 --region $2 --resources ${volid} --tags Key=SnapshotsManagement,Value="True"
    echo "Done!"
    done
