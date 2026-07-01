package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Map;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public Map<String, String> hello() {
        return Map.of(
            "message",   "Hello from Abdul Mohammed's Spring Boot ECR Lab!",
            "student",   "Abdul Mohammed",
            "image",     "abdulmohammed_springboot",
            "timestamp", Instant.now().toString()
        );
    }
}
