FROM tomcat:9.0.96-jre11-temurin
COPY target/kowshik*.war /usr/local/tomcat/webapps/kowshik.war
