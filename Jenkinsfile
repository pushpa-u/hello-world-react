pipeline {
    agent any
    tools {
        docker 'Docker' 
    }
    environment{
        DOCKER_USERNAME = credentials('DOCKER_HUB_USERNAME')
        DOCKER_PASSWORD = credentials('DOCKER_HUB_PASSWORD')
        DOCKER_REPO = credentials('DOCKER_HUB_REPO')
        // REMOTE_USER = credentials('REMOTE_USER')
        // REMOTE_PASSWORD = credentials('REMOTE_PASSWORD')
        // REMOTE_IP = credentials('REMOTE_IP')
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'puspa-jenkin', url: 'https://github.com/pushpa-u/hello-world-react.git' 
            }
        }

        // Copy ENV variables

        stage('Login to Docker, Build and Push Image') {
            steps {
                script {
                    // Login to Docker
                    sh """
                    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                    DOCKER_ACCESS_TOKEN=\$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "$DOCKER_USERNAME", "password": "$DOCKER_PASSWORD"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
                    input_string=\$(curl -s -H "Authorization: Bearer \$DOCKER_ACCESS_TOKEN" https://registry.hub.docker.com/v2/repositories/pushpau/$DOCKER_REPO/tags | jq -r '.results | max_by(.last_updated) | .name')
                    number=\$(echo "\$input_string" | grep -oE '[0-9]+\$') && new_number=\$((number + 1)) && new_string=\$(echo "\$input_string" | sed "s/\$number\$/\$new_number/")
                    docker build -t pushpau/$DOCKER_REPO:\$new_string .
                    docker push pushpau/$DOCKER_REPO:\$new_string
                    """
                }
            }
        }

        // stage('Deploy to Server') {
        //     steps {
        //         script {
        //             sshagent(['jenkins-ssh-key-id']) { // Replace with your Jenkins SSH key credential ID
        //                 sh """
        //                 ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "bash /root/screening/deploy/integration/deploy.sh"
        //                 """
        //             }
        //         }
        //     }
        // }
    }
}