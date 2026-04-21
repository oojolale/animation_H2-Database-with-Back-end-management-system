package com.web.animation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import java.time.LocalDateTime;

/**
 * 轮播图实体
 */
@Data
@TableName("banner")
public class Banner {

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 标题 */
    private String title;

    /** 图片URL */
    private String imageUrl;

    /** 链接地址 */
    private String linkUrl;

    /** 关联动漫ID */
    private Long animeId;

    /** 描述 */
    private String description;

    /** 显示顺序 */
    private Integer sortOrder;

    /** 类型：home-首页, anime-动漫页 */
    private String location;

    /** 状态：0-禁用 1-启用 */
    private Integer status;

    /** 开始时间 */
    private LocalDateTime startTime;

    /** 结束时间 */
    private LocalDateTime endTime;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
