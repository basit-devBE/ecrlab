# =============================================================
# Stage 1 — Build: Maven + JDK 21 (Alpine)
# pom.xml is copied before src/ so the dependency layer is
# cached separately — only re-downloaded when pom.xml changes.
# =============================================================
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /build

COPY pom.xml .
RUN mvn dependency:go-offline -q

COPY src ./src
RUN mvn package -DskipTests -q

# =============================================================
# Stage 2 — Runtime: JRE 21 only (~80 MB, no JDK or build tools)
# =============================================================
FROM eclipse-temurin:21-jre-alpine AS runtime

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

WORKDIR /app
COPY --from=builder /build/target/demo-0.0.1-SNAPSHOT.jar demo.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/demo.jar"]
