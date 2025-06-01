package com.quiz.models.enums;

public class Enums {

    public enum CommonStatus {
        ACTIVE,
        INACTIVE,
        DELETED
    }

    public enum UserStatus {
        ACTIVE,
        INACTIVE,
        BANNED,
        DELETED
    }

    public enum CourseStatus {
        DRAFT,
        PUBLISHED,
        ARCHIVED,
        DELETED
    }

    public enum LevelStatus {
        ACTIVE,
        INACTIVE
    }

    public enum CourseContentStatus {
        ACTIVE,
        INACTIVE,
        DELETED
    }

    public enum BlockStatus {
        ACTIVE,
        INACTIVE,
        DELETED
    }

    public enum FileStatus {
        UPLOADED,
        PROCESSING,
        FAILED,
        DELETED
    }

    public enum QuestionStatus {
        ACTIVE,
        INACTIVE,
        ARCHIVED,
        DELETED
    }

    public enum ChoiceStatus {
        ACTIVE,
        INACTIVE
    }

    public enum AnswerStatus {
        RECORDED,
        REVIEWED
    }

    public enum AchievementStatus {
        EARNED,
        REVOKED,
        INACTIVE
    }

    public enum CourseProgressStatus {
        IN_PROGRESS,
        COMPLETED,
        RESET
    }

    public enum CourseAccessLogStatus {
        LOGGED,
        IGNORED
    }

    public enum AdminAccessLogStatus {
        LOGGED,
        REVIEWED
    }

    public enum QuizStatus {
        DRAFT,
        PUBLISHED,
        ARCHIVED,
        INACTIVE
    }

    // ========== MISSING STATUS ENUMS ==========

    public enum WelcomeTemplateStatus {
        ACTIVE,
        INACTIVE,
        DELETED
    }

    public enum CourseModuleStatus {
        ACTIVE,
        INACTIVE,
        ARCHIVED,
        DELETED
    }

    public enum QuizSubmissionStatus {
        IN_PROGRESS,
        SUBMITTED,
        GRADED,
        INCOMPLETE,
        INVALID
    }

    public enum CourseEnrollmentStatus {
        enrolled("enrolled"),
        active("active"),
        dropped("dropped"),
        completed("completed"),
        suspended("suspended"),
        expired("expired");
        
    	private final String name;       

        private CourseEnrollmentStatus(String s) {
            name = s;
        }

        public boolean equalsName(String otherName) {
            // (otherName == null) check is not needed because name.equals(null) returns false 
            return name.equals(otherName);
        }

        public String toString() {
           return this.name;
        }
    }

    public enum ModuleProgressStatus {
        NOT_STARTED,
        IN_PROGRESS,
        COMPLETED,
        RESET,
        SKIPPED
    }

    public enum ProgressSummaryStatus {
        ACTIVE,
        COMPLETED,
        RESET,
        ARCHIVED
    }

    // ========== ADDITIONAL HELPFUL ENUMS ==========

    public enum ContentType {
        VIDEO,
        TEXT,
        AUDIO,
        PDF,
        INTERACTIVE,
        QUIZ,
        ASSIGNMENT
    }

    public enum QuestionType {
        MULTIPLE_CHOICE,
        TRUE_FALSE,
        SHORT_ANSWER,
        ESSAY,
        FILL_IN_BLANK,
        MATCHING
    }

    public enum UserRole {
        ADMIN,
        INSTRUCTOR,
        STUDENT,
        GUEST
    }

    public enum WelcomeMode {
        TEMPLATE,
        CUSTOM,
        DISABLED
    }

    public enum LogLevel {
        INFO,
        WARNING,
        ERROR,
        DEBUG
    }
}