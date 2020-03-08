// Declarative Ochestration of infra deployment 
// Any complex logic should go to functions in a scripted groovy script 
// Help Points for declaratives 
//      - http://jenkins.dev-minds.com/view/Infrastructure_cicd/job/dminds_infra_wip/pipeline-syntax/
//      - 

pipeline { 
    agent any
    environment {
        AWS_DEFAULT_REGION = 'eu-west-1'
    }

    options {
		buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '50'))
		disableConcurrentBuilds()
		timestamps()
		timeout 240 // minutes
		ansiColor('xterm')
		skipDefaultCheckout()
    }

    stages {
        stage('Validate & Lint') {
            parallel{
                stage('vacker validate') {
                    agent { docker { image 'simonmcc/hashicorp-pipeline:latest'}}
                    steps {
                        checkout scm 
                        wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                            sh "packer validate -var-file=./base/vars.json ./base/base.json"
                        }
                    }
                }
                stage('Validate TF'){
                    agent { docker { image 'simonmcc/hashicorp-pipeline:latest'}}
                    steps {
                        checkout scm
                        withCredentials([
                            usernamePassword(credentialsId: 'dminds_aws_keys',
                            passwordVariable: 'AWS_ACCESS_KEY_ID', 
                            usernameVariable: 'AWS_SECRET_ACCESS_KEY'
                        )]) {
                            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                                sh "terraform init"
                                sh "terraform validate"
                                sh "terraform fmt"
                            } 
                        }
                    }
                }
            }
        }

        stage ('Proceed AMI Build') {
            steps{
                 input 'Build AMI?'
            }
        }

        stage('Bake AMI') {
            agent { docker { image 'simonmcc/hashicorp-pipeline:latest' }}
            steps {
                checkout scm 
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'dminds_aws_keys',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    // wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                        sh "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} aws ec2 describe-instances --region eu-west-1"
                        sh "./scripts/build.sh base base"
                        sh "./scripts/build.sh app app"
                    // }

                }
            }
        }

        stage('Docker executor') {
            agent { docker { image 'simonmcc/hashicorp-pipeline:latest' }}
            steps {
                checkout scm 
                sh "cat START_HERE.md"
            }
        }

        stage("AWS ACCT ACCESS") {
            agent {docker {image 'simonmcc/hashicorp-pipeline:latest'}}
            steps {
                checkout scm
                withCredentials([
                    usernamePassword(credentialsId: 'dminds_aws_keys',
                    passwordVariable: 'AWS_ACCESS_KEY_ID', 
                    usernameVariable: 'AWS_SECRET_ACCESS_KEY'
                )]) {
                  wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                      sh "echo 'variables here'"
                  } 
                    // sh "echo Variables"                                     
                }
            }
        }

    }
}