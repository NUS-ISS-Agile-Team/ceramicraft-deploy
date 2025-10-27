# CeramiCraft 一键部署指南

[README in English Click Me](./README_EN.md)

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
├── ms-comt/                   # 评论微服务 (Go)
├── monitor-serv/              # 监控环境配置
├── nginx/                     # Nginx 配置
├── mysql/                     # MySQL 初始化脚本
└── docker-compose.yml         # 生产环境 Docker 编排文件
```

## 快速开始

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
- `ms-comt`: 商品管理微服务

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

部署成功后，您**配置本地域名解析**后可以通过以下方式访问各个服务：

| 服务 | 访问地址 | 说明 |
|------|----------|------|
| 商户前端 | http://ceramicraft-customer-frontend | 商户管理界面 |
| 客户前端 | http://ceramicraft-customer-frontend | 客户购物界面 |

### 配置本地域名解析

为了更好的本地开发体验，您可以在 `/etc/hosts` 文件中添加以下条目：

```bash
# macOS/Linux
sudo echo "127.0.0.1 ceramicraft-merchant-frontend" >> /etc/hosts
sudo echo "127.0.0.1 ceramicraft-customer-frontend" >> /etc/hosts

# Windows (管理员权限)
# 编辑 C:\Windows\System32\drivers\etc\hosts 文件
127.0.0.1 ceramicraft-merchant-frontend
127.0.0.1 ceramicraft-customer-frontend
```

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

## 清理环境

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