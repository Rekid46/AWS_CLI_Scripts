#!/bin/bash
read -p "Please Enter The Name of Instance You Want To Start:  " Instance
InstanceId=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].{Id:InstanceId}" --filters "Name=tag:Name,Values='*$InstanceName*'" --output text)
start=$(aws ec2 start-instances --instance-ids $InstanceId)
read -p "Do you want to SSM into $InstanceName Instance: " WantSSM
if [ "$WantSSM" == "Yes" -o "$WantSSM" == "yes" -o "$WantSSM" == "y" -o "$WantSSM" == "Y" ]
then
    echo "Please Wait for a minute, Let the Instance boot-up.Please don't press ctrl+c :-) "
    sleep 45
    aws ssm start-session --target $InstanceId
else
    echo "Ok Bye"
fi