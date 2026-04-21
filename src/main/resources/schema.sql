-- H2 Database Schema for Animation Website
-- =============================================
-- 1. 动漫列表表
-- =============================================
CREATE TABLE IF NOT EXISTS anime (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '动漫ID',
  title VARCHAR(255) NOT NULL COMMENT '动漫名称',
  cover_image VARCHAR(500) DEFAULT NULL COMMENT '封面图片地址',
  type VARCHAR(20) NOT NULL COMMENT '动漫类型(日本/国产/欧美/电影)',
  status VARCHAR(20) DEFAULT '连载中' COMMENT '动漫状态(连载中/已完结)',
  rating DOUBLE DEFAULT 0 COMMENT '评分',
  view_count INT DEFAULT 0 COMMENT '观看人数',
  tags VARCHAR(500) DEFAULT NULL COMMENT '标签(用逗号分隔)',
  description VARCHAR(1000) DEFAULT NULL COMMENT '简介',
  author VARCHAR(100) DEFAULT '未知' COMMENT '作者/原作',
  release_date DATE DEFAULT NULL COMMENT '上映日期',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

CREATE INDEX IF NOT EXISTS idx_type ON anime(type);
CREATE INDEX IF NOT EXISTS idx_status ON anime(status);
CREATE INDEX IF NOT EXISTS idx_rating ON anime(rating);
CREATE INDEX IF NOT EXISTS idx_view_count ON anime(view_count);

-- =============================================
-- 2. 动漫详情表
-- =============================================
CREATE TABLE IF NOT EXISTS anime_detail (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '详情ID',
  anime_id BIGINT NOT NULL COMMENT '关联的动漫ID',
  title VARCHAR(255) NOT NULL COMMENT '动漫名称',
  introduction TEXT COMMENT '动漫介绍',
  author VARCHAR(100) DEFAULT '未知' COMMENT '作者/原作',
  type VARCHAR(20) NOT NULL COMMENT '动漫类型(日本/国产/欧美/电影)',
  cover_image VARCHAR(500) DEFAULT NULL COMMENT '封面图片地址',
  background_image VARCHAR(500) DEFAULT NULL COMMENT '背景图片地址',
  rating DOUBLE DEFAULT 0 COMMENT '评分',
  view_count INT DEFAULT 0 COMMENT '观看人数',
  favorite_count INT DEFAULT 0 COMMENT '收藏人数',
  tags VARCHAR(500) DEFAULT NULL COMMENT '标签(用逗号分隔)',
  status VARCHAR(20) DEFAULT '连载中' COMMENT '状态(连载中/已完结)',
  total_episodes INT DEFAULT 0 COMMENT '集数',
  release_date DATE DEFAULT NULL COMMENT '上映日期',
  studio VARCHAR(100) DEFAULT NULL COMMENT '制作公司',
  director VARCHAR(100) DEFAULT NULL COMMENT '导演',
  voice_actors VARCHAR(500) DEFAULT NULL COMMENT '主要配音演员(用逗号分隔)',
  video_url VARCHAR(500) DEFAULT NULL COMMENT '视频地址(播放链接)',
  episode_urls TEXT COMMENT '每集视频地址(JSON格式)',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_anime_id ON anime_detail(anime_id);
CREATE INDEX IF NOT EXISTS idx_title ON anime_detail(title);
CREATE INDEX IF NOT EXISTS idx_rating_detail ON anime_detail(rating);
CREATE INDEX IF NOT EXISTS idx_view_count_detail ON anime_detail(view_count);

-- =============================================
-- 3. 评论表
-- =============================================
CREATE TABLE IF NOT EXISTS anime_comment (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '评论ID',
  anime_id BIGINT NOT NULL COMMENT '动漫ID',
  user_id BIGINT DEFAULT NULL COMMENT '用户ID(NULL表示游客)',
  username VARCHAR(100) NOT NULL DEFAULT '匿名用户' COMMENT '用户名',
  avatar VARCHAR(500) DEFAULT NULL COMMENT '用户头像',
  content VARCHAR(1000) NOT NULL COMMENT '评论内容',
  rating INT DEFAULT NULL COMMENT '评分(1-10)',
  likes INT DEFAULT 0 COMMENT '点赞数',
  parent_id BIGINT DEFAULT NULL COMMENT '父评论ID(回复)',
  status TINYINT DEFAULT 1 COMMENT '状态(0:禁用 1:正常)',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间'
);

CREATE INDEX IF NOT EXISTS idx_anime_id_comment ON anime_comment(anime_id);
CREATE INDEX IF NOT EXISTS idx_user_id_comment ON anime_comment(user_id);
CREATE INDEX IF NOT EXISTS idx_create_time_comment ON anime_comment(create_time);

-- =============================================
-- 4. 收藏表
-- =============================================
CREATE TABLE IF NOT EXISTS anime_favorite (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '收藏ID',
  anime_id BIGINT NOT NULL COMMENT '动漫ID',
  user_id BIGINT NOT NULL COMMENT '用户ID',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间'
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_user_anime ON anime_favorite(user_id, anime_id);
CREATE INDEX IF NOT EXISTS idx_user_id_fav ON anime_favorite(user_id);
CREATE INDEX IF NOT EXISTS idx_anime_id_fav ON anime_favorite(anime_id);

-- =============================================
-- 5. 观看历史表
-- =============================================
CREATE TABLE IF NOT EXISTS watch_history (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '记录ID',
  anime_id BIGINT NOT NULL COMMENT '动漫ID',
  user_id BIGINT DEFAULT NULL COMMENT '用户ID',
  session_id VARCHAR(100) DEFAULT NULL COMMENT '会话ID(游客)',
  episode INT DEFAULT 1 COMMENT '看到第几集',
  progress INT DEFAULT 0 COMMENT '播放进度(秒)',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

CREATE INDEX IF NOT EXISTS idx_user_id_history ON watch_history(user_id);
CREATE INDEX IF NOT EXISTS idx_anime_id_history ON watch_history(anime_id);

-- =============================================
-- 6. 动漫资讯新闻表
-- =============================================
CREATE TABLE IF NOT EXISTS anime_news (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '新闻ID',
  title VARCHAR(500) NOT NULL COMMENT '标题',
  summary VARCHAR(1000) DEFAULT NULL COMMENT '摘要',
  content TEXT COMMENT '正文内容',
  cover_image VARCHAR(500) DEFAULT NULL COMMENT '封面图片',
  category VARCHAR(50) DEFAULT '资讯' COMMENT '分类(新番资讯/声优消息/制作动态/周边情报)',
  source VARCHAR(100) DEFAULT NULL COMMENT '来源',
  view_count INT DEFAULT 0 COMMENT '浏览量',
  tags VARCHAR(200) DEFAULT NULL COMMENT '标签',
  status TINYINT DEFAULT 1 COMMENT '状态(0:草稿 1:发布)',
  publish_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
);

CREATE INDEX IF NOT EXISTS idx_category ON anime_news(category);
CREATE INDEX IF NOT EXISTS idx_publish_time ON anime_news(publish_time);

-- =============================================
-- 7. 用户表（Spring Security 用）
-- =============================================
CREATE TABLE IF NOT EXISTS users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '用户ID',
  username VARCHAR(100) NOT NULL COMMENT '用户名',
  password VARCHAR(255) NOT NULL COMMENT '密码(BCrypt加密)',
  email VARCHAR(200) DEFAULT NULL COMMENT '邮箱',
  nickname VARCHAR(100) DEFAULT NULL COMMENT '昵称',
  avatar VARCHAR(500) DEFAULT NULL COMMENT '头像URL',
  enabled TINYINT DEFAULT 1 COMMENT '是否启用',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_username ON users(username);
CREATE UNIQUE INDEX IF NOT EXISTS uk_email ON users(email);

-- =============================================
-- 8. 角色表
-- =============================================
CREATE TABLE IF NOT EXISTS roles (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '角色ID',
  name VARCHAR(50) NOT NULL COMMENT '角色名称(ROLE_USER/ROLE_ADMIN)',
  organization_id BIGINT DEFAULT NULL,
  privacy TINYINT DEFAULT 0
);

CREATE UNIQUE INDEX IF NOT EXISTS uk_name ON roles(name);

-- =============================================
-- 9. 用户角色关联表
-- =============================================
CREATE TABLE IF NOT EXISTS users_roles (
  user_id BIGINT NOT NULL COMMENT '用户ID',
  role_id BIGINT NOT NULL COMMENT '角色ID',
  PRIMARY KEY (user_id, role_id)
);

-- =============================================
-- 10. 系统用户扩展信息表
-- =============================================
CREATE TABLE IF NOT EXISTS userinfo (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID',
  name VARCHAR(100) DEFAULT NULL COMMENT '姓名',
  card VARCHAR(50) DEFAULT NULL COMMENT '卡号',
  sex VARCHAR(10) DEFAULT NULL COMMENT '性别',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
);

-- =============================================
-- 11. 分类管理表
-- =============================================
CREATE TABLE IF NOT EXISTS category (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '分类ID',
  name VARCHAR(100) NOT NULL COMMENT '分类名称',
  code VARCHAR(50) NOT NULL COMMENT '分类标识',
  type VARCHAR(20) DEFAULT 'anime' COMMENT '类型(anime/news)',
  parent_id BIGINT DEFAULT NULL COMMENT '上级分类ID',
  sort_order INT DEFAULT 0 COMMENT '排序',
  status TINYINT DEFAULT 1 COMMENT '状态(0:禁用 1:启用)',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- =============================================
-- 12. 轮播图表
-- =============================================
CREATE TABLE IF NOT EXISTS banner (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '轮播图ID',
  title VARCHAR(255) NOT NULL COMMENT '标题',
  image_url VARCHAR(500) NOT NULL COMMENT '图片URL',
  link_url VARCHAR(500) DEFAULT NULL COMMENT '链接地址',
  anime_id BIGINT DEFAULT NULL COMMENT '关联动漫ID',
  description VARCHAR(500) DEFAULT NULL COMMENT '描述',
  sort_order INT DEFAULT 0 COMMENT '排序',
  location VARCHAR(20) DEFAULT 'home' COMMENT '位置(home/anime)',
  status TINYINT DEFAULT 1 COMMENT '状态(0:禁用 1:启用)',
  start_time TIMESTAMP DEFAULT NULL COMMENT '开始时间',
  end_time TIMESTAMP DEFAULT NULL COMMENT '结束时间',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);

-- =============================================
-- 13. 首页配置表
-- =============================================
CREATE TABLE IF NOT EXISTS home_config (
  id BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '配置ID',
  name VARCHAR(100) NOT NULL COMMENT '配置名称',
  type VARCHAR(50) NOT NULL COMMENT '配置类型(banner/latest/hot/japanese/chinese/western/news/ranking)',
  anime_id BIGINT DEFAULT NULL COMMENT '关联动漫ID',
  news_id BIGINT DEFAULT NULL COMMENT '关联资讯ID',
  sort_order INT DEFAULT 0 COMMENT '排序',
  status TINYINT DEFAULT 1 COMMENT '状态(0:禁用 1:启用)',
  create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
);
