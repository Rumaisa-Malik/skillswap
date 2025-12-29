pipeline {
    agent any

    tools {
        maven 'Maven'
        jdk 'JDK'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/mudasirshamshadali/skillswap.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'tomcat-creds',
                        path: '',
                        url: 'http://localhost:8080'
                    )
                ],
                contextPath: 'SkillSwap',
                war: 'target/*.war'
            }
        }
    }

    post {
        success {
            echo '✅ SkillSwap Pipeline Successful'
        }
        failure {
            echo '❌ SkillSwap Pipeline Failed'
        }
    }
}
