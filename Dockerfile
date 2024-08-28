# Utiliza la imagen oficial de Jenkins como base
FROM jenkins/jenkins:lts

# Cambia a usuario root para instalar herramientas
USER root

# Instala Maven, JMeter, JUnit, SoapUI y dependencias adicionales
RUN apt-get update && \
    apt-get install -y wget unzip maven junit4 python3 python3-venv && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.zip -O /tmp/jmeter.zip && \
    unzip /tmp/jmeter.zip -d /opt && \
    rm /tmp/jmeter.zip && \
    ln -s /opt/apache-jmeter-5.5 /opt/jmeter && \
    wget https://dl.eviware.com/soapuios/5.7.2/SoapUI-5.7.2-linux-bin.tar.gz && \
    tar -xzf SoapUI-5.7.2-linux-bin.tar.gz -C /opt && \
    ln -s /opt/SoapUI-5.7.2/bin/soapui.sh /usr/local/bin/soapui && \
    rm SoapUI-5.7.2-linux-bin.tar.gz

# Descargar e instalar SonarQube Scanner
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.8.0.2856-linux.zip -O /tmp/sonar-scanner.zip && \
    unzip /tmp/sonar-scanner.zip -d /opt && \
    ln -s /opt/sonar-scanner-4.8.0.2856-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner && \
    rm /tmp/sonar-scanner.zip

# Configura el PATH para JMeter, SoapUI y SonarQube Scanner
ENV PATH=$PATH:/opt/jmeter/bin:/opt/soapui/bin:/opt/sonar-scanner-4.8.0.2856-linux/bin

# Establece variables de entorno para facilitar configuraciones
ENV MAVEN_HOME=/usr/share/maven
ENV JMETER_HOME=/opt/jmeter
ENV SOAPUI_HOME=/opt/SoapUI-5.7.2
ENV SONAR_SCANNER_HOME=/opt/sonar-scanner-4.8.0.2856-linux

# Limpieza de paquetes temporales
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Cambia el usuario de nuevo a Jenkins
USER jenkins

# Exponer puertos necesarios
EXPOSE 8080
