pipeline {
    agent any
    stages {
        stage('Clonar repositorio') {
            steps {
                git branch: 'main', url: 'https://github.com/andreschilva1/prueba-jenkins.git', credentialsId: 'github-credentials'
            }
        }

        stage('Levantar contenedores') {
            steps {
                sh 'docker-compose up -d'
            }
        }
        stage('Copiar código') {
            steps {
                sh 'docker cp . laravel:/var/www/html'
            }
        }
        stage('Instalar dependencias') {
            steps {
                sh 'docker exec laravel composer install'
            }
        }
    }
}
