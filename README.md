# 哈哈动漫网

一个基于 Spring Boot 的动漫网站管理系统，包含前台展示页面和后台管理功能。

## 项目简介

哈哈动漫网是一个完整的动漫资讯和播放平台，提供动漫浏览、搜索、详情查看、评论互动等功能，并配备完善的后台管理系统。

## 技术栈

| 技术 | 说明 |
|------|------|
| Spring Boot 3.1.5 | 后端框架 |
| Java 17 | 开发语言 |
| MyBatis-Plus 3.5.7 | ORM 框架 |
| Spring Security 6 | 安全框架 |
| Thymeleaf | 模板引擎 |
| H2 Database | 嵌入式数据库 |
| HikariCP | 数据库连接池 |

## 功能模块

### 前台网站
- **首页** - 轮播图、热门推荐、最新更新
- **日本动漫** - 日本动漫列表、筛选、排序
- **国产动漫** - 国产动漫列表
- **欧美动漫** - 欧美动漫列表
- **动漫电影** - 动漫电影列表
- **动漫详情** - 播放、简介、评论、收藏
- **资讯中心** - 动漫相关新闻资讯
- **排行榜** - 各类别排行榜

### 后台管理
- **控制台** - 数据统计概览
- **动漫管理** - 增删改查动漫信息
- **资讯管理** - 管理动漫资讯
- **分类管理** - 管理动漫分类
- **轮播图管理** - 首页轮播图配置
- **首页配置** - 首页内容配置
- **用户管理** - 查看用户信息

## 项目结构

```
animation/
├── src/main/java/com/web/animation/
│   ├── controller/          # 控制器
│   │   ├── AdminController.java      # 后台管理
│   │   ├── AnimeController.java       # 动漫API
│   │   ├── AnimeWebController.java    # 前台页面
│   │   └── HomeController.java        # 首页
│   ├── entity/              # 实体类
│   │   ├── Anime.java               # 动漫
│   │   ├── AnimeDetail.java         # 动漫详情
│   │   ├── AnimeComment.java        # 评论
│   │   ├── AnimeNews.java           # 资讯
│   │   ├── Banner.java              # 轮播图
│   │   ├── Category.java            # 分类
│   │   ├── HomeConfig.java          # 首页配置
│   │   └── User.java                # 用户
│   ├── mapper/              # 数据访问层
│   ├── service/             # 业务逻辑
│   ├── dto/                 # 数据传输对象
│   └── util/                # 工具类
├── src/main/resources/
│   ├── templates/           # Thymeleaf 页面
│   │   ├── admin/          # 后台管理页面
│   │   └── animation/       # 前台展示页面
│   ├── schema.sql           # 数据库表结构
│   └── data.sql             # 初始化数据
└── pom.xml
```

## 快速开始

### 环境要求
- JDK 17+
- Maven 3.6+

### 启动步骤

1. **克隆项目**
```bash
git clone <项目地址>
cd animation
```

2. **修改数据库配置**（可选，默认使用 H2）
```yaml
# application.yml
spring:
  datasource:
    url: jdbc:h2:file:./animation_db
    driver-class-name: org.h2.Driver
    username: sa
    password:
```

3. **编译运行**
```bash
mvn clean compile
mvn spring-boot:run
```

4. **访问应用**
- 前台网站: http://localhost:8080/
- 后台管理: http://localhost:8080/admin
- H2 控制台: http://localhost:8080/h2-console

### 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin22121 | admin123 |

## 页面说明

### 前台页面 (templates/animation/)

| 页面 | 路径 | 说明 |
|------|------|------|
| 首页 | / | 展示轮播图、热门推荐等 |
| 日本动漫 | /anime/japanese | 日本动漫列表 |
| 国产动漫 | /anime/chinese | 国产动漫列表 |
| 欧美动漫 | /anime/western | 欧美动漫列表 |
| 动漫电影 | /anime/movie | 动漫电影列表 |
| 动漫详情 | /anime/detail/{id} | 播放页面、简介、评论 |
| 排行榜 | /ranking | 各类别排行榜 |
| 资讯中心 | /news | 动漫资讯列表 |
| 资讯详情 | /news/{id} | 资讯详情页 |
| 登录 | /login | 用户登录 |

### 后台页面 (templates/admin/)

| 页面 | 路径 | 说明 |
|------|------|------|
| 控制台 | /admin/index | 数据统计 |
| 动漫列表 | /admin/anime | 动漫列表/搜索 |
| 添加动漫 | /admin/anime/add | 新增动漫 |
| 编辑动漫 | /admin/anime/edit/{id} | 编辑动漫信息 |
| 资讯列表 | /admin/news | 资讯列表 |
| 添加资讯 | /admin/news/add | 新增资讯 |
| 编辑资讯 | /admin/news/edit/{id} | 编辑资讯 |
| 分类列表 | /admin/category | 分类管理 |
| 轮播图列表 | /admin/banner | 轮播图管理 |
| 首页配置 | /admin/home/config | 首页内容配置 |
| 用户列表 | /admin/user | 用户管理 |

## API 接口

### 动漫接口

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /api/anime/list | 获取动漫列表（不分页） |
| GET | /api/anime/list/page | 分页获取动漫列表 |
| GET | /api/anime/detail/{id} | 获取动漫详情 |
| GET | /api/anime/detail | 按名称获取详情 |
| GET | /api/anime/search | 搜索动漫 |
| GET | /api/anime/ranking | 获取排行榜 |
| GET | /api/anime/home | 首页聚合数据 |

### 评论接口

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /api/anime/{id}/comments | 获取评论列表 |
| POST | /api/anime/{id}/comments | 发表评论 |
| POST | /api/anime/comments/{commentId}/like | 评论点赞 |

### 收藏接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | /api/anime/{id}/favorite | 收藏/取消收藏 |
| GET | /api/anime/{id}/favorite/status | 查询收藏状态 |
| GET | /api/anime/favorites | 获取收藏列表 |

### 资讯接口

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /api/anime/news | 获取资讯列表 |
| GET | /api/anime/news/{id} | 获取资讯详情 |

### 用户接口

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | /api/anime/register | 用户注册 |

## 数据库表

| 表名 | 说明 |
|------|------|
| anime | 动漫列表 |
| anime_detail | 动漫详情 |
| anime_comment | 评论表 |
| anime_favorite | 收藏表 |
| watch_history | 观看历史 |
| anime_news | 资讯新闻 |
| users | 用户表 |
| roles | 角色表 |
| users_roles | 用户角色关联 |
| category | 分类表 |
| banner | 轮播图表 |
| home_config | 首页配置 |

## 常用命令

### 打包
```bash
mvn clean package -DskipTests
```

### 运行打包后的 jar
```bash
java -jar target/animation-0.0.1-SNAPSHOT.jar
```

### 清除数据库重新初始化
```bash
# 删除数据库文件
rm animation_db.mv.db animation_db.trace.db
# 重启应用即可重新初始化
```

## 开发说明

### 页面模板
- 前台页面使用 Thymeleaf 模板引擎
- 支持静态 HTML 和动态数据渲染
- 异步数据加载通过 Fetch API 实现

### 安全配置
- 后台管理需要管理员权限
- 使用 Spring Security 进行权限控制
- CSRF 防护已配置

### 数据初始化
- 应用启动时自动执行 `data.sql`
- 使用 H2 MERGE INTO 语法避免重复数据
- 可通过删除数据库文件重置数据

## 许可证

本项目仅供学习交流使用。
