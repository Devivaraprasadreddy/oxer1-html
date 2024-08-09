pipeline {
    agent any

    parameters {
        choice(name: 'BRANCH_NAME', choices: ['main', 'master'], description: 'Choose the branch to deploy')
    }

    environment {
        REMOTE_HOST = '192.168.29.130'
        REMOTE_USER = 'root'
        //REMOTE_KEY = 'your-private-key-credential-id'
        REMOTE_PATH = '/var/www/html'
        GIT_CREDENTIALS_ID = '0ce9cbdc-1c6e-4cb1-866b-bbec3ffb6db3'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the specified branch using Git credentials
                    checkout([$class: 'GitSCM', branches: [[name: "${params.BRANCH_NAME}"]],
                              userRemoteConfigs: [[url: 'https://gitlab.com/dsp9391/oxer-html.git', credentialsId: "${env.GIT_CREDENTIALS_ID}"]], extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: "source-code"]]])
                }
            }
        }

        stage('Deploy to Apache') {
            steps {
                script {
                    // Copy files to the remote Apache server
                        sh """
                        rsync -avz -e "ssh" --exclude 'Jenkinsfile' --exclude 'ansible' --delete ${WORKSPACE}/ ${env.REMOTE_USER}@${env.REMOTE_HOST}:${env.REMOTE_PATH}
                        """
                    
                }
            }
        }
    }

    post {
        always {
            echo 'Deployment completed.'
        }
    }
}