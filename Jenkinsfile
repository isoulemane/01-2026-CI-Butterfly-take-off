pipeline {
    agent any

    tools {
        maven 'cimaven'
        jdk 'cijava'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/isoulemane/01-2026-CI-Butterfly-take-off.git'
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
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }
    }

    post {
        failure {
            echo '❌ Build failed'
        }
        success {
            echo '✅ Build successful'
        }
        always {
            cleanWs()
        }
    }
}
