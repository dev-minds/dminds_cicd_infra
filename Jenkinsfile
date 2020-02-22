// Declarative Ochestration of infra deployment 
// Any complex logic should go to functions in a scripted groovy script 
// 

pipline { 
    agent any
    // 
    
    stages {
        stage('Validate Connection') {
            steps {
                checkout scm 
                sh "echo $HOSTNAME"
            }
        }
    }
}