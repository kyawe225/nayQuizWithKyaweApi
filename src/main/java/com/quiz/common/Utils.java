package com.quiz.common;

import java.util.UUID;

public class Utils {
    public static String GetGuid(String prefix) {
        return prefix +"_" + UUID.randomUUID();
    }

}
