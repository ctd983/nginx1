pipeline {
    agent {
        docker {
            image 'latest' // Replace with your desired Docker image name
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
        stage('Build') {
            steps {
                sh 'echo "Building Nginx"'
                sh 'docker build -t nginx1-image .'
            }
        }

        stage('Check') {
            steps {
                sh 'echo "Running checks"'
                sh 'docker run nginx1-image nginx -t'
            }
        }
    }

    post {
        always {
            // Clean up any resources, if needed
            sh 'docker rm $(docker ps -a -q --filter ancestor=nginx1-image)'
            sh 'docker image rm nginx1-image'
        }
    }


