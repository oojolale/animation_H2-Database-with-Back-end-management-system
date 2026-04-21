package com.web.animation.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.web.animation.entity.Anime;
import com.web.animation.entity.AnimeComment;
import com.web.animation.entity.AnimeDetail;
import com.web.animation.entity.AnimeNews;

import java.util.List;
import java.util.Map;

public interface AnimeService {

    // ==================== 动漫列表 ====================

    /** 根据类型查询动漫列表 */
    List<Anime> getAnimeListByType(String type);

    /** 根据类型分页查询动漫列表，支持标签和状态筛选 */
    Page<Anime> getAnimeListByTypePage(String type, int page, int size, String tag, String status, String sort);

    /** 兼容旧接口：根据类型分页查询 */
    Page<Anime> getAnimeListByTypePage(String type, int page, int size);

    // ==================== 动漫详情 ====================

    /** 根据动漫表ID查询详情 */
    AnimeDetail getAnimeDetailById(Long id);

    /** 根据名称查询详情 */
    AnimeDetail getAnimeDetailByTitle(String title);

    // ==================== 搜索 ====================

    /** 关键词搜索动漫（标题模糊匹配） */
    Page<Anime> searchAnime(String keyword, int page, int size);

    // ==================== 排行榜 ====================

    /** 排行榜：按评分/观看量/收藏量排序 */
    List<Anime> getRankingList(String type, String sortBy, int limit);

    // ==================== 评论 ====================

    /** 分页获取动漫评论 */
    Page<AnimeComment> getComments(Long animeId, int page, int size);

    /** 发表评论 */
    boolean addComment(AnimeComment comment);

    /** 评论点赞 */
    boolean likeComment(Long commentId);

    // ==================== 收藏 ====================

    /** 收藏/取消收藏 */
    Map<String, Object> toggleFavorite(Long animeId, Long userId);

    /** 查询是否已收藏 */
    boolean isFavorited(Long animeId, Long userId);

    /** 获取用户收藏列表 */
    List<Anime> getUserFavorites(Long userId);

    // ==================== 新闻资讯 ====================

    /** 分页获取新闻列表 */
    Page<AnimeNews> getNewsList(String category, int page, int size);

    /** 获取新闻详情并增加浏览量 */
    AnimeNews getNewsDetail(Long id);

    // ==================== 首页数据 ====================

    /** 获取首页聚合数据（轮播/最新/热门等） */
    Map<String, Object> getHomeData();

    // ==================== 用户注册 ====================

    /** 注册新用户，返回结果消息 */
    Map<String, Object> registerUser(String username, String password, String email);
}
