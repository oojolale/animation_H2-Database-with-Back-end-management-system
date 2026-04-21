package com.web.animation.service.impl;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.web.animation.entity.SysUserEntity;
import com.web.animation.mapper.SysUserMapper;
import com.web.animation.service.SysUserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUserEntity> implements SysUserService {

}
