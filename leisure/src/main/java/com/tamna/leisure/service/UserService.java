// service/UserService.java
package com.tamna.leisure.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.tamna.leisure.repository.UserRepository;
import com.tamna.leisure.domain.User;
import java.util.concurrent.TimeUnit;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    public boolean sendEmailVerification(String email, String code) {
        String redisKey = "email_verify:" + email;
        redisTemplate.opsForValue().set(redisKey, code, 10, TimeUnit.MINUTES);
        // 실제 이메일 전송 생략
        return true;
    }

    public boolean verifyEmailCode(String email, String code) {
        String redisKey = "email_verify:" + email;
        String stored = (String) redisTemplate.opsForValue().get(redisKey);
        return code.equals(stored);
    }

    public User signup(User user) {
        // 이메일/휴대폰 인증 확인(실제 로직 보강 필요)
        // 비밀번호 해싱, 약관 JSON 등 보강 필요
        return userRepository.save(user);
    }
}
