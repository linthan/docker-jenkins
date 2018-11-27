FROM ubuntu:16.04
MAINTAINER  Ethan "445366464@qq.com"

ADD ./sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y wget git curl
RUN apt-get update && apt-get install -y --no-install-recommends openjdk-7-jdk build-essential
RUN apt-get update && apt-get install -y maven ant ruby rbenv make
RUN echo "2.138.3" > .lts-version-number
RUN wget -q -O - http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key | sudo apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian-stable binary/ >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y jenkins
RUN mkdir -p /jenkins 
ADD init.groovy /tmp/WEB-INF/init.groovy
RUN apt-get install -y zip && cd /tmp && zip -g /usr/share/jenkins/jenkins.war WEB-INF/init.groovy

ENV JENKINS_HOME /jenkins

ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
EXPOSE 8080

CMD [""]
