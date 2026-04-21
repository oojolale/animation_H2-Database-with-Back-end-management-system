package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("watch_history")
public class WatchHistory {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 动漫ID */
    private Long animeId;

    /** 用户ID */
    private Long userId;

    /** 会话ID(游客) */
    private String sessionId;

    /** 看到第几集 */
    private Integer episode;

    /** 播放进度(秒) */
    private Integer progress;

    /** 记录时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
