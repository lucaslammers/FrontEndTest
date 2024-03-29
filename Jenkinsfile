pipeline {
    agent any

    environment {
        // Set your Kubernetes cluster credentials
        KUBE_CONFIG = credentials('c7bc4fb6-be60-4879-86aa-b1362598deeb')
        KUBE_NAMESPACE = 'jenkins'
    }

    stages {
        stage('Checkout') {
            steps {
                // Assuming you have your code in a Git repository
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Execute your .sh script to build Docker image
                    sh 'chmod +x ./docker-release.sh'
                    sh 'sudo ./docker-release.sh'
                }
            }
        }

        stage('Deploy Pod') {
            steps {
                script {
                    // Define the pod YAML configuration
                    def podConfig = """
                    apiVersion: apps/v1
                    kind: Deployment
                    metadata:
                      name: ontdekstation-client
                    spec:
                      replicas: 1
                      selector:
                        matchLabels:
                          app: ontdekstation-client
                      template:
                        metadata:
                          labels:
                            app: ontdekstation-client
                        spec:
                          containers:
                          - name: ontdekstation-client
                            image: 172.16.20.110:5000/ontdekstation-client-release:latest
                            imagePullPolicy: Always
                            ports:
                            - containerPort: 80"""

                    // Save the pod configuration to a file
                    writeFile file: 'ontdekstation-client.yaml', text: podConfig

                    // Use kubectl to apply the pod configuration
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} replace -f ontdekstation-client.yaml --force -n ${KUBE_NAMESPACE}"
                }
            }
        }

        stage('Deploy Service ') {
            steps {
                script {
                    // Define the pod YAML configuration
                    def podConfig = """
                    apiVersion: v1
                    kind: Service
                    metadata:
                      name: ontdekstation-client-service
                    spec:
                      selector:
                        app: ontdekstation-client
                      ports:
                        - protocol: TCP
                          port: 3000
                          targetPort: 80
                      type: LoadBalancer"""

                    // Save the pod configuration to a file
                    writeFile file: 'ontdekstation-client-service.yaml', text: podConfig

                    // Use kubectl to apply the pod configuration
                    sh "kubectl --kubeconfig=${KUBE_CONFIG} apply -f ontdekstation-client-service.yaml -n ${KUBE_NAMESPACE}"
                }
            }
        }
    }
}
