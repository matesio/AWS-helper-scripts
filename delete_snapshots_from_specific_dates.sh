#!/bin/bash

snaps=( $(aws ec2 describe-snapshots --query 'Snapshots[?StartTime <= `2019-10-01`].{id:SnapshotId}' --owner self --output text --profile $1 --region $2)) 
echo $snaps
for snapId in ${snaps[@]}
do 
	echo "Deleting snap..." ${snapId}
	aws ec2 delete-snapshot --profile $1 --region $2 --snapshot-id ${snapId}
done
