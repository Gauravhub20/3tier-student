
FROM ubuntu:latest
LABEL dev="Gaurav"
 
# Install necessary packages
RUN apt-get update && \
    apt-get install -y wget unzip openjdk-11-jdk
 
# Download and extract Tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.zip   /opt
RUN unzip /opt/apache-tomcat-9.0.93.zip -d /opt
 
# Set up Tomcat and deploy the WAR file
WORKDIR /opt/apache-tomcat-9.0.93/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war /opt/apache-tomcat-9.0.93/webapps/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar /opt/apache-tomcat-9.0.93/lib/mysql-connector.jar 
COPY context.xml /opt/apache-tomcat-9.0.93/conf/context.xml

# Set permissions and run Tomcat
RUN chmod +rwx /opt/apache-tomcat-9.0.93/bin/*.sh
 
CMD ["/opt/apache-tomcat-9.0.93/bin/catalina.sh", "run"]
 
EXPOSE 8080
 
