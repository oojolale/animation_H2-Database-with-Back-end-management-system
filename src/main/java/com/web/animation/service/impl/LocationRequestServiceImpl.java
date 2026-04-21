package com.web.animation.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.web.animation.entity.LocationRequest;
import com.web.animation.mapper.LocationRequestMapper;
import com.web.animation.service.LocationRequestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
public class LocationRequestServiceImpl extends ServiceImpl<LocationRequestMapper, LocationRequest> implements LocationRequestService {
}
