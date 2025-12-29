pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/Rumaisa-Malik/skillswap.git'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                bat '''
                curl -u admin:admin ^
                -T target/SkillSwap.war ^
                "http://localhost:8082/manager/text/deploy?path=/skillswap&update=true"
                '''
            }
        }
    }
}
