#!groovy

pipeline {
    agent any

    options { 
        disableConcurrentBuilds()
    }

    environment { 
        GIT_URL = 'git@git.tech.rz.db.de:vendo/zml/kibana.git'
        DOCKER_IMAGE = '${env.DOCKER_REG}/vendo-zml-service-kibana'
    }

    stages {
       stage('Checkout from SCM') {
            steps { 
                dbGitCheckout(url: "${GIT_URL}")
            }
        }
/*
        stage('Build & Test') { 
            steps { 
                dbMavenBuild()
            }
        }

        stage('Static Analysis'){
            steps {
                dbCodeAnalysis()
            }
        }
*/
        stage('Build Docker Image') {
            steps {
                dbBuildDockerImage(image: "${DOCKER_IMAGE}")
            }
        }

		
        /*stage('Apply to Kubernetes') {
            steps {
                dbApplyKubernetes()
            }
        }
		*/

        // Deactivate smoke test until openshift is running
        /*stage('Automated tests') {
            steps {
                dbSmokeTest()
            }
        }
        */
    }


}
