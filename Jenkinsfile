pipeline {
    agent any

    stages {
        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker build -t limkel/emailservice:2.0 ."
                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker push limkel/emailservice:2.0 "
                    }
                }
            }
        }
    }
}
