# Using the official tomcat base image
FROM tomcat:9.0-jdk21-temurin

# Copying the war file and renaming it to app.war
COPY target/*.war /usr/local/tomcat/webapps/app.war

# Exposing the 8080 port
EXPOSE 8080

# Starting the container
CMD ["catalina.sh", "run"]