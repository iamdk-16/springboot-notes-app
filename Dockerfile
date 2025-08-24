# Use official OpenJDK 11 image as base
FROM openjdk:11-jdk-slim

# Set a working directory inside the container
WORKDIR /app

# Copy the built JAR into the container
COPY target/notes-app-0.0.2-SNAPSHOT.jar app.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8081

# Command to run the app
ENTRYPOINT ["java", "-jar", "app.jar"]

