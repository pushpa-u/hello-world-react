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

    
 
    }
}