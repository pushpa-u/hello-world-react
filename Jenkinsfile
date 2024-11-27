pipeline {
    agent any
    // tools {
    //     nodejs 'NodeJS' 
    // }
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

        // Copy ENV variables

        stage('Login to Docker, Build and Push Image') {
            steps {
                script {
                    // Login to Docker
                    sh """
                    echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
                    DOCKER_ACCESS_TOKEN=\$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "$DOCKER_USERNAME", "password": "$DOCKER_PASSWORD"}' https://hub.docker.com/v2/users/login/ | grep -o '"token":"[^"]*"' | sed 's/"token":"//;s/"//')
                    input_string=\$(curl -s -H "Authorization: Bearer \$DOCKER_ACCESS_TOKEN" https://registry.hub.docker.com/v2/repositories/pushpau/$DOCKER_REPO/tags | grep -o '"name":"v[0-9]*"' | sed 's/"name":"//;s/"//' | sort -V | tail -n 1)
                    if [ -z "\$input_string" ] || [ "\$input_string" == "null" ]; then
                        input_string="v0"
                    fi                   
                    number=\$(echo "\$input_string" | grep -oE '[0-9]+\$') && new_number=\$((number + 1)) && new_string=\$(echo "\$input_string" | sed "s/\$number\$/\$new_number/")

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