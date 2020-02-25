#!/bin/bash
AWSprofile=$1

volumes=$(aws ec2 describe-volumes --filters '[{"Name":"status","Values":["available"]}]'  --region us-west-1 --profile ${AWSprofile} | jq -r '.Volumes[].VolumeId')

for volId in ${volumes[@]}
do 
	echo "Deleting volume..." ${volId}
	aws ec2 delete-volume --profile ${AWSprofile} --region us-west-1 --volume-id ${volId}


done
