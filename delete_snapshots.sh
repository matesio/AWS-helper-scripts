#!/bin/sh

# Determine whether the OS is Linux or OSX based
if [ `uname` == "OSX" ]; then
    DATETOCOMPARE=$(date -v-30d +%s) #OSX
else
    DATETOCOMPARE=$(date --date="30 days ago" +%s) #Linux
fi


date > SNAP_TO_KEEP.txt
date > SNAP_TO_DELETE.txt

echo "Collecting snapshot information"

aws ec2 describe-snapshots  --output json --profile $1 --region $2  > listofsnaps.txt
cat listofsnaps.txt | egrep "StartTime|SnapshotId" | awk -F'"' '{print $4}'  | awk 'NR%2{printf "%s, ",$0;next;}1' > listofsnaps.txt_tmp
  while read snap
  do
     echo "working on snap " $snap
     raw_date=$(echo $snap | cut -d , -f1)
     snap_date=$(date -d $raw_date +%s)
     echo "Snap date is: " $snap_date
     echo "Snap to compare is: " $DATETOCOMPARE
     if [ $DATETOCOMPARE -gt $snap_date ]
     then
        echo $snap | cut -d, -f2 >> SNAP_TO_DELETE.txt
        snapToDelete='echo $snap | cut -d, -f2'
        echo "Deleting Snapshot: " $snapToDelete
        aws ec2 delete-snapshot --profile $1 --region $2 --snapshot-id $snapToDelete
        echo "aws ec2 delete-snapshot --region" $2"--snapshot-id" $snapToDelete
     else
        echo $snap | cut -d, -f2 >> SNAP_TO_KEEP.txt
                                      fi
  done < listofsnaps.txt_tmp
              
