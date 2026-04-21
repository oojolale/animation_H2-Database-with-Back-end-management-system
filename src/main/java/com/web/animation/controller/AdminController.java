package com.web.animation.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.web.animation.entity.*;
import com.web.animation.mapper.*;
import com.web.animation.dto.AnimeSaveRequest;
import com.web.animation.service.HomeConfigService;
import com.web.animation.util.AjaxResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 后台管理系统控制器
 */
@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController {

    @Autowired
    private HomeConfigService homeConfigService;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private AnimeDetailMapper animeDetailMapper;

    @Autowired
    private AnimeNewsMapper newsMapper;

    @Autowired
    private UserMapper userMapper;

    // ==================== 后台首页 ====================

    @GetMapping("/index")
    public String adminIndex(Model model) {
        Map<String, Object> stats = homeConfigService.getStats();
        model.addAllAttributes(stats);
        return "admin/index";
    }

    // ==================== 动漫管理 ====================

    @GetMapping("/anime")
    public String animeManage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String type,
            Model model) {
        
        Page<Anime> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Anime> wrapper = new LambdaQueryWrapper<>();
        
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(Anime::getTitle, keyword);
        }
        if (type != null && !type.isEmpty()) {
            wrapper.eq(Anime::getType, type);
        }
        
        wrapper.orderByDesc(Anime::getId);
        Page<Anime> result = animeMapper.selectPage(pageParam, wrapper);
        
        model.addAttribute("animeList", result.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getPages());
        model.addAttribute("total", result.getTotal());
        model.addAttribute("keyword", keyword);
        model.addAttribute("type", type);
        
        return "admin/anime/list";
    }

    @GetMapping("/anime/add")
    public String animeAdd(Model model) {
        return "admin/anime/add";
    }

    @GetMapping("/anime/edit/{id}")
    public String animeEdit(@PathVariable Long id, Model model) {
        Anime anime = animeMapper.selectById(id);
        AnimeDetail detail = null;
        if (anime != null) {
            LambdaQueryWrapper<AnimeDetail> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(AnimeDetail::getAnimeId, id);
            detail = animeDetailMapper.selectOne(wrapper);
        }
        model.addAttribute("anime", anime);
        model.addAttribute("detail", detail);
        return "admin/anime/edit";
    }

    @PostMapping("/anime/save")
    @ResponseBody
    public AjaxResult saveAnime(@RequestBody AnimeSaveRequest request) {
        try {
            Anime anime = new Anime();
            anime.setId(request.getId());
            anime.setTitle(request.getTitle());
            anime.setType(request.getType());
            anime.setStatus(request.getStatus());
            anime.setRating(request.getRating() != null ? request.getRating() : 0.0);
            anime.setViewCount(request.getViewCount() != null ? request.getViewCount() : 0);
            anime.setCoverImage(request.getCoverImage());
            anime.setTags(request.getTags());
            anime.setDescription(request.getDescription());
            anime.setAuthor(request.getAuthor());
            if (request.getReleaseDate() != null && !request.getReleaseDate().isEmpty()) {
                anime.setReleaseDate(LocalDate.parse(request.getReleaseDate()));
            }
            
            if (anime.getId() == null) {
                animeMapper.insert(anime);
            } else {
                animeMapper.updateById(anime);
            }
            
            // 处理详情
            if (request.getIntroduction() != null || request.getTotalEpisodes() != null) {
                AnimeDetail detail = new AnimeDetail();
                detail.setAnimeId(anime.getId());
                detail.setTitle(request.getTitle());
                detail.setType(request.getType());
                detail.setCoverImage(request.getCoverImage());
                detail.setTags(request.getTags());
                detail.setStatus(request.getStatus());
                detail.setRating(anime.getRating());
                detail.setViewCount(anime.getViewCount());
                detail.setAuthor(request.getAuthor());
                detail.setIntroduction(request.getIntroduction());
                if (request.getTotalEpisodes() != null && !request.getTotalEpisodes().isEmpty()) {
                    detail.setTotalEpisodes(Integer.parseInt(request.getTotalEpisodes()));
                }
                detail.setStudio(request.getStudio());
                detail.setDirector(request.getDirector());
                detail.setVoiceActors(request.getVoiceActors());

                LambdaQueryWrapper<AnimeDetail> wrapper = new LambdaQueryWrapper<>();
                wrapper.eq(AnimeDetail::getAnimeId, anime.getId());
                AnimeDetail existing = animeDetailMapper.selectOne(wrapper);
                if (existing != null) {
                    detail.setId(existing.getId());
                    animeDetailMapper.updateById(detail);
                } else {
                    animeDetailMapper.insert(detail);
                }
            }
            
            return AjaxResult.success("保存成功");
        } catch (Exception e) {
            e.printStackTrace();
            return AjaxResult.error("保存失败: " + e.getMessage());
        }
    }

    @PostMapping("/anime/delete/{id}")
    @ResponseBody
    public AjaxResult deleteAnime(@PathVariable Long id) {
        try {
            animeMapper.deleteById(id);
            LambdaQueryWrapper<AnimeDetail> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(AnimeDetail::getAnimeId, id);
            animeDetailMapper.delete(wrapper);
            return AjaxResult.success("删除成功");
        } catch (Exception e) {
            return AjaxResult.error("删除失败: " + e.getMessage());
        }
    }

    // ==================== 资讯管理 ====================

    @GetMapping("/news")
    public String newsManage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String category,
            Model model) {
        
        Page<AnimeNews> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<AnimeNews> wrapper = new LambdaQueryWrapper<>();
        
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(AnimeNews::getTitle, keyword);
        }
        if (category != null && !category.isEmpty()) {
            wrapper.eq(AnimeNews::getCategory, category);
        }
        
        wrapper.orderByDesc(AnimeNews::getId);
        Page<AnimeNews> result = newsMapper.selectPage(pageParam, wrapper);
        
        model.addAttribute("newsList", result.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getPages());
        model.addAttribute("total", result.getTotal());
        model.addAttribute("keyword", keyword);
        model.addAttribute("category", category);
        
        return "admin/news/list";
    }

    @GetMapping("/news/add")
    public String newsAdd(Model model) {
        return "admin/news/add";
    }

    @GetMapping("/news/edit/{id}")
    public String newsEdit(@PathVariable Long id, Model model) {
        AnimeNews news = newsMapper.selectById(id);
        model.addAttribute("news", news);
        return "admin/news/edit";
    }

    @PostMapping("/news/save")
    @ResponseBody
    public AjaxResult saveNews(AnimeNews news) {
        try {
            if (news.getId() == null) {
                news.setCreateTime(LocalDateTime.now());
                news.setPublishTime(LocalDateTime.now());
                news.setViewCount(0);
                if (news.getStatus() == null) {
                    news.setStatus(1);
                }
                newsMapper.insert(news);
            } else {
                newsMapper.updateById(news);
            }
            return AjaxResult.success("保存成功");
        } catch (Exception e) {
            return AjaxResult.error("保存失败: " + e.getMessage());
        }
    }

    @PostMapping("/news/delete/{id}")
    @ResponseBody
    public AjaxResult deleteNews(@PathVariable Long id) {
        try {
            newsMapper.deleteById(id);
            return AjaxResult.success("删除成功");
        } catch (Exception e) {
            return AjaxResult.error("删除失败: " + e.getMessage());
        }
    }

    // ==================== 分类管理 ====================

    @GetMapping("/category")
    public String categoryManage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String type,
            Model model) {
        
        Page<Category> result = homeConfigService.getCategoryList(type, page, size);
        
        model.addAttribute("categoryList", result.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getPages());
        model.addAttribute("total", result.getTotal());
        model.addAttribute("type", type);
        
        return "admin/category/list";
    }

    @GetMapping("/category/add")
    public String categoryAdd(Model model) {
        return "admin/category/add";
    }

    @GetMapping("/category/edit/{id}")
    public String categoryEdit(@PathVariable Long id, Model model) {
        LambdaQueryWrapper<Category> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Category::getId, id);
        Category category = homeConfigService.getCategoryList(null, 1, 1).getRecords().stream()
            .filter(c -> c.getId().equals(id)).findFirst().orElse(null);
        // 简化获取方式
        List<Category> all = homeConfigService.getCategoryList(null, 1, 100).getRecords();
        for (Category c : all) {
            if (c.getId().equals(id)) {
                category = c;
                break;
            }
        }
        model.addAttribute("category", category);
        return "admin/category/edit";
    }

    @PostMapping("/category/save")
    @ResponseBody
    public AjaxResult saveCategory(Category category) {
        try {
            boolean result = homeConfigService.saveCategory(category);
            return result ? AjaxResult.success("保存成功") : AjaxResult.error("保存失败");
        } catch (Exception e) {
            return AjaxResult.error("保存失败: " + e.getMessage());
        }
    }

    @PostMapping("/category/delete/{id}")
    @ResponseBody
    public AjaxResult deleteCategory(@PathVariable Long id) {
        try {
            boolean result = homeConfigService.deleteCategory(id);
            return result ? AjaxResult.success("删除成功") : AjaxResult.error("删除失败");
        } catch (Exception e) {
            return AjaxResult.error("删除失败: " + e.getMessage());
        }
    }

    // ==================== 轮播图管理 ====================

    @GetMapping("/banner")
    public String bannerManage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String location,
            Model model) {
        
        Page<Banner> result = homeConfigService.getBannerList(location, page, size);
        
        model.addAttribute("bannerList", result.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getPages());
        model.addAttribute("total", result.getTotal());
        model.addAttribute("location", location);
        
        return "admin/banner/list";
    }

    @GetMapping("/banner/add")
    public String bannerAdd(Model model) {
        return "admin/banner/add";
    }

    @GetMapping("/banner/edit/{id}")
    public String bannerEdit(@PathVariable Long id, Model model) {
        Banner banner = homeConfigService.getBannerList(null, 1, 100).getRecords().stream()
            .filter(b -> b.getId().equals(id)).findFirst().orElse(null);
        model.addAttribute("banner", banner);
        return "admin/banner/edit";
    }

    @PostMapping("/banner/save")
    @ResponseBody
    public AjaxResult saveBanner(Banner banner) {
        try {
            boolean result = homeConfigService.saveBanner(banner);
            return result ? AjaxResult.success("保存成功") : AjaxResult.error("保存失败");
        } catch (Exception e) {
            return AjaxResult.error("保存失败: " + e.getMessage());
        }
    }

    @PostMapping("/banner/delete/{id}")
    @ResponseBody
    public AjaxResult deleteBanner(@PathVariable Long id) {
        try {
            boolean result = homeConfigService.deleteBanner(id);
            return result ? AjaxResult.success("删除成功") : AjaxResult.error("删除失败");
        } catch (Exception e) {
            return AjaxResult.error("删除失败: " + e.getMessage());
        }
    }

    // ==================== 首页配置 ====================

    @GetMapping("/home/config")
    public String homeConfig(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String type,
            Model model) {
        
        Page<HomeConfig> result = homeConfigService.getHomeConfigList(type, page, size);
        
        model.addAttribute("configList", result.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getPages());
        model.addAttribute("total", result.getTotal());
        model.addAttribute("type", type);
        
        return "admin/home/config";
    }

    @GetMapping("/home/config/add")
    public String homeConfigAdd(Model model) {
        return "admin/home/config-add";
    }

    @PostMapping("/home/config/save")
    @ResponseBody
    public AjaxResult saveHomeConfig(HomeConfig config) {
        try {
            boolean result = homeConfigService.saveHomeConfig(config);
            return result ? AjaxResult.success("保存成功") : AjaxResult.error("保存失败");
        } catch (Exception e) {
            return AjaxResult.error("保存失败: " + e.getMessage());
        }
    }

    @PostMapping("/home/config/delete/{id}")
    @ResponseBody
    public AjaxResult deleteHomeConfig(@PathVariable Long id) {
        try {
            boolean result = homeConfigService.deleteHomeConfig(id);
            return result ? AjaxResult.success("删除成功") : AjaxResult.error("删除失败");
        } catch (Exception e) {
            return AjaxResult.error("删除失败: " + e.getMessage());
        }
    }

    // ==================== 用户管理 ====================

    @GetMapping("/user")
    public String userManage(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(required = false) String keyword,
            Model model) {
        
        Page<User> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<User> wrapper = new LambdaQueryWrapper<>();
        if (keyword != null && !keyword.isEmpty()) {
            wrapper.like(User::getUsername, keyword).or()
                   .like(User::getEmail, keyword);
        }
        wrapper.orderByDesc(User::getId);
        Page<User> result = userMapper.selectPage(pageParam, wrapper);
        
        model.addAttribute("userList", result.getRecords());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", result.getPages());
        model.addAttribute("total", result.getTotal());
        model.addAttribute("keyword", keyword);
        
        return "admin/user/list";
    }

    // ==================== 数据统计 ====================

    @GetMapping("/stats")
    @ResponseBody
    public AjaxResult getStats() {
        return AjaxResult.success(homeConfigService.getStats());
    }
}
