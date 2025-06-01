package com.quiz.models.enums;

public final class DatabasePrefix {

    private DatabasePrefix() {
        // Prevent instantiation
    }

    // Existing prefixes
    public static final String ROLE = "role";
    public static final String USER = "user";
    public static final String LEVEL = "level";
    public static final String COURSE = "course";
    public static final String COURSE_CONTENT = "content";
    public static final String BLOCK = "block";
    public static final String FILE = "file";
    public static final String QUESTION = "q";
    public static final String CHOICE = "choice";
    public static final String COURSE_PROGRESS = "progress";
    public static final String COURSE_LOG = "log";
    public static final String ACHIEVEMENT = "achieve";
    public static final String ADMIN_ACCESS_LOG = "admin-log";
    
    // New prefixes for missing entities
    public static final String WELCOME_TEMPLATE = "template";
    public static final String MODULE = "module";
    public static final String QUIZ = "quiz";
    public static final String USER_ANSWER = "answer";
    public static final String QUIZ_SUBMISSION = "submission";
    public static final String ENROLLMENT = "enroll";
    public static final String MODULE_PROGRESS = "mod-progress";
    public static final String PROGRESS_SUMMARY = "summary";
}
