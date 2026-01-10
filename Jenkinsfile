pipeline {
    agent any

    tools {
        maven 'cimaven'     // Nom exact configuré dans Jenkins
        jdk 'ci-java'       // Nom exact configuré dans Jenkins
    }

    environment {
        APP_NAME = "ci-java-app"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/isoulemane/your-repo-name.git'
            }
        }

        stage('Clean') {
            steps {
                sh 'mvn clean'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Archive Artifact') {
            steps {
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
    }

    post {
        success {
            echo '✅ Build completed successfully'
        }
        failure {
            echo '❌ Build failed'
        }
        always {
            cleanWs()
        }
    }
}
