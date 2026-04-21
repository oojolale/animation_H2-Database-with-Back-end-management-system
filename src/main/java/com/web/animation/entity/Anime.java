package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;

@Data
@TableName("anime")
public class Anime {

    @TableId(type = IdType.AUTO)
    private Long id;

    /**
     * 动漫名称
     */
    private String title;

    /**
     * 封面图片地址
     */
    private String coverImage;

    /**
     * 动漫类型(日本/国产/欧美)
     */
    private String type;

    /**
     * 动漫状态(连载中/已完结)
     */
    private String status;

    /**
     * 评分
     */
    private Double rating;

    /**
     * 观看人数
     */
    private Integer viewCount;

    /**
     * 标签(用逗号分隔)
     */
    private String tags;

    /**
     * 简介
     */
    private String description;

    /**
     * 作者/原作
     */
    private String author;

    /**
     * 上映日期
     */
    private LocalDate releaseDate;

    /**
     * 创建时间
     */
    private LocalDate createTime;

    /**
     * 更新时间
     */
    private LocalDate updateTime;
}
