FROM openjdk:8-jre-alpine
ADD target/tpAchatProject-2.0.1.jar tpAchatProject-2.0.1.jar
EXPOSE 8089
ENTRYPOINT ["java", "-jar", "tpAchatProject-2.0.1.jar"]