package com.web.animation.dto;

import lombok.Data;

/**
 * 动漫保存请求 DTO
 */
@Data
public class AnimeSaveRequest {
    private Long id;
    private String title;
    private String type;
    private String status;
    private Double rating;
    private Integer viewCount;
    private String coverImage;
    private String tags;
    private String description;
    private String author;
    private String releaseDate;
    
    // 详情字段
    private String introduction;
    private String totalEpisodes;
    private String studio;
    private String director;
    private String voiceActors;
}
