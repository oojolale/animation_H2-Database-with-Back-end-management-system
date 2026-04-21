package com.web.animation.core.security.filter;

import cn.hutool.core.util.ObjectUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/*
 * JWT认证过滤器
 */
@Component
@Slf4j
public class JwtAuthenticationTokenFilter extends OncePerRequestFilter {
    @Autowired
    UserDetailsService userDetailsService;
    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) throws ServletException {
        String uri = request.getRequestURI();
        return !uri.startsWith("/discuz/picture");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        // TODO: 校验 session（签名、过期等），解析出用户名、权限
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if( ObjectUtil.isNotEmpty(authentication) && authentication.isAuthenticated()) {
            if (authentication.getPrincipal() instanceof User principal){
                if(authentication.getDetails() instanceof WebAuthenticationDetails details){
                    String sessionId = details.getSessionId();
                    if(ObjectUtil.isNotEmpty(sessionId) && ObjectUtil.isNotEmpty(SecurityContextHolder.getContext())){
                        //通过UserDetailsService 加载用户加载用户
                        UserDetails userDetails = userDetailsService.loadUserByUsername(principal.getUsername());
                        UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                        usernamePasswordAuthenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                        SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
                    }
                }
            }
        }
        else {
            // 避免此前曾经存入过用户信息，后续即使没有携带JWT，在Spring Security仍保存有上下文数据（包括用户信息）
            SecurityContextHolder.clearContext();
        }
        filterChain.doFilter(request, response);
    }

}
