# Correção: 0,1. Nem o interpretador correto você colocou. 
#!bin/bash
keyname=$1
user_name=$2
passw=$3

AM=ami-08e4e35cccc6189f4
VPCID=$(aws ec2 describe-vpcs --query "Vpcs[0].VpcId" --output text)
SUBNETID=$(aws ec2 describe-subnets --query "Subnets[0].SubnetId" --output text)

aws ec2 create-security-group --group-name MeuSecurityGroup5 --description "Meu security group" --vpc-id $VPCID

SGC=$(aws ec2 describe-security-groups --group-name MeuSecurityGroup5 --query "SecurityGroups[0].GroupId" --output text)

PUBLIC_IP=$(wget -qO- https://ipecho.net/plain)


aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 22 --cidr $PUBLIC_IP
    
aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 80 --cidr $PUBLIC_IP

aws ec2 authorize-security-group-ingress --group-name MeuSecurityGroup5 --protocol tcp --port 3306 --source-group $SGC




cat <<MYSQL > /tmp/MYSQL.sh
 #!/bin/bash
 sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
 sudo yum localinstall mysql57-community-release-el7-11.noarch.rpm 
 sudo yum install mysql-community-server
 systemctl start mysqld.service
 sed -i '/bind-address/s/127.0.0.1/0.0.0.0/g' etc/mysql/mysql.conf.d/mysqld.cnf
 systemctl restart mysql.service
 
 sudo mysql <<EOF
  CREATE DATABASE scripts;
  CREATE USER '$user_name'@$'%' IDENTIFIED BY '$passw';
  GRANT ALL PPRIVILEGES ON scripts.* TO '$user_name'@$'%';
  EOF
  
SERVERMYSQL

chmod 744 /tmp/MYSQL.sh
echo "*/1  *  *  *  *  root  /tmp/MYSQL.sh" >> /etc/crontab

instance_value=$(aws ec2 run-instances --instance-type "t2.micro" --image-id $AM --key-name $keyname --security-group-ids $SGC --subnet-id $SUBNETID --user-data file:///tmp/MYSQL.sh) 


instanceStatus=$(aws ec2 describe-instance-status --instance-ids $instance_value --query "InstanceStatuses[0].InstanceState.Name" --output text)

until [ "$instanceStatus" = "running" ]
do
    instanceStatus=$(aws ec2 describe-instance-status --instance-id s $instance_value --query "InstanceStatuses[0].InstanceState.Name" --output text)
    sleep 5
done


insid1=$(grep "InstanceId" | cut -f2 -d":" | tr -d '",')

ip_1=$(aws ec2 describe-instances --instance-ids $instance_value --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Criando servidor de Banco de Dados..."
echo "IP Privado do Banco de Dados: $ip_1" 

cat <<CLIENTEMYSQL > /tmp/CMYSQL.sh
 #!/bin/bash
 sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
 sudo yum install -y mysql-community-client
 systemctl start mysqld.service
 
 
 sudo mysql -u $user_name scripts -h $ip_1 <<EOF
  CREATE TABLE Teste ( atividade INT );
  EOF
  
CLIENTEMYSQL

chmod 744 /tmp/CMYSQL.sh
echo "*/1  *  *  *  *  root  /tmp/CMYSQL.sh" >> /etc/crontab

instance_value2=$(aws ec2 run-instances --instance-type "t2.micro" --image-id $AM --key-name $keyname --security-group-ids $SGC --subnet-id $SUBNETID --user-data file:///tmp/CMYSQL.sh) 


instanceStatus2=$(aws ec2 describe-instance-status --instance-ids $instance_value2 --query "InstanceStatuses[0].InstanceState.Name" --output text)

until [ "$instanceStatus" = "running" ]
do
    instanceStatus=$(aws ec2 describe-instance-status --instance-id s $instance_value2 --query "InstanceStatuses[0].InstanceState.Name" --output text)
    sleep 5
done

ip_2=$(aws ec2 describe-instances --instance-ids $instance_value2 --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

echo "Criando servidor de Aplicação..."
IP Público do Servidor de Aplicação: $ip_2" 

