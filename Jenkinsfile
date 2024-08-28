pipeline {
    agent any

    stages {
        stage('Clonar ppastene/td-unit-tests') {
            steps {
                script {
                    try {
                        // Clonar el repositorio de pruebas unitarias
                        sh 'git clone https://github.com/ppastene/td-unit-tests.git'
                    } catch (Exception e) {
                        echo "Uno o ambos repositorios ya existen, omitiendo la clonación."
                    }
                }
            }
        }
        stage('Ejecutar JUnit') {
            steps {
                dir('td-unit-tests') {
                    sh 'mvn clean test'
                }
            }
        }
        stage('Verificar archivos en shared') {
            steps {
                sh 'ls -la /shared'
            }
        }
        stage('Ejecutar JMeter') {
            steps {
                script {
                    sh '/opt/jmeter/bin/jmeter -n -t /shared/clase4_m4.jmx -l /shared/results.jtl'
                }
            }
        }
        stage('Ejecutar SOAPUI') {
            steps {
                script {
                    def soapUICommand = '/opt/soapui/bin/testrunner.sh -r -j -d"/opt/soapui/reports" /shared/test-soapui-project.xml'
                    sh soapUICommand
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/shared/results.jtl', allowEmptyArchive: true
            archiveArtifacts artifacts: '**/opt/soapui/reports/*.xml', allowEmptyArchive: true
        }
    }
}
