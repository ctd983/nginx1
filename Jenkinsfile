pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Replace this with your actual build steps for Nginx
                sh 'echo "Building Nginx"'
                sh 'docker build -t my-nginx-image .'
            }
        }
        
        stage('Check') {
            steps {
                // Replace this with your actual check steps
                sh 'echo "Running checks"'
                sh 'docker run my-nginx-image nginx -t'
            }
        }
    }
    
    post {
        always {
            // Clean up any resources, if needed
            sh 'docker image rm my-nginx-image'
        }
    }
}

