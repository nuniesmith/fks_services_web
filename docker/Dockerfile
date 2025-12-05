# Multi-stage build for fks_web Kotlin Multiplatform Web Service
# Stage 1: Build Kotlin Multiplatform Web App
FROM gradle:8.5-jdk17 AS builder

WORKDIR /app

# Copy Gradle files first for better caching
COPY clients/gradle/ ./gradle/
COPY clients/gradle.properties ./
COPY clients/settings.gradle.kts ./
COPY clients/build.gradle.kts ./
COPY clients/gradle/libs.versions.toml ./gradle/

# Copy source code
COPY clients/shared/ ./shared/
COPY clients/web/ ./web/

# Build the web app
RUN gradle :web:jsBrowserWebpack --no-daemon

# Stage 2: Nginx to serve the built web app
FROM nginx:alpine

# Copy built web app from builder
COPY --from=builder /app/web/dist /usr/share/nginx/html

# Copy nginx configuration
COPY services/web/docker/nginx.conf /etc/nginx/conf.d/default.conf

# Add health check endpoint script
COPY services/web/docker/health.sh /usr/local/bin/health.sh
RUN chmod +x /usr/local/bin/health.sh

# Expose ports
EXPOSE 3001 8000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD /usr/local/bin/health.sh || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
