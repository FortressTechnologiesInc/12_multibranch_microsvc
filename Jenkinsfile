pipeline {
    agent any

    stages {
        stage('Deploy To Kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: '', contextName: '', credentialsId: '.kube', namespace: 'jenkins', serverUrl: ' https://192.168.49.2:8443']]) {
                    sh "kubectl apply -f deployment-service.yml"
                    
                }
            }
        }
        
        stage('verify Deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: '', contextName: '', credentialsId: 'kube', namespace: 'jenkins', serverUrl: ' https://192.168.49.2:8443']]) {
                    sh "kubectl get svc -n jenkins"
                    sh "kubectl get po -n jenkins"
                }
            }
        }
    }
}
