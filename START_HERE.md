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
    - Packer build 
    - Terraform 
    - Chef Inspec 
    - Bash build
    - AWS target env 
      - Install clodbees aws creds plugin 
    - See how you can do git squash here 

1. Setup Jenkins environment 