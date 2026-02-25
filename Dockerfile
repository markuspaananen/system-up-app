# Builder stage
FROM maven:3.9.7-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy files
COPY pom.xml .
COPY src ./src

# Build JAR
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-jammy

WORKDIR /app

COPY --from=builder /app/target/SystemApp-1.0-SNAPSHOT.jar ./app.jar

CMD ["java", "-jar", "app.jar"]