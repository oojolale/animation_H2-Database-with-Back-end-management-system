package com.web.animation.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.web.animation.entity.*;
import com.web.animation.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class HomeConfigService {

    @Autowired
    private HomeConfigMapper homeConfigMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private BannerMapper bannerMapper;

    @Autowired
    private AnimeMapper animeMapper;

    @Autowired
    private AnimeNewsMapper newsMapper;

    // ==================== 首页配置 ====================

    public Page<HomeConfig> getHomeConfigList(String type, int page, int size) {
        Page<HomeConfig> pageParam = new Page<>(page, size);
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<HomeConfig> wrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        if (type != null && !type.isEmpty()) {
            wrapper.eq(HomeConfig::getType, type);
        }
        wrapper.orderByAsc(HomeConfig::getSortOrder);
        return homeConfigMapper.selectPage(pageParam, wrapper);
    }

    @Transactional
    public boolean saveHomeConfig(HomeConfig config) {
        if (config.getId() == null) {
            config.setCreateTime(LocalDateTime.now());
            config.setUpdateTime(LocalDateTime.now());
            return homeConfigMapper.insert(config) > 0;
        } else {
            config.setUpdateTime(LocalDateTime.now());
            return homeConfigMapper.updateById(config) > 0;
        }
    }

    @Transactional
    public boolean deleteHomeConfig(Long id) {
        return homeConfigMapper.deleteById(id) > 0;
    }

    // ==================== 分类管理 ====================

    public Page<Category> getCategoryList(String type, int page, int size) {
        Page<Category> pageParam = new Page<>(page, size);
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Category> wrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        if (type != null && !type.isEmpty()) {
            wrapper.eq(Category::getType, type);
        }
        wrapper.orderByAsc(Category::getSortOrder);
        return categoryMapper.selectPage(pageParam, wrapper);
    }

    public List<Category> getAllCategories(String type) {
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Category> wrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        wrapper.eq(Category::getStatus, 1);
        if (type != null && !type.isEmpty()) {
            wrapper.eq(Category::getType, type);
        }
        wrapper.orderByAsc(Category::getSortOrder);
        return categoryMapper.selectList(wrapper);
    }

    @Transactional
    public boolean saveCategory(Category category) {
        if (category.getId() == null) {
            category.setCreateTime(LocalDateTime.now());
            category.setUpdateTime(LocalDateTime.now());
            return categoryMapper.insert(category) > 0;
        } else {
            category.setUpdateTime(LocalDateTime.now());
            return categoryMapper.updateById(category) > 0;
        }
    }

    @Transactional
    public boolean deleteCategory(Long id) {
        return categoryMapper.deleteById(id) > 0;
    }

    // ==================== 轮播图管理 ====================

    public Page<Banner> getBannerList(String location, int page, int size) {
        Page<Banner> pageParam = new Page<>(page, size);
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Banner> wrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        if (location != null && !location.isEmpty()) {
            wrapper.eq(Banner::getLocation, location);
        }
        wrapper.orderByAsc(Banner::getSortOrder);
        return bannerMapper.selectPage(pageParam, wrapper);
    }

    public List<Banner> getActiveBanners(String location) {
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Banner> wrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        wrapper.eq(Banner::getStatus, 1);
        if (location != null && !location.isEmpty()) {
            wrapper.eq(Banner::getLocation, location);
        }
        wrapper.orderByAsc(Banner::getSortOrder);
        return bannerMapper.selectList(wrapper);
    }

    @Transactional
    public boolean saveBanner(Banner banner) {
        if (banner.getId() == null) {
            banner.setCreateTime(LocalDateTime.now());
            banner.setUpdateTime(LocalDateTime.now());
            return bannerMapper.insert(banner) > 0;
        } else {
            banner.setUpdateTime(LocalDateTime.now());
            return bannerMapper.updateById(banner) > 0;
        }
    }

    @Transactional
    public boolean deleteBanner(Long id) {
        return bannerMapper.deleteById(id) > 0;
    }

    // ==================== 统计数据 ====================

    public Map<String, Object> getStats() {
        Map<String, Object> stats = new HashMap<>();
        
        // 动漫总数
        stats.put("animeCount", animeMapper.selectCount(null));
        
        // 资讯总数
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<AnimeNews> newsWrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        newsWrapper.eq(AnimeNews::getStatus, 1);
        stats.put("newsCount", newsMapper.selectCount(newsWrapper));
        
        // 轮播图数量
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Banner> bannerWrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        bannerWrapper.eq(Banner::getStatus, 1);
        stats.put("bannerCount", bannerMapper.selectCount(bannerWrapper));
        
        // 分类数量
        com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Category> catWrapper = 
            new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<>();
        catWrapper.eq(Category::getStatus, 1);
        stats.put("categoryCount", categoryMapper.selectCount(catWrapper));
        
        return stats;
    }
}
