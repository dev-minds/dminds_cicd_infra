# Infrastructure cicd pipeline, inspired by https://github.com/jenkins201/packer-terraform-cicd-aws/blob/master/Jenkinsfile

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
    - Setup a repo to hold your code 
    - Have docker engine configured on your jenkins env
    - Packer build 
    - Terraform 
    - Chef Inspec 
    - Bash build
    - AWS target env 

1. Setup Jenkins environment 