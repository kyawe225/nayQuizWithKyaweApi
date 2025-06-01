package com.quiz.configs;

import java.util.TimeZone;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DateTimeConfig {
    @Bean
    public TimeZone timeZone() {
        TimeZone utc = TimeZone.getTimeZone("UTC");
        TimeZone.setDefault(utc);
        return utc;
    }
}
