#!/bin/bash
clear
echo -e "Welcome $USER \n"
echo "Please Select The Instance You Want To Start:  "
echo "1.Web Server"
echo -e "2.Main Server \n "
read -p ": " Instance

if [ $Instance == 1 -o "$Instance" == "Web" -o "$Instance" == "web" ]
then
    InstanceName="Apache Web-Server"
elif [ $Instance == 2 -o "$Instance" == "Main" -o "$Instance" == "main" ]
then
    InstanceName="Main Server"
else
    echo "Uh Oh! Wrong Input.Please Try Again"
    $(exit)
fi

InstanceId=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].{Id:InstanceId}" --filters "Name=tag:Name,Values='*$InstanceName*'" --output text)
echo -e "Instance Id is $InstanceId \n"
start=$(aws ec2 start-instances --instance-ids $InstanceId)
read -p "Do you want to SSM into $InstanceName Instance: " WantSSM

if [ "$WantSSM" == "Yes" -o "$WantSSM" == "yes" -o "$WantSSM" == "y" -o "$WantSSM" == "Y" ]
then
    echo "Please Wait for a minute, Let the Instance boot-up."
    echo "Please don't press ctrl+c :-) "
    sleep 60
    aws ssm start-session --target $InstanceId
else
    echo "Thank You"
    $(exit)
fi
