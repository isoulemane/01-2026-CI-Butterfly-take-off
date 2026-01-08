# Use Amazon Linux 2023 as base
FROM amazonlinux:2023

# Set environment variables
ENV MAVEN_VERSION=3.9.9
ENV JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto
ENV PATH=$JAVA_HOME/bin:/opt/maven/bin:$PATH

# Install basic tools
RUN yum update -y && \
    yum install -y wget git tar unzip sudo curl which && \
    yum clean all

# Install Java 17 (Corretto)
RUN amazon-linux-extras enable corretto-17 && \
    yum install -y java-17-amazon-corretto-devel

# Install Maven
RUN cd /opt && \
    wget https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz -O maven.tar.gz && \
    tar -xzf maven.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /opt/maven && \
    ln -sf /opt/maven/bin/mvn /usr/bin/mvn

# Install Docker CLI (optional, for docker-in-docker builds)
RUN yum install -y docker && \
    yum clean all

# Create Jenkins user
RUN useradd -m -s /bin/bash jenkins
RUN usermod -aG docker jenkins

# Set working directory
WORKDIR /home/jenkins

# Copy scripts into the container
COPY . /home/jenkins/workspace

# Expose workspace as volume
VOLUME ["/home/jenkins/workspace"]

# Switch to jenkins user
USER jenkins

# Default command
CMD ["bash"]

