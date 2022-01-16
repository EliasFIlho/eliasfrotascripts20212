#!/bin/bash

keyname=$1
AM=ami-08e4e35cccc6189f4
VPCID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text)
SUBNETID=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
aws ec2 create-security-group --group-name MeuSecurityGroup3 --description "Meu security group" --vpc-id $VPCID
SGC=$(aws ec2 describe-security-groups --group-name MeuSecurityGroup3 --query "SecurityGroups[0].GroupId" --output text)


aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup3 --protocol tcp --port 22 --cidr 0.0.0.0/0
    
aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup3 --protocol tcp --port 80 --cidr 0.0.0.0/0
    
instance_value=$(aws ec2 run-instances --instance-type "t2.micro" --image-id $AM --key-name $keyname --security-group-ids $SGC --subnet-id $SUBNETID --user-data file:///tmp/webscript.txt) 





#echo "Acesse http://$ip/ 

