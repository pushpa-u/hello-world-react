pipeline {
    agent {
        docker {
         image 'docker:latest'
         args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
    }
    
    environment{
        DOCKER_USERNAME = credentials('DOCKER_HUB_USERNAME')
        DOCKER_PASSWORD = credentials('DOCKER_HUB_PASSWORD')
        DOCKER_REPO = credentials('DOCKER_HUB_REPO')
        // REMOTE_USER = credentials('REMOTE_USER')
        // REMOTE_IP = credentials('REMOTE_IP')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'puspa-jenkin', url: 'https://github.com/pushpa-u/hello-world-react.git' 
            }
        }

        stage('Test Docker') {
            steps {
                sh 'docker --version'
                sh 'docker ps'
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
                    if [ -z "\$input_string" ] || [ "\$input_string" == "null" ]; then
                        input_string="v0"
                    fi                   
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
        //             sshagent(credentials: ['REMOTE_SSH']) { 
        //                 sh """
        //                 ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_IP "sudo -i bash /root/practice-pipeline/deploy.sh"
        //                 """
        //             }
        //         }
        //     }
        // }
    }
}