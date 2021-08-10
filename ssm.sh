#!/bin/bash
InstanceId=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].{Id:InstanceId}" --filters "Name=instance-state-name,Values=running" --output text)
aws ssm start-session --target $InstanceId