pipeline {
    agent any

    environment {
        COMPOSE_INTERACTIVE_NO_CLI = 1
    }

    stages {
        stage('Clonar repositorio') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/andreschilva1/prueba-jenkins.git', branch: 'main'
            }
        }

        stage('Levantar contenedores') {
            steps {
                sh 'docker-compose down || true'
                sh 'docker-compose build'
                sh 'docker-compose up -d'
            }
        }

        stage('Migraciones') {
            steps {
                sh 'docker-compose exec -T laravel php artisan migrate --force'
            }
        }

        stage('Test (opcional)') {
            steps {
                echo 'Aquí podrías correr pruebas si las tienes'
                // Ejemplo: sh 'docker-compose exec -T laravel php artisan test'
            }
        }
    }

    post {
        failure {
            echo 'Hubo un error en el pipeline.'
        }
    }
}
