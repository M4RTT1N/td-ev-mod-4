# Utiliza la imagen oficial de Jenkins como base
FROM jenkins/jenkins:lts

# Instala JMeter
USER root
RUN apt-get update && \
    apt-get install -y wget unzip maven && \
    wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.5.zip -O /tmp/jmeter.zip && \
    unzip /tmp/jmeter.zip -d /opt && \
    rm /tmp/jmeter.zip && \
    ln -s /opt/apache-jmeter-5.5 /opt/jmeter

# Configura el PATH para JMeter
ENV PATH=$PATH:/opt/jmeter/bin

# Instala JUnit y sus dependencias
RUN apt-get install -y junit4

# Instala SoapUI
RUN wget https://dl.eviware.com/soapuios/5.7.2/SoapUI-5.7.2-linux-bin.tar.gz && \
    tar -xzf SoapUI-5.7.2-linux-bin.tar.gz && \
    mv SoapUI-5.7.2 /opt/soapui && \
    ln -s /opt/soapui/bin/soapui.sh /usr/local/bin/soapui

# Configura el PATH para SoapUI
ENV PATH=$PATH:/opt/soapui/bin

# Cambia el usuario de nuevo a Jenkins
USER jenkins
