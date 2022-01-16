#!/bin/bash

keyname=$1
AM=ami-08e4e35cccc6189f4
VPCID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text)
SUBNETID=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)
aws ec2 create-security-group --group-name MeuSecurityGroup5 --description "Meu security group" --vpc-id $VPCID
SGC=$(aws ec2 describe-security-groups --group-name MeuSecurityGroup5 --query "SecurityGroups[0].GroupId" --output text)


aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 22 --cidr 0.0.0.0/0
    
aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 80 --cidr 0.0.0.0/0
    
    
echo "#!/bin/bash
sudo amazon-linux-extras install -y nginx1.12
sudo systemctl start nginx
cd /usr/share/nginx/html
sudo mv index.html index.html.old
echo '<html><head><meta charset='UTF-8'/><title>Atividade12</title></head><body><h1>Elias Frota Coutinho Filho</h1> <h1>422173</h1></body></html>' > index.html" > /tmp/webscript.txt
    
instance_value=$(aws ec2 run-instances --instance-type "t2.micro" --image-id $AM --key-name $keyname --security-group-ids $SGC --subnet-id $SUBNETID --user-data file:///tmp/webscript.txt) 

insid=$(grep "InstanceId" | cut -f2 -d":" | tr -d '",')

ip=$(aws ec2 describe-instances --instance-ids $instanceId --query "Reservations[0].Instances[0].PublicIpAddress" --output text)


echo "Acesse http://$ip/ 

