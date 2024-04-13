pipeline {
    agent any

  

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
                        sh "docker build -t limkel/frontend:2.0 ."
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh "docker push limkel/frontend:2.0"
                        sh "docker rmi -f limkel/frontend:2.0"
                    }
                }
            }
        }
    }
}
