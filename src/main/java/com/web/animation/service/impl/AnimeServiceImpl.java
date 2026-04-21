package com.web.animation.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.web.animation.entity.*;
import com.web.animation.mapper.*;
import com.web.animation.repository.RoleRepository;
import com.web.animation.repository.UserRepository;
import com.web.animation.service.AnimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.*;

@Service
public class AnimeServiceImpl implements AnimeService {

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private AnimeDetailMapper animeDetailMapper;

    @Autowired
    private AnimeCommentMapper commentMapper;

    @Autowired
    private AnimeFavoriteMapper favoriteMapper;

    @Autowired
    private AnimeNewsMapper newsMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // ==================== 动漫列表 ====================

    @Override
    public List<Anime> getAnimeListByType(String type) {
        return animeMapper.selectByType(type);
    }

    @Override
    public Page<Anime> getAnimeListByTypePage(String type, int page, int size) {
        return getAnimeListByTypePage(type, page, size, null, null, "rating");
    }

    @Override
    public Page<Anime> getAnimeListByTypePage(String type, int page, int size, String tag, String status, String sort) {
        Page<Anime> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Anime> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.hasText(type) && !"全部".equals(type)) {
            wrapper.eq(Anime::getType, type);
        }
        if (StringUtils.hasText(tag)) {
            wrapper.like(Anime::getTags, tag);
        }
        if (StringUtils.hasText(status)) {
            wrapper.eq(Anime::getStatus, status);
        }

        // 排序
        if ("viewCount".equals(sort)) {
            wrapper.orderByDesc(Anime::getViewCount);
        } else if ("releaseDate".equals(sort)) {
            wrapper.orderByDesc(Anime::getReleaseDate);
        } else {
            wrapper.orderByDesc(Anime::getRating).orderByDesc(Anime::getViewCount);
        }

