package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("anime_news")
public class AnimeNews {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 标题 */
    private String title;

    /** 摘要 */
    private String summary;

    /** 正文 */
    private String content;

    /** 封面图片 */
    private String coverImage;

    /** 分类(新番资讯/声优消息/制作动态/周边情报) */
    private String category;

    /** 来源 */
    private String source;

    /** 浏览量 */
    private Integer viewCount;

    /** 标签 */
    private String tags;

    /** 状态(0:草稿 1:发布) */
    private Integer status;

    /** 发布时间 */
    private LocalDateTime publishTime;

    /** 创建时间 */
    private LocalDateTime createTime;
}
