// Declarative Ochestration of infra deployment 
// Any complex logic should go to functions in a scripted groovy script 
// Help Points for declaratives 
//      - http://jenkins.dev-minds.com/view/Infrastructure_cicd/job/dminds_infra_wip/pipeline-syntax/
//      - 

pipeline { 
    agent any
    // 
    
    stages {
        stage('Validate Connection') {
            steps {
                sh "echo HOSTNAME"
                sh "whoami"
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

    }
}