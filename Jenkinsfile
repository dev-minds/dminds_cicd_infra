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
                stage('packer validate') {
                    agent { docker { image 'simonmcc/hashicorp-pipeline:latest'}}
                    steps {
                        checkout scm 
                        wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                            sh "packer validate -var-file=./base/vars.json ./base/base.json"
                            sh "terraform version"
                        }
                    }
                }
                stage('terraform validate'){
                    agent { docker { image 'simonmcc/hashicorp-pipeline:latest'}}
                    steps {
                        checkout scm
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                            credentialsId: 'aws_keys',
                            accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                            secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                        ]]) {
                            wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                                sh "export TF_LOG=DEBUG"
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
                    credentialsId: 'aws_keys',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                        // sh "./scripts/build.sh base base"
                        // sh "./scripts/build.sh app app"
                    }
                }
            }
        }

        stage('build sandbox stack'){
            agent { docker {image 'simonmcc/hashicorp-pipeline:latest' }}
            when {
                expression { env.BRANCH_NAME != 'master' }
            }
            steps{
                checkout scm
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_keys',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'

                ]]) {
                    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                        sh "./scripts/tf-wrapper.sh -a plan"
                        sh "./scripts/tf-wrapper.sh -a apply"
                        sh "cat output.json"
                        stash name: 'terraform_output', includes: '**/output.json'
                    }
                }
            }
            post {
              failure {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_keys',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                ]]) {
                    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']) {
                         sh "./scripts/tf-wrapper.sh -a destroy"
                    }
                }
              }
            }
        }

        stage('test sandbox stack'){
            agent { 
              docker {
                image 'chef/inspec:latest'
                  args "--entrypoint=''"
              }
            }
            when {
                expression {env.BRANCH_NAME != 'master' }
            }
            steps{
                checkout scm
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_keys',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'

                ]]) {
                    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                        unstash 'terraform_output'
                        sh "cat output.json"
                        sh "mkdir -p aws-security/files || true"
                        sh "mkdir test-results || true"
                        sh "cp -rf ./output.json aws-security/files/"
                        sh "inspec exec aws-security --reporter=cli junit:test-results/inspec-junit.xml -t aws://eu-west-1 --chef-license accept-silent"
                        sh "touch test-results/inspec-junit.xml"
                        junit 'test-results/*.xml'
                    }
                }
            }

        }
        stage('destroy sandbox stack'){
            agent { docker {image 'simonmcc/hashicorp-pipeline:latest'} }
            when {
                expression { env.BRANCH_NAME != 'master' }
            }
            steps{
                checkout scm
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws_keys',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'

                ]]) {
                    wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'xterm']){
                        sh "./scripts/tf-wrapper.sh -a destroy"
                    }
                }
            }            

        }
    }
}