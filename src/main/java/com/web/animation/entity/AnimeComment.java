package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("anime_comment")
public class AnimeComment {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 动漫ID */
    private Long animeId;

    /** 用户ID(可为null表示游客) */
    private Long userId;

    /** 用户名 */
    private String username;

    /** 用户头像 */
    private String avatar;

    /** 评论内容 */
    private String content;

    /** 评分(1-10) */
    private Integer rating;

    /** 点赞数 */
    private Integer likes;

    /** 父评论ID(回复) */
    private Long parentId;

    /** 状态(0:禁用 1:正常) */
    private Integer status;

    /** 评论时间 */
    private LocalDateTime createTime;
}
