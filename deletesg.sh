#!/bin/bash
while IFS= read -r id; do 
	echo "detleting group..." $id
	aws ec2 delete-security-group --group-id $id --profile $1 --region us-west-1
done < $2
