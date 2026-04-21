package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("anime_favorite")
public class AnimeFavorite {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 动漫ID */
    private Long animeId;

    /** 用户ID */
    private Long userId;

    /** 收藏时间 */
    private LocalDateTime createTime;
}
