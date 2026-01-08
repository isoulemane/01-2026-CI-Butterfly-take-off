#!/bin/bash

# Install vsftpd (FTP server)
sudo yum update -y
sudo yum install vsftpd -y
sudo systemctl enable vsftpd
sudo systemctl start vsftpd
sudo systemctl status vsftpd

sudo yum update -y
sudo yum install git -y 



# Install Maven
sudo yum update -y
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
sudo tar -xzf apache-maven-3.9.6-bin.tar.gz -C /opt/
sudo mv /opt/apache-maven-3.9.6 /opt/maven

# Set up Maven environment
echo 'export M2_HOME=/opt/maven
export PATH=$M2_HOME/bin:$PATH' | sudo tee /etc/profile.d/maven.sh
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

# Install Maven via package manager
sudo yum install maven -y
mvn --version

# Install Docker
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
docker --version

# Install Java
sudo yum update -y
sudo yum install java-11-amazon-corretto-devel -y

# Install Jenkins - CORRECTED APPROACH
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# IMPORT GPG KEY - FIXED
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Alternative GPG key import if above fails
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Clean yum cache and install Jenkins with GPG check disabled if needed
sudo yum clean all

# Try installation with GPG check
sudo yum install jenkins -y

# If GPG check still fails, use this alternative:
# sudo yum install jenkins --nogpgcheck -y

# Start Jenkins services
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

echo "All services installed successfully!"
