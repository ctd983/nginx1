pipeline {
    agent any

    stages {
        stage('Install Docker') {
            steps {
                sh 'curl -fsSL https://get.docker.com -o get-docker.sh'
                sh 'sudo sh get-docker.sh'
                sh 'sudo usermod -aG docker jenkins' // Add Jenkins user to the Docker group
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
}

