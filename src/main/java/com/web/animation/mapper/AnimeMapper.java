package com.web.animation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.web.animation.entity.Anime;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AnimeMapper extends BaseMapper<Anime> {

    /**
     * 根据类型查询动漫列表
     * @param type 动漫类型(日本/国产/欧美)
     * @return 动漫列表
     */
    List<Anime> selectByType(String type);
}
