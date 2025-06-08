
FROM openjdk:17-jdk-alpine
WORKDIR /app

# Build the Jar
COPY pom.xml .
RUN ./mvn dependency:go-offline
COPY src/ ./src/
RUN mvn package -DskipTests

# Create the Docker image
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
