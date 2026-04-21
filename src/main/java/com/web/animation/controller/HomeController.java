package com.web.animation.controller;

import com.web.animation.service.MailService;
import com.web.animation.util.AjaxResult;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;

@Controller
public class HomeController {

    @Autowired
    MailService mailService;

    private final RestTemplate restTemplate;

    public HomeController(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @GetMapping("/")
    public String home() {
        return "redirect:/aaa";
    }
    
    // 注: /aaa 首页路由已移至 AnimeWebController，实现数据绑定
    // 动漫分类页面路由已移至 AnimeWebController

    // ==================== 论坛页面路由 ====================

    @GetMapping("/discuz")
    public String discuz() {
        return "discuz/index";
    }

    @GetMapping("/discuz/picture")
    public String picture() {
        return "discuz/picture";
    }

    @GetMapping("/discuz/bulletin")
    public String bulletinBoard() {
        return "discuz/bulletinBoard";
    }

    // ==================== 系统页面路由 ====================

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        return "login";
    }

    @GetMapping("/error")
    public String error() {
        return "error";
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminPanel() {
        return "admin";
    }

    @GetMapping("/user")
    @PreAuthorize("hasAnyRole('USER', 'ADMIN')")
    public String userPanel() {
        return "user";
    }

    @GetMapping("api/sendMail")
    @ResponseBody
    public AjaxResult sendMail(HttpServletResponse response) {
        mailService.send("type", "prompt", "th");
        return AjaxResult.success("业务处理中请稍后！");
    }
}
