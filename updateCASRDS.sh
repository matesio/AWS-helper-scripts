#!/bin/bash
profile=your_profile_name_for_awscli
region=region_value

db_instances=($(aws rds describe-db-instances --profile $profile --region $region  | jq '.DBInstances[].DBInstanceIdentifier' |  sed 's/"//g'))
i=0

while [ $i -le ${#db_instances} ]
do
   echo  updation TLS certifacte for ${db_instances[$i]} ...
   aws rds modify-db-instance \
    --db-instance-identifier ${db_instances[$i]} \
    --ca-certificate-identifier rds-ca-2019 \
    --no-apply-immediately \
    --region $region \
    --profile $profile
   i=$((i+1))
done
