FROM openjdk:17-jdk-alpine

# Build the Jar
COPY pom.xml .
RUN ./mvn dependency:go-offline
COPY src/ ./src/
RUN ./mvn package -DskipTests

# Create the Docker image
COPY ./target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
