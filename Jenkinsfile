pipeline {
    environment {
        registry = "isprastika/jenkins-docker-test"
        registryCredential = 'nitrogear21'
	dockerImage = ''
    }
    agent {
        docker {
            image 'ardityopm/nodejs-docker:2'
            args '-p 3000:3000'
            args '-w /app'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage("Build"){
            steps {
                sh 'npm install'
            }
        }
        stage("Test"){
            steps {
                sh 'npm test'
            }
        }
        stage("Build & Push Docker image") {
            steps {
                script {
			dockerImage = docker.build registry + ":$BUILD_NUMBER"
                 	docker.withRegistry( '', registryCredential ) {
			dockerImage.push()
                   }
                sh "docker image rm $registry:$BUILD_NUMBER"
            }
        }
        }
        stage('Deploy and smoke test') {
            steps{
                sh './jenkins/scripts/deploy.sh'
            }
        }
        stage('Cleanup') {
            steps{
                sh './jenkins/scripts/cleanup.sh'
            }
        }
    }
}
