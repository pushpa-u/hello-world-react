pipeline {
    agent any
    // tools {
    //     nodejs 'NodeJS' 
    // }
    environment{
        DOCKER_USERNAME = credentials('DOCKER_HUB_USERNAME')
        DOCKER_PASSWORD = credentials('DOCKER_HUB_PASSWORD')
        DOCKER_REPO = credentials('DOCKER_HUB_REPO')
        DOCKER_TAG = 'v20' 
        // REMOTE_USER = credentials('REMOTE_USER')
        // REMOTE_IP = credentials('REMOTE_IP')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/pushpa-u/hello-world-react.git' 
            }
        }

         stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the repository and tag
                    def appImage = docker.build("${DOCKER_REPO}:${DOCKER_TAG}")
                }
            }
        }


        stage('Push Docker Image') {
            steps {
                script {
                    // Use Docker Hub credentials for authentication
                    docker.withRegistry('https://index.docker.io/v1/', 'Dckerhub-Credentials') {
                        def appImage = docker.image("${DOCKER_REPO}:${DOCKER_TAG}")
                        appImage.push() // Push the Docker image to Docker Hub
                    }
                }
            }
        }

 
    }
}