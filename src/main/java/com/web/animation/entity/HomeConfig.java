package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 首页配置实体
 * 用于配置首页各个模块的显示内容
 */
@Data
@TableName("home_config")
public class HomeConfig {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 配置名称 */
    private String name;

    /** 配置类型：banner-轮播图, latest-最新, hot-热门, japanese-日漫, chinese-国漫, western-欧美, news-资讯, ranking-排行榜 */
    private String type;

    /** 关联的动漫ID */
    private Long animeId;

    /** 关联的资讯ID */
    private Long newsId;

    /** 显示顺序 */
    private Integer sortOrder;

    /** 状态：0-禁用 1-启用 */
    private Integer status;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
