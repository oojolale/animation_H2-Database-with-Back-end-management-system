-- 为anime表添加author字段
ALTER TABLE `anime` ADD COLUMN `author` VARCHAR(100) DEFAULT '未知' COMMENT '作者/原作' AFTER `description`;

-- 为anime_detail表添加author字段
ALTER TABLE `anime_detail` ADD COLUMN `author` VARCHAR(100) DEFAULT '未知' COMMENT '作者/原作' AFTER `introduction`;

-- 更新现有数据的作者信息
UPDATE `anime` SET `author` = '尾田荣一郎' WHERE `title` = '海贼王';
UPDATE `anime` SET `author` = '岸本齐史' WHERE `title` = '火影忍者';
UPDATE `anime` SET `author` = '芥见下下' WHERE `title` = '咒术回战';
UPDATE `anime` SET `author` = '吾峠呼世晴' WHERE `title` = '鬼灭之刃';
UPDATE `anime` SET `author` = '堀越耕平' WHERE `title` = '我的英雄学院';
UPDATE `anime` SET `author` = '谏山创' WHERE `title` = '进击的巨人';
UPDATE `anime` SET `author` = '青山刚昌' WHERE `title` = '名侦探柯南';
UPDATE `anime` SET `author` = '伏濑' WHERE `title` = '关于我转生变成史莱姆这档事';
UPDATE `anime` SET `author` = '富坚义博' WHERE `title` = '全职猎人';
UPDATE `anime` SET `author` = '川原砾' WHERE `title` = '刀剑神域';
UPDATE `anime` SET `author` = '长月达平' WHERE `title` = 'Re:从零开始的异世界生活';
UPDATE `anime` SET `author` = '古馆春一' WHERE `title` = '排球少年';
UPDATE `anime` SET `author` = '远藤达哉' WHERE `title` = '间谍过家家';
UPDATE `anime` SET `author` = '山田钟人' WHERE `title` = '葬送的芙莉莲';
UPDATE `anime` SET `author` = '九井谅子' WHERE `title` = '迷宫饭';
UPDATE `anime` SET `author` = 'Chugong' WHERE `title` = '我独自升级';
UPDATE `anime` SET `author` = '藤本树' WHERE `title` = '电锯人';
UPDATE `anime` SET `author` = '赤坂明' WHERE `title` = '辉夜大小姐想让我告白';
UPDATE `anime` SET `author` = 'ONE' WHERE `title` = '一拳超人';
UPDATE `anime` SET `author` = '晓佳奈' WHERE `title` = '紫罗兰永恒花园';
UPDATE `anime` SET `author` = '新海诚' WHERE `title` = '你的名字';
UPDATE `anime` SET `author` = '宫崎骏' WHERE `title` = '千与千寻';
UPDATE `anime` SET `author` = '久保带人' WHERE `title` = '死神';
UPDATE `anime` SET `author` = '空知英秋' WHERE `title` = '银魂';
UPDATE `anime` SET `author` = '绿川幸' WHERE `title` = '夏目友人帐';
UPDATE `anime` SET `author` = '藤子·F·不二雄' WHERE `title` = '哆啦A梦';
UPDATE `anime` SET `author` = '井上雄彦' WHERE `title` = '灌篮高手';
UPDATE `anime` SET `author` = '鸟山明' WHERE `title` = '龙珠超';
UPDATE `anime` SET `author` = 'ONE' WHERE `title` = '灵能百分百';
UPDATE `anime` SET `author` = '户冢庆文' WHERE `title` = '不死不幸';

-- 国产动漫作者
UPDATE `anime` SET `author` = '天蚕土豆' WHERE `title` = '斗破苍穹';
UPDATE `anime` SET `author` = '唐家三少' WHERE `title` = '斗罗大陆';
UPDATE `anime` SET `author` = '辰东' WHERE `title` = '完美世界';
UPDATE `anime` SET `author` = '辰东' WHERE `title` = '遮天';
UPDATE `anime` SET `author` = '我吃西红柿' WHERE `title` = '吞噬星空';
UPDATE `anime` SET `author` = '未知' WHERE `title` = '万界独尊';
UPDATE `anime` SET `author` = '忘语' WHERE `title` = '凡人修仙传';
UPDATE `anime` SET `author` = '米二' WHERE `title` = '一人之下';
UPDATE `anime` SET `author` = '青青树' WHERE `title` = '魁拔';
UPDATE `anime` SET `author` = '沈乐平' WHERE `title` = '秦时明月';
UPDATE `anime` SET `author` = '逆光飞行' WHERE `title` = '那年那兔那些事';
UPDATE `anime` SET `author` = '许辰' WHERE `title` = '镇魂街';
UPDATE `anime` SET `author` = '墨香铜臭' WHERE `title` = '天官赐福';
UPDATE `anime` SET `author` = '墨香铜臭' WHERE `title` = '魔道祖师';
UPDATE `anime` SET `author` = '艺画开天' WHERE `title` = '灵笼';
UPDATE `anime` SET `author` = '林魂' WHERE `title` = '雾山五行';
UPDATE `anime` SET `author` = 'MTJJ' WHERE `title` = '罗小黑战记';
UPDATE `anime` SET `author` = '梁旋、张春' WHERE `title` = '大鱼海棠';
UPDATE `anime` SET `author` = '饺子' WHERE `title` = '哪吒之魔童降世';
UPDATE `anime` SET `author` = '黄家康、赵霁' WHERE `title` = '白蛇：缘起';

-- 欧美动漫作者
UPDATE `anime` SET `author` = 'Phil Lord、Christopher Miller' WHERE `title` = '蜘蛛侠：平行宇宙';
UPDATE `anime` SET `author` = 'Byron Howard、Rich Moore' WHERE `title` = '疯狂动物城';
UPDATE `anime` SET `author` = 'Chris Buck、Jennifer Lee' WHERE `title` = '冰雪奇缘';
UPDATE `anime` SET `author` = 'Lee Unkrich' WHERE `title` = '寻梦环游记';
UPDATE `anime` SET `author` = 'Pete Docter' WHERE `title` = '灵魂急转弯';
UPDATE `anime` SET `author` = 'John Francis Daley、Jonathan Goldstein' WHERE `title` = '龙与地下城';
UPDATE `anime` SET `author` = 'Christopher Nolan' WHERE `title` = '蝙蝠侠：黑暗骑士崛起';
UPDATE `anime` SET `author` = 'James Cameron' WHERE `title` = '未来战士';
UPDATE `anime` SET `author` = 'Christopher Nolan' WHERE `title` = '星际穿越';
UPDATE `anime` SET `author` = 'Dean DeBlois' WHERE `title` = '驯龙高手';
UPDATE `anime` SET `author` = 'Josh Cooley' WHERE `title` = '玩具总动员4';
UPDATE `anime` SET `author` = 'Brad Bird' WHERE `title` = '超人总动员2';
UPDATE `anime` SET `author` = 'Andrew Stanton' WHERE `title` = '海底总动员';
UPDATE `anime` SET `author` = 'Mike Mitchell' WHERE `title` = '功夫熊猫4';
UPDATE `anime` SET `author` = 'Andrew Stanton' WHERE `title` = '机器人总动员';

-- 同步anime_detail表的作者信息
UPDATE `anime_detail` ad 
JOIN `anime` a ON ad.anime_id = a.id 
SET ad.author = a.author 
WHERE ad.author = '未知' OR ad.author IS NULL;

-- 显示更新结果
SELECT title, author FROM `anime` ORDER BY type, title;