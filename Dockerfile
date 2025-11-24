ARG BASE_IMAGE=amazoncorretto:21-alpine-jdk
FROM ${BASE_IMAGE}

ARG IMAGE_VERSION=1.0
LABEL org.opencontainers.image.authors="Doc" \
 org.opencontainers.image.version=${IMAGE_VERSION} \
 org.opencontainers.image.title="Users Microservice" \
 org.opencontainers.image.description="Spring boot service to manage users"

WORKDIR /app
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

ENV LOG_FILE=users-ws.log
# ENTRYPOINT is default command, always execute
ENTRYPOINT ["java", "-Dlogging.file.name=${LOG_FILE}", "-Xmx300m", "-jar", "app.jar"]
#ENTRYPOINT ["java", "-XX:InitialRAMPercentage=50.0", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar", "--spring.profiles.active=prod", "--server.port=9090"]

# CMD is command when container starts, used to pass optional default params
# and can be changed in runtime in docker build command as argument
# CMD will be added finally to ENTRYPOINT as a command line argument:
# ["java", "-Xmx300m", "-jar", "app.jar", "--spring.profiles.active=test"]
CMD ["--spring.profiles.active=test"]