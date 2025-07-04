// controller/UserController.java
package com.tamna.leisure.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.tamna.leisure.service.UserService;
import com.tamna.leisure.domain.User;

@RestController
@RequestMapping("/auth")
public class UserController {
    @Autowired
    private UserService userService;

    @PostMapping("/email/send")
    public String sendEmailCode(@RequestParam String email) {
        String code = "123456"; // 실제 랜덤 생성 필요
        userService.sendEmailVerification(email, code);
        return "ok";
    }

    @PostMapping("/email/verify")
    public String verifyEmail(@RequestParam String email, @RequestParam String code) {
        return userService.verifyEmailCode(email, code) ? "success" : "fail";
    }

    @PostMapping("/signup")
    public User signup(@RequestBody User user) {
        return userService.signup(user);
    }
}
