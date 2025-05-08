FROM openjdk:17-alpine AS mvn-build
WORKDIR /app/build
COPY ./src ./src
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
RUN ./mvnw clean install -Dmaven.test.skip=true

FROM openjdk:17-alpine
WORKDIR /app
COPY --from=mvn-build /app/build/target/*.jar ./tp-foyer.jar
EXPOSE 8081
CMD ["java", "-jar", "/app/tp-foyer.jar"]
