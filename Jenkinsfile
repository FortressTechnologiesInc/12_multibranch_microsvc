pipeline {
    agent any

    stages {
        stage('Install grpc_health_probe') {
            steps {
                script {
                    sh 'wget -O /bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/v0.4.4/grpc_health_probe-linux-amd64'
                    sh 'chmod +x /bin/grpc_health_probe'
                }
            }
        }

        stage('Build & Tag Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker build -t limkel/checkoutservice:2.2 ."
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker push limkel/checkoutservice:2.2"
                        sh "docker rmi -f limkel/checkoutservice:2.2"
                    }
                }
            }
        }
    }
}
