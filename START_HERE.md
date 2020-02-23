# Infrastructure cicd pipeline, inspired by https://github.com/jenkins201/packer-terraform-cicd-aws/blob/master/Jenkinsfile

# Reference Repos 
https://github.com/phelun/packer-terraform-cicd-aws/blob/master/Jenkinsfile
https://github.com/awslabs/ami-builder-packer


# Futuring Technologies 
    - Packer 
    - Terraform 
    - Jenkins
    - Docker
    - Chef Test Framework   
    - Bash 


# AIM: Have a step by step hand scripting of this

# FLOW: From a jenkinsfile point of view, below is the flow 
    - Setup Jenkins environment 
    - Test a simple jenkinsfile to connect with your repo 
    - Setup a repo to hold your code (CURRENTLY REPO IS PRIVATE: WILL ALWAYS REQUIRE SOME AUTHE.)
    - Have docker engine configured on your jenkins env
      - Add Jenkins user to docker group
      - Restart both docker and jenkins services
      - We are using this image simonmcc/hashicorp-pipeline:latest
    - PACKER BUILDs(IMMUTABLE INFRA)
      - VPC ide: vpc-a6bda2ce
      - SubnetPub: subnet-c97205af -- eu-west-1   
      - Building a secure AWS environment has many layers - 
        - the AWS account access and resource privileges, 
        - keeping inventory of the instances, and 
        - managing application configuration.  
      2) Packer process does: https://www.helecloud.com/single-post/2019/01/21/Building-Secure-Immutable-Infrastructure-on-AWS
        a. Start new EC2 instance
        b. Connect to that EC2 instance and executes predefined scripts
            i. OS update
            ii. Apply OS configuration and tuning
            iii. Apply CIS hardening on OS
            iv. Install application
            v. Install antivirus, IDS, IPS, file integrity check software
            vi. Install CloudWatch agent
            vii. Install Inspector agent
        c. Register new AMI
    - Terraform 
    - Chef Inspec 
    - Bash build
    - AWS target env 
      - Install clodbees aws creds plugin 
    - See how you can do git squash here 

1. Setup Jenkins environment 