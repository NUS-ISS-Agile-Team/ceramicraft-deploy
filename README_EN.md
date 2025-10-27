# CeramiCraft One-Click Deployment Guide

CeramiCraft is a microservices-based e-commerce platform for ceramic crafts, supporting both merchant and customer applications.

## 🏗️ Project Architecture

```
ceramicraft-deploy/
├── fe-mer/                    # Merchant Frontend (Vue.js)
├── fe-cus/                    # Customer Frontend (Vue.js)  
├── ms-user/                   # User Microservice (Go)
├── ms-order/                  # Order Microservice (Go)
├── ms-pay/                    # Payment Microservice (Go)
├── ms-cmdt/                   # Commodity Microservice (Go)
├── ms-comt/                   # Comment Microservice (Go)
├── monitor-serv/              # Monitoring Environment Configuration
├── nginx/                     # Nginx Configuration
├── mysql/                     # MySQL Initialization Scripts
└── docker-compose.yml         # Production Docker Compose File
```

## Quick Start

### Prerequisites

Ensure your system has the following software installed:

- [Docker](https://docs.docker.com/get-docker/) (version 20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 2.0+)
- [Git](https://git-scm.com/downloads) (version 2.30+)

### 1. Clone the Project

```bash
# Clone the main project repository
git clone https://github.com/NUS-ISS-Agile-Team/ceramicraft-deploy.git
cd ceramicraft-deploy
```

### 2. Download Submodules

```bash
# Initialize and update all submodules
git submodule update --init --recursive

# Pull latest updates for submodules if needed
git submodule update --remote --recursive
```

**Submodule Description:**
- `fe-mer`: Merchant management frontend
- `fe-cus`: Customer shopping frontend
- `ms-user`: User management microservice
- `ms-order`: Order processing microservice
- `ms-pay`: Payment processing microservice
- `ms-cmdt`: Commodity management microservice
- `ms-comt`: Comment management microservice

### 3. One-Click Deployment

```bash
# Build and start all services
docker-compose up -d

# Check service status
docker-compose ps

# View service logs
docker-compose logs -f
```

## 📊 Service Access

After successful deployment, you can access services through when the Local Domain Resolution been configured:

| Service | Access URL | Description |
|---------|------------|-------------|
| Merchant Frontend | http://ceramicraft-merchant-frontend | Merchant management interface |
| Customer Frontend | http://ceramicraft-customer-frontend | Customer shopping interface |

### Configure Local Domain Resolution

For a better local development experience, you can add the following entries to your `/etc/hosts` file:

```bash
# macOS/Linux
sudo echo "127.0.0.1 ceramicraft-merchant-frontend" >> /etc/hosts
sudo echo "127.0.0.1 ceramicraft-customer-frontend" >> /etc/hosts

# Windows (Administrator privileges required)
# Edit C:\Windows\System32\drivers\etc\hosts file
127.0.0.1 ceramicraft-merchant-frontend
127.0.0.1 ceramicraft-customer-frontend
```

## 🛠️ Development and Debugging

### View Real-time Logs

```bash
# View all service logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f ceramicraft-user-mservice
docker-compose logs -f mysql
```

### Restart Services

```bash
# Restart all services
docker-compose restart

# Restart specific service
docker-compose restart ceramicraft-user-mservice
```

### Rebuild Services

```bash
# Rebuild and start
docker-compose up -d --build

# Rebuild specific service
docker-compose build ceramicraft-user-mservice
docker-compose up -d ceramicraft-user-mservice
```

## Environment Cleanup

**Production Environment Cleanup:**
```bash
# Stop all services
docker-compose down

# Stop and remove data volumes (Warning: Will delete database data)
docker-compose down -v

# Remove all related images
docker-compose down --rmi all
```

**Development Environment Cleanup:**
```bash
# Execute in dev-env directory
cd dev-env

# Stop development environment services
docker-compose down

# Stop and remove development environment data volumes
docker-compose down -v

# Remove development environment related images
docker-compose down --rmi all
```

## 📝 Update Project

```bash
# Update main project
git pull origin main

# Update all submodules to latest version
git submodule update --remote --recursive

# Rebuild and deploy
docker-compose up -d --build
```

## 🤝 Contributing

1. Fork this project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

If you encounter issues or need help:

- Submit an [Issue](https://github.com/NUS-ISS-Agile-Team/ceramicraft-deploy/issues)
- Check the project documentation
- Contact the development team

---

**Note**: This project is for development and testing environments only. For production deployment, please refer to the production environment configuration guide.
