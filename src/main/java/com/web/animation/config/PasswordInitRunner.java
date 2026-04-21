package com.web.animation.config;

import com.web.animation.entity.User;
import com.web.animation.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

/**
 * 密码初始化
 * 确保管理员密码正确
 */
@Component
public class PasswordInitRunner implements CommandLineRunner {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public PasswordInitRunner(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        // 确保 admin22121 密码是 admin123
        userRepository.findByUsername("admin22121").ifPresent(user -> {
            String expectedPassword = "admin123";
            if (!passwordEncoder.matches(expectedPassword, user.getPassword())) {
                System.out.println("重置管理员密码...");
                user.setPassword(passwordEncoder.encode(expectedPassword));
                userRepository.save(user);
                System.out.println("管理员密码已重置为: " + expectedPassword);
            } else {
                System.out.println("管理员密码正确");
            }
        });

        // 确保 test 用户密码是 test123
        userRepository.findByUsername("test").ifPresent(user -> {
            String expectedPassword = "test123";
            if (!passwordEncoder.matches(expectedPassword, user.getPassword())) {
                System.out.println("重置测试用户密码...");
                user.setPassword(passwordEncoder.encode(expectedPassword));
                userRepository.save(user);
                System.out.println("测试用户密码已重置为: " + expectedPassword);
            }
        });
    }
}
