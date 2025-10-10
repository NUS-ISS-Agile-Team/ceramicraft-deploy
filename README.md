# CeramiCraft 一键部署指南

CeramiCraft 是一个基于微服务架构的陶瓷工艺品电商平台，支持商户和客户端双端应用。

## 🏗️ 项目架构

```
ceramicraft-deploy/
├── fe-mer/                    # 商户前端 (Vue.js)
├── fe-cus/                    # 客户前端 (Vue.js)  
├── ms-user/                   # 用户微服务 (Go)
├── ms-order/                  # 订单微服务 (Go)
├── ms-pay/                    # 支付微服务 (Go)
├── ms-cmdt/                   # 商品微服务 (Go)
├── dev-env/                   # 开发环境配置
├── nginx/                     # Nginx 配置
├── mysql/                     # MySQL 初始化脚本
└── docker-compose.yml         # 生产环境 Docker 编排文件
```

## �️ 开发环境

对于本地开发，我们提供了独立的开发环境配置，包含必要的基础服务。

### 开发环境服务

开发环境(`dev-env/`)包含以下服务：

| 服务 | 端口 | 访问地址 | 用途 |
|------|------|----------|------|
| MySQL | 3306 | localhost:3306 | 主数据库 |
| phpMyAdmin | 8080 | http://localhost:8080 | 数据库管理界面 |
| Kafka | 9092 | localhost:9092 | 消息队列 |
| Kafka UI | 8081 | http://localhost:8081 | Kafka 管理界面 |
| Zookeeper | 2181 | localhost:2181 | Kafka 协调服务 |

### 启动开发环境

```bash
# 进入开发环境目录
cd dev-env

# 启动开发环境服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看服务日志
docker-compose logs -f
```

### 开发环境数据库配置

- **数据库名**: `ceramicraft`
- **用户名**: `ceramicraft`
- **密码**: `ceramicraft123`
- **Root 密码**: `root123`

### 停止开发环境

```bash
# 在 dev-env 目录下执行
docker-compose down

# 停止并删除数据卷（会清除所有数据）
docker-compose down -v
```

## �🚀 快速开始

### 前置要求

确保您的系统已安装以下软件：

