-- H2 Database Initial Data for Animation Website
-- =============================================
-- 初始化角色
-- =============================================
MERGE INTO roles (id, name) VALUES (1, 'ROLE_USER');
MERGE INTO roles (id, name) VALUES (2, 'ROLE_ADMIN');

-- =============================================
-- 初始化管理员账号 (密码: admin123)
-- =============================================
MERGE INTO users (id, username, password, email, nickname, enabled) VALUES
(1, 'admin', '$2a$10$7EqJtq98hPqEX7fNZaFWoO7b2N.7mSGKBmU/E6gd/1bfFOPkHUuWq', 'admin@haha.com', '管理员', 1),
(2, 'admin22121', '$2a$10$7EqJtq98hPqEX7fNZaFWoO7b2N.7mSGKBmU/E6gd/1bfFOPkHUuWq', 'admin22121@haha.com', '超级管理员', 1),
(3, 'test', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE5cZmElkBMp5t.02', 'test@haha.com', '测试用户', 1);

-- =============================================
-- 分配角色
-- =============================================
MERGE INTO users_roles (user_id, role_id) VALUES (1, 2);
MERGE INTO users_roles (user_id, role_id) VALUES (1, 1);
MERGE INTO users_roles (user_id, role_id) VALUES (2, 2);
MERGE INTO users_roles (user_id, role_id) VALUES (2, 1);
MERGE INTO users_roles (user_id, role_id) VALUES (3, 1);

-- =============================================
-- 日本动漫数据（30条）
-- =============================================
MERGE INTO anime (id, title, cover_image, type, status, rating, view_count, tags, description, author, release_date) VALUES
(1, '海贼王', 'https://img.acgn.cc/anime/one-piece.jpg', '日本', '连载中', 9.9, 12500000, '热血,冒险,友情', '少年路飞为了找到传说中的ONE PIECE，与伙伴们踏上冒险之旅的故事。', '尾田荣一郎', '1999-10-20'),
(2, '火影忍者', 'https://img.acgn.cc/anime/naruto.jpg', '日本', '已完结', 9.8, 9800000, '热血,忍者,成长', '少年漩涡鸣人为了成为火影，不断修炼成长的故事。', '岸本齐史', '2002-10-03'),
(3, '咒术回战', 'https://img.acgn.cc/anime/jjk.jpg', '日本', '连载中', 9.7, 8200000, '热血,战斗,奇幻', '高中生虎杖悠仁吞下特级咒物，进入咒术高专的故事。', '芥见下下', '2020-10-03'),
(4, '鬼灭之刃', 'https://img.acgn.cc/anime/demon-slayer.jpg', '日本', '连载中', 9.6, 10500000, '热血,战斗,亲情', '灶门炭治郎为了拯救变成鬼的妹妹，踏上猎鬼之旅的故事。', '吾峠呼世晴', '2019-04-06'),
(5, '我的英雄学院', 'https://img.acgn.cc/anime/mha.jpg', '日本', '连载中', 9.5, 7800000, '热血,超能力,成长', '无个性少年绿谷出久获得最强个性，成为英雄的故事。', '堀越耕平', '2016-04-03'),
(6, '进击的巨人', 'https://img.acgn.cc/anime/aot.jpg', '日本', '已完结', 9.9, 11200000, '战斗,悬疑,剧情', '艾伦等人对抗巨人的故事，揭露世界真相的史诗巨作。', '谏山创', '2013-04-07'),
(7, '名侦探柯南', 'https://img.acgn.cc/anime/detective-conan.jpg', '日本', '连载中', 9.7, 13500000, '推理,悬疑,侦探', '高中生侦探工藤新一被变小后化名江户川柯南破案的故事。', '青山刚昌', '1996-01-08'),
(8, '关于我转生变成史莱姆这档事', 'https://img.acgn.cc/anime/teslime.jpg', '日本', '连载中', 9.5, 6500000, '转生,奇幻,冒险', '上班族转生成为最强史莱姆的异世界冒险故事。', '伏濑', '2018-10-02'),
(9, '全职猎人', 'https://img.acgn.cc/anime/hxh.jpg', '日本', '连载中', 9.8, 7200000, '热血,冒险,成长', '小杰为了寻找父亲成为猎人的冒险故事。', '富坚义博', '2011-10-02'),
(10, '刀剑神域', 'https://img.acgn.cc/anime/sao.jpg', '日本', '已完结', 9.4, 8900000, '游戏,冒险,恋爱', '桐人被困在VRMMORPG中，为了通关而战斗的故事。', '川原砾', '2012-07-08'),
(11, 'Re:从零开始的异世界生活', 'https://img.acgn.cc/anime/rezero.jpg', '日本', '连载中', 9.6, 7500000, '转生,奇幻,悬疑', '菜月昴穿越到异世界，拥有死亡回归能力的冒险故事。', '长月达平', '2016-04-04'),
(12, '排球少年', 'https://img.acgn.cc/anime/haikyuu.jpg', '日本', '已完结', 9.7, 6800000, '运动,校园,热血', '日向翔阳加入排球部，向着全国大赛努力的青春物语。', '古馆春一', '2014-04-06'),
(13, '间谍过家家', 'https://img.acgn.cc/anime/spy-family.jpg', '日本', '连载中', 9.5, 9200000, '搞笑,家庭,动作', '间谍、杀手和超能力者组成的虚假家庭的日常生活。', '远藤达哉', '2022-04-09'),
(14, '葬送的芙莉莲', 'https://img.acgn.cc/anime/frieren.jpg', '日本', '已完结', 9.8, 5600000, '奇幻,冒险,治愈', '活了千年的精灵魔法师芙莉莲的冒险旅程。', '山田钟人', '2023-09-29'),
(15, '迷宫饭', 'https://img.acgn.cc/anime/dungeon-meshi.jpg', '日本', '已完结', 9.6, 4900000, '奇幻,美食,冒险', '在地下迷宫中烹饪怪物料理的冒险故事。', '九井谅子', '2024-01-04'),
(16, '我独自升级', 'https://img.acgn.cc/anime/solo-leveling.jpg', '日本', '已完结', 9.6, 8800000, '动作,冒险,成长', '最弱猎人程肖宇获得系统能力成为最强。', 'Chugong', '2024-01-07'),
(17, '电锯人', 'https://img.acgn.cc/anime/chainsaw-man.jpg', '日本', '连载中', 9.4, 7100000, '动作,黑暗,奇幻', '电锯人淀治猎杀恶魔的故事。', '藤本树', '2022-10-11'),
(18, '辉夜大小姐想让我告白', 'https://img.acgn.cc/anime/kaguya.jpg', '日本', '连载中', 9.3, 6500000, '恋爱,校园,搞笑', '秀知院学园学生会会长的恋爱头脑战。', '赤坂明', '2019-01-12'),
(19, '一拳超人', 'https://img.acgn.cc/anime/opm.jpg', '日本', '连载中', 9.5, 8200000, '动作,搞笑,英雄', '埼玉老师一拳解决一切的英雄故事。', 'ONE', '2015-10-05'),
(20, '紫罗兰永恒花园', 'https://img.acgn.cc/anime/violet.jpg', '日本', '已完结', 9.7, 5900000, '剧情,治愈,战争', '自动手记人偶薇尔莉特寻找感情真谛的故事。', '晓佳奈', '2018-01-11'),
(21, '你的名字', 'https://img.acgn.cc/anime/your-name.jpg', '日本', '已完结', 9.8, 15800000, '剧情,恋爱,奇幻', '高中男女互换身体引发的奇幻爱情故事。', '新海诚', '2016-08-26'),
(22, '千与千寻', 'https://img.acgn.cc/anime/spirited-away.jpg', '日本', '已完结', 9.9, 17200000, '奇幻,冒险,成长', '千寻在神灵世界的冒险与成长。', '宫崎骏', '2001-07-20'),
(23, '死神', 'https://img.acgn.cc/anime/bleach.jpg', '日本', '连载中', 9.3, 7600000, '热血,战斗,死神', '黑崎一护获得死神力量的故事。', '久保带人', '2004-10-05'),
(24, '银魂', 'https://img.acgn.cc/anime/gintama.jpg', '日本', '已完结', 9.7, 6200000, '搞笑,武士,剧情', '坂田银时和他的伙伴们的日常冒险。', '空知英秋', '2006-04-04'),
(25, '夏目友人帐', 'https://img.acgn.cc/anime/natsume.jpg', '日本', '连载中', 9.5, 3800000, '治愈,奇幻,妖怪', '夏目玲子与猫咪老师归还妖怪名字的故事。', '绿川幸', '2008-07-08'),
(26, '哆啦A梦', 'https://img.acgn.cc/anime/doraemon.jpg', '日本', '连载中', 9.6, 14500000, '搞笑,奇幻,成长', '来自未来的猫型机器人哆啦A梦帮助大雄的故事。', '藤子·F·不二雄', '1979-04-02'),
(27, '灌篮高手', 'https://img.acgn.cc/anime/slam-dunk.jpg', '日本', '已完结', 9.8, 11200000, '运动,热血,校园', '湘北篮球队向着全国大赛努力的青春物语。', '井上雄彦', '1993-10-16'),
(28, '龙珠超', 'https://img.acgn.cc/anime/db-super.jpg', '日本', '已完结', 9.4, 9500000, '热血,战斗,科幻', '悟空等人面对强大宇宙敌人的战斗。', '鸟山明', '2015-07-05'),
(29, '灵能百分百', 'https://img.acgn.cc/anime/mob100.jpg', '日本', '已完结', 9.6, 4100000, '动作,成长,奇幻', '超能力少年影山茂夫的成长故事。', 'ONE', '2016-07-12'),
(30, '不死不幸', 'https://img.acgn.cc/anime/undead-unluck.jpg', '日本', '已完结', 9.5, 4200000, '奇幻,动作,恋爱', '不幸少女和不死能力的奇妙相遇。', '户冢庆文', '2023-10-07');

-- =============================================
-- 国产动漫数据（20条）
-- =============================================
MERGE INTO anime (id, title, cover_image, type, status, rating, view_count, tags, description, author, release_date) VALUES
(31, '斗破苍穹', 'https://img.acgn.cc/anime/doupo.jpg', '国产', '连载中', 9.5, 8800000, '热血,修炼,冒险', '少年萧炎从天才跌落废柴，凭借异火重登巅峰的故事。', '天蚕土豆', '2017-01-07'),
(32, '斗罗大陆', 'https://img.acgn.cc/anime/douluodalu.jpg', '国产', '连载中', 9.4, 9200000, '热血,武魂,冒险', '唐三带着唐门暗器绝学穿越到斗罗大陆的故事。', '唐家三少', '2018-01-20'),
(33, '完美世界', 'https://img.acgn.cc/anime/wanmei.jpg', '国产', '连载中', 9.3, 7500000, '修仙,冒险,成长', '石昊从小村庄走向无尽苍穹，追寻完美大道的故事。', '辰东', '2021-03-13'),
(34, '遮天', 'https://img.acgn.cc/anime/zhetian.jpg', '国产', '连载中', 9.2, 6900000, '修仙,探索,热血', '叶凡从月坟中走出，踏上不朽之路的故事。', '辰东', '2023-06-18'),
(35, '吞噬星空', 'https://img.acgn.cc/anime/tunshi.jpg', '国产', '连载中', 9.1, 6300000, '科幻,修炼,冒险', '罗峰以武力称雄，从地球走向宇宙的故事。', '我吃西红柿', '2019-01-26'),
(36, '万界独尊', 'https://img.acgn.cc/anime/wanjie.jpg', '国产', '连载中', 8.9, 5800000, '修仙,热血,冒险', '独自踏上修仙之路，寻求万界之巅的故事。', '未知', '2021-09-11'),
(37, '凡人修仙传', 'https://img.acgn.cc/anime/fanren.jpg', '国产', '连载中', 9.3, 7100000, '修仙,成长,冒险', '平凡少年韩立踏上修仙之路，历经千辛终成大乘修士。', '忘语', '2020-07-25'),
(38, '一人之下', 'https://img.acgn.cc/anime/yirenzhixia.jpg', '国产', '连载中', 9.4, 8500000, '异能,热血,悬疑', '张楚岚拥有神秘力量，卷入奇人异事的故事。', '米二', '2016-07-10'),
(39, '魁拔', 'https://img.acgn.cc/anime/kuiba.jpg', '国产', '已完结', 9.0, 4200000, '奇幻,热血,冒险', '少年蛮吉成长为魁拔的奇幻冒险故事。', '青青树', '2011-07-08'),
(40, '秦时明月', 'https://img.acgn.cc/anime/qinshi.jpg', '国产', '连载中', 9.3, 9800000, '历史,武侠,冒险', '秦时代背景，荆轲转世少年的江湖冒险故事。', '沈乐平', '2007-01-01'),
(41, '那年那兔那些事', 'https://img.acgn.cc/anime/natu.jpg', '国产', '已完结', 9.6, 6700000, '历史,热血,感动', '以小兔子为主角讲述中国近现代史的热血动漫。', '逆光飞行', '2015-03-12'),
(42, '镇魂街', 'https://img.acgn.cc/anime/zhenhunjie.jpg', '国产', '连载中', 9.1, 5500000, '武魂,热血,战斗', '镇守镇魂街的曹焱兵成长为一方守护者的故事。', '许辰', '2017-07-11'),
(43, '天官赐福', 'https://img.acgn.cc/anime/tianguan.jpg', '国产', '连载中', 9.5, 7800000, '仙侠,唯美,奇幻', '三太子谢怜八百年后重回天庭的故事。', '墨香铜臭', '2020-10-31'),
(44, '魔道祖师', 'https://img.acgn.cc/anime/modao.jpg', '国产', '已完结', 9.6, 8900000, '仙侠,悬疑,感情', '魏无羡与蓝忘机斩妖除魔的故事。', '墨香铜臭', '2018-07-09'),
(45, '灵笼', 'https://img.acgn.cc/anime/linglong.jpg', '国产', '连载中', 9.4, 5200000, '科幻,末世,冒险', '未来末世中人类与灵笼力量的抗争故事。', '艺画开天', '2019-10-17'),
(46, '雾山五行', 'https://img.acgn.cc/anime/wushan.jpg', '国产', '连载中', 9.5, 4600000, '水墨,奇幻,武侠', '以中国水墨风格呈现的奇幻武侠动漫。', '林魂', '2020-08-29'),
(47, '罗小黑战记', 'https://img.acgn.cc/anime/luoxiaohei.jpg', '国产', '已完结', 9.4, 5900000, '奇幻,治愈,冒险', '小黑猫妖罗小黑寻找家园的冒险故事。', 'MTJJ', '2011-05-23'),
(48, '大鱼海棠', 'https://img.acgn.cc/anime/dayu.jpg', '国产', '已完结', 9.2, 4300000, '奇幻,唯美,感情', '少女椿在人间世界的冒险与成长故事。', '梁旋、张春', '2016-07-08'),
(49, '哪吒之魔童降世', 'https://img.acgn.cc/anime/nezha.jpg', '国产', '已完结', 9.7, 12000000, '神话,热血,成长', '哪吒生而为妖，挣脱命运束缚的热血故事。', '饺子', '2019-07-26'),
(50, '白蛇：缘起', 'https://img.acgn.cc/anime/baishe.jpg', '国产', '已完结', 9.3, 5100000, '神话,恋爱,奇幻', '白蛇与许宣前世之缘的唯美爱情故事。', '黄家康、赵霁', '2019-01-11');

-- =============================================
-- 欧美动漫数据（15条）
-- =============================================
MERGE INTO anime (id, title, cover_image, type, status, rating, view_count, tags, description, author, release_date) VALUES
(51, '蜘蛛侠：平行宇宙', 'https://img.acgn.cc/anime/spiderman.jpg', '欧美', '已完结', 9.6, 11500000, '超级英雄,动作,冒险', '多元宇宙蜘蛛侠合力拯救世界的故事。', 'Phil Lord、Christopher Miller', '2018-12-14'),
(52, '疯狂动物城', 'https://img.acgn.cc/anime/zootopia.jpg', '欧美', '已完结', 9.5, 9800000, '冒险,搞笑,推理', '兔子警察与狐狸侦探携手破案的故事。', 'Byron Howard、Rich Moore', '2016-03-04'),
(53, '冰雪奇缘', 'https://img.acgn.cc/anime/frozen.jpg', '欧美', '已完结', 9.4, 13200000, '奇幻,感情,音乐', '安娜公主寻找姐姐艾莎解除魔咒的故事。', 'Chris Buck、Jennifer Lee', '2013-11-27'),
(54, '寻梦环游记', 'https://img.acgn.cc/anime/coco.jpg', '欧美', '已完结', 9.7, 10500000, '奇幻,音乐,感情', '少年米格尔误入亡灵世界寻找音乐梦想的故事。', 'Lee Unkrich', '2017-11-22'),
(55, '灵魂急转弯', 'https://img.acgn.cc/anime/soul.jpg', '欧美', '已完结', 9.5, 8900000, '奇幻,感人,音乐', '爵士乐手乔意外进入灵魂之地的故事。', 'Pete Docter', '2020-12-25'),
(56, '龙与地下城', 'https://img.acgn.cc/anime/dnd.jpg', '欧美', '已完结', 9.2, 7300000, '奇幻,冒险,搞笑', '一群亡命之徒踏上拯救家园的奇幻冒险旅途。', 'John Francis Daley、Jonathan Goldstein', '2023-03-31'),
(57, '蝙蝠侠：黑暗骑士崛起', 'https://img.acgn.cc/anime/batman.jpg', '欧美', '已完结', 9.3, 8100000, '超级英雄,动作,悬疑', '蝙蝠侠与强大反派班恩的终极对决。', 'Christopher Nolan', '2012-07-20'),
(58, '未来战士', 'https://img.acgn.cc/anime/terminator.jpg', '欧美', '已完结', 9.1, 6800000, '科幻,动作,末世', '来自未来的机器人与人类的对决故事。', 'James Cameron', '1984-10-26'),
(59, '星际穿越', 'https://img.acgn.cc/anime/interstellar.jpg', '欧美', '已完结', 9.6, 9200000, '科幻,冒险,感人', '宇航员穿越虫洞寻找人类新家园的故事。', 'Christopher Nolan', '2014-11-07'),
(60, '驯龙高手', 'https://img.acgn.cc/anime/httyd.jpg', '欧美', '已完结', 9.5, 8600000, '奇幻,冒险,感情', '少年希卡普与龙的深厚友情故事。', 'Dean DeBlois', '2010-03-26'),
(61, '玩具总动员4', 'https://img.acgn.cc/anime/toy-story4.jpg', '欧美', '已完结', 9.3, 9400000, '冒险,感动,友情', '胡迪与玩具伙伴们踏上全新冒险之旅。', 'Josh Cooley', '2019-06-21'),
(62, '超人总动员2', 'https://img.acgn.cc/anime/incredibles2.jpg', '欧美', '已完结', 9.2, 8200000, '超级英雄,搞笑,家庭', '超能先生一家对抗新反派的冒险故事。', 'Brad Bird', '2018-06-15'),
(63, '海底总动员', 'https://img.acgn.cc/anime/finding-nemo.jpg', '欧美', '已完结', 9.4, 7900000, '冒险,感动,友情', '父亲马林寻找儿子小丑鱼Nemo的故事。', 'Andrew Stanton', '2003-05-30'),
(64, '功夫熊猫4', 'https://img.acgn.cc/anime/kung-fu-panda4.jpg', '欧美', '已完结', 9.1, 7500000, '功夫,搞笑,冒险', '阿宝面对新挑战踏上新旅程的故事。', 'Mike Mitchell', '2024-03-08'),
(65, '机器人总动员', 'https://img.acgn.cc/anime/wall-e.jpg', '欧美', '已完结', 9.5, 8800000, '科幻,感人,冒险', '小机器人WALL-E与EVE的宇宙爱情故事。', 'Andrew Stanton', '2008-06-27');

-- =============================================
-- 动漫电影数据（10条）
-- =============================================
MERGE INTO anime (id, title, cover_image, type, status, rating, view_count, tags, description, author, release_date) VALUES
(66, '你的名字', 'https://img.acgn.cc/anime/your-name-movie.jpg', '电影', '已完结', 9.8, 15800000, '剧情,恋爱,奇幻', '高中男女互换身体引发的奇幻爱情故事。', '新海诚', '2016-08-26'),
(67, '千与千寻', 'https://img.acgn.cc/anime/spirited-away-movie.jpg', '电影', '已完结', 9.9, 17200000, '奇幻,冒险,成长', '千寻在神灵世界的冒险与成长，吉卜力经典之作。', '宫崎骏', '2001-07-20'),
(68, '哪吒之魔童降世', 'https://img.acgn.cc/anime/nezha-movie.jpg', '电影', '已完结', 9.7, 12000000, '神话,热血,成长', '哪吒生而为妖，挣脱命运束缚的热血故事。', '饺子', '2019-07-26'),
(69, '龙猫', 'https://img.acgn.cc/anime/totoro.jpg', '电影', '已完结', 9.8, 10500000, '治愈,奇幻,儿童', '小女孩小月与龙猫的温馨奇幻故事。', '宫崎骏', '1988-04-16'),
(70, '天空之城', 'https://img.acgn.cc/anime/laputa.jpg', '电影', '已完结', 9.7, 8900000, '奇幻,冒险,科幻', '少年少女寻找传说中天空之城的故事。', '宫崎骏', '1986-08-02'),
(71, '风之谷', 'https://img.acgn.cc/anime/nausicaa.jpg', '电影', '已完结', 9.6, 7800000, '奇幻,冒险,生态', '少女娜乌西卡在废土世界的冒险故事。', '宫崎骏', '1984-03-11'),
(72, '夏日大作战', 'https://img.acgn.cc/anime/summer-wars.jpg', '电影', '已完结', 9.5, 6500000, '科幻,家庭,冒险', '少年健二在网络世界与现实家庭的双重冒险。', '细田守', '2009-08-01'),
(73, '大护法', 'https://img.acgn.cc/anime/dahufaen.jpg', '电影', '已完结', 9.3, 5100000, '成人向,暗黑,剧情', '大护法在奇幻王国中的冒险与觉醒故事。', '不思凡', '2017-07-13'),
(74, '北极快车', 'https://img.acgn.cc/anime/polar-express.jpg', '电影', '已完结', 9.2, 6200000, '奇幻,圣诞,儿童', '男孩乘坐北极快车前往圣诞镇的奇幻旅程。', 'Robert Zemeckis', '2004-11-10'),
(75, '魁拔之大战元泱界', 'https://img.acgn.cc/anime/kuiba-movie.jpg', '电影', '已完结', 9.0, 3800000, '奇幻,热血,冒险', '蛮吉在元泱界与强大敌人的终极对决。', '青青树', '2014-07-04');

-- =============================================
-- 动漫详情数据（对应前30条日本动漫）
-- =============================================
MERGE INTO anime_detail (id, anime_id, title, introduction, author, type, cover_image, background_image, rating, view_count, favorite_count, tags, status, total_episodes, release_date, studio, director, voice_actors, video_url, episode_urls) VALUES
(1, 1, '海贼王', '少年路飞为了找到传说中的ONE PIECE，与伙伴们踏上冒险之旅的故事。这部作品描绘了友情、冒险和梦想的航海史诗，被誉为有史以来最伟大的漫画改编动漫之一。', '尾田荣一郎', '日本', 'https://img.acgn.cc/anime/one-piece.jpg', 'https://img.acgn.cc/anime/one-piece-bg.jpg', 9.9, 12500000, 8500000, '热血,冒险,友情', '连载中', 1111, '1999-10-20', '东映动画', '宇田钢之助', '田中真弓,中井和哉,岡村明美', 'https://v.acgn.cc/one-piece-ep1.mp4', '[{"ep":1,"title":"我是要成为海贼王的男人","url":"https://v.acgn.cc/one-piece-ep1.mp4"},{"ep":2,"title":"世界第一剑士的称号","url":"https://v.acgn.cc/one-piece-ep2.mp4"}]'),
(2, 2, '火影忍者', '少年漩涡鸣人为了成为火影，不断修炼成长的故事。这是一部关于友情、努力和胜利的热血物语，三大原则贯穿全作。', '岸本齐史', '日本', 'https://img.acgn.cc/anime/naruto.jpg', 'https://img.acgn.cc/anime/naruto-bg.jpg', 9.8, 9800000, 7800000, '热血,忍者,成长', '已完结', 720, '2002-10-03', 'Pierrot', '伊达勇登', '竹内顺子,中村千绘,井上和彦', 'https://v.acgn.cc/naruto-ep1.mp4', '[{"ep":1,"title":"12岁的忍者","url":"https://v.acgn.cc/naruto-ep1.mp4"},{"ep":2,"title":"比树叶还要坏的坏孩子？","url":"https://v.acgn.cc/naruto-ep2.mp4"}]'),
(3, 3, '咒术回战', '高中生虎杖悠仁吞下特级咒物，进入咒术高专的故事。现代咒术战斗的校园战斗番，作画精良，战斗场面震撼。', '芥见下下', '日本', 'https://img.acgn.cc/anime/jjk.jpg', 'https://img.acgn.cc/anime/jjk-bg.jpg', 9.7, 8200000, 6200000, '热血,战斗,奇幻', '连载中', 48, '2020-10-03', 'MAPPA', '朴朴朴', '榎木淳弥,中村悠一,内田真礼', 'https://v.acgn.cc/jjk-ep1.mp4', '[{"ep":1,"title":"两面宿傩","url":"https://v.acgn.cc/jjk-ep1.mp4"},{"ep":2,"title":"为了人而死","url":"https://v.acgn.cc/jjk-ep2.mp4"}]'),
(4, 4, '鬼灭之刃', '灶门炭治郎为了拯救变成鬼的妹妹，踏上猎鬼之旅的故事。ufotable制作的精美画质，感人的亲情故事。', '吾峠呼世晴', '日本', 'https://img.acgn.cc/anime/demon-slayer.jpg', 'https://img.acgn.cc/anime/demon-slayer-bg.jpg', 9.6, 10500000, 8900000, '热血,战斗,亲情', '连载中', 55, '2019-04-06', 'ufotable', '外崎春雄', '花江夏树,鬼头明里,下野纮', 'https://v.acgn.cc/demon-slayer-ep1.mp4', '[{"ep":1,"title":"残忍","url":"https://v.acgn.cc/demon-slayer-ep1.mp4"},{"ep":2,"title":"除了头部以外请从任何地方斩断","url":"https://v.acgn.cc/demon-slayer-ep2.mp4"}]'),
(5, 5, '我的英雄学院', '无个性少年绿谷出久获得最强个性，成为英雄的故事。超级英雄题材的校园战斗番，热血励志。', '堀越耕平', '日本', 'https://img.acgn.cc/anime/mha.jpg', 'https://img.acgn.cc/anime/mha-bg.jpg', 9.5, 7800000, 6100000, '热血,超能力,成长', '连载中', 138, '2016-04-03', 'BONES', '长崎健司', '山下大辉,梶裕贵,岡本信彦', 'https://v.acgn.cc/mha-ep1.mp4', '[{"ep":1,"title":"绿谷出久：诞生之日","url":"https://v.acgn.cc/mha-ep1.mp4"},{"ep":2,"title":"小小银英雄","url":"https://v.acgn.cc/mha-ep2.mp4"}]'),
(6, 6, '进击的巨人', '艾伦等人对抗巨人的故事，揭露世界真相的史诗巨作。世界观宏大，剧情精彩，是动漫史上的里程碑。', '谏山创', '日本', 'https://img.acgn.cc/anime/aot.jpg', 'https://img.acgn.cc/anime/aot-bg.jpg', 9.9, 11200000, 9200000, '战斗,悬疑,剧情', '已完结', 87, '2013-04-07', 'MAPPA', '荒木哲郎', '梶裕贵,井上麻里奈,神谷浩史', 'https://v.acgn.cc/aot-ep1.mp4', '[{"ep":1,"title":"致先驱者的怒吼","url":"https://v.acgn.cc/aot-ep1.mp4"},{"ep":2,"title":"合格者 第57次壁外调查行动①","url":"https://v.acgn.cc/aot-ep2.mp4"}]'),
(7, 7, '名侦探柯南', '高中生侦探工藤新一被变小后化名江户川柯南破案的故事。经典推理动画，已持续连载近30年。', '青山刚昌', '日本', 'https://img.acgn.cc/anime/detective-conan.jpg', 'https://img.acgn.cc/anime/detective-conan-bg.jpg', 9.7, 13500000, 10500000, '推理,悬疑,侦探', '连载中', 1185, '1996-01-08', 'TMS Entertainment', '山本泰一郎', '高山南,山崎和佳奈,神谷明', 'https://v.acgn.cc/conan-ep1.mp4', '[{"ep":1,"title":"过山车密室案","url":"https://v.acgn.cc/conan-ep1.mp4"},{"ep":2,"title":"超级金刚双胞胎事件","url":"https://v.acgn.cc/conan-ep2.mp4"}]'),
(8, 8, '关于我转生变成史莱姆这档事', '上班族转生成为最强史莱姆的异世界冒险故事。轻松愉快的异世界题材，国民度极高。', '伏濑', '日本', 'https://img.acgn.cc/anime/teslime.jpg', 'https://img.acgn.cc/anime/teslime-bg.jpg', 9.5, 6500000, 5100000, '转生,奇幻,冒险', '连载中', 48, '2018-10-02', '8bit', '菊池宣幸', '冈咲美保,丰口惠美', 'https://v.acgn.cc/teslime-ep1.mp4', '[{"ep":1,"title":"关于我转生变成史莱姆这档事","url":"https://v.acgn.cc/teslime-ep1.mp4"},{"ep":2,"title":"关于暴风龙这档事","url":"https://v.acgn.cc/teslime-ep2.mp4"}]'),
(9, 9, '全职猎人', '小杰为了寻找父亲成为猎人的冒险故事。富坚老贼的代表作，念能力体系无比精彩。', '富坚义博', '日本', 'https://img.acgn.cc/anime/hxh.jpg', 'https://img.acgn.cc/anime/hxh-bg.jpg', 9.8, 7200000, 5800000, '热血,冒险,成长', '连载中', 148, '2011-10-02', 'Madhouse', '神志那弘志', '潘惠美,伊濑茉莉也,日野聪', 'https://v.acgn.cc/hxh-ep1.mp4', '[{"ep":1,"title":"出发！从伊鲁米出发的小伙伴！","url":"https://v.acgn.cc/hxh-ep1.mp4"},{"ep":2,"title":"申请者是野蛮人？恶名昭彰的巴士考场！","url":"https://v.acgn.cc/hxh-ep2.mp4"}]'),
(10, 10, '刀剑神域', '桐人被困在VRMMORPG中，为了通关而战斗的故事。游戏题材的异世界冒险，开创了isekai类型的先河。', '川原砾', '日本', 'https://img.acgn.cc/anime/sao.jpg', 'https://img.acgn.cc/anime/sao-bg.jpg', 9.4, 8900000, 7100000, '游戏,冒险,恋爱', '已完结', 96, '2012-07-08', 'A-1 Pictures', '伊藤智彦', '松冈祯丞,户松遥,日高里菜', 'https://v.acgn.cc/sao-ep1.mp4', '[{"ep":1,"title":"剑的世界","url":"https://v.acgn.cc/sao-ep1.mp4"},{"ep":2,"title":"决斗者","url":"https://v.acgn.cc/sao-ep2.mp4"}]'),
(11, 11, 'Re:从零开始的异世界生活', '菜月昴穿越到异世界，拥有死亡回归能力的冒险故事。剧情烧脑，情感真挚，是异世界题材的佼佼者。', '长月达平', '日本', 'https://img.acgn.cc/anime/rezero.jpg', 'https://img.acgn.cc/anime/rezero-bg.jpg', 9.6, 7500000, 6200000, '转生,奇幻,悬疑', '连载中', 50, '2016-04-04', 'White Fox', '渡边政治', '小林裕介,高桥李依,水濑祈', 'https://v.acgn.cc/rezero-ep1.mp4', '[{"ep":1,"title":"从零开始异世界生活","url":"https://v.acgn.cc/rezero-ep1.mp4"},{"ep":2,"title":"再见，王都","url":"https://v.acgn.cc/rezero-ep2.mp4"}]'),
(12, 12, '排球少年', '日向翔阳加入排球部，向着全国大赛努力的青春物语。热血运动番的经典之作，令人热血沸腾。', '古馆春一', '日本', 'https://img.acgn.cc/anime/haikyuu.jpg', 'https://img.acgn.cc/anime/haikyuu-bg.jpg', 9.7, 6800000, 5500000, '运动,校园,热血', '已完结', 85, '2014-04-06', 'Production I.G', '满仲劝', '村濑步,石川界人,入野自由', 'https://v.acgn.cc/haikyuu-ep1.mp4', '[{"ep":1,"title":"小巨人","url":"https://v.acgn.cc/haikyuu-ep1.mp4"},{"ep":2,"title":"球队","url":"https://v.acgn.cc/haikyuu-ep2.mp4"}]'),
(13, 13, '间谍过家家', '间谍、杀手和超能力者组成的虚假家庭的日常生活。温馨搞笑的家庭喜剧，2022年度最热门动漫。', '远藤达哉', '日本', 'https://img.acgn.cc/anime/spy-family.jpg', 'https://img.acgn.cc/anime/spy-family-bg.jpg', 9.5, 9200000, 7600000, '搞笑,家庭,动作', '连载中', 37, '2022-04-09', 'Wit Studio', '古桥一浩', '江口拓也,种崎敦美,早见沙织', 'https://v.acgn.cc/spy-family-ep1.mp4', '[{"ep":1,"title":"见面·为了和平","url":"https://v.acgn.cc/spy-family-ep1.mp4"},{"ep":2,"title":"接受任务","url":"https://v.acgn.cc/spy-family-ep2.mp4"}]'),
(14, 14, '葬送的芙莉莲', '活了千年的精灵魔法师芙莉莲的冒险旅程。细腻感人的奇幻物语，2023年度神作，荣获多个大奖。', '山田钟人', '日本', 'https://img.acgn.cc/anime/frieren.jpg', 'https://img.acgn.cc/anime/frieren-bg.jpg', 9.8, 5600000, 4700000, '奇幻,冒险,治愈', '已完结', 28, '2023-09-29', 'Madhouse', '斋藤圭一郎', '种崎敦美,市之濑加那,小林千晶', 'https://v.acgn.cc/frieren-ep1.mp4', '[{"ep":1,"title":"旅途的终点","url":"https://v.acgn.cc/frieren-ep1.mp4"},{"ep":2,"title":"冒险的价值","url":"https://v.acgn.cc/frieren-ep2.mp4"}]'),
(15, 15, '迷宫饭', '在地下迷宫中烹饪怪物料理的冒险故事。独特的美食奇幻冒险番，2024年话题之作。', '九井谅子', '日本', 'https://img.acgn.cc/anime/dungeon-meshi.jpg', 'https://img.acgn.cc/anime/dungeon-meshi-bg.jpg', 9.6, 4900000, 4100000, '奇幻,美食,冒险', '已完结', 24, '2024-01-04', 'Studio Trigger', '宫岛善博', '千叶翔也,雨宫天,泽城美雪', 'https://v.acgn.cc/dungeon-meshi-ep1.mp4', '[{"ep":1,"title":"烤蝎子·走地鸡炒蘑菇","url":"https://v.acgn.cc/dungeon-meshi-ep1.mp4"},{"ep":2,"title":"辣炒蟹壳·浅摊爆炒植物","url":"https://v.acgn.cc/dungeon-meshi-ep2.mp4"}]'),
(16, 16, '我独自升级', '最弱猎人程肖宇获得系统能力成为最强。超能力战斗的爽番，2024年爆款作品。', 'Chugong', '日本', 'https://img.acgn.cc/anime/solo-leveling.jpg', 'https://img.acgn.cc/anime/solo-leveling-bg.jpg', 9.6, 8800000, 7300000, '动作,冒险,成长', '已完结', 12, '2024-01-07', 'A-1 Pictures', '中重俊祐', '坂泰斗,中村源太,日野聪', 'https://v.acgn.cc/solo-leveling-ep1.mp4', '[{"ep":1,"title":"我，诸如此类","url":"https://v.acgn.cc/solo-leveling-ep1.mp4"},{"ep":2,"title":"我是该死的最弱等级","url":"https://v.acgn.cc/solo-leveling-ep2.mp4"}]'),
(17, 17, '电锯人', '电锯人淀治猎杀恶魔的故事。黑暗风格的动作番，MAPPA制作，画质极佳。', '藤本树', '日本', 'https://img.acgn.cc/anime/chainsaw-man.jpg', 'https://img.acgn.cc/anime/chainsaw-man-bg.jpg', 9.4, 7100000, 5800000, '动作,黑暗,奇幻', '连载中', 12, '2022-10-11', 'MAPPA', '中山龙', '户谷菊之介,雨宫天,楠木灯', 'https://v.acgn.cc/chainsaw-man-ep1.mp4', '[{"ep":1,"title":"狗与电锯","url":"https://v.acgn.cc/chainsaw-man-ep1.mp4"},{"ep":2,"title":"蕃茄","url":"https://v.acgn.cc/chainsaw-man-ep2.mp4"}]'),
(18, 18, '辉夜大小姐想让我告白', '秀知院学园学生会会长的恋爱头脑战。甜蜜搞笑的恋爱喜剧，三季均获极高评价。', '赤坂明', '日本', 'https://img.acgn.cc/anime/kaguya.jpg', 'https://img.acgn.cc/anime/kaguya-bg.jpg', 9.3, 6500000, 5200000, '恋爱,校园,搞笑', '连载中', 37, '2019-01-12', 'A-1 Pictures', '畠山守', '古贺葵,古川慎,佐藤利奈', 'https://v.acgn.cc/kaguya-ep1.mp4', '[{"ep":1,"title":"辉夜大小姐想让白银告白/白银想让辉夜告白","url":"https://v.acgn.cc/kaguya-ep1.mp4"},{"ep":2,"title":"藤原千花想玩游戏/辉夜大小姐不想被人想","url":"https://v.acgn.cc/kaguya-ep2.mp4"}]'),
(19, 19, '一拳超人', '埼玉老师一拳解决一切的英雄故事。搞笑热血战斗番，格斗场面堪称神作。', 'ONE', '日本', 'https://img.acgn.cc/anime/opm.jpg', 'https://img.acgn.cc/anime/opm-bg.jpg', 9.5, 8200000, 6800000, '动作,搞笑,英雄', '连载中', 24, '2015-10-05', 'Madhouse', '夏目真悟', '古川慎,石川界人,梶裕贵', 'https://v.acgn.cc/opm-ep1.mp4', '[{"ep":1,"title":"一拳超人","url":"https://v.acgn.cc/opm-ep1.mp4"},{"ep":2,"title":"最强男人","url":"https://v.acgn.cc/opm-ep2.mp4"}]'),
(20, 20, '紫罗兰永恒花园', '自动手记人偶薇尔莉特寻找感情真谛的故事。京都动画出品，感人的剧情番，每集都令人落泪。', '晓佳奈', '日本', 'https://img.acgn.cc/anime/violet.jpg', 'https://img.acgn.cc/anime/violet-bg.jpg', 9.7, 5900000, 4800000, '剧情,治愈,战争', '已完结', 13, '2018-01-11', 'Kyoto Animation', '石立太一', '石川由依,子安武人,浪川大辅', 'https://v.acgn.cc/violet-ep1.mp4', '[{"ep":1,"title":"自动手记人偶","url":"https://v.acgn.cc/violet-ep1.mp4"},{"ep":2,"title":"放在心中的那个词语","url":"https://v.acgn.cc/violet-ep2.mp4"}]'),
(21, 21, '你的名字', '高中男女互换身体引发的奇幻爱情故事。新海诚导演，感动无数人的动漫电影，全球票房超2.5亿美元。', '新海诚', '日本', 'https://img.acgn.cc/anime/your-name.jpg', 'https://img.acgn.cc/anime/your-name-bg.jpg', 9.8, 15800000, 13500000, '剧情,恋爱,奇幻', '已完结', 1, '2016-08-26', 'CoMix Wave Films', '新海诚', '神木隆之介,上白石萌音', 'https://v.acgn.cc/your-name-full.mp4', '[{"ep":1,"title":"你的名字（完整版）","url":"https://v.acgn.cc/your-name-full.mp4"}]'),
(22, 22, '千与千寻', '千寻在神灵世界的冒险与成长。宫崎骏导演，吉卜力经典之作，奥斯卡最佳动画长片得主。', '宫崎骏', '日本', 'https://img.acgn.cc/anime/spirited-away.jpg', 'https://img.acgn.cc/anime/spirited-away-bg.jpg', 9.9, 17200000, 14800000, '奇幻,冒险,成长', '已完结', 1, '2001-07-20', 'Studio Ghibli', '宫崎骏', '柊瑠美,入野自由,夏木玛利', 'https://v.acgn.cc/spirited-away-full.mp4', '[{"ep":1,"title":"千与千寻（完整版）","url":"https://v.acgn.cc/spirited-away-full.mp4"}]'),
(23, 23, '死神', '黑崎一护获得死神力量的故事。经典战斗番，千年血战篇于2022年回归。', '久保带人', '日本', 'https://img.acgn.cc/anime/bleach.jpg', 'https://img.acgn.cc/anime/bleach-bg.jpg', 9.3, 7600000, 6200000, '热血,战斗,死神', '连载中', 366, '2004-10-05', 'Pierrot', '阿部记之', '森田成一,折笠富美子,冬马由美', 'https://v.acgn.cc/bleach-ep1.mp4', '[{"ep":1,"title":"一护无法解决死神之战","url":"https://v.acgn.cc/bleach-ep1.mp4"},{"ep":2,"title":"死神的力量","url":"https://v.acgn.cc/bleach-ep2.mp4"}]'),
(24, 24, '银魂', '坂田银时和他的伙伴们的日常冒险。搞笑吐槽神作，涵盖搞笑、剧情、热血等多种类型。', '空知英秋', '日本', 'https://img.acgn.cc/anime/gintama.jpg', 'https://img.acgn.cc/anime/gintama-bg.jpg', 9.7, 6200000, 5100000, '搞笑,武士,剧情', '已完结', 367, '2006-04-04', 'Sunrise', '高松信司', '杉田智和,阪口大助,釘宫理惠', 'https://v.acgn.cc/gintama-ep1.mp4', '[{"ep":1,"title":"在这个世界，武士精神已不再……怎么可能！","url":"https://v.acgn.cc/gintama-ep1.mp4"},{"ep":2,"title":"摩耶卡马纳","url":"https://v.acgn.cc/gintama-ep2.mp4"}]'),
(25, 25, '夏目友人帐', '夏目玲子与猫咪老师归还妖怪名字的故事。温暖治愈番，治愈系动漫中的佳作。', '绿川幸', '日本', 'https://img.acgn.cc/anime/natsume.jpg', 'https://img.acgn.cc/anime/natsume-bg.jpg', 9.5, 3800000, 3100000, '治愈,奇幻,妖怪', '连载中', 75, '2008-07-08', 'Brains Base', '大森贵弘', '神谷浩史,井上和彦,小林沙苗', 'https://v.acgn.cc/natsume-ep1.mp4', '[{"ep":1,"title":"夏目友人帐","url":"https://v.acgn.cc/natsume-ep1.mp4"},{"ep":2,"title":"纸沼","url":"https://v.acgn.cc/natsume-ep2.mp4"}]'),
(26, 26, '哆啦A梦', '来自未来的猫型机器人哆啦A梦帮助大雄的故事。国民级动漫，陪伴几代人成长的经典作品。', '藤子·F·不二雄', '日本', 'https://img.acgn.cc/anime/doraemon.jpg', 'https://img.acgn.cc/anime/doraemon-bg.jpg', 9.6, 14500000, 12000000, '搞笑,奇幻,成长', '连载中', 2700, '1979-04-02', 'Shogakukan Music & Digital Entertainment', '本乡满', '水田山葵,大原惠美,木村昱', 'https://v.acgn.cc/doraemon-ep1.mp4', '[{"ep":1,"title":"哆啦A梦来了","url":"https://v.acgn.cc/doraemon-ep1.mp4"},{"ep":2,"title":"竹蜻蜓","url":"https://v.acgn.cc/doraemon-ep2.mp4"}]'),
(27, 27, '灌篮高手', '湘北篮球队向着全国大赛努力的青春物语。运动番经典之作，2023年推出剧场版大获成功。', '井上雄彦', '日本', 'https://img.acgn.cc/anime/slam-dunk.jpg', 'https://img.acgn.cc/anime/slam-dunk-bg.jpg', 9.8, 11200000, 9500000, '运动,热血,校园', '已完结', 101, '1993-10-16', 'Toei Animation', '西泽信孝', '草尾毅,绿川光,置鲇龙太郎', 'https://v.acgn.cc/slam-dunk-ep1.mp4', '[{"ep":1,"title":"我是天才！！","url":"https://v.acgn.cc/slam-dunk-ep1.mp4"},{"ep":2,"title":"他是篮球白痴！！","url":"https://v.acgn.cc/slam-dunk-ep2.mp4"}]'),
(28, 28, '龙珠超', '悟空等人面对强大宇宙敌人的战斗。热血战斗经典续作，破坏神比鲁斯的登场让粉丝疯狂。', '鸟山明', '日本', 'https://img.acgn.cc/anime/db-super.jpg', 'https://img.acgn.cc/anime/db-super-bg.jpg', 9.4, 9500000, 7900000, '热血,战斗,科幻', '已完结', 131, '2015-07-05', 'Toei Animation', '地冈公俊', '野泽雅子,堀川亮,鶴ひろみ', 'https://v.acgn.cc/db-super-ep1.mp4', '[{"ep":1,"title":"再见，悟饭！胡须老爷爷的育儿计划","url":"https://v.acgn.cc/db-super-ep1.mp4"},{"ep":2,"title":"大神比鲁斯的复仇","url":"https://v.acgn.cc/db-super-ep2.mp4"}]'),
(29, 29, '灵能百分百', '超能力少年影山茂夫的成长故事。温暖治愈的成长番，BONES制作，战斗场面极为华丽。', 'ONE', '日本', 'https://img.acgn.cc/anime/mob100.jpg', 'https://img.acgn.cc/anime/mob100-bg.jpg', 9.6, 4100000, 3300000, '动作,成长,奇幻', '已完结', 37, '2016-07-12', 'Bones', '立川让', '伊藤节生,种崎敦美,日野聪', 'https://v.acgn.cc/mob100-ep1.mp4', '[{"ep":1,"title":"自我-~100%~","url":"https://v.acgn.cc/mob100-ep1.mp4"},{"ep":2,"title":"IG组织-~100%~","url":"https://v.acgn.cc/mob100-ep2.mp4"}]'),
(30, 30, '不死不幸', '不幸少女和不死能力的奇妙相遇。独特的设定和精彩的战斗场面，David Production出品。', '户冢庆文', '日本', 'https://img.acgn.cc/anime/undead-unluck.jpg', 'https://img.acgn.cc/anime/undead-unluck-bg.jpg', 9.5, 4200000, 3500000, '奇幻,动作,恋爱', '已完结', 24, '2023-10-07', 'David Production', '铃木健太郎', '户谷菊之介,濑户麻沙美,坂本真绫', 'https://v.acgn.cc/undead-unluck-ep1.mp4', '[{"ep":1,"title":"不死不幸","url":"https://v.acgn.cc/undead-unluck-ep1.mp4"},{"ep":2,"title":"unbelievable","url":"https://v.acgn.cc/undead-unluck-ep2.mp4"}]');

-- =============================================
-- 动漫资讯新闻数据（15条）
-- =============================================
MERGE INTO anime_news (id, title, summary, cover_image, category, source, view_count, tags, status, publish_time) VALUES
(1, '《咒术回战》第三季确认制作，预计2025年播出', '官方宣布《咒术回战》第三季正式立项，MAPPA继续制作，预计2025年春季播出。', 'https://img.acgn.cc/news/jjk-s3.jpg', '新番资讯', '官方公告', 58900, '咒术回战,新番', 1, CURRENT_TIMESTAMP),
(2, '《间谍过家家》第三季宣布制作', 'Wit Studio宣布《间谍过家家》第三季正式开始制作，阿尼亚将迎来新的冒险。', 'https://img.acgn.cc/news/spy-s3.jpg', '新番资讯', 'AnimeNews', 45600, '间谍过家家,新番', 1, CURRENT_TIMESTAMP),
(3, '2024年度动漫排行：《葬送的芙莉莲》荣登榜首', '各大媒体评选2024年度最佳动漫，《葬送的芙莉莲》以绝对优势夺得冠军，成为年度最佳。', 'https://img.acgn.cc/news/frieren-top.jpg', '资讯', '动漫时报', 72100, '葬送的芙莉莲,年度排行', 1, CURRENT_TIMESTAMP),
(4, '声优花江夏树出演新番《XX》男主角', '知名声优花江夏树将出演2025年新番的男主角，粉丝期待度极高。', 'https://img.acgn.cc/news/hanae.jpg', '声优消息', '声优俱乐部', 38700, '花江夏树,声优', 1, CURRENT_TIMESTAMP),
(5, 'MAPPA公开2025年制作计划，多部新番齐亮相', 'MAPPA公布2025年度制作计划，包括多部热门续作和全新原创动漫，令粉丝兴奋不已。', 'https://img.acgn.cc/news/mappa-2025.jpg', '制作动态', 'MAPPA官方', 91200, 'MAPPA,2025新番', 1, CURRENT_TIMESTAMP),
(6, '《鬼灭之刃》无限城篇剧场版三部曲正式确认', '吾峠呼世晴原著改编，《鬼灭之刃》无限城篇将制作成三部剧场版，ufotable继续担任制作。', 'https://img.acgn.cc/news/kimetsu-movie.jpg', '新番资讯', '官方公告', 125000, '鬼灭之刃,剧场版', 1, CURRENT_TIMESTAMP),
(7, '《哪吒2》票房突破100亿，刷新国产动漫纪录', '国产动漫《哪吒之魔童闹海》票房突破100亿，成为中国影史最高票房动漫电影。', 'https://img.acgn.cc/news/nezha2-box.jpg', '资讯', '票房追踪', 186000, '哪吒,国产动漫', 1, CURRENT_TIMESTAMP),
(8, '《斗罗大陆》动漫正式完结，粉丝不舍', '陪伴观众多年的《斗罗大陆》动漫版即将迎来大结局，制作团队发布最终特辑。', 'https://img.acgn.cc/news/douluo-final.jpg', '新番资讯', '腾讯动漫', 67800, '斗罗大陆,完结', 1, CURRENT_TIMESTAMP),
(9, '2025春季新番预览：这些作品值得期待', '2025年春季档期即将开始，本文为你盘点值得关注的热门新番，从续作到原创应有尽有。', 'https://img.acgn.cc/news/spring-2025.jpg', '新番资讯', '新番速报', 83400, '2025春番,新番', 1, CURRENT_TIMESTAMP),
(10, '种崎敦美荣获年度最佳声优奖', '人气声优种崎敦美凭借《葬送的芙莉莲》中芙莉莲一角荣获多个声优奖项，实力获得认可。', 'https://img.acgn.cc/news/tanezaki.jpg', '声优消息', '声优大赏', 52300, '种崎敦美,声优奖', 1, CURRENT_TIMESTAMP),
(11, '《我独自升级》第二季确定制作，原班人马回归', '大受好评的《我独自升级》宣布第二季制作确定，A-1 Pictures原班人马回归，预计年内播出。', 'https://img.acgn.cc/news/solo-leveling-s2.jpg', '新番资讯', '官方公告', 98700, '我独自升级,第二季', 1, CURRENT_TIMESTAMP),
(12, '京都动画新作《XXX》宣传PV公开', '京都动画发布全新原创动漫宣传视频，精美的作画质量再次震惊业界，期待值拉满。', 'https://img.acgn.cc/news/kyoani-new.jpg', '制作动态', 'Kyoto Animation', 41200, '京都动画,新作', 1, CURRENT_TIMESTAMP),
(13, '《电锯人》第二季确认！MAPPA将于2025年献上', '原著漫画大热的《电锯人》动漫第二季由MAPPA继续操刀，制作规格将进一步提升。', 'https://img.acgn.cc/news/chainsaw-s2.jpg', '新番资讯', '官方公告', 76500, '电锯人,第二季', 1, CURRENT_TIMESTAMP),
(14, '这些动漫周边卖疯了！2024年度热门周边盘点', '2024年销量最高的动漫周边产品大盘点，手办、联名款产品等，看看你收集了几款。', 'https://img.acgn.cc/news/merch-2024.jpg', '周边情报', '周边情报站', 59800, '周边,手办', 1, CURRENT_TIMESTAMP),
(15, '动漫迷必看！2025年最值得追的10部动漫', '新的一年，动漫爱好者不能错过这些作品，从热血战斗到温馨治愈，总有一款适合你。', 'https://img.acgn.cc/news/must-watch-2025.jpg', '资讯', '动漫推荐', 110300, '推荐,2025', 1, CURRENT_TIMESTAMP);

-- =============================================
-- 示例评论数据
-- =============================================
MERGE INTO anime_comment (id, anime_id, username, content, rating, likes) VALUES
(1, 1, '路飞粉丝', '海贼王是我的青春，看了20多年了，还是追的那么起劲！', 10, 1250),
(2, 1, '动漫达人', '最近的剧情太精彩了，最终章感觉要来了', 9, 876),
(3, 1, '老鸟观众', '从小学看到大学，路飞是我的英雄', 10, 650),
(4, 2, '火影粉', '鸣人的成长历程太感动了，再看一遍还是会哭', 10, 980),
(5, 2, '千年等一回', '这是我看过的最好的热血动漫，没有之一', 9, 723),
(6, 3, '术师见习生', '咒术回战打斗场面太帅了，MAPPA没有让人失望', 9, 543),
(7, 4, '炭治郎应援', '鬼灭之刃的作画是业界天花板，ufotable太强了', 10, 892),
(8, 6, '进击党', '进击的巨人是神作，结局争议很大但我觉得还是很好', 9, 1100),
(9, 14, '芙莉莲迷', '葬送的芙莉莲让我重新相信了爱情，每集都在哭', 10, 760),
(10, 22, '宫崎骏信徒', '千与千寻永远是最好的动漫电影，百看不厌', 10, 1580);
