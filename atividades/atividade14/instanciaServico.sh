#!/bin/bash
keyname=$1
AM=ami-08e4e35cccc6189f4
VPCID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text)
SUBNETID=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
aws ec2 create-security-group --group-name MeuSecurityGroup5 --description "Meu security group" --vpc-id $VPCID
SGC=$(aws ec2 describe-security-groups --group-name MeuSecurityGroup5 --query "SecurityGroups[0].GroupId" --output text)

mv userdata.sh /tmp/

aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 22 --cidr 0.0.0.0/0
    
aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 80 --cidr 0.0.0.0/0
    
    

instance_value=$(aws ec2 run-instances --instance-type "t2.micro" --image-id $AM --key-name $keyname --security-group-ids $SGC --subnet-id $SUBNETID --user-data file:///tmp/userdata.sh) 


instanceStatus=$(aws ec2 describe-instance-status --instance-ids $instance_value --query "InstanceStatuses[0].InstanceState.Name" --output text)

until [ "$instanceStatus" = "running" ]
do
    instanceStatus=$(aws ec2 describe-instance-status --instance-id s $instanceId --query "InstanceStatuses[0].InstanceState.Name" --output text)
    sleep 5
done


insid=$(grep "InstanceId" | cut -f2 -d":" | tr -d '",')

ip=$(aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Instância em estado 'running'"
echo "Acesse http://$ip/ 






