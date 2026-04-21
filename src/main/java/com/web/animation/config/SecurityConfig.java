package com.web.animation.config;

import com.web.animation.core.security.filter.JwtAuthenticationTokenFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter;
    private final UserDetailsService userDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf(csrf -> csrf
                .ignoringRequestMatchers(new AntPathRequestMatcher("/api/**"))
                .ignoringRequestMatchers(new AntPathRequestMatcher("/h2-console/**"))
            )
            .headers(headers -> headers.frameOptions(frameOptions -> frameOptions.sameOrigin()))
            .authorizeHttpRequests(authz -> authz
                // H2控制台
                .requestMatchers(new AntPathRequestMatcher("/h2-console/**")).permitAll()
                // 静态资源
                .requestMatchers(new AntPathRequestMatcher("/images/**"), new AntPathRequestMatcher("/static/**"), 
                    new AntPathRequestMatcher("/css/**"), new AntPathRequestMatcher("/js/**"), 
                    new AntPathRequestMatcher("/fonts/**"), new AntPathRequestMatcher("/font/**")).permitAll()
                // 动漫网站公开页面
                .requestMatchers(new AntPathRequestMatcher("/"), new AntPathRequestMatcher("/aaa"), 
                    new AntPathRequestMatcher("/anime/**"), new AntPathRequestMatcher("/login"), 
                    new AntPathRequestMatcher("/register"), new AntPathRequestMatcher("/error"), 
                    new AntPathRequestMatcher("/error.html")).permitAll()
                // 论坛
                .requestMatchers(new AntPathRequestMatcher("/discuz/**")).permitAll()
                // 文件服务
                .requestMatchers(new AntPathRequestMatcher("/files/**")).permitAll()
                // 全部API公开（动漫数据、注册等）
                .requestMatchers(new AntPathRequestMatcher("/api/**")).permitAll()
                // jqueryIp等第三方
                .requestMatchers(new AntPathRequestMatcher("/jqueryIp/**")).permitAll()
                // 其他路径需要认证
                .anyRequest().authenticated()
            )
            .exceptionHandling(ex -> ex
                .authenticationEntryPoint((request, response, authException) -> {
                    // 未认证时重定向到登录页
                    response.sendRedirect("/login");
                })
                .accessDeniedHandler((request, response, accessDeniedException) -> {
                    // 无权限时重定向到登录页
                    response.sendRedirect("/login");
                })
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/aaa", true)
                .failureUrl("/login?error=true")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/aaa")
                .permitAll()
            )
            ;

        return http.build();
    }
}
