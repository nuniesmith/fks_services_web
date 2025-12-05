# fks_web

Kotlin Multiplatform Web Service for FKS Trading Platform.

## Overview

This service serves the web frontend built with Kotlin Multiplatform and Compose Multiplatform. The web app is compiled to JavaScript and served via Nginx.

## Architecture

- **Build**: Kotlin Multiplatform compiles to JavaScript
- **Server**: Nginx serves static files
- **Port**: 3001 (Kubernetes), 8000 (Docker)

## Building

### Prerequisites

- JDK 17+
- Gradle 8.5+
- Node.js (for webpack)

### Build Steps

1. Build the Kotlin Multiplatform web app:
```bash
cd clients
./gradlew :web:jsBrowserWebpack
```

2. Build Docker image:
```bash
cd services/web
docker-compose build
```

3. Start the service:
```bash
docker-compose up -d
```

## Configuration

The web app connects to FKS services via environment variables:
- `FKS_API_URL`: API gateway URL (default: http://fks-api:8001)
- `FKS_AUTH_URL`: Auth service URL (default: http://fks-auth:8009)
- `FKS_DATA_URL`: Data service URL (default: http://fks-data:8003)
- `FKS_PORTFOLIO_URL`: Portfolio service URL (default: http://fks-portfolio:8012)

These can also be configured in `index.html` via window globals.

## Development

For local development:
```bash
cd clients
./gradlew :web:jsBrowserDevelopmentRun
```

This starts a development server with hot reload.

## Production Deployment

The service is built as a static site and served via Nginx. The build output is in `clients/web/dist/`.

## Health Check

Health endpoint: `http://localhost:3001/health`

## Integration

The web service depends on:
- `fks_api` - API gateway
- `fks_auth` - Authentication service
# fks_services_web
