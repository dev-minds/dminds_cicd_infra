// Declarative Ochestration of infra deployment 
// Any complex logic should go to functions in a scripted groovy script 
// Help Points for declaratives 
//      - http://jenkins.dev-minds.com/view/Infrastructure_cicd/job/dminds_infra_wip/pipeline-syntax/
//      - 

pipeline { 
    agent any
    environment {
        AWS_REGION = 'eu-west-1'
    }
    stages {
        stage('Validate AMI Build') {
            parallel{
                stage('Validate Packer') {
                    agent { docker { image 'simonmcc/hashicorp-pipeline:latest' }}
                    steps {
                        checkout scm 
                        wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                            sh "packer validate -var-file=vars.json base.json"
                            
                        }
                    }
                }
            }
        }

        stage('Docker executor') {
            agent {
                docker {
                    image 'simonmcc/hashicorp-pipeline:latest'
                    alwaysPull false 
                }
            }
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