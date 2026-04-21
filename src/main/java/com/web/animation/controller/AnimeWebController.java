package com.web.animation.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.web.animation.entity.*;
import com.web.animation.mapper.*;
import com.web.animation.service.AnimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 动漫网站前端页面控制器
 * 处理所有动漫网站页面的数据绑定
 */
@Controller
public class AnimeWebController {

    @Autowired
    private AnimeService animeService;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private AnimeDetailMapper animeDetailMapper;

    @Autowired
    private AnimeNewsMapper newsMapper;

    @Autowired
    private AnimeCommentMapper commentMapper;

    @Autowired
    private AnimeFavoriteMapper favoriteMapper;

    // ==================== 首页 ====================

    @GetMapping("/aaa")
    public String index(Model model) {
        // 获取首页聚合数据
        Map<String, Object> homeData = animeService.getHomeData();
        model.addAllAttributes(homeData);
        return "animation/index";
    }

    // ==================== 动漫分类页面 ====================

    /**
     * 日漫列表页面
     */
    @GetMapping("/anime/japanese")
    public String japanese(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String tag,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "rating") String sort,
            Model model) {
        
        Page<Anime> animePage = animeService.getAnimeListByTypePage("日本", page, size, tag, status, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "日本");
        model.addAttribute("selectedTag", tag);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSort", sort);
        
        return "animation/japanese";
    }

    /**
     * 国漫列表页面
     */
    @GetMapping("/anime/chinese")
    public String chinese(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String tag,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "rating") String sort,
            Model model) {
        
        Page<Anime> animePage = animeService.getAnimeListByTypePage("国产", page, size, tag, status, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "国产");
        model.addAttribute("selectedTag", tag);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSort", sort);
        
        return "animation/chinese";
    }

    /**
     * 欧美动漫列表页面
     */
    @GetMapping("/anime/western")
    public String western(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String tag,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "rating") String sort,
            Model model) {
        
        Page<Anime> animePage = animeService.getAnimeListByTypePage("欧美", page, size, tag, status, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "欧美");
        model.addAttribute("selectedTag", tag);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSort", sort);
        
        return "animation/western";
    }

    /**
     * 剧场版/电影列表页面
     */
    @GetMapping("/anime/movies")
    public String movies(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String tag,
            @RequestParam(defaultValue = "rating") String sort,
            Model model) {
        
        // 电影类型筛选
        Page<Anime> animePage = animeService.getAnimeListByTypePage("电影", page, size, tag, null, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "电影");
        model.addAttribute("selectedTag", tag);
        model.addAttribute("selectedSort", sort);
        
        return "animation/movies";
    }

    /**
     * TV动画列表页面
     */
    @GetMapping("/anime/tv")
    public String tv(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String tag,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "rating") String sort,
            Model model) {
        
        Page<Anime> animePage = animeService.getAnimeListByTypePage("TV", page, size, tag, status, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "TV");
        model.addAttribute("selectedTag", tag);
        model.addAttribute("selectedStatus", status);
        model.addAttribute("selectedSort", sort);
        
        return "animation/tv";
    }

    /**
     * 综艺列表页面
     */
    @GetMapping("/anime/variety")
    public String variety(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String sort,
            Model model) {
        
        Page<Anime> animePage = animeService.getAnimeListByTypePage("综艺", page, size, null, null, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "综艺");
        model.addAttribute("selectedSort", sort);
        
        return "animation/variety";
    }

    /**
     * 纪录片列表页面
     */
    @GetMapping("/anime/documentary")
    public String documentary(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            @RequestParam(required = false) String sort,
            Model model) {
        
        Page<Anime> animePage = animeService.getAnimeListByTypePage("纪录片", page, size, null, null, sort);
        
        model.addAttribute("animeList", animePage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", animePage.getPages());
        model.addAttribute("total", animePage.getTotal());
        model.addAttribute("type", "纪录片");
        model.addAttribute("selectedSort", sort);
        
        return "animation/documentary";
    }

    // ==================== 动漫详情页 ====================

    @GetMapping("/anime/detail")
    public String detail(@RequestParam Long id, Model model) {
        AnimeDetail detail = animeService.getAnimeDetailById(id);
        if (detail != null) {
            model.addAttribute("anime", detail);
            
            // 获取评论
            Page<AnimeComment> comments = animeService.getComments(id, 1, 20);
            model.addAttribute("comments", comments.getRecords());
            model.addAttribute("commentCount", comments.getTotal());
            
            // 获取相关推荐（同类型）
            List<Anime> related = animeService.getRankingList(detail.getType(), "rating", 6);
            model.addAttribute("relatedAnime", related);
            
            // 检查用户是否收藏
            Long userId = getCurrentUserId();
            if (userId != null) {
                model.addAttribute("isFavorited", animeService.isFavorited(id, userId));
            }
        }
        return "animation/detail";
    }

    @GetMapping("/anime/player")
    public String player(@RequestParam Long id, @RequestParam(required = false) Integer episode, Model model) {
        AnimeDetail detail = animeService.getAnimeDetailById(id);
        if (detail != null) {
            model.addAttribute("anime", detail);
            model.addAttribute("currentEpisode", episode != null ? episode : 1);
        }
        return "animation/player";
    }

    // ==================== 排行榜页面 ====================

    @GetMapping("/anime/rankings")
    public String rankings(
            @RequestParam(required = false) String type,
            @RequestParam(defaultValue = "rating") String sortBy,
            @RequestParam(defaultValue = "20") int limit,
            Model model) {
        
        List<Anime> rankingList = animeService.getRankingList(type, sortBy, limit);
        
        model.addAttribute("rankingList", rankingList);
        model.addAttribute("selectedType", type);
        model.addAttribute("selectedSort", sortBy);
        
        // 获取各类别的TOP3
        model.addAttribute("japaneseTop", animeService.getRankingList("日本", "rating", 3));
        model.addAttribute("chineseTop", animeService.getRankingList("国产", "rating", 3));
        model.addAttribute("westernTop", animeService.getRankingList("欧美", "rating", 3));
        
        return "animation/rankings";
    }

    // ==================== 资讯页面 ====================

    @GetMapping("/anime/news")
    public String news(
            @RequestParam(required = false) String category,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            Model model) {
        
        Page<AnimeNews> newsPage = animeService.getNewsList(category, page, size);
        
        model.addAttribute("newsList", newsPage.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", newsPage.getPages());
        model.addAttribute("total", newsPage.getTotal());
        model.addAttribute("selectedCategory", category);
        
        // 获取热门资讯
        LambdaQueryWrapper<AnimeNews> hotWrapper = new LambdaQueryWrapper<>();
        hotWrapper.eq(AnimeNews::getStatus, 1)
                .orderByDesc(AnimeNews::getViewCount)
                .last("LIMIT 5");
        model.addAttribute("hotNews", newsMapper.selectList(hotWrapper));
        
        return "animation/news";
    }

    /**
     * 资讯详情页
     */
    @GetMapping("/anime/news/detail")
    public String newsDetail(@RequestParam Long id, Model model) {
        AnimeNews news = animeService.getNewsDetail(id);
        if (news != null) {
            model.addAttribute("news", news);
            
            // 获取相关资讯
            LambdaQueryWrapper<AnimeNews> relatedWrapper = new LambdaQueryWrapper<>();
            relatedWrapper.eq(AnimeNews::getStatus, 1)
                    .eq(AnimeNews::getCategory, news.getCategory())
                    .ne(AnimeNews::getId, id)
                    .orderByDesc(AnimeNews::getPublishTime)
                    .last("LIMIT 5");
            model.addAttribute("relatedNews", newsMapper.selectList(relatedWrapper));
        }
        return "animation/news-detail";
    }

    // ==================== 搜索页面 ====================

    @GetMapping("/anime/search")
    public String search(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "24") int size,
            Model model) {
        
        Page<Anime> searchResult = animeService.searchAnime(keyword, page, size);
        
        model.addAttribute("keyword", keyword);
        model.addAttribute("animeList", searchResult.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", searchResult.getPages());
        model.addAttribute("total", searchResult.getTotal());
        
        return "animation/search";
    }

    // ==================== 用户收藏页面 ====================

    @GetMapping("/anime/favorites")
    public String favorites(Model model) {
        Long userId = getCurrentUserId();
        if (userId != null) {
            List<Anime> favorites = animeService.getUserFavorites(userId);
            model.addAttribute("favorites", favorites);
        }
        return "animation/favorites";
    }

    // ==================== 注册页面 ====================

    @GetMapping("/anime/register")
    public String register() {
        return "animation/register";
    }

    // ==================== 辅助方法 ====================

    /**
     * 获取当前登录用户ID
     */
    private Long getCurrentUserId() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            // 这里可以通过用户名查询用户ID
            // 简化处理，实际项目中应从UserDetails中获取
            return null;
        }
        return null;
    }

    /**
     * 获取当前登录用户名
     */
    protected String getCurrentUsername() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.isAuthenticated() && !"anonymousUser".equals(auth.getPrincipal())) {
            return auth.getName();
        }
        return null;
    }

    // ==================== 分类标签数据 ====================

    @ModelAttribute("animeTypes")
    public Map<String, String> animeTypes() {
        Map<String, String> types = new HashMap<>();
        types.put("日本", "日漫");
        types.put("国产", "国漫");
        types.put("欧美", "欧美");
        types.put("电影", "剧场版");
        types.put("TV", "TV动画");
        types.put("综艺", "综艺");
        types.put("纪录片", "纪录片");
        return types;
    }

    @ModelAttribute("animeTags")
    public Map<String, List<String>> animeTags() {
        Map<String, List<String>> tags = new HashMap<>();
        tags.put("热血", List.of("热血", "冒险", "战斗", "奇幻", "悬疑", "推理", "搞笑", "治愈", "校园", "恋爱", "科幻", "后宫", "机战", "运动", "音乐"));
        return tags;
    }

    @ModelAttribute("animeStatuses")
    public Map<String, String> animeStatuses() {
        Map<String, String> statuses = new HashMap<>();
        statuses.put("连载中", "连载中");
        statuses.put("已完结", "已完结");
        return statuses;
    }
}
