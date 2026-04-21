-- 动漫网站数据库建表脚本（完整版）
-- 数据库：base

-- =============================================
-- 1. 动漫列表表
-- =============================================
CREATE TABLE IF NOT EXISTS `anime` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '动漫ID',
  `title` varchar(255) NOT NULL COMMENT '动漫名称',
  `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片地址',
  `type` varchar(20) NOT NULL COMMENT '动漫类型(日本/国产/欧美/电影)',
  `status` varchar(20) DEFAULT '连载中' COMMENT '动漫状态(连载中/已完结)',
  `rating` double DEFAULT 0 COMMENT '评分',
  `view_count` int DEFAULT 0 COMMENT '观看人数',
  `tags` varchar(500) DEFAULT NULL COMMENT '标签(用逗号分隔)',
  `description` varchar(1000) DEFAULT NULL COMMENT '简介',
  `release_date` date DEFAULT NULL COMMENT '上映日期',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_rating` (`rating`),
  KEY `idx_view_count` (`view_count`),
  FULLTEXT KEY `ft_title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫列表表';

-- =============================================
-- 2. 动漫详情表
-- =============================================
CREATE TABLE IF NOT EXISTS `anime_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '详情ID',
  `anime_id` bigint NOT NULL COMMENT '关联的动漫ID',
  `title` varchar(255) NOT NULL COMMENT '动漫名称',
  `introduction` text COMMENT '动漫介绍',
  `type` varchar(20) NOT NULL COMMENT '动漫类型(日本/国产/欧美/电影)',
  `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片地址',
  `background_image` varchar(500) DEFAULT NULL COMMENT '背景图片地址',
  `rating` double DEFAULT 0 COMMENT '评分',
  `view_count` int DEFAULT 0 COMMENT '观看人数',
  `favorite_count` int DEFAULT 0 COMMENT '收藏人数',
  `tags` varchar(500) DEFAULT NULL COMMENT '标签(用逗号分隔)',
  `status` varchar(20) DEFAULT '连载中' COMMENT '状态(连载中/已完结)',
  `total_episodes` int DEFAULT 0 COMMENT '集数',
  `release_date` date DEFAULT NULL COMMENT '上映日期',
  `studio` varchar(100) DEFAULT NULL COMMENT '制作公司',
  `director` varchar(100) DEFAULT NULL COMMENT '导演',
  `voice_actors` varchar(500) DEFAULT NULL COMMENT '主要配音演员(用逗号分隔)',
  `video_url` varchar(500) DEFAULT NULL COMMENT '视频地址(播放链接)',
  `episode_urls` text COMMENT '每集视频地址(JSON格式)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_anime_id` (`anime_id`),
  KEY `idx_title` (`title`),
  KEY `idx_rating` (`rating`),
  KEY `idx_view_count` (`view_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫详情表';

-- =============================================
-- 3. 评论表
-- =============================================
CREATE TABLE IF NOT EXISTS `anime_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `anime_id` bigint NOT NULL COMMENT '动漫ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID(NULL表示游客)',
  `username` varchar(100) NOT NULL DEFAULT '匿名用户' COMMENT '用户名',
  `avatar` varchar(500) DEFAULT NULL COMMENT '用户头像',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `rating` int DEFAULT NULL COMMENT '评分(1-10)',
  `likes` int DEFAULT 0 COMMENT '点赞数',
  `parent_id` bigint DEFAULT NULL COMMENT '父评论ID(回复)',
  `status` tinyint DEFAULT 1 COMMENT '状态(0:禁用 1:正常)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`),
  KEY `idx_anime_id` (`anime_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫评论表';

-- =============================================
-- 4. 收藏表
-- =============================================
CREATE TABLE IF NOT EXISTS `anime_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `anime_id` bigint NOT NULL COMMENT '动漫ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_anime` (`user_id`, `anime_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_anime_id` (`anime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫收藏表';

-- =============================================
-- 5. 观看历史表
-- =============================================
CREATE TABLE IF NOT EXISTS `watch_history` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `anime_id` bigint NOT NULL COMMENT '动漫ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `session_id` varchar(100) DEFAULT NULL COMMENT '会话ID(游客)',
  `episode` int DEFAULT 1 COMMENT '看到第几集',
  `progress` int DEFAULT 0 COMMENT '播放进度(秒)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '记录时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_anime_id` (`anime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='观看历史表';

-- =============================================
-- 6. 动漫资讯新闻表
-- =============================================
CREATE TABLE IF NOT EXISTS `anime_news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '新闻ID',
  `title` varchar(500) NOT NULL COMMENT '标题',
  `summary` varchar(1000) DEFAULT NULL COMMENT '摘要',
  `content` text COMMENT '正文内容',
  `cover_image` varchar(500) DEFAULT NULL COMMENT '封面图片',
  `category` varchar(50) DEFAULT '资讯' COMMENT '分类(新番资讯/声优消息/制作动态/周边情报)',
  `source` varchar(100) DEFAULT NULL COMMENT '来源',
  `view_count` int DEFAULT 0 COMMENT '浏览量',
  `tags` varchar(200) DEFAULT NULL COMMENT '标签',
  `status` tinyint DEFAULT 1 COMMENT '状态(0:草稿 1:发布)',
  `publish_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category`),
  KEY `idx_publish_time` (`publish_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='动漫资讯新闻表';

-- =============================================
-- 7. 用户表（Spring Security 用）
-- =============================================
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码(BCrypt加密)',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `nickname` varchar(100) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(500) DEFAULT NULL COMMENT '头像URL',
  `enabled` tinyint DEFAULT 1 COMMENT '是否启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- =============================================
-- 8. 角色表
-- =============================================
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(50) NOT NULL COMMENT '角色名称(ROLE_USER/ROLE_ADMIN)',
  `organization_id` bigint DEFAULT NULL,
  `privacy` tinyint DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- =============================================
-- 9. 用户角色关联表
-- =============================================
CREATE TABLE IF NOT EXISTS `users_roles` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户角色关联表';

-- =============================================
-- 10. 系统用户扩展信息表
-- =============================================
CREATE TABLE IF NOT EXISTS `userinfo` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `card` varchar(50) DEFAULT NULL COMMENT '卡号',
  `sex` varchar(10) DEFAULT NULL COMMENT '性别',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户扩展信息表';

-- =============================================
-- 数据初始化
-- =============================================

-- 初始化角色
INSERT IGNORE INTO `roles` (`name`) VALUES ('ROLE_USER'), ('ROLE_ADMIN');

-- 初始化管理员账号 (密码: admin123)
INSERT IGNORE INTO `users` (`username`, `password`, `email`, `nickname`, `enabled`) VALUES
('admin', '$2a$10$7EqJtq98hPqEX7fNZaFWoO7b2N.7mSGKBmU/E6gd/1bfFOPkHUuWq', 'admin@haha.com', '管理员', 1),
('admin22121', '$2a$10$7EqJtq98hPqEX7fNZaFWoO7b2N.7mSGKBmU/E6gd/1bfFOPkHUuWq', 'admin22121@haha.com', '超级管理员', 1),
('test', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE5cZmElkBMp5t.02', 'test@haha.com', '测试用户', 1);

-- 分配角色
INSERT IGNORE INTO `users_roles` (`user_id`, `role_id`) 
SELECT u.id, r.id FROM `users` u, `roles` r 
WHERE u.username = 'admin' AND r.name = 'ROLE_ADMIN';

INSERT IGNORE INTO `users_roles` (`user_id`, `role_id`) 
SELECT u.id, r.id FROM `users` u, `roles` r 
WHERE u.username = 'admin' AND r.name = 'ROLE_USER';

INSERT IGNORE INTO `users_roles` (`user_id`, `role_id`) 
SELECT u.id, r.id FROM `users` u, `roles` r 
WHERE u.username = 'admin22121' AND r.name = 'ROLE_ADMIN';

INSERT IGNORE INTO `users_roles` (`user_id`, `role_id`) 
SELECT u.id, r.id FROM `users` u, `roles` r 
WHERE u.username = 'admin22121' AND r.name = 'ROLE_USER';

INSERT IGNORE INTO `users_roles` (`user_id`, `role_id`) 
SELECT u.id, r.id FROM `users` u, `roles` r 
WHERE u.username = 'test' AND r.name = 'ROLE_USER';

-- =============================================
-- 日本动漫数据（30条）
-- =============================================
INSERT INTO `anime` (`title`, `cover_image`, `type`, `status`, `rating`, `view_count`, `tags`, `description`, `release_date`) VALUES
('海贼王', 'https://img.acgn.cc/anime/one-piece.jpg', '日本', '连载中', 9.9, 12500000, '热血,冒险,友情', '少年路飞为了找到传说中的ONE PIECE，与伙伴们踏上冒险之旅的故事。', '1999-10-20'),
('火影忍者', 'https://img.acgn.cc/anime/naruto.jpg', '日本', '已完结', 9.8, 9800000, '热血,忍者,成长', '少年漩涡鸣人为了成为火影，不断修炼成长的故事。', '2002-10-03'),
('咒术回战', 'https://img.acgn.cc/anime/jjk.jpg', '日本', '连载中', 9.7, 8200000, '热血,战斗,奇幻', '高中生虎杖悠仁吞下特级咒物，进入咒术高专的故事。', '2020-10-03'),
('鬼灭之刃', 'https://img.acgn.cc/anime/demon-slayer.jpg', '日本', '连载中', 9.6, 10500000, '热血,战斗,亲情', '灶门炭治郎为了拯救变成鬼的妹妹，踏上猎鬼之旅的故事。', '2019-04-06'),
('我的英雄学院', 'https://img.acgn.cc/anime/mha.jpg', '日本', '连载中', 9.5, 7800000, '热血,超能力,成长', '无个性少年绿谷出久获得最强个性，成为英雄的故事。', '2016-04-03'),
('进击的巨人', 'https://img.acgn.cc/anime/aot.jpg', '日本', '已完结', 9.9, 11200000, '战斗,悬疑,剧情', '艾伦等人对抗巨人的故事，揭露世界真相的史诗巨作。', '2013-04-07'),
('名侦探柯南', 'https://img.acgn.cc/anime/detective-conan.jpg', '日本', '连载中', 9.7, 13500000, '推理,悬疑,侦探', '高中生侦探工藤新一被变小后化名江户川柯南破案的故事。', '1996-01-08'),
('关于我转生变成史莱姆这档事', 'https://img.acgn.cc/anime/teslime.jpg', '日本', '连载中', 9.5, 6500000, '转生,奇幻,冒险', '上班族转生成为最强史莱姆的异世界冒险故事。', '2018-10-02'),
('全职猎人', 'https://img.acgn.cc/anime/hxh.jpg', '日本', '连载中', 9.8, 7200000, '热血,冒险,成长', '小杰为了寻找父亲成为猎人的冒险故事。', '2011-10-02'),
('刀剑神域', 'https://img.acgn.cc/anime/sao.jpg', '日本', '已完结', 9.4, 8900000, '游戏,冒险,恋爱', '桐人被困在VRMMORPG中，为了通关而战斗的故事。', '2012-07-08'),
('Re:从零开始的异世界生活', 'https://img.acgn.cc/anime/rezero.jpg', '日本', '连载中', 9.6, 7500000, '转生,奇幻,悬疑', '菜月昴穿越到异世界，拥有死亡回归能力的冒险故事。', '2016-04-04'),
('排球少年', 'https://img.acgn.cc/anime/haikyuu.jpg', '日本', '已完结', 9.7, 6800000, '运动,校园,热血', '日向翔阳加入排球部，向着全国大赛努力的青春物语。', '2014-04-06'),
('间谍过家家', 'https://img.acgn.cc/anime/spy-family.jpg', '日本', '连载中', 9.5, 9200000, '搞笑,家庭,动作', '间谍、杀手和超能力者组成的虚假家庭的日常生活。', '2022-04-09'),
('葬送的芙莉莲', 'https://img.acgn.cc/anime/frieren.jpg', '日本', '已完结', 9.8, 5600000, '奇幻,冒险,治愈', '活了千年的精灵魔法师芙莉莲的冒险旅程。', '2023-09-29'),
('迷宫饭', 'https://img.acgn.cc/anime/dungeon-meshi.jpg', '日本', '已完结', 9.6, 4900000, '奇幻,美食,冒险', '在地下迷宫中烹饪怪物料理的冒险故事。', '2024-01-04'),
('我独自升级', 'https://img.acgn.cc/anime/solo-leveling.jpg', '日本', '已完结', 9.6, 8800000, '动作,冒险,成长', '最弱猎人程肖宇获得系统能力成为最强。', '2024-01-07'),
('电锯人', 'https://img.acgn.cc/anime/chainsaw-man.jpg', '日本', '连载中', 9.4, 7100000, '动作,黑暗,奇幻', '电锯人淀治猎杀恶魔的故事。', '2022-10-11'),
('辉夜大小姐想让我告白', 'https://img.acgn.cc/anime/kaguya.jpg', '日本', '连载中', 9.3, 6500000, '恋爱,校园,搞笑', '秀知院学园学生会会长的恋爱头脑战。', '2019-01-12'),
('一拳超人', 'https://img.acgn.cc/anime/opm.jpg', '日本', '连载中', 9.5, 8200000, '动作,搞笑,英雄', '埼玉老师一拳解决一切的英雄故事。', '2015-10-05'),
('紫罗兰永恒花园', 'https://img.acgn.cc/anime/violet.jpg', '日本', '已完结', 9.7, 5900000, '剧情,治愈,战争', '自动手记人偶薇尔莉特寻找感情真谛的故事。', '2018-01-11'),
('你的名字', 'https://img.acgn.cc/anime/your-name.jpg', '日本', '已完结', 9.8, 15800000, '剧情,恋爱,奇幻', '高中男女互换身体引发的奇幻爱情故事。', '2016-08-26'),
('千与千寻', 'https://img.acgn.cc/anime/spirited-away.jpg', '日本', '已完结', 9.9, 17200000, '奇幻,冒险,成长', '千寻在神灵世界的冒险与成长。', '2001-07-20'),
('死神', 'https://img.acgn.cc/anime/bleach.jpg', '日本', '连载中', 9.3, 7600000, '热血,战斗,死神', '黑崎一护获得死神力量的故事。', '2004-10-05'),
('银魂', 'https://img.acgn.cc/anime/gintama.jpg', '日本', '已完结', 9.7, 6200000, '搞笑,武士,剧情', '坂田银时和他的伙伴们的日常冒险。', '2006-04-04'),
('夏目友人帐', 'https://img.acgn.cc/anime/natsume.jpg', '日本', '连载中', 9.5, 3800000, '治愈,奇幻,妖怪', '夏目玲子与猫咪老师归还妖怪名字的故事。', '2008-07-08'),
('哆啦A梦', 'https://img.acgn.cc/anime/doraemon.jpg', '日本', '连载中', 9.6, 14500000, '搞笑,奇幻,成长', '来自未来的猫型机器人哆啦A梦帮助大雄的故事。', '1979-04-02'),
('灌篮高手', 'https://img.acgn.cc/anime/slam-dunk.jpg', '日本', '已完结', 9.8, 11200000, '运动,热血,校园', '湘北篮球队向着全国大赛努力的青春物语。', '1993-10-16'),
('龙珠超', 'https://img.acgn.cc/anime/db-super.jpg', '日本', '已完结', 9.4, 9500000, '热血,战斗,科幻', '悟空等人面对强大宇宙敌人的战斗。', '2015-07-05'),
('灵能百分百', 'https://img.acgn.cc/anime/mob100.jpg', '日本', '已完结', 9.6, 4100000, '动作,成长,奇幻', '超能力少年影山茂夫的成长故事。', '2016-07-12'),
('不死不幸', 'https://img.acgn.cc/anime/undead-unluck.jpg', '日本', '已完结', 9.5, 4200000, '奇幻,动作,恋爱', '不幸少女和不死能力的奇妙相遇。', '2023-10-07');

-- =============================================
-- 国产动漫数据（20条）
-- =============================================
INSERT INTO `anime` (`title`, `cover_image`, `type`, `status`, `rating`, `view_count`, `tags`, `description`, `release_date`) VALUES
('斗破苍穹', 'https://img.acgn.cc/anime/doupo.jpg', '国产', '连载中', 9.5, 8800000, '热血,修炼,冒险', '少年萧炎从天才跌落废柴，凭借异火重登巅峰的故事。', '2017-01-07'),
('斗罗大陆', 'https://img.acgn.cc/anime/douluodalu.jpg', '国产', '连载中', 9.4, 9200000, '热血,武魂,冒险', '唐三带着唐门暗器绝学穿越到斗罗大陆的故事。', '2018-01-20'),
('完美世界', 'https://img.acgn.cc/anime/wanmei.jpg', '国产', '连载中', 9.3, 7500000, '修仙,冒险,成长', '石昊从小村庄走向无尽苍穹，追寻完美大道的故事。', '2021-03-13'),
('遮天', 'https://img.acgn.cc/anime/zhetian.jpg', '国产', '连载中', 9.2, 6900000, '修仙,探索,热血', '叶凡从月坟中走出，踏上不朽之路的故事。', '2023-06-18'),
('吞噬星空', 'https://img.acgn.cc/anime/tunshi.jpg', '国产', '连载中', 9.1, 6300000, '科幻,修炼,冒险', '罗峰以武力称雄，从地球走向宇宙的故事。', '2019-01-26'),
('万界独尊', 'https://img.acgn.cc/anime/wanjie.jpg', '国产', '连载中', 8.9, 5800000, '修仙,热血,冒险', '独自踏上修仙之路，寻求万界之巅的故事。', '2021-09-11'),
('凡人修仙传', 'https://img.acgn.cc/anime/fanren.jpg', '国产', '连载中', 9.3, 7100000, '修仙,成长,冒险', '平凡少年韩立踏上修仙之路，历经千辛终成大乘修士。', '2020-07-25'),
('一人之下', 'https://img.acgn.cc/anime/yirenzhixia.jpg', '国产', '连载中', 9.4, 8500000, '异能,热血,悬疑', '张楚岚拥有神秘力量，卷入奇人异事的故事。', '2016-07-10'),
('魁拔', 'https://img.acgn.cc/anime/kuiba.jpg', '国产', '已完结', 9.0, 4200000, '奇幻,热血,冒险', '少年蛮吉成长为魁拔的奇幻冒险故事。', '2011-07-08'),
('秦时明月', 'https://img.acgn.cc/anime/qinshi.jpg', '国产', '连载中', 9.3, 9800000, '历史,武侠,冒险', '秦时代背景，荆轲转世少年的江湖冒险故事。', '2007-01-01'),
('那年那兔那些事', 'https://img.acgn.cc/anime/natu.jpg', '国产', '已完结', 9.6, 6700000, '历史,热血,感动', '以小兔子为主角讲述中国近现代史的热血动漫。', '2015-03-12'),
('镇魂街', 'https://img.acgn.cc/anime/zhenhunjie.jpg', '国产', '连载中', 9.1, 5500000, '武魂,热血,战斗', '镇守镇魂街的曹焱兵成长为一方守护者的故事。', '2017-07-11'),
('天官赐福', 'https://img.acgn.cc/anime/tianguan.jpg', '国产', '连载中', 9.5, 7800000, '仙侠,唯美,奇幻', '三太子谢怜八百年后重回天庭的故事。', '2020-10-31'),
('魔道祖师', 'https://img.acgn.cc/anime/modao.jpg', '国产', '已完结', 9.6, 8900000, '仙侠,悬疑,感情', '魏无羡与蓝忘机斩妖除魔的故事。', '2018-07-09'),
('灵笼', 'https://img.acgn.cc/anime/linglong.jpg', '国产', '连载中', 9.4, 5200000, '科幻,末世,冒险', '未来末世中人类与灵笼力量的抗争故事。', '2019-10-17'),
('雾山五行', 'https://img.acgn.cc/anime/wushan.jpg', '国产', '连载中', 9.5, 4600000, '水墨,奇幻,武侠', '以中国水墨风格呈现的奇幻武侠动漫。', '2020-08-29'),
('罗小黑战记', 'https://img.acgn.cc/anime/luoxiaohei.jpg', '国产', '已完结', 9.4, 5900000, '奇幻,治愈,冒险', '小黑猫妖罗小黑寻找家园的冒险故事。', '2011-05-23'),
('大鱼海棠', 'https://img.acgn.cc/anime/dayu.jpg', '国产', '已完结', 9.2, 4300000, '奇幻,唯美,感情', '少女椿在人间世界的冒险与成长故事。', '2016-07-08'),
('哪吒之魔童降世', 'https://img.acgn.cc/anime/nezha.jpg', '国产', '已完结', 9.7, 12000000, '神话,热血,成长', '哪吒生而为妖，挣脱命运束缚的热血故事。', '2019-07-26'),
('白蛇：缘起', 'https://img.acgn.cc/anime/baishe.jpg', '国产', '已完结', 9.3, 5100000, '神话,恋爱,奇幻', '白蛇与许宣前世之缘的唯美爱情故事。', '2019-01-11');

-- =============================================
-- 欧美动漫数据（15条）
-- =============================================
INSERT INTO `anime` (`title`, `cover_image`, `type`, `status`, `rating`, `view_count`, `tags`, `description`, `release_date`) VALUES
('蜘蛛侠：平行宇宙', 'https://img.acgn.cc/anime/spiderman.jpg', '欧美', '已完结', 9.6, 11500000, '超级英雄,动作,冒险', '多元宇宙蜘蛛侠合力拯救世界的故事。', '2018-12-14'),
('疯狂动物城', 'https://img.acgn.cc/anime/zootopia.jpg', '欧美', '已完结', 9.5, 9800000, '冒险,搞笑,推理', '兔子警察与狐狸侦探携手破案的故事。', '2016-03-04'),
('冰雪奇缘', 'https://img.acgn.cc/anime/frozen.jpg', '欧美', '已完结', 9.4, 13200000, '奇幻,感情,音乐', '安娜公主寻找姐姐艾莎解除魔咒的故事。', '2013-11-27'),
('寻梦环游记', 'https://img.acgn.cc/anime/coco.jpg', '欧美', '已完结', 9.7, 10500000, '奇幻,音乐,感情', '少年米格尔误入亡灵世界寻找音乐梦想的故事。', '2017-11-22'),
('灵魂急转弯', 'https://img.acgn.cc/anime/soul.jpg', '欧美', '已完结', 9.5, 8900000, '奇幻,感人,音乐', '爵士乐手乔意外进入灵魂之地的故事。', '2020-12-25'),
('龙与地下城', 'https://img.acgn.cc/anime/dnd.jpg', '欧美', '已完结', 9.2, 7300000, '奇幻,冒险,搞笑', '一群亡命之徒踏上拯救家园的奇幻冒险旅途。', '2023-03-31'),
('蝙蝠侠：黑暗骑士崛起', 'https://img.acgn.cc/anime/batman.jpg', '欧美', '已完结', 9.3, 8100000, '超级英雄,动作,悬疑', '蝙蝠侠与强大反派班恩的终极对决。', '2012-07-20'),
('未来战士', 'https://img.acgn.cc/anime/terminator.jpg', '欧美', '已完结', 9.1, 6800000, '科幻,动作,末世', '来自未来的机器人与人类的对决故事。', '1984-10-26'),
('星际穿越', 'https://img.acgn.cc/anime/interstellar.jpg', '欧美', '已完结', 9.6, 9200000, '科幻,冒险,感人', '宇航员穿越虫洞寻找人类新家园的故事。', '2014-11-07'),
('驯龙高手', 'https://img.acgn.cc/anime/httyd.jpg', '欧美', '已完结', 9.5, 8600000, '奇幻,冒险,感情', '少年希卡普与龙的深厚友情故事。', '2010-03-26'),
('玩具总动员4', 'https://img.acgn.cc/anime/toy-story4.jpg', '欧美', '已完结', 9.3, 9400000, '冒险,感动,友情', '胡迪与玩具伙伴们踏上全新冒险之旅。', '2019-06-21'),
('超人总动员2', 'https://img.acgn.cc/anime/incredibles2.jpg', '欧美', '已完结', 9.2, 8200000, '超级英雄,搞笑,家庭', '超能先生一家对抗新反派的冒险故事。', '2018-06-15'),
('海底总动员', 'https://img.acgn.cc/anime/finding-nemo.jpg', '欧美', '已完结', 9.4, 7900000, '冒险,感动,友情', '父亲马林寻找儿子小丑鱼Nemo的故事。', '2003-05-30'),
('功夫熊猫4', 'https://img.acgn.cc/anime/kung-fu-panda4.jpg', '欧美', '已完结', 9.1, 7500000, '功夫,搞笑,冒险', '阿宝面对新挑战踏上新旅程的故事。', '2024-03-08'),
('机器人总动员', 'https://img.acgn.cc/anime/wall-e.jpg', '欧美', '已完结', 9.5, 8800000, '科幻,感人,冒险', '小机器人WALL-E与EVE的宇宙爱情故事。', '2008-06-27');

-- =============================================
-- 动漫电影数据（10条）
-- =============================================
INSERT INTO `anime` (`title`, `cover_image`, `type`, `status`, `rating`, `view_count`, `tags`, `description`, `release_date`) VALUES
('你的名字', 'https://img.acgn.cc/anime/your-name-movie.jpg', '电影', '已完结', 9.8, 15800000, '剧情,恋爱,奇幻', '高中男女互换身体引发的奇幻爱情故事。', '2016-08-26'),
('千与千寻', 'https://img.acgn.cc/anime/spirited-away-movie.jpg', '电影', '已完结', 9.9, 17200000, '奇幻,冒险,成长', '千寻在神灵世界的冒险与成长，吉卜力经典之作。', '2001-07-20'),
('哪吒之魔童降世', 'https://img.acgn.cc/anime/nezha-movie.jpg', '电影', '已完结', 9.7, 12000000, '神话,热血,成长', '哪吒生而为妖，挣脱命运束缚的热血故事。', '2019-07-26'),
('龙猫', 'https://img.acgn.cc/anime/totoro.jpg', '电影', '已完结', 9.8, 10500000, '治愈,奇幻,儿童', '小女孩小月与龙猫的温馨奇幻故事。', '1988-04-16'),
('天空之城', 'https://img.acgn.cc/anime/laputa.jpg', '电影', '已完结', 9.7, 8900000, '奇幻,冒险,科幻', '少年少女寻找传说中天空之城的故事。', '1986-08-02'),
('风之谷', 'https://img.acgn.cc/anime/nausicaa.jpg', '电影', '已完结', 9.6, 7800000, '奇幻,冒险,生态', '少女娜乌西卡在废土世界的冒险故事。', '1984-03-11'),
('夏日大作战', 'https://img.acgn.cc/anime/summer-wars.jpg', '电影', '已完结', 9.5, 6500000, '科幻,家庭,冒险', '少年健二在网络世界与现实家庭的双重冒险。', '2009-08-01'),
('大护法', 'https://img.acgn.cc/anime/dahufaen.jpg', '电影', '已完结', 9.3, 5100000, '成人向,暗黑,剧情', '大护法在奇幻王国中的冒险与觉醒故事。', '2017-07-13'),
('北极快车', 'https://img.acgn.cc/anime/polar-express.jpg', '电影', '已完结', 9.2, 6200000, '奇幻,圣诞,儿童', '男孩乘坐北极快车前往圣诞镇的奇幻旅程。', '2004-11-10'),
('魁拔之大战元泱界', 'https://img.acgn.cc/anime/kuiba-movie.jpg', '电影', '已完结', 9.0, 3800000, '奇幻,热血,冒险', '蛮吉在元泱界与强大敌人的终极对决。', '2014-07-04');

-- =============================================
-- 动漫详情数据（对应前30条日本动漫）
-- =============================================
INSERT INTO `anime_detail` (`anime_id`, `title`, `introduction`, `type`, `cover_image`, `background_image`, `rating`, `view_count`, `favorite_count`, `tags`, `status`, `total_episodes`, `release_date`, `studio`, `director`, `voice_actors`, `video_url`, `episode_urls`) VALUES
(1, '海贼王', '少年路飞为了找到传说中的ONE PIECE，与伙伴们踏上冒险之旅的故事。这部作品描绘了友情、冒险和梦想的航海史诗，被誉为有史以来最伟大的漫画改编动漫之一。', '日本', 'https://img.acgn.cc/anime/one-piece.jpg', 'https://img.acgn.cc/anime/one-piece-bg.jpg', 9.9, 12500000, 8500000, '热血,冒险,友情', '连载中', 1111, '1999-10-20', '东映动画', '宇田钢之助', '田中真弓,中井和哉,岡村明美', 'https://v.acgn.cc/one-piece-ep1.mp4', '[{"ep":1,"title":"我是要成为海贼王的男人","url":"https://v.acgn.cc/one-piece-ep1.mp4"},{"ep":2,"title":"世界第一剑士的称号","url":"https://v.acgn.cc/one-piece-ep2.mp4"}]'),
(2, '火影忍者', '少年漩涡鸣人为了成为火影，不断修炼成长的故事。这是一部关于友情、努力和胜利的热血物语，三大原则贯穿全作。', '日本', 'https://img.acgn.cc/anime/naruto.jpg', 'https://img.acgn.cc/anime/naruto-bg.jpg', 9.8, 9800000, 7800000, '热血,忍者,成长', '已完结', 720, '2002-10-03', 'Pierrot', '伊达勇登', '竹内顺子,中村千绘,井上和彦', 'https://v.acgn.cc/naruto-ep1.mp4', '[{"ep":1,"title":"12岁的忍者","url":"https://v.acgn.cc/naruto-ep1.mp4"},{"ep":2,"title":"比树叶还要坏的坏孩子？","url":"https://v.acgn.cc/naruto-ep2.mp4"}]'),
(3, '咒术回战', '高中生虎杖悠仁吞下特级咒物，进入咒术高专的故事。现代咒术战斗的校园战斗番，作画精良，战斗场面震撼。', '日本', 'https://img.acgn.cc/anime/jjk.jpg', 'https://img.acgn.cc/anime/jjk-bg.jpg', 9.7, 8200000, 6200000, '热血,战斗,奇幻', '连载中', 48, '2020-10-03', 'MAPPA', '朴朴朴', '榎木淳弥,中村悠一,内田真礼', 'https://v.acgn.cc/jjk-ep1.mp4', '[{"ep":1,"title":"两面宿傩","url":"https://v.acgn.cc/jjk-ep1.mp4"},{"ep":2,"title":"为了人而死","url":"https://v.acgn.cc/jjk-ep2.mp4"}]'),
(4, '鬼灭之刃', '灶门炭治郎为了拯救变成鬼的妹妹，踏上猎鬼之旅的故事。ufotable制作的精美画质，感人的亲情故事。', '日本', 'https://img.acgn.cc/anime/demon-slayer.jpg', 'https://img.acgn.cc/anime/demon-slayer-bg.jpg', 9.6, 10500000, 8900000, '热血,战斗,亲情', '连载中', 55, '2019-04-06', 'ufotable', '外崎春雄', '花江夏树,鬼头明里,下野纮', 'https://v.acgn.cc/demon-slayer-ep1.mp4', '[{"ep":1,"title":"残忍","url":"https://v.acgn.cc/demon-slayer-ep1.mp4"},{"ep":2,"title":"除了头部以外请从任何地方斩断","url":"https://v.acgn.cc/demon-slayer-ep2.mp4"}]'),
(5, '我的英雄学院', '无个性少年绿谷出久获得最强个性，成为英雄的故事。超级英雄题材的校园战斗番，热血励志。', '日本', 'https://img.acgn.cc/anime/mha.jpg', 'https://img.acgn.cc/anime/mha-bg.jpg', 9.5, 7800000, 6100000, '热血,超能力,成长', '连载中', 138, '2016-04-03', 'BONES', '长崎健司', '山下大辉,梶裕贵,岡本信彦', 'https://v.acgn.cc/mha-ep1.mp4', '[{"ep":1,"title":"绿谷出久：诞生之日","url":"https://v.acgn.cc/mha-ep1.mp4"},{"ep":2,"title":"小小银英雄","url":"https://v.acgn.cc/mha-ep2.mp4"}]'),
(6, '进击的巨人', '艾伦等人对抗巨人的故事，揭露世界真相的史诗巨作。世界观宏大，剧情精彩，是动漫史上的里程碑。', '日本', 'https://img.acgn.cc/anime/aot.jpg', 'https://img.acgn.cc/anime/aot-bg.jpg', 9.9, 11200000, 9200000, '战斗,悬疑,剧情', '已完结', 87, '2013-04-07', 'MAPPA', '荒木哲郎', '梶裕贵,井上麻里奈,神谷浩史', 'https://v.acgn.cc/aot-ep1.mp4', '[{"ep":1,"title":"致先驱者的怒吼","url":"https://v.acgn.cc/aot-ep1.mp4"},{"ep":2,"title":"合格者 第57次壁外调查行动①","url":"https://v.acgn.cc/aot-ep2.mp4"}]'),
(7, '名侦探柯南', '高中生侦探工藤新一被变小后化名江户川柯南破案的故事。经典推理动画，已持续连载近30年。', '日本', 'https://img.acgn.cc/anime/detective-conan.jpg', 'https://img.acgn.cc/anime/detective-conan-bg.jpg', 9.7, 13500000, 10500000, '推理,悬疑,侦探', '连载中', 1185, '1996-01-08', 'TMS Entertainment', '山本泰一郎', '高山南,山崎和佳奈,神谷明', 'https://v.acgn.cc/conan-ep1.mp4', '[{"ep":1,"title":"过山车密室案","url":"https://v.acgn.cc/conan-ep1.mp4"},{"ep":2,"title":"超级金刚双胞胎事件","url":"https://v.acgn.cc/conan-ep2.mp4"}]'),
(8, '关于我转生变成史莱姆这档事', '上班族转生成为最强史莱姆的异世界冒险故事。轻松愉快的异世界题材，国民度极高。', '日本', 'https://img.acgn.cc/anime/teslime.jpg', 'https://img.acgn.cc/anime/teslime-bg.jpg', 9.5, 6500000, 5100000, '转生,奇幻,冒险', '连载中', 48, '2018-10-02', '8bit', '菊池宣幸', '冈咲美保,丰口惠美', 'https://v.acgn.cc/teslime-ep1.mp4', '[{"ep":1,"title":"关于我转生变成史莱姆这档事","url":"https://v.acgn.cc/teslime-ep1.mp4"},{"ep":2,"title":"关于暴风龙这档事","url":"https://v.acgn.cc/teslime-ep2.mp4"}]'),
(9, '全职猎人', '小杰为了寻找父亲成为猎人的冒险故事。富坚老贼的代表作，念能力体系无比精彩。', '日本', 'https://img.acgn.cc/anime/hxh.jpg', 'https://img.acgn.cc/anime/hxh-bg.jpg', 9.8, 7200000, 5800000, '热血,冒险,成长', '连载中', 148, '2011-10-02', 'Madhouse', '神志那弘志', '潘惠美,伊濑茉莉也,日野聪', 'https://v.acgn.cc/hxh-ep1.mp4', '[{"ep":1,"title":"出发！从伊鲁米出发的小伙伴！","url":"https://v.acgn.cc/hxh-ep1.mp4"},{"ep":2,"title":"申请者是野蛮人？恶名昭彰的巴士考场！","url":"https://v.acgn.cc/hxh-ep2.mp4"}]'),
(10, '刀剑神域', '桐人被困在VRMMORPG中，为了通关而战斗的故事。游戏题材的异世界冒险，开创了isekai类型的先河。', '日本', 'https://img.acgn.cc/anime/sao.jpg', 'https://img.acgn.cc/anime/sao-bg.jpg', 9.4, 8900000, 7100000, '游戏,冒险,恋爱', '已完结', 96, '2012-07-08', 'A-1 Pictures', '伊藤智彦', '松冈祯丞,户松遥,日高里菜', 'https://v.acgn.cc/sao-ep1.mp4', '[{"ep":1,"title":"剑的世界","url":"https://v.acgn.cc/sao-ep1.mp4"},{"ep":2,"title":"决斗者","url":"https://v.acgn.cc/sao-ep2.mp4"}]'),
(11, 'Re:从零开始的异世界生活', '菜月昴穿越到异世界，拥有死亡回归能力的冒险故事。剧情烧脑，情感真挚，是异世界题材的佼佼者。', '日本', 'https://img.acgn.cc/anime/rezero.jpg', 'https://img.acgn.cc/anime/rezero-bg.jpg', 9.6, 7500000, 6200000, '转生,奇幻,悬疑', '连载中', 50, '2016-04-04', 'White Fox', '渡边政治', '小林裕介,高桥李依,水濑祈', 'https://v.acgn.cc/rezero-ep1.mp4', '[{"ep":1,"title":"从零开始异世界生活","url":"https://v.acgn.cc/rezero-ep1.mp4"},{"ep":2,"title":"再见，王都","url":"https://v.acgn.cc/rezero-ep2.mp4"}]'),
(12, '排球少年', '日向翔阳加入排球部，向着全国大赛努力的青春物语。热血运动番的经典之作，令人热血沸腾。', '日本', 'https://img.acgn.cc/anime/haikyuu.jpg', 'https://img.acgn.cc/anime/haikyuu-bg.jpg', 9.7, 6800000, 5500000, '运动,校园,热血', '已完结', 85, '2014-04-06', 'Production I.G', '满仲劝', '村濑步,石川界人,入野自由', 'https://v.acgn.cc/haikyuu-ep1.mp4', '[{"ep":1,"title":"小巨人","url":"https://v.acgn.cc/haikyuu-ep1.mp4"},{"ep":2,"title":"球队","url":"https://v.acgn.cc/haikyuu-ep2.mp4"}]'),
(13, '间谍过家家', '间谍、杀手和超能力者组成的虚假家庭的日常生活。温馨搞笑的家庭喜剧，2022年度最热门动漫。', '日本', 'https://img.acgn.cc/anime/spy-family.jpg', 'https://img.acgn.cc/anime/spy-family-bg.jpg', 9.5, 9200000, 7600000, '搞笑,家庭,动作', '连载中', 37, '2022-04-09', 'Wit Studio', '古桥一浩', '江口拓也,种崎敦美,早见沙织', 'https://v.acgn.cc/spy-family-ep1.mp4', '[{"ep":1,"title":"见面·为了和平","url":"https://v.acgn.cc/spy-family-ep1.mp4"},{"ep":2,"title":"接受任务","url":"https://v.acgn.cc/spy-family-ep2.mp4"}]'),
(14, '葬送的芙莉莲', '活了千年的精灵魔法师芙莉莲的冒险旅程。细腻感人的奇幻物语，2023年度神作，荣获多个大奖。', '日本', 'https://img.acgn.cc/anime/frieren.jpg', 'https://img.acgn.cc/anime/frieren-bg.jpg', 9.8, 5600000, 4700000, '奇幻,冒险,治愈', '已完结', 28, '2023-09-29', 'Madhouse', '斋藤圭一郎', '种崎敦美,市之濑加那,小林千晶', 'https://v.acgn.cc/frieren-ep1.mp4', '[{"ep":1,"title":"旅途的终点","url":"https://v.acgn.cc/frieren-ep1.mp4"},{"ep":2,"title":"冒险的价值","url":"https://v.acgn.cc/frieren-ep2.mp4"}]'),
(15, '迷宫饭', '在地下迷宫中烹饪怪物料理的冒险故事。独特的美食奇幻冒险番，2024年话题之作。', '日本', 'https://img.acgn.cc/anime/dungeon-meshi.jpg', 'https://img.acgn.cc/anime/dungeon-meshi-bg.jpg', 9.6, 4900000, 4100000, '奇幻,美食,冒险', '已完结', 24, '2024-01-04', 'Studio Trigger', '宫岛善博', '千叶翔也,雨宫天,泽城美雪', 'https://v.acgn.cc/dungeon-meshi-ep1.mp4', '[{"ep":1,"title":"烤蝎子·走地鸡炒蘑菇","url":"https://v.acgn.cc/dungeon-meshi-ep1.mp4"},{"ep":2,"title":"辣炒蟹壳·浅摊爆炒植物","url":"https://v.acgn.cc/dungeon-meshi-ep2.mp4"}]'),
(16, '我独自升级', '最弱猎人程肖宇获得系统能力成为最强。超能力战斗的爽番，2024年爆款作品。', '日本', 'https://img.acgn.cc/anime/solo-leveling.jpg', 'https://img.acgn.cc/anime/solo-leveling-bg.jpg', 9.6, 8800000, 7300000, '动作,冒险,成长', '已完结', 12, '2024-01-07', 'A-1 Pictures', '中重俊祐', '坂泰斗,中村源太,日野聪', 'https://v.acgn.cc/solo-leveling-ep1.mp4', '[{"ep":1,"title":"我，诸如此类","url":"https://v.acgn.cc/solo-leveling-ep1.mp4"},{"ep":2,"title":"我是该死的最弱等级","url":"https://v.acgn.cc/solo-leveling-ep2.mp4"}]'),
(17, '电锯人', '电锯人淀治猎杀恶魔的故事。黑暗风格的动作番，MAPPA制作，画质极佳。', '日本', 'https://img.acgn.cc/anime/chainsaw-man.jpg', 'https://img.acgn.cc/anime/chainsaw-man-bg.jpg', 9.4, 7100000, 5800000, '动作,黑暗,奇幻', '连载中', 12, '2022-10-11', 'MAPPA', '中山龙', '户谷菊之介,雨宫天,楠木灯', 'https://v.acgn.cc/chainsaw-man-ep1.mp4', '[{"ep":1,"title":"狗与电锯","url":"https://v.acgn.cc/chainsaw-man-ep1.mp4"},{"ep":2,"title":"蕃茄","url":"https://v.acgn.cc/chainsaw-man-ep2.mp4"}]'),
(18, '辉夜大小姐想让我告白', '秀知院学园学生会会长的恋爱头脑战。甜蜜搞笑的恋爱喜剧，三季均获极高评价。', '日本', 'https://img.acgn.cc/anime/kaguya.jpg', 'https://img.acgn.cc/anime/kaguya-bg.jpg', 9.3, 6500000, 5200000, '恋爱,校园,搞笑', '连载中', 37, '2019-01-12', 'A-1 Pictures', '畠山守', '古贺葵,古川慎,佐藤利奈', 'https://v.acgn.cc/kaguya-ep1.mp4', '[{"ep":1,"title":"辉夜大小姐想让白银告白/白银想让辉夜告白","url":"https://v.acgn.cc/kaguya-ep1.mp4"},{"ep":2,"title":"藤原千花想玩游戏/辉夜大小姐不想被人想","url":"https://v.acgn.cc/kaguya-ep2.mp4"}]'),
(19, '一拳超人', '埼玉老师一拳解决一切的英雄故事。搞笑热血战斗番，格斗场面堪称神作。', '日本', 'https://img.acgn.cc/anime/opm.jpg', 'https://img.acgn.cc/anime/opm-bg.jpg', 9.5, 8200000, 6800000, '动作,搞笑,英雄', '连载中', 24, '2015-10-05', 'Madhouse', '夏目真悟', '古川慎,石川界人,梶裕贵', 'https://v.acgn.cc/opm-ep1.mp4', '[{"ep":1,"title":"一拳超人","url":"https://v.acgn.cc/opm-ep1.mp4"},{"ep":2,"title":"最强男人","url":"https://v.acgn.cc/opm-ep2.mp4"}]'),
(20, '紫罗兰永恒花园', '自动手记人偶薇尔莉特寻找感情真谛的故事。京都动画出品，感人的剧情番，每集都令人落泪。', '日本', 'https://img.acgn.cc/anime/violet.jpg', 'https://img.acgn.cc/anime/violet-bg.jpg', 9.7, 5900000, 4800000, '剧情,治愈,战争', '已完结', 13, '2018-01-11', 'Kyoto Animation', '石立太一', '石川由依,子安武人,浪川大辅', 'https://v.acgn.cc/violet-ep1.mp4', '[{"ep":1,"title":"自动手记人偶","url":"https://v.acgn.cc/violet-ep1.mp4"},{"ep":2,"title":"放在心中的那个词语","url":"https://v.acgn.cc/violet-ep2.mp4"}]'),
(21, '你的名字', '高中男女互换身体引发的奇幻爱情故事。新海诚导演，感动无数人的动漫电影，全球票房超2.5亿美元。', '日本', 'https://img.acgn.cc/anime/your-name.jpg', 'https://img.acgn.cc/anime/your-name-bg.jpg', 9.8, 15800000, 13500000, '剧情,恋爱,奇幻', '已完结', 1, '2016-08-26', 'CoMix Wave Films', '新海诚', '神木隆之介,上白石萌音', 'https://v.acgn.cc/your-name-full.mp4', '[{"ep":1,"title":"你的名字（完整版）","url":"https://v.acgn.cc/your-name-full.mp4"}]'),
(22, '千与千寻', '千寻在神灵世界的冒险与成长。宫崎骏导演，吉卜力经典之作，奥斯卡最佳动画长片得主。', '日本', 'https://img.acgn.cc/anime/spirited-away.jpg', 'https://img.acgn.cc/anime/spirited-away-bg.jpg', 9.9, 17200000, 14800000, '奇幻,冒险,成长', '已完结', 1, '2001-07-20', 'Studio Ghibli', '宫崎骏', '柊瑠美,入野自由,夏木玛利', 'https://v.acgn.cc/spirited-away-full.mp4', '[{"ep":1,"title":"千与千寻（完整版）","url":"https://v.acgn.cc/spirited-away-full.mp4"}]'),
(23, '死神', '黑崎一护获得死神力量的故事。经典战斗番，千年血战篇于2022年回归。', '日本', 'https://img.acgn.cc/anime/bleach.jpg', 'https://img.acgn.cc/anime/bleach-bg.jpg', 9.3, 7600000, 6200000, '热血,战斗,死神', '连载中', 366, '2004-10-05', 'Pierrot', '阿部记之', '森田成一,折笠富美子,冬马由美', 'https://v.acgn.cc/bleach-ep1.mp4', '[{"ep":1,"title":"一护无法解决死神之战","url":"https://v.acgn.cc/bleach-ep1.mp4"},{"ep":2,"title":"死神的力量","url":"https://v.acgn.cc/bleach-ep2.mp4"}]'),
(24, '银魂', '坂田银时和他的伙伴们的日常冒险。搞笑吐槽神作，涵盖搞笑、剧情、热血等多种类型。', '日本', 'https://img.acgn.cc/anime/gintama.jpg', 'https://img.acgn.cc/anime/gintama-bg.jpg', 9.7, 6200000, 5100000, '搞笑,武士,剧情', '已完结', 367, '2006-04-04', 'Sunrise', '高松信司', '杉田智和,阪口大助,釘宫理惠', 'https://v.acgn.cc/gintama-ep1.mp4', '[{"ep":1,"title":"在这个世界，武士精神已不再……怎么可能！","url":"https://v.acgn.cc/gintama-ep1.mp4"},{"ep":2,"title":"摩耶卡马纳","url":"https://v.acgn.cc/gintama-ep2.mp4"}]'),
(25, '夏目友人帐', '夏目玲子与猫咪老师归还妖怪名字的故事。温暖治愈番，治愈系动漫中的佳作。', '日本', 'https://img.acgn.cc/anime/natsume.jpg', 'https://img.acgn.cc/anime/natsume-bg.jpg', 9.5, 3800000, 3100000, '治愈,奇幻,妖怪', '连载中', 75, '2008-07-08', 'Brains Base', '大森贵弘', '神谷浩史,井上和彦,小林沙苗', 'https://v.acgn.cc/natsume-ep1.mp4', '[{"ep":1,"title":"夏目友人帐","url":"https://v.acgn.cc/natsume-ep1.mp4"},{"ep":2,"title":"纸沼","url":"https://v.acgn.cc/natsume-ep2.mp4"}]'),
(26, '哆啦A梦', '来自未来的猫型机器人哆啦A梦帮助大雄的故事。国民级动漫，陪伴几代人成长的经典作品。', '日本', 'https://img.acgn.cc/anime/doraemon.jpg', 'https://img.acgn.cc/anime/doraemon-bg.jpg', 9.6, 14500000, 12000000, '搞笑,奇幻,成长', '连载中', 2700, '1979-04-02', 'Shogakukan Music & Digital Entertainment', '本乡满', '水田山葵,大原惠美,木村昱', 'https://v.acgn.cc/doraemon-ep1.mp4', '[{"ep":1,"title":"哆啦A梦来了","url":"https://v.acgn.cc/doraemon-ep1.mp4"},{"ep":2,"title":"竹蜻蜓","url":"https://v.acgn.cc/doraemon-ep2.mp4"}]'),
(27, '灌篮高手', '湘北篮球队向着全国大赛努力的青春物语。运动番经典之作，2023年推出剧场版大获成功。', '日本', 'https://img.acgn.cc/anime/slam-dunk.jpg', 'https://img.acgn.cc/anime/slam-dunk-bg.jpg', 9.8, 11200000, 9500000, '运动,热血,校园', '已完结', 101, '1993-10-16', 'Toei Animation', '西泽信孝', '草尾毅,绿川光,置鲇龙太郎', 'https://v.acgn.cc/slam-dunk-ep1.mp4', '[{"ep":1,"title":"我是天才！！","url":"https://v.acgn.cc/slam-dunk-ep1.mp4"},{"ep":2,"title":"他是篮球白痴！！","url":"https://v.acgn.cc/slam-dunk-ep2.mp4"}]'),
(28, '龙珠超', '悟空等人面对强大宇宙敌人的战斗。热血战斗经典续作，破坏神比鲁斯的登场让粉丝疯狂。', '日本', 'https://img.acgn.cc/anime/db-super.jpg', 'https://img.acgn.cc/anime/db-super-bg.jpg', 9.4, 9500000, 7900000, '热血,战斗,科幻', '已完结', 131, '2015-07-05', 'Toei Animation', '地冈公俊', '野泽雅子,堀川亮,鶴ひろみ', 'https://v.acgn.cc/db-super-ep1.mp4', '[{"ep":1,"title":"再见，悟饭！胡须老爷爷的育儿计划","url":"https://v.acgn.cc/db-super-ep1.mp4"},{"ep":2,"title":"大神比鲁斯的复仇","url":"https://v.acgn.cc/db-super-ep2.mp4"}]'),
(29, '灵能百分百', '超能力少年影山茂夫的成长故事。温暖治愈的成长番，BONES制作，战斗场面极为华丽。', '日本', 'https://img.acgn.cc/anime/mob100.jpg', 'https://img.acgn.cc/anime/mob100-bg.jpg', 9.6, 4100000, 3300000, '动作,成长,奇幻', '已完结', 37, '2016-07-12', 'Bones', '立川让', '伊藤节生,种崎敦美,日野聪', 'https://v.acgn.cc/mob100-ep1.mp4', '[{"ep":1,"title":"自我-~100%~","url":"https://v.acgn.cc/mob100-ep1.mp4"},{"ep":2,"title":"IG组织-~100%~","url":"https://v.acgn.cc/mob100-ep2.mp4"}]'),
(30, '不死不幸', '不幸少女和不死能力的奇妙相遇。独特的设定和精彩的战斗场面，David Production出品。', '日本', 'https://img.acgn.cc/anime/undead-unluck.jpg', 'https://img.acgn.cc/anime/undead-unluck-bg.jpg', 9.5, 4200000, 3500000, '奇幻,动作,恋爱', '已完结', 24, '2023-10-07', 'David Production', '铃木健太郎', '户谷菊之介,濑户麻沙美,坂本真绫', 'https://v.acgn.cc/undead-unluck-ep1.mp4', '[{"ep":1,"title":"不死不幸","url":"https://v.acgn.cc/undead-unluck-ep1.mp4"},{"ep":2,"title":"unbelievable","url":"https://v.acgn.cc/undead-unluck-ep2.mp4"}]');

-- =============================================
-- 动漫资讯新闻数据（15条）
-- =============================================
INSERT INTO `anime_news` (`title`, `summary`, `cover_image`, `category`, `source`, `view_count`, `tags`, `publish_time`) VALUES
('《咒术回战》第三季确认制作，预计2025年播出', '官方宣布《咒术回战》第三季正式立项，MAPPA继续制作，预计2025年春季播出。', 'https://img.acgn.cc/news/jjk-s3.jpg', '新番资讯', '官方公告', 58900, '咒术回战,新番', NOW()),
('《间谍过家家》第三季宣布制作', 'Wit Studio宣布《间谍过家家》第三季正式开始制作，阿尼亚将迎来新的冒险。', 'https://img.acgn.cc/news/spy-s3.jpg', '新番资讯', 'AnimeNews', 45600, '间谍过家家,新番', NOW()),
('2024年度动漫排行：《葬送的芙莉莲》荣登榜首', '各大媒体评选2024年度最佳动漫，《葬送的芙莉莲》以绝对优势夺得冠军，成为年度最佳。', 'https://img.acgn.cc/news/frieren-top.jpg', '资讯', '动漫时报', 72100, '葬送的芙莉莲,年度排行', NOW()),
('声优花江夏树出演新番《XX》男主角', '知名声优花江夏树将出演2025年新番的男主角，粉丝期待度极高。', 'https://img.acgn.cc/news/hanae.jpg', '声优消息', '声优俱乐部', 38700, '花江夏树,声优', NOW()),
('MAPPA公开2025年制作计划，多部新番齐亮相', 'MAPPA公布2025年度制作计划，包括多部热门续作和全新原创动漫，令粉丝兴奋不已。', 'https://img.acgn.cc/news/mappa-2025.jpg', '制作动态', 'MAPPA官方', 91200, 'MAPPA,2025新番', NOW()),
('《鬼灭之刃》无限城篇剧场版三部曲正式确认', '吾峠呼世晴原著改编，《鬼灭之刃》无限城篇将制作成三部剧场版，ufotable继续担任制作。', 'https://img.acgn.cc/news/kimetsu-movie.jpg', '新番资讯', '官方公告', 125000, '鬼灭之刃,剧场版', NOW()),
('《哪吒2》票房突破100亿，刷新国产动漫纪录', '国产动漫《哪吒之魔童闹海》票房突破100亿，成为中国影史最高票房动漫电影。', 'https://img.acgn.cc/news/nezha2-box.jpg', '资讯', '票房追踪', 186000, '哪吒,国产动漫', NOW()),
('《斗罗大陆》动漫正式完结，粉丝不舍', '陪伴观众多年的《斗罗大陆》动漫版即将迎来大结局，制作团队发布最终特辑。', 'https://img.acgn.cc/news/douluo-final.jpg', '新番资讯', '腾讯动漫', 67800, '斗罗大陆,完结', NOW()),
('2025春季新番预览：这些作品值得期待', '2025年春季档期即将开始，本文为你盘点值得关注的热门新番，从续作到原创应有尽有。', 'https://img.acgn.cc/news/spring-2025.jpg', '新番资讯', '新番速报', 83400, '2025春番,新番', NOW()),
('种崎敦美荣获年度最佳声优奖', '人气声优种崎敦美凭借《葬送的芙莉莲》中芙莉莲一角荣获多个声优奖项，实力获得认可。', 'https://img.acgn.cc/news/tanezaki.jpg', '声优消息', '声优大赏', 52300, '种崎敦美,声优奖', NOW()),
('《我独自升级》第二季确定制作，原班人马回归', '大受好评的《我独自升级》宣布第二季制作确定，A-1 Pictures原班人马回归，预计年内播出。', 'https://img.acgn.cc/news/solo-leveling-s2.jpg', '新番资讯', '官方公告', 98700, '我独自升级,第二季', NOW()),
('京都动画新作《XXX》宣传PV公开', '京都动画发布全新原创动漫宣传视频，精美的作画质量再次震惊业界，期待值拉满。', 'https://img.acgn.cc/news/kyoani-new.jpg', '制作动态', 'Kyoto Animation', 41200, '京都动画,新作', NOW()),
('《电锯人》第二季确认！MAPPA将于2025年献上', '原著漫画大热的《电锯人》动漫第二季由MAPPA继续操刀，制作规格将进一步提升。', 'https://img.acgn.cc/news/chainsaw-s2.jpg', '新番资讯', '官方公告', 76500, '电锯人,第二季', NOW()),
('这些动漫周边卖疯了！2024年度热门周边盘点', '2024年销量最高的动漫周边产品大盘点，手办、联名款产品等，看看你收集了几款。', 'https://img.acgn.cc/news/merch-2024.jpg', '周边情报', '周边情报站', 59800, '周边,手办', NOW()),
('动漫迷必看！2025年最值得追的10部动漫', '新的一年，动漫爱好者不能错过这些作品，从热血战斗到温馨治愈，总有一款适合你。', 'https://img.acgn.cc/news/must-watch-2025.jpg', '资讯', '动漫推荐', 110300, '推荐,2025', NOW());

-- =============================================
-- 示例评论数据
-- =============================================
INSERT INTO `anime_comment` (`anime_id`, `username`, `content`, `rating`, `likes`) VALUES
(1, '路飞粉丝', '海贼王是我的青春，看了20多年了，还是追的那么起劲！', 10, 1250),
(1, '动漫达人', '最近的剧情太精彩了，最终章感觉要来了', 9, 876),
(1, '老鸟观众', '从小学看到大学，路飞是我的英雄', 10, 650),
(2, '火影粉', '鸣人的成长历程太感动了，再看一遍还是会哭', 10, 980),
(2, '千年等一回', '这是我看过的最好的热血动漫，没有之一', 9, 723),
(3, '术师见习生', '咒术回战打斗场面太帅了，MAPPA没有让人失望', 9, 543),
(4, '炭治郎应援', '鬼灭之刃的作画是业界天花板，ufotable太强了', 10, 892),
(6, '进击党', '进击的巨人是神作，结局争议很大但我觉得还是很好', 9, 1100),
(14, '芙莉莲迷', '葬送的芙莉莲让我重新相信了爱情，每集都在哭', 10, 760),
(22, '宫崎骏信徒', '千与千寻永远是最好的动漫电影，百看不厌', 10, 1580);
