FROM eclipse-temurin:11-jdk as Build
WORKDIR /app
COPY pom.xml
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -Dskip Tests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=Build /app/target/spring-petclinic-2.1.0.war ./app/spring-petclinic-2.1.0.war
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/spring-petclinic-2.1.0.war"]