        return animeMapper.selectPage(pageParam, wrapper);
    }

    // ==================== 动漫详情 ====================

    @Override
    public AnimeDetail getAnimeDetailById(Long id) {
        LambdaQueryWrapper<AnimeDetail> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeDetail::getAnimeId, id);
        AnimeDetail detail = animeDetailMapper.selectOne(wrapper);
        
        // 如果anime_detail表没有数据，从anime表获取并创建AnimeDetail对象
        if (detail == null) {
            Anime anime = animeMapper.selectById(id);
            if (anime != null) {
                detail = new AnimeDetail();
                detail.setAnimeId(anime.getId());
                detail.setTitle(anime.getTitle());
                detail.setIntroduction(anime.getDescription());
                detail.setType(anime.getType());
                detail.setCoverImage(anime.getCoverImage());
                detail.setRating(anime.getRating());
                detail.setViewCount(anime.getViewCount());
                detail.setTags(anime.getTags());
                detail.setStatus(anime.getStatus());
                detail.setReleaseDate(anime.getReleaseDate());
                detail.setAuthor(anime.getAuthor()); // 设置作者字段
                detail.setTotalEpisodes(0); // 默认值
                detail.setStudio("未知");
                detail.setDirector("未知");
                detail.setVoiceActors("未知");
                
                // 增加观看量
                anime.setViewCount(anime.getViewCount() + 1);
                animeMapper.updateById(anime);
                detail.setViewCount(anime.getViewCount());
                
                // 尝试保存到anime_detail表
                try {
                    animeDetailMapper.insert(detail);
                } catch (Exception e) {
                    // 忽略插入错误，继续返回数据
                }
            }
        } else {
            // 增加观看量
            Anime anime = animeMapper.selectById(id);
            if (anime != null) {
                anime.setViewCount(anime.getViewCount() + 1);
                animeMapper.updateById(anime);
                detail.setViewCount(anime.getViewCount());
            }
        }
        return detail;
    }

    @Override
    public AnimeDetail getAnimeDetailByTitle(String title) {
        LambdaQueryWrapper<AnimeDetail> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeDetail::getTitle, title);
        AnimeDetail detail = animeDetailMapper.selectOne(wrapper);
        
        // 如果anime_detail表没有数据，从anime表获取
        if (detail == null) {
            LambdaQueryWrapper<Anime> animeWrapper = new LambdaQueryWrapper<>();
            animeWrapper.eq(Anime::getTitle, title);
            Anime anime = animeMapper.selectOne(animeWrapper);
            
            if (anime != null) {
                // 调用getAnimeDetailById来获取或创建详情
                return getAnimeDetailById(anime.getId());
            }
        }
        return detail;
    }

    // ==================== 搜索 ====================

    @Override
    public Page<Anime> searchAnime(String keyword, int page, int size) {
        Page<Anime> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Anime> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(keyword)) {
            wrapper.like(Anime::getTitle, keyword)
                    .or().like(Anime::getTags, keyword)
                    .or().like(Anime::getDescription, keyword);
        }
        wrapper.orderByDesc(Anime::getRating).orderByDesc(Anime::getViewCount);
        return animeMapper.selectPage(pageParam, wrapper);
    }

    // ==================== 排行榜 ====================

    @Override
    public List<Anime> getRankingList(String type, String sortBy, int limit) {
        LambdaQueryWrapper<Anime> wrapper = new LambdaQueryWrapper<>();
        if (StringUtils.hasText(type) && !"全部".equals(type)) {
            wrapper.eq(Anime::getType, type);
        }
        if ("viewCount".equals(sortBy)) {
            wrapper.orderByDesc(Anime::getViewCount);
        } else if ("releaseDate".equals(sortBy)) {
            wrapper.orderByDesc(Anime::getReleaseDate);
        } else {
            wrapper.orderByDesc(Anime::getRating).orderByDesc(Anime::getViewCount);
        }
        wrapper.last("LIMIT " + Math.min(limit, 100));
        return animeMapper.selectList(wrapper);
    }

    // ==================== 评论 ====================

    @Override
    public Page<AnimeComment> getComments(Long animeId, int page, int size) {
        Page<AnimeComment> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<AnimeComment> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeComment::getAnimeId, animeId)
                .eq(AnimeComment::getStatus, 1)
                .isNull(AnimeComment::getParentId)
                .orderByDesc(AnimeComment::getLikes)
                .orderByDesc(AnimeComment::getCreateTime);
        return commentMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public boolean addComment(AnimeComment comment) {
        comment.setStatus(1);
        comment.setLikes(0);
        if (!StringUtils.hasText(comment.getUsername())) {
            comment.setUsername("匿名用户");
        }
        return commentMapper.insert(comment) > 0;
    }

    @Override
    public boolean likeComment(Long commentId) {
        AnimeComment comment = commentMapper.selectById(commentId);
        if (comment == null) return false;
        comment.setLikes(comment.getLikes() + 1);
        return commentMapper.updateById(comment) > 0;
    }

    // ==================== 收藏 ====================

    @Override
    @Transactional
    public Map<String, Object> toggleFavorite(Long animeId, Long userId) {
        Map<String, Object> result = new HashMap<>();
        LambdaQueryWrapper<AnimeFavorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeFavorite::getAnimeId, animeId)
                .eq(AnimeFavorite::getUserId, userId);
        AnimeFavorite existing = favoriteMapper.selectOne(wrapper);

        if (existing != null) {
            // 取消收藏
            favoriteMapper.deleteById(existing.getId());
            // 减少收藏数
            updateFavoriteCount(animeId, -1);
            result.put("favorited", false);
            result.put("message", "已取消收藏");
        } else {
            // 添加收藏
            AnimeFavorite favorite = new AnimeFavorite();
            favorite.setAnimeId(animeId);
            favorite.setUserId(userId);
            favoriteMapper.insert(favorite);
            // 增加收藏数
            updateFavoriteCount(animeId, 1);
            result.put("favorited", true);
            result.put("message", "收藏成功");
        }
        return result;
    }

    private void updateFavoriteCount(Long animeId, int delta) {
        LambdaQueryWrapper<AnimeDetail> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeDetail::getAnimeId, animeId);
        AnimeDetail detail = animeDetailMapper.selectOne(wrapper);
        if (detail != null) {
            detail.setFavoriteCount(Math.max(0, detail.getFavoriteCount() + delta));
            animeDetailMapper.updateById(detail);
        }
    }

    @Override
    public boolean isFavorited(Long animeId, Long userId) {
        if (userId == null) return false;
        LambdaQueryWrapper<AnimeFavorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeFavorite::getAnimeId, animeId)
                .eq(AnimeFavorite::getUserId, userId);
        return favoriteMapper.selectCount(wrapper) > 0;
    }

    @Override
    public List<Anime> getUserFavorites(Long userId) {
        LambdaQueryWrapper<AnimeFavorite> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeFavorite::getUserId, userId)
                .orderByDesc(AnimeFavorite::getCreateTime);
        List<AnimeFavorite> favorites = favoriteMapper.selectList(wrapper);
        if (favorites.isEmpty()) return new ArrayList<>();

        List<Long> animeIds = new ArrayList<>();
        for (AnimeFavorite fav : favorites) {
            animeIds.add(fav.getAnimeId());
        }
        LambdaQueryWrapper<Anime> animeWrapper = new LambdaQueryWrapper<>();
        animeWrapper.in(Anime::getId, animeIds);
        return animeMapper.selectList(animeWrapper);
    }

    // ==================== 新闻资讯 ====================

    @Override
    public Page<AnimeNews> getNewsList(String category, int page, int size) {
        Page<AnimeNews> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<AnimeNews> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AnimeNews::getStatus, 1);
        if (StringUtils.hasText(category) && !"全部".equals(category)) {
            wrapper.eq(AnimeNews::getCategory, category);
        }
        wrapper.orderByDesc(AnimeNews::getPublishTime);
        return newsMapper.selectPage(pageParam, wrapper);
    }

    @Override
    public AnimeNews getNewsDetail(Long id) {
        AnimeNews news = newsMapper.selectById(id);
        if (news != null) {
            news.setViewCount(news.getViewCount() + 1);
            newsMapper.updateById(news);
        }
        return news;
    }

    // ==================== 首页数据 ====================

    @Override
    public Map<String, Object> getHomeData() {
        Map<String, Object> data = new HashMap<>();

        // 轮播图：评分最高的5部
        LambdaQueryWrapper<Anime> bannerWrapper = new LambdaQueryWrapper<>();
        bannerWrapper.orderByDesc(Anime::getRating).last("LIMIT 5");
        data.put("banner", animeMapper.selectList(bannerWrapper));

        // 最新动漫：最近上映的8部
        LambdaQueryWrapper<Anime> latestWrapper = new LambdaQueryWrapper<>();
        latestWrapper.orderByDesc(Anime::getReleaseDate).last("LIMIT 8");
        data.put("latest", animeMapper.selectList(latestWrapper));

        // 热门日本动漫
        LambdaQueryWrapper<Anime> jpWrapper = new LambdaQueryWrapper<>();
        jpWrapper.eq(Anime::getType, "日本").orderByDesc(Anime::getViewCount).last("LIMIT 8");
        data.put("japanese", animeMapper.selectList(jpWrapper));

        // 热门国产动漫
        LambdaQueryWrapper<Anime> cnWrapper = new LambdaQueryWrapper<>();
        cnWrapper.eq(Anime::getType, "国产").orderByDesc(Anime::getViewCount).last("LIMIT 8");
        data.put("chinese", animeMapper.selectList(cnWrapper));

        // 热门欧美动漫
        LambdaQueryWrapper<Anime> usWrapper = new LambdaQueryWrapper<>();
        usWrapper.eq(Anime::getType, "欧美").orderByDesc(Anime::getViewCount).last("LIMIT 6");
        data.put("western", animeMapper.selectList(usWrapper));

        // 最新资讯
        LambdaQueryWrapper<AnimeNews> newsWrapper = new LambdaQueryWrapper<>();
        newsWrapper.eq(AnimeNews::getStatus, 1).orderByDesc(AnimeNews::getPublishTime).last("LIMIT 5");
        data.put("news", newsMapper.selectList(newsWrapper));

        // 综合排行榜 TOP10
        LambdaQueryWrapper<Anime> rankWrapper = new LambdaQueryWrapper<>();
        rankWrapper.orderByDesc(Anime::getRating).orderByDesc(Anime::getViewCount).last("LIMIT 10");
        data.put("ranking", animeMapper.selectList(rankWrapper));

        return data;
    }

    // ==================== 用户注册 ====================

    @Override
    @Transactional
    public Map<String, Object> registerUser(String username, String password, String email) {
        Map<String, Object> result = new HashMap<>();

        if (userRepository.existsByUsername(username)) {
            result.put("success", false);
            result.put("message", "用户名已存在");
            return result;
        }
        if (org.springframework.util.StringUtils.hasText(email) && userRepository.existsByEmail(email)) {
            result.put("success", false);
            result.put("message", "邮箱已被注册");
            return result;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setEmail(email);
        user.setEnabled(true);

        com.web.animation.entity.Role userRole = roleRepository.findByName("ROLE_USER").orElse(null);
        if (userRole != null) {
            user.setRoles(new HashSet<>(Collections.singletonList(userRole)));
        }

        userRepository.save(user);

        result.put("success", true);
        result.put("message", "注册成功，请登录");
        return result;
    }
}
