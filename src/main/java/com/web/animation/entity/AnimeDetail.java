package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;

@Data
@TableName("anime_detail")
public class AnimeDetail {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 关联的动漫ID
     */
    private Long animeId;

    /**
     * 动漫名称
     */
    private String title;

    /**
     * 动漫介绍
     */
    private String introduction;

    /**
     * 作者/原作
     */
    private String author;

    /**
     * 动漫类型(日本/国产/欧美)
     */
    private String type;

    /**
     * 封面图片地址
     */
    private String coverImage;

    /**
     * 背景图片地址
     */
    private String backgroundImage;

    /**
     * 评分
     */
    private Double rating;

    /**
     * 观看人数
     */
    private Integer viewCount;

    /**
     * 收藏人数
     */
    private Integer favoriteCount;

    /**
     * 标签(用逗号分隔)
     */
    private String tags;

    /**
     * 状态(连载中/已完结)
     */
    private String status;

    /**
     * 集数
     */
    private Integer totalEpisodes;

    /**
     * 上映日期
     */
    private LocalDate releaseDate;

    /**
     * 制作公司
     */
    private String studio;

    /**
     * 导演
     */
    private String director;

    /**
     * 主要配音演员(用逗号分隔)
     */
    private String voiceActors;

    /**
     * 视频地址(播放链接)
     */
    private String videoUrl;

    /**
     * 每集视频地址(JSON格式)
     */
    private String episodeUrls;

    /**
     * 创建时间
     */
    private LocalDate createTime;

    /**
     * 更新时间
     */
    private LocalDate updateTime;
}
