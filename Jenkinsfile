pipeline {
    agent {
        docker {
            image 'thedk/maven-docker:latest'
            // mount local maven repo for caching dependencies
            args '-v /root/.m2:/root/.m2'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                // get code from your repo
                git branch: 'main',
                    url: 'https://github.com/iamdk-16/springboot-notes-app.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t thedk/springboot-notes-app:latest ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push thedk/springboot-notes-app:latest"
                }
            }
        }
    }
}

