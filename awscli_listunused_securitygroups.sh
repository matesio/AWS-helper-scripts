#!/usr/bin/env bash

###
Script for list all unused security groups.
###
# all groups
aws ec2 describe-security-groups \
  | jq --raw-output '.SecurityGroups[] | [.GroupName, .GroupId] | @tsv' \
  | sort > allgroups.txt

# groups in use
aws ec2 describe-network-interfaces \
  | jq --raw-output '.NetworkInterfaces[].Groups[] | [.GroupName, .GroupId] | @tsv' \
  | sort \
  | uniq > /tmp/inusegroups.txt

diff allgroups.txt inusegroups.txt |grep "<" |cut -d ' ' -f2-3 . > unusedgroups.txt
