package com.web.animation.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.web.animation.entity.Anime;
import com.web.animation.entity.AnimeComment;
import com.web.animation.entity.AnimeDetail;
import com.web.animation.entity.AnimeNews;
import com.web.animation.service.AnimeService;
import com.web.animation.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/anime")
public class AnimeController {

    @Autowired
    private AnimeService animeService;

    // ==================== 动漫列表 ====================

    /**
     * 根据类型获取动漫列表（全量，不分页）
     */
    @GetMapping("/list")
    public AjaxResult getAnimeList(@RequestParam(required = false) String type) {
        if (type == null) type = "全部";
        List<Anime> animeList = animeService.getAnimeListByType(type);
        return AjaxResult.success(animeList);
    }

    /**
     * 根据类型分页获取动漫列表，支持标签/状态/排序筛选
     */
    @GetMapping("/list/page")
    public AjaxResult getAnimeListPage(
            @RequestParam(required = false, defaultValue = "全部") String type,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size,
            @RequestParam(required = false) String tag,
            @RequestParam(required = false) String status,
            @RequestParam(required = false, defaultValue = "rating") String sort) {
        Page<Anime> pageResult = animeService.getAnimeListByTypePage(type, page, size, tag, status, sort);
        return AjaxResult.success(pageResult);
    }

    // ==================== 动漫详情 ====================

    /**
     * 根据动漫ID获取详情（同时增加观看量）
     */
    @GetMapping("/detail/{id}")
    public AjaxResult getAnimeDetail(@PathVariable Long id) {
        AnimeDetail detail = animeService.getAnimeDetailById(id);
        if (detail == null) {
            return AjaxResult.error("动漫详情不存在");
        }
        return AjaxResult.success(detail);
    }

    /**
     * 根据名称获取动漫详情
     */
    @GetMapping("/detail")
    public AjaxResult getAnimeDetailByTitle(@RequestParam String title) {
        AnimeDetail detail = animeService.getAnimeDetailByTitle(title);
        if (detail == null) {
            return AjaxResult.error("动漫详情不存在");
        }
        return AjaxResult.success(detail);
    }

    // ==================== 搜索 ====================

    /**
     * 关键词搜索动漫
     */
    @GetMapping("/search")
    public AjaxResult searchAnime(
            @RequestParam String keyword,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "12") int size) {
        Page<Anime> result = animeService.searchAnime(keyword, page, size);
        return AjaxResult.success(result);
    }

    // ==================== 排行榜 ====================

    /**
     * 获取排行榜
     * @param type  动漫类型(全部/日本/国产/欧美)
     * @param sortBy 排序(rating/viewCount/releaseDate)
     * @param limit  条数(默认20)
     */
    @GetMapping("/ranking")
    public AjaxResult getRanking(
            @RequestParam(defaultValue = "全部") String type,
            @RequestParam(defaultValue = "rating") String sortBy,
            @RequestParam(defaultValue = "20") int limit) {
        List<Anime> list = animeService.getRankingList(type, sortBy, limit);
        return AjaxResult.success(list);
    }

    // ==================== 评论 ====================

    /**
     * 获取动漫评论列表
     */
    @GetMapping("/{id}/comments")
    public AjaxResult getComments(
            @PathVariable Long id,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<AnimeComment> result = animeService.getComments(id, page, size);
        return AjaxResult.success(result);
    }

    /**
     * 发表评论
     */
    @PostMapping("/{id}/comments")
    public AjaxResult addComment(@PathVariable Long id, @RequestBody AnimeComment comment) {
        comment.setAnimeId(id);
        boolean success = animeService.addComment(comment);
        return success ? AjaxResult.success("评论成功") : AjaxResult.error("评论失败");
    }

    /**
     * 评论点赞
     */
    @PostMapping("/comments/{commentId}/like")
    public AjaxResult likeComment(@PathVariable Long commentId) {
        boolean success = animeService.likeComment(commentId);
        return success ? AjaxResult.success("点赞成功") : AjaxResult.error("操作失败");
    }

    // ==================== 收藏 ====================

    /**
     * 收藏/取消收藏（需要userId参数，实际项目应从Session/Token获取）
     */
    @PostMapping("/{id}/favorite")
    public AjaxResult toggleFavorite(@PathVariable Long id, @RequestParam Long userId) {
        Map<String, Object> result = animeService.toggleFavorite(id, userId);
        return AjaxResult.success(result);
    }

    /**
     * 查询是否已收藏
     */
    @GetMapping("/{id}/favorite/status")
    public AjaxResult getFavoriteStatus(@PathVariable Long id, @RequestParam(required = false) Long userId) {
        boolean favorited = animeService.isFavorited(id, userId);
        return AjaxResult.success(favorited);
    }

    /**
     * 获取用户收藏列表
     */
    @GetMapping("/favorites")
    public AjaxResult getUserFavorites(@RequestParam Long userId) {
        List<Anime> list = animeService.getUserFavorites(userId);
        return AjaxResult.success(list);
    }

    // ==================== 新闻资讯 ====================

    /**
     * 获取资讯新闻列表
     */
    @GetMapping("/news")
    public AjaxResult getNewsList(
            @RequestParam(required = false, defaultValue = "全部") String category,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size) {
        Page<AnimeNews> result = animeService.getNewsList(category, page, size);
        return AjaxResult.success(result);
    }

    /**
     * 获取新闻详情
     */
    @GetMapping("/news/{id}")
    public AjaxResult getNewsDetail(@PathVariable Long id) {
        AnimeNews news = animeService.getNewsDetail(id);
        if (news == null) {
            return AjaxResult.error("新闻不存在");
        }
        return AjaxResult.success(news);
    }

    // ==================== 首页聚合数据 ====================

    /**
     * 首页聚合数据
     */
    @GetMapping("/home")
    public AjaxResult getHomeData() {
        Map<String, Object> data = animeService.getHomeData();
        return AjaxResult.success(data);
    }

    // ==================== 用户注册 ====================

    /**
     * 用户注册
     */
    @PostMapping("/register")
    public AjaxResult register(@RequestBody Map<String, String> body) {
        String username = body.get("username");
        String password = body.get("password");
        String email = body.get("email");
        if (username == null || password == null || username.isBlank() || password.isBlank()) {
            return AjaxResult.error("用户名和密码不能为空");
        }
        if (password.length() < 6) {
            return AjaxResult.error("密码长度不能少于6位");
        }
        Map<String, Object> result = animeService.registerUser(username, password, email);
        boolean success = Boolean.TRUE.equals(result.get("success"));
        return success ? AjaxResult.success(result.get("message")) : AjaxResult.error((String) result.get("message"));
    }
}
