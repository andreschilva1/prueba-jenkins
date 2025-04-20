pipeline {
  agent any

  environment {
    COMPOSE_PROJECT_NAME = "laravel_ci"
  }

  stages {
    stage('Clonar repositorio') {
      steps {
        git credentialsId: 'github-credentials', url: 'https://github.com/andreschilva1/prueba-jenkins.git', branch: 'main'
      }
    }

    stage('Levantar contenedores') {
      steps {
        sh 'docker compose down || true'
        sh 'docker compose build'
        sh 'docker compose up -d'
      }
    }

    stage('Migraciones') {
      steps {
        sh 'docker exec laravel php artisan migrate --force'
      }
    }

    stage('Test (opcional)') {
      steps {
        echo 'Aquí puedes agregar tests con PHPUnit si quieres'
      }
    }
  }

  post {
    failure {
      echo 'Hubo un error en el pipeline.'
    }
  }
}
