pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')  // Jenkins DockerHub credentials
        DOCKER_IMAGE = "thedk/notes-app"                             // Your DockerHub repo
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Replace 'github-credentials' with the Jenkins credentials ID you created for GitHub
                git branch: 'main', 
                    url: 'https://github.com/iamdk-16/springboot-notes-app.git',
                    credentialsId: 'github-credentials'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub-credentials', url: 'https://index.docker.io/v1/' ]) {
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build and Docker push successful!"
        }
        failure {
            echo "❌ Build failed. Check logs."
        }
    }
}

