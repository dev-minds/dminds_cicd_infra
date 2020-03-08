#!/bin/bash 

echo "helloworld" 
hosted_zone_id=`aws route53 list-hosted-zones-by-name --dns-name dev-minds.com --profile dminds --query 'HostedZones[].Id' --output text | cut -d '/' -f3`
aws route53 list-resource-record-sets --hosted-zone-id $hosted_zone_id
aws route53 list-resource-record-sets --hosted-zone-id $hosted_zone_id --query 'ResourceRecordSets[].Name'
echo -e $hosted_zone_id