- [Docker](https://docs.docker.com/get-docker/) (版本 20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (版本 2.0+)
- [Git](https://git-scm.com/downloads) (版本 2.30+)

### 1. 克隆项目

```bash
# 克隆主项目仓库
git clone https://github.com/NUS-ISS-Agile-Team/ceramicraft-deploy.git
cd ceramicraft-deploy
```

### 2. 下载子模块

```bash
# 初始化并更新所有子模块
git submodule update --init --recursive

# 如果需要拉取子模块的最新更新
git submodule update --remote --recursive
```

**子模块说明：**
- `fe-mer`: 商户管理前端
- `fe-cus`: 客户购物前端
- `ms-user`: 用户管理微服务
- `ms-order`: 订单处理微服务
- `ms-pay`: 支付处理微服务
- `ms-cmdt`: 商品管理微服务

### 3. 准备 Nginx 配置

```bash
# 创建 Nginx 配置目录
mkdir -p nginx/conf.d

# 创建基础的 Nginx 配置文件
cat > nginx/conf.d/default.conf << 'EOF'
upstream merchant_frontend {
    server ceramicraft-merchant-frontend:80;
}

upstream customer_frontend {
    server ceramicraft-customer-frontend:80;
}

server {
    listen 80;
    server_name merchant.ceramicraft.local;
    
    location / {
        proxy_pass http://merchant_frontend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name customer.ceramicraft.local;
    
    location / {
        proxy_pass http://customer_frontend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF
```

### 4. 一键部署

```bash
# 构建并启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看服务日志
docker-compose logs -f
```

## 📊 服务访问

部署成功后，您可以通过以下方式访问各个服务：

| 服务 | 访问地址 | 说明 |
|------|----------|------|
| 商户前端 | http://localhost:80 (Host: merchant.ceramicraft.local) | 商户管理界面 |
| 客户前端 | http://localhost:80 (Host: customer.ceramicraft.local) | 客户购物界面 |
| 用户微服务 | http://localhost:8082 | HTTP API |
| 用户微服务 gRPC | localhost:9001 | gRPC 服务 |
| MySQL 数据库 | localhost:3306 | 数据库连接 |
| phpMyAdmin | http://localhost:8080 | 数据库管理（开发环境） |
| Kafka UI | http://localhost:8081 | 消息队列管理（开发环境） |

### 配置本地域名解析 (可选)

为了更好的本地开发体验，您可以在 `/etc/hosts` 文件中添加以下条目：

```bash
# macOS/Linux
sudo echo "127.0.0.1 merchant.ceramicraft.local" >> /etc/hosts
sudo echo "127.0.0.1 customer.ceramicraft.local" >> /etc/hosts

# Windows (管理员权限)
# 编辑 C:\Windows\System32\drivers\etc\hosts 文件
127.0.0.1 merchant.ceramicraft.local
127.0.0.1 customer.ceramicraft.local
```

## 🗄️ 数据库配置

### 生产环境数据库

系统会自动创建 MySQL 数据库，默认配置：

- **数据库名**: `ceramicraft`
- **用户名**: `ceramicraft`
- **密码**: `ceramicraft123`
- **Root 密码**: `ceramicraft123`

### 开发环境数据库

开发环境使用相同的数据库配置：

- **数据库名**: `ceramicraft`
- **用户名**: `ceramicraft`
- **密码**: `ceramicraft123`
- **Root 密码**: `root123`

数据会持久化存储在 Docker 卷中，重启容器后数据不会丢失。

您可以通过 phpMyAdmin (http://localhost:8080) 管理开发环境数据库。

## 🛠️ 开发和调试

### 查看实时日志

```bash
# 查看所有服务日志
docker-compose logs -f

# 查看特定服务日志
docker-compose logs -f ceramicraft-user-mservice
docker-compose logs -f mysql
```

### 重启服务

```bash
# 重启所有服务
docker-compose restart

# 重启特定服务
docker-compose restart ceramicraft-user-mservice
```

### 重新构建服务

```bash
# 重新构建并启动
docker-compose up -d --build

# 重新构建特定服务
docker-compose build ceramicraft-user-mservice
docker-compose up -d ceramicraft-user-mservice
```

## 🔧 故障排除

### 常见问题

1. **端口占用错误**
   ```bash
   # 检查端口占用
   lsof -i :80
   lsof -i :3306
   lsof -i :8080   # phpMyAdmin
   lsof -i :8081   # Kafka UI
   lsof -i :9092   # Kafka
   
   # 停止占用端口的服务或修改 docker-compose.yml 中的端口配置
   ```

2. **MySQL 连接失败**
   ```bash
   # 检查 MySQL 健康状态
   docker-compose ps mysql
   
   # 查看 MySQL 日志
   docker-compose logs mysql
   
   # 重置 MySQL 数据 (注意：会删除所有数据)
   docker-compose down
   docker volume rm ceramicraft-deploy_mysql_data  # 生产环境
   docker volume rm dev-env_mysql_data              # 开发环境
   docker-compose up -d
   ```

3. **Kafka 连接问题**
   ```bash
   # 检查 Kafka 和 Zookeeper 状态
   docker-compose ps kafka zookeeper
   
   # 查看 Kafka 日志
   docker-compose logs kafka
   
   # 重启 Kafka 服务
   docker-compose restart kafka zookeeper
   ```

4. **前端构建失败**
   ```bash
   # 清理构建缓存
   docker-compose build --no-cache fe-mer fe-cus
   ```

5. **子模块更新问题**
   ```bash
   # 强制更新子模块
   git submodule foreach --recursive git reset --hard
   git submodule update --init --recursive --force
   ```

### 清理环境

**生产环境清理：**
```bash
# 停止所有服务
docker-compose down

# 停止并删除数据卷 (注意：会删除数据库数据)
docker-compose down -v

# 删除所有相关镜像
docker-compose down --rmi all
```

**开发环境清理：**
```bash
# 在 dev-env 目录下执行
cd dev-env

# 停止开发环境服务
docker-compose down

# 停止并删除开发环境数据卷
docker-compose down -v

# 删除开发环境相关镜像
docker-compose down --rmi all
```

## 📝 更新项目

```bash
# 更新主项目
git pull origin main

# 更新所有子模块到最新版本
git submodule update --remote --recursive

# 重新构建并部署
docker-compose up -d --build
```

## 🤝 贡献指南

1. Fork 本项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 支持

如果您遇到问题或需要帮助：

- 提交 [Issue](https://github.com/NUS-ISS-Agile-Team/ceramicraft-deploy/issues)
- 查看项目文档
- 联系开发团队

---

**注意**: 本项目仅用于开发和测试环境。生产环境部署请参考生产环境配置指南。