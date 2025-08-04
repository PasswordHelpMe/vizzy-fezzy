# 🐳 Containerized Deployment Guide

This guide shows how to deploy the Vizio TV Controller web app using Docker with environment variable configuration.

## 🚀 Quick Start

### Option 1: Docker Compose (Recommended)

```bash
# Clone or download the web app files
git clone <repository-url>
cd vizio-tv-controller

# Edit environment variables
nano docker-compose.yml

# Start the container
docker-compose up -d

# Access the app
open http://localhost:8080
```

### Option 2: Docker Run

```bash
# Build the image
docker build -t vizio-tv-controller .

# Run with environment variables
docker run -d \
  --name vizio-tv-controller \
  -p 8080:80 \
  -e DEFAULT_API_URL=http://192.168.1.100:8000 \
  -e APP_TITLE="My TV Controller" \
  -e THEME_COLOR="#FF6B6B" \
  vizio-tv-controller
```

## ⚙️ Environment Variables

### Required Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DEFAULT_API_URL` | `http://localhost:8000` | Backend API URL |

### Optional Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `APP_TITLE` | `Vizio TV Controller` | App title in browser |
| `APP_DESCRIPTION` | `Control your Vizio SmartCast TV from any device` | App description |
| `THEME_COLOR` | `#007AFF` | Theme color for PWA |
| `DEBUG_MODE` | `false` | Enable debug logging |
| `AUTO_CONNECT` | `true` | Auto-connect to TV on load |
| `REFRESH_INTERVAL` | `5000` | Status refresh interval (ms) |

## 🏠 Home Network Setup

### 1. Find Your Backend IP

```bash
# On the machine running vizzy backend
ip addr show | grep "inet " | grep -v 127.0.0.1
```

### 2. Update docker-compose.yml

```yaml
version: '3.8'
services:
  vizio-tv-controller:
    build: .
    ports:
      - "8080:80"
    environment:
      - DEFAULT_API_URL=http://192.168.1.100:8000  # Your backend IP
      - APP_TITLE="Family TV Controller"
      - THEME_COLOR="#51CF66"
    restart: unless-stopped
```

### 3. Deploy

```bash
docker-compose up -d
```

## 🌐 Production Deployment

### Option 1: Docker Swarm

```bash
# Initialize swarm
docker swarm init

# Deploy stack
docker stack deploy -c docker-compose.yml vizio-tv
```

### Option 2: Kubernetes

```yaml
# k8s-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vizio-tv-controller
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vizio-tv-controller
  template:
    metadata:
      labels:
        app: vizio-tv-controller
    spec:
      containers:
      - name: vizio-tv-controller
        image: vizio-tv-controller:latest
        ports:
        - containerPort: 80
        env:
        - name: DEFAULT_API_URL
          value: "http://backend-service:8000"
        - name: APP_TITLE
          value: "Vizio TV Controller"
---
apiVersion: v1
kind: Service
metadata:
  name: vizio-tv-controller-service
spec:
  selector:
    app: vizio-tv-controller
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer
```

### Option 3: Reverse Proxy (Nginx)

```nginx
# /etc/nginx/sites-available/vizio-tv
server {
    listen 80;
    server_name tv.yourdomain.com;
    
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 🔧 Configuration Examples

### Development Environment

```yaml
environment:
  - DEFAULT_API_URL=http://localhost:8000
  - DEBUG_MODE=true
  - AUTO_CONNECT=false
```

### Production Environment

```yaml
environment:
  - DEFAULT_API_URL=http://192.168.1.100:8000
  - APP_TITLE="Family TV Remote"
  - THEME_COLOR="#FF6B6B"
  - DEBUG_MODE=false
  - AUTO_CONNECT=true
```

### Multi-TV Setup

```yaml
services:
  tv-controller-living:
    build: .
    ports:
      - "8080:80"
    environment:
      - DEFAULT_API_URL=http://192.168.1.100:8000
      - APP_TITLE="Living Room TV"
      - THEME_COLOR="#51CF66"
  
  tv-controller-bedroom:
    build: .
    ports:
      - "8081:80"
    environment:
      - DEFAULT_API_URL=http://192.168.1.101:8000
      - APP_TITLE="Bedroom TV"
      - THEME_COLOR="#339AF0"
```

## 🔒 Security Considerations

### 1. Network Isolation

```yaml
# Use custom network
networks:
  vizio-network:
    driver: bridge

services:
  vizio-tv-controller:
    networks:
      - vizio-network
    environment:
      - DEFAULT_API_URL=http://backend:8000
```

### 2. HTTPS Setup

```yaml
# With Let's Encrypt
services:
  vizio-tv-controller:
    environment:
      - HTTPS_REDIRECT=true
    volumes:
      - ./certs:/etc/nginx/certs
```

### 3. Access Control

```nginx
# Basic auth
location / {
    auth_basic "TV Controller";
    auth_basic_user_file /etc/nginx/.htpasswd;
    proxy_pass http://localhost:8080;
}
```

## 📊 Monitoring

### Health Checks

```yaml
healthcheck:
  test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost/health"]
  interval: 30s
  timeout: 10s
  retries: 3
  start_period: 10s
```

### Logging

```bash
# View logs
docker-compose logs -f vizio-tv-controller

# Check container status
docker-compose ps
```

## 🐛 Troubleshooting

### Container Won't Start

```bash
# Check logs
docker-compose logs vizio-tv-controller

# Check if port is in use
netstat -tulpn | grep 8080

# Rebuild image
docker-compose build --no-cache
```

### Environment Variables Not Applied

```bash
# Check if config.js was created
docker exec vizio-tv-controller cat /usr/share/nginx/html/config.js

# Restart container
docker-compose restart
```

### Network Connectivity

```bash
# Test backend connectivity
docker exec vizio-tv-controller wget -qO- http://192.168.1.100:8000/health

# Check DNS resolution
docker exec vizio-tv-controller nslookup backend
```

## 🔄 Updates

### Update Container

```bash
# Pull latest changes
git pull

# Rebuild and restart
docker-compose down
docker-compose build --no-cache
docker-compose up -d
```

### Rollback

```bash
# Revert to previous version
docker-compose down
docker image tag vizio-tv-controller:previous vizio-tv-controller:latest
docker-compose up -d
```

## 📱 Mobile Access

### Local Network

- **iOS/Android**: `http://192.168.1.100:8080`
- **PWA Installation**: Available on all devices

### Remote Access

- **VPN**: Connect to home network via VPN
- **Port Forwarding**: Forward port 8080 to router
- **Dynamic DNS**: Use service like No-IP

## 🎯 Best Practices

1. **Use Environment Files**: Create `.env` files for different environments
2. **Health Checks**: Always include health checks for production
3. **Logging**: Configure proper logging for debugging
4. **Backups**: Regularly backup your configuration
5. **Updates**: Keep containers updated for security
6. **Monitoring**: Use monitoring tools for production deployments

---

**Happy Containerizing! 🐳📺** 