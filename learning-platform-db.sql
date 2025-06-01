-- Learning Platform Database Schema and Sample Data
-- All primary keys are VARCHAR(125), all tables include status field, COURSES includes name field
-- Primary key prefixes follow DatabasePrefixes.java conventions

-- Create Tables with Updated Schema

CREATE TABLE USERS (
    user_id VARCHAR(125) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'INSTRUCTOR', 'ADMIN') DEFAULT 'STUDENT',
    status ENUM('ACTIVE', 'INACTIVE', 'BANNED', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE WELCOME_TEMPLATES (
    template_id VARCHAR(125) PRIMARY KEY,
    description TEXT,
    base_content TEXT,
    status ENUM('ACTIVE', 'INACTIVE', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE COURSES (
    course_id VARCHAR(125) PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    welcome_fk VARCHAR(125),
    welcome_mode VARCHAR(50),
    welcome_stylesheet TEXT,
    welcome_template_id VARCHAR(125),
    status ENUM('DRAFT', 'PUBLISHED', 'ARCHIVED', 'DELETED') DEFAULT 'DRAFT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (welcome_template_id) REFERENCES WELCOME_TEMPLATES(template_id)
);

CREATE TABLE CONTENT_BLOCKS (
    block_id VARCHAR(125) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('ACTIVE', 'INACTIVE', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE COURSE_CONTENT_BLOCKS (
    content_id VARCHAR(125) PRIMARY KEY,
    course_fk VARCHAR(125) NOT NULL,
    block_id VARCHAR(125) NOT NULL,
    position INT DEFAULT 0,
    file VARCHAR(255),
    description TEXT,
    base_url VARCHAR(255),
    welcome_file_path VARCHAR(255),
    is_enabled BOOLEAN DEFAULT TRUE,
    status ENUM('ACTIVE', 'INACTIVE', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_fk) REFERENCES COURSES(course_id),
    FOREIGN KEY (block_id) REFERENCES CONTENT_BLOCKS(block_id)
);

CREATE TABLE COURSE_LEVELS (
    level_id VARCHAR(125) PRIMARY KEY,
    course_id VARCHAR(125) NOT NULL,
    name VARCHAR(100) NOT NULL,
    ranks INT NOT NULL,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

CREATE TABLE COURSE_MODULES (
    module_id VARCHAR(125) PRIMARY KEY,
    course_id VARCHAR(125) NOT NULL,
    level_id VARCHAR(125) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    sequence_order INT DEFAULT 0,
    content_type VARCHAR(50),
    content_url VARCHAR(255),
    estimated_duration_minutes INT,
    is_required BOOLEAN DEFAULT TRUE,
    status ENUM('ACTIVE', 'INACTIVE', 'ARCHIVED', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id),
    FOREIGN KEY (level_id) REFERENCES COURSE_LEVELS(level_id)
);

CREATE TABLE QUIZZES (
    quiz_id VARCHAR(125) PRIMARY KEY,
    course_id VARCHAR(125) NOT NULL,
    level_id VARCHAR(125) NOT NULL,
    file VARCHAR(255),
    is_final BOOLEAN DEFAULT FALSE,
    time_and_minutes INT DEFAULT 30,
    status ENUM('DRAFT', 'PUBLISHED', 'ARCHIVED', 'INACTIVE') DEFAULT 'DRAFT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id),
    FOREIGN KEY (level_id) REFERENCES COURSE_LEVELS(level_id)
);

CREATE TABLE QUESTIONS (
    question_id VARCHAR(125) PRIMARY KEY,
    quiz_id VARCHAR(125) NOT NULL,
    content TEXT NOT NULL,
    type ENUM('MULTIPLE_CHOICE', 'TRUE_FALSE', 'SHORT_ANSWER') DEFAULT 'MULTIPLE_CHOICE',
    points INT DEFAULT 1,
    status ENUM('ACTIVE', 'INACTIVE', 'ARCHIVED', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES QUIZZES(quiz_id)
);

CREATE TABLE CHOICES (
    choice_id VARCHAR(125) PRIMARY KEY,
    question_id VARCHAR(125) NOT NULL,
    content TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    status ENUM('ACTIVE', 'INACTIVE') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES QUESTIONS(question_id)
);

CREATE TABLE ACHIEVEMENTS (
    achievement_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    quiz_id VARCHAR(125) NOT NULL,
    score DECIMAL(5,2),
    achieved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('EARNED', 'REVOKED', 'INACTIVE') DEFAULT 'EARNED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (quiz_id) REFERENCES QUIZZES(quiz_id)
);

CREATE TABLE QUIZ_SUBMISSIONS (
    submission_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    quiz_id VARCHAR(125) NOT NULL,
    completed_at TIMESTAMP,
    score DECIMAL(5,2),
    status ENUM('IN_PROGRESS', 'SUBMITTED', 'GRADED', 'INCOMPLETE', 'INVALID') DEFAULT 'IN_PROGRESS',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (quiz_id) REFERENCES QUIZZES(quiz_id)
);

CREATE TABLE USER_ANSWERS (
    user_answer_id VARCHAR(125) PRIMARY KEY,
    submission_id VARCHAR(125) NOT NULL,
    question_id VARCHAR(125) NOT NULL,
    choice_id VARCHAR(125),
    answer_text TEXT,
    is_correct BOOLEAN DEFAULT FALSE,
    answered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('RECORDED', 'REVIEWED') DEFAULT 'RECORDED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (submission_id) REFERENCES QUIZ_SUBMISSIONS(submission_id),
    FOREIGN KEY (question_id) REFERENCES QUESTIONS(question_id),
    FOREIGN KEY (choice_id) REFERENCES CHOICES(choice_id)
);

CREATE TABLE COURSE_ENROLLMENTS (
    enrollment_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    course_id VARCHAR(125) NOT NULL,
    status ENUM('enrolled', 'active', 'dropped', 'completed', 'suspended', 'expired') DEFAULT 'enrolled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

CREATE TABLE COURSE_ACCESS_LOG (
    log_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    course_id VARCHAR(125) NOT NULL,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    browser_info VARCHAR(255),
    status ENUM('LOGGED', 'IGNORED') DEFAULT 'LOGGED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

CREATE TABLE ADMIN_ACCESS_LOG (
    log_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    action VARCHAR(100),
    details TEXT,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    browser_info VARCHAR(255),
    status ENUM('LOGGED', 'REVIEWED') DEFAULT 'LOGGED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE USER_MODULE_PROGRESS (
    progress_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    module_id VARCHAR(125) NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    progress_percentage DECIMAL(5,2) DEFAULT 0.00,
    completion_date TIMESTAMP NULL,
    time_spent_seconds INT DEFAULT 0,
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED', 'RESET', 'SKIPPED') DEFAULT 'NOT_STARTED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (module_id) REFERENCES COURSE_MODULES(module_id)
);

CREATE TABLE COURSE_PROGRESS_SUMMARY (
    summary_id VARCHAR(125) PRIMARY KEY,
    user_id VARCHAR(125) NOT NULL,
    course_id VARCHAR(125) NOT NULL,
    overall_progress_percentage DECIMAL(5,2) DEFAULT 0.00,
    completed_modules INT DEFAULT 0,
    total_modules INT DEFAULT 0,
    completed_quizzes INT DEFAULT 0,
    total_quizzes INT DEFAULT 0,
    total_points_earned INT DEFAULT 0,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'COMPLETED', 'RESET', 'ARCHIVED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

-- Insert Sample Data (using DatabasePrefixes.java conventions)

-- USERS (prefix: "user")
INSERT INTO USERS (user_id, username, email, password_hash, role, status) VALUES
('user_001_john_doe', 'john_doe', 'john.doe@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'ACTIVE'),
('user_002_jane_smith', 'jane_smith', 'jane.smith@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'INSTRUCTOR', 'ACTIVE'),
('user_003_admin_user', 'admin_user', 'admin@platform.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'ADMIN', 'ACTIVE'),
('user_004_mike_wilson', 'mike_wilson', 'mike.wilson@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'ACTIVE'),
('user_005_sarah_jones', 'sarah_jones', 'sarah.jones@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'INACTIVE'),
('user_006_robert_brown', 'robert_brown', 'robert.brown@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'INSTRUCTOR', 'ACTIVE'),
('user_007_emily_davis', 'emily_davis', 'emily.davis@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'SUSPENDED'),
('user_008_alex_taylor', 'alex_taylor', 'alex.taylor@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'ACTIVE');

-- WELCOME_TEMPLATES (prefix: "template")
INSERT INTO WELCOME_TEMPLATES (template_id, description, base_content, status) VALUES
('template_001_standard', 'Standard Welcome Template', '<h1>Welcome to {{course_name}}!</h1><p>We are excited to have you here.</p>', 'ACTIVE'),
('template_002_premium', 'Premium Welcome Template', '<div class="premium-welcome"><h1>Welcome to {{course_name}}</h1><p>Your journey begins now!</p></div>', 'ACTIVE'),
('template_003_minimal', 'Minimal Welcome Template', '<h2>{{course_name}}</h2><p>Let\'s get started.</p>', 'ACTIVE'),
('template_004_interactive', 'Interactive Welcome Template', '<div class="interactive"><h1>Welcome!</h1><button>Start Learning</button></div>', 'INACTIVE');

-- COURSES (prefix: "course")
INSERT INTO COURSES (course_id, name, description, welcome_fk, welcome_mode, welcome_stylesheet, welcome_template_id, status) VALUES
('course_001_intro_prog', 'Introduction to Programming', 'Learn the basics of programming with Python', 'template_001_standard', 'standard', 'body { font-family: Arial; }', 'template_001_standard', 'PUBLISHED'),
('course_002_adv_web', 'Advanced Web Development', 'Master modern web technologies including React and Node.js', 'template_002_premium', 'premium', 'body { background: #f0f0f0; }', 'template_002_premium', 'PUBLISHED'),
('course_003_data_sci', 'Data Science Fundamentals', 'Explore data analysis, visualization, and machine learning basics', 'template_001_standard', 'standard', 'body { color: #333; }', 'template_001_standard', 'PUBLISHED'),
('course_004_mobile_dev', 'Mobile App Development', 'Build iOS and Android applications using React Native', 'template_003_minimal', 'minimal', NULL, 'template_003_minimal', 'DRAFT'),
('course_005_db_sql', 'Database Design and SQL', 'Master relational databases and SQL queries', 'template_001_standard', 'standard', 'body { font-size: 16px; }', 'template_001_standard', 'PUBLISHED'),
('course_006_cloud_comp', 'Cloud Computing Essentials', 'Learn AWS, Azure, and Google Cloud Platform', 'template_002_premium', 'premium', 'body { margin: 20px; }', 'template_002_premium', 'ARCHIVED');

-- CONTENT_BLOCKS (prefix: "block")
INSERT INTO CONTENT_BLOCKS (block_id, name, description, status) VALUES
('block_001_video', 'Video Lectures', 'Video content for course modules', 'ACTIVE'),
('block_002_reading', 'Reading Materials', 'PDF and text-based learning resources', 'ACTIVE'),
('block_003_code', 'Code Examples', 'Sample code and programming exercises', 'ACTIVE'),
('block_004_labs', 'Interactive Labs', 'Hands-on practice environments', 'ACTIVE'),
('block_005_quiz', 'Quizzes', 'Assessment and knowledge checks', 'ACTIVE'),
('block_006_forum', 'Discussion Forums', 'Community interaction and Q&A', 'ACTIVE'),
('block_007_project', 'Project Templates', 'Starter code for course projects', 'ACTIVE'),
('block_008_external', 'External Resources', 'Links to additional learning materials', 'DELETED');

-- COURSE_CONTENT_BLOCKS (prefix: "content")
INSERT INTO COURSE_CONTENT_BLOCKS (content_id, course_fk, block_id, position, file, description, base_url, welcome_file_path, is_enabled, status) VALUES
('content_001_py_intro_vid', 'course_001_intro_prog', 'block_001_video', 1, 'intro_video.mp4', 'Introduction video for Python basics', 'https://cdn.example.com/courses/1/', '/welcome/intro.html', TRUE, 'ACTIVE'),
('content_002_py_basics_read', 'course_001_intro_prog', 'block_002_reading', 2, 'python_basics.pdf', 'Python fundamentals reading material', 'https://cdn.example.com/courses/1/', NULL, TRUE, 'ACTIVE'),
('content_003_py_hello', 'course_001_intro_prog', 'block_003_code', 3, 'hello_world.py', 'First Python program example', 'https://cdn.example.com/courses/1/', NULL, TRUE, 'ACTIVE'),
('content_004_react_intro', 'course_002_adv_web', 'block_001_video', 1, 'react_intro.mp4', 'Introduction to React framework', 'https://cdn.example.com/courses/2/', '/welcome/react.html', TRUE, 'ACTIVE'),
('content_005_react_lab', 'course_002_adv_web', 'block_004_labs', 2, NULL, 'React development environment setup', 'https://labs.example.com/react/', NULL, TRUE, 'ACTIVE'),
('content_006_ds_overview', 'course_003_data_sci', 'block_001_video', 1, 'data_science_overview.mp4', 'Overview of data science field', 'https://cdn.example.com/courses/3/', NULL, TRUE, 'ACTIVE'),
('content_007_stats_basics', 'course_003_data_sci', 'block_002_reading', 2, 'statistics_basics.pdf', 'Statistical concepts for data science', 'https://cdn.example.com/courses/3/', NULL, TRUE, 'ACTIVE'),
('content_008_mobile_intro', 'course_004_mobile_dev', 'block_001_video', 1, 'mobile_dev_intro.mp4', 'Mobile development introduction', 'https://cdn.example.com/courses/4/', NULL, FALSE, 'INACTIVE');

-- COURSE_LEVELS (prefix: "level")
INSERT INTO COURSE_LEVELS (level_id, course_id, name, ranks, status) VALUES
('level_001_py_begin', 'course_001_intro_prog', 'Beginner', 1, 'ACTIVE'),
('level_002_py_inter', 'course_001_intro_prog', 'Intermediate', 2, 'ACTIVE'),
('level_003_py_adv', 'course_001_intro_prog', 'Advanced', 3, 'ACTIVE'),
('level_004_web_found', 'course_002_adv_web', 'Foundation', 1, 'ACTIVE'),
('level_005_web_prof', 'course_002_adv_web', 'Professional', 2, 'ACTIVE'),
('level_006_ds_basics', 'course_003_data_sci', 'Basics', 1, 'ACTIVE'),
('level_007_ds_applied', 'course_003_data_sci', 'Applied Concepts', 2, 'ACTIVE'),
('level_008_mob_start', 'course_004_mobile_dev', 'Getting Started', 1, 'INACTIVE'),
('level_009_sql_fund', 'course_005_db_sql', 'SQL Fundamentals', 1, 'ACTIVE'),
('level_010_sql_adv', 'course_005_db_sql', 'Advanced Queries', 2, 'ACTIVE');

-- COURSE_MODULES (prefix: "module")
INSERT INTO COURSE_MODULES (module_id, course_id, level_id, title, description, sequence_order, content_type, content_url, estimated_duration_minutes, is_required, status) VALUES
('module_001_py_intro', 'course_001_intro_prog', 'level_001_py_begin', 'Introduction to Python', 'Learn Python syntax and basic concepts', 1, 'video', '/videos/python_intro.mp4', 45, TRUE, 'ACTIVE'),
('module_002_py_vars', 'course_001_intro_prog', 'level_001_py_begin', 'Variables and Data Types', 'Understanding Python data types', 2, 'video', '/videos/python_datatypes.mp4', 30, TRUE, 'ACTIVE'),
('module_003_py_control', 'course_001_intro_prog', 'level_001_py_begin', 'Control Flow', 'If statements and loops in Python', 3, 'interactive', '/labs/control_flow', 60, TRUE, 'ACTIVE'),
('module_004_py_funcs', 'course_001_intro_prog', 'level_002_py_inter', 'Functions and Modules', 'Creating reusable code', 1, 'video', '/videos/python_functions.mp4', 50, TRUE, 'ACTIVE'),
('module_005_react_comp', 'course_002_adv_web', 'level_004_web_found', 'React Components', 'Building React components', 1, 'video', '/videos/react_components.mp4', 40, TRUE, 'ACTIVE'),
('module_006_react_state', 'course_002_adv_web', 'level_004_web_found', 'State Management', 'Managing application state', 2, 'interactive', '/labs/react_state', 90, TRUE, 'ACTIVE'),
('module_007_data_viz', 'course_003_data_sci', 'level_006_ds_basics', 'Data Visualization', 'Creating charts and graphs', 1, 'video', '/videos/data_viz.mp4', 55, TRUE, 'ACTIVE'),
('module_008_pandas', 'course_003_data_sci', 'level_006_ds_basics', 'Pandas Basics', 'Data manipulation with Pandas', 2, 'interactive', '/labs/pandas_intro', 75, FALSE, 'ACTIVE');

-- QUIZZES (prefix: "quiz")
INSERT INTO QUIZZES (quiz_id, course_id, level_id, file, is_final, time_and_minutes, status) VALUES
('quiz_001_py_basics', 'course_001_intro_prog', 'level_001_py_begin', 'python_basics_quiz.json', FALSE, 20, 'PUBLISHED'),
('quiz_002_py_inter', 'course_001_intro_prog', 'level_002_py_inter', 'python_intermediate_quiz.json', FALSE, 30, 'PUBLISHED'),
('quiz_003_py_final', 'course_001_intro_prog', 'level_003_py_adv', 'python_final_exam.json', TRUE, 60, 'PUBLISHED'),
('quiz_004_react_found', 'course_002_adv_web', 'level_004_web_found', 'react_foundation_quiz.json', FALSE, 25, 'PUBLISHED'),
('quiz_005_react_final', 'course_002_adv_web', 'level_005_web_prof', 'react_final_exam.json', TRUE, 90, 'DRAFT'),
('quiz_006_ds_basics', 'course_003_data_sci', 'level_006_ds_basics', 'data_science_basics_quiz.json', FALSE, 30, 'PUBLISHED'),
('quiz_007_sql_basics', 'course_005_db_sql', 'level_009_sql_fund', 'sql_basics_quiz.json', FALSE, 25, 'PUBLISHED'),
('quiz_008_sql_adv', 'course_005_db_sql', 'level_010_sql_adv', 'sql_advanced_quiz.json', TRUE, 45, 'PUBLISHED');

-- QUESTIONS (prefix: "q")
INSERT INTO QUESTIONS (question_id, quiz_id, content, type, points, status) VALUES
('q_001_py_var', 'quiz_001_py_basics', 'What is the correct way to declare a variable in Python?', 'MULTIPLE_CHOICE', 2, 'ACTIVE'),
('q_002_py_compiled', 'quiz_001_py_basics', 'Python is a compiled language.', 'TRUE_FALSE', 1, 'ACTIVE'),
('q_003_py_print', 'quiz_001_py_basics', 'What does the print() function do?', 'MULTIPLE_CHOICE', 2, 'ACTIVE'),
('q_004_py_list', 'quiz_002_py_inter', 'What is a Python list?', 'MULTIPLE_CHOICE', 3, 'ACTIVE'),
('q_005_py_diff', 'quiz_002_py_inter', 'Explain the difference between a list and a tuple.', 'SHORT_ANSWER', 5, 'ACTIVE'),
('q_006_oop', 'quiz_003_py_final', 'What is object-oriented programming?', 'MULTIPLE_CHOICE', 4, 'ACTIVE'),
('q_007_jsx', 'quiz_004_react_found', 'What is JSX in React?', 'MULTIPLE_CHOICE', 3, 'ACTIVE'),
('q_008_react_multi', 'quiz_004_react_found', 'React components must always return multiple elements.', 'TRUE_FALSE', 2, 'ACTIVE');

-- CHOICES (prefix: "choice")
INSERT INTO CHOICES (choice_id, question_id, content, is_correct, status) VALUES
('choice_001_var_js', 'q_001_py_var', 'var x = 5', FALSE, 'ACTIVE'),
('choice_002_py_correct', 'q_001_py_var', 'x = 5', TRUE, 'ACTIVE'),
('choice_003_let', 'q_001_py_var', 'let x = 5', FALSE, 'ACTIVE'),
('choice_004_declare', 'q_001_py_var', 'declare x = 5', FALSE, 'ACTIVE'),
('choice_005_true', 'q_002_py_compiled', 'True', FALSE, 'ACTIVE'),
('choice_006_false', 'q_002_py_compiled', 'False', TRUE, 'ACTIVE'),
('choice_007_console', 'q_003_py_print', 'It displays output to the console', TRUE, 'ACTIVE'),
('choice_008_input', 'q_003_py_print', 'It reads input from the user', FALSE, 'ACTIVE'),
('choice_009_variable', 'q_003_py_print', 'It creates a new variable', FALSE, 'ACTIVE'),
('choice_010_import', 'q_003_py_print', 'It imports a module', FALSE, 'ACTIVE'),
('choice_011_ordered', 'q_004_py_list', 'An ordered, mutable collection', TRUE, 'ACTIVE'),
('choice_012_immutable', 'q_004_py_list', 'An ordered, immutable collection', FALSE, 'ACTIVE'),
('choice_013_unordered', 'q_004_py_list', 'An unordered collection', FALSE, 'ACTIVE'),
('choice_014_jsx_xml', 'q_007_jsx', 'JavaScript XML', TRUE, 'ACTIVE'),
('choice_015_jsx_ext', 'q_007_jsx', 'JavaScript Extension', FALSE, 'ACTIVE'),
('choice_016_java_ext', 'q_007_jsx', 'Java Syntax Extension', FALSE, 'ACTIVE'),
('choice_017_react_true', 'q_008_react_multi', 'True', FALSE, 'ACTIVE'),
('choice_018_react_false', 'q_008_react_multi', 'False', TRUE, 'ACTIVE');

-- COURSE_ENROLLMENTS (prefix: "enroll")
INSERT INTO COURSE_ENROLLMENTS (enrollment_id, user_id, course_id, status) VALUES
('enroll_001_john_py', 'user_001_john_doe', 'course_001_intro_prog', 'active'),
('enroll_002_john_web', 'user_001_john_doe', 'course_002_adv_web', 'active'),
('enroll_003_john_ds', 'user_001_john_doe', 'course_003_data_sci', 'completed'),
('enroll_004_mike_py', 'user_004_mike_wilson', 'course_001_intro_prog', 'active'),
('enroll_005_mike_ds', 'user_004_mike_wilson', 'course_003_data_sci', 'active'),
('enroll_006_sarah_web', 'user_005_sarah_jones', 'course_002_adv_web', 'dropped'),
('enroll_007_emily_py', 'user_007_emily_davis', 'course_001_intro_prog', 'suspended'),
('enroll_008_alex_py', 'user_008_alex_taylor', 'course_001_intro_prog', 'active'),
('enroll_009_alex_web', 'user_008_alex_taylor', 'course_002_adv_web', 'active'),
('enroll_010_alex_sql', 'user_008_alex_taylor', 'course_005_db_sql', 'active');

-- QUIZ_SUBMISSIONS (prefix: "submission")
INSERT INTO QUIZ_SUBMISSIONS (submission_id, user_id, quiz_id, completed_at, score, status) VALUES
('submission_001_john_q1', 'user_001_john_doe', 'quiz_001_py_basics', '2024-01-15 10:30:00', 85.50, 'GRADED'),
('submission_002_john_q2', 'user_001_john_doe', 'quiz_002_py_inter', '2024-01-20 14:45:00', 92.00, 'GRADED'),
('submission_003_john_q3', 'user_001_john_doe', 'quiz_003_py_final', NULL, NULL, 'IN_PROGRESS'),
('submission_004_mike_q1', 'user_004_mike_wilson', 'quiz_001_py_basics', '2024-01-18 09:15:00', 78.00, 'GRADED'),
('submission_005_alex_q1', 'user_008_alex_taylor', 'quiz_001_py_basics', '2024-01-22 16:20:00', 88.50, 'GRADED'),
('submission_006_alex_q4', 'user_008_alex_taylor', 'quiz_004_react_found', NULL, NULL, 'INCOMPLETE');

-- USER_ANSWERS (prefix: "answer")
INSERT INTO USER_ANSWERS (user_answer_id, submission_id, question_id, choice_id, answer_text, is_correct, status) VALUES
('answer_001_john_q1_1', 'submission_001_john_q1', 'q_001_py_var', 'choice_002_py_correct', NULL, TRUE, 'REVIEWED'),
('answer_002_john_q1_2', 'submission_001_john_q1', 'q_002_py_compiled', 'choice_006_false', NULL, TRUE, 'REVIEWED'),
('answer_003_john_q1_3', 'submission_001_john_q1', 'q_003_py_print', 'choice_007_console', NULL, TRUE, 'REVIEWED'),
('answer_004_john_q2_1', 'submission_002_john_q2', 'q_004_py_list', 'choice_011_ordered', NULL, TRUE, 'REVIEWED'),
('answer_005_john_q2_2', 'submission_002_john_q2', 'q_005_py_diff', NULL, 'Lists are mutable and can be changed, tuples are immutable', TRUE, 'REVIEWED'),
('answer_006_mike_q1_1', 'submission_004_mike_q1', 'q_001_py_var', 'choice_001_var_js', NULL, FALSE, 'REVIEWED'),
('answer_007_mike_q1_2', 'submission_004_mike_q1', 'q_002_py_compiled', 'choice_005_true', NULL, FALSE, 'REVIEWED'),
('answer_008_mike_q1_3', 'submission_004_mike_q1', 'q_003_py_print', 'choice_007_console', NULL, TRUE, 'REVIEWED');

-- ACHIEVEMENTS (prefix: "achieve")
INSERT INTO ACHIEVEMENTS (achievement_id, user_id, quiz_id, score, status) VALUES
('achieve_001_john_q1', 'user_001_john_doe', 'quiz_001_py_basics', 85.50, 'EARNED'),
('achieve_002_john_q2', 'user_001_john_doe', 'quiz_002_py_inter', 92.00, 'EARNED'),
('achieve_003_mike_q1', 'user_004_mike_wilson', 'quiz_001_py_basics', 78.00, 'EARNED'),
('achieve_004_alex_q1', 'user_008_alex_taylor', 'quiz_001_py_basics', 88.50, 'EARNED');

-- USER_MODULE_PROGRESS (prefix: "mod-progress")
INSERT INTO USER_MODULE_PROGRESS (progress_id, user_id, module_id, is_completed, progress_percentage, completion_date, time_spent_seconds, status) VALUES
('mod-progress_001_john_m1', 'user_001_john_doe', 'module_001_py_intro', TRUE, 100.00, '2024-01-10 11:45:00', 2700, 'COMPLETED'),
('mod-progress_002_john_m2', 'user_001_john_doe', 'module_002_py_vars', TRUE, 100.00, '2024-01-12 10:30:00', 1800, 'COMPLETED'),
('mod-progress_003_john_m3', 'user_001_john_doe', 'module_003_py_control', TRUE, 100.00, '2024-01-14 15:20:00', 3600, 'COMPLETED'),
('mod-progress_004_john_m4', 'user_001_john_doe', 'module_004_py_funcs', FALSE, 65.00, NULL, 1950, 'IN_PROGRESS'),
('mod-progress_005_mike_m1', 'user_004_mike_wilson', 'module_001_py_intro', TRUE, 100.00, '2024-01-16 09:00:00', 2400, 'COMPLETED'),
('mod-progress_006_mike_m2', 'user_004_mike_wilson', 'module_002_py_vars', FALSE, 45.00, NULL, 810, 'IN_PROGRESS'),
('mod-progress_007_alex_m1', 'user_008_alex_taylor', 'module_001_py_intro', TRUE, 100.00, '2024-01-20 14:00:00', 2550, 'COMPLETED'),
('mod-progress_008_alex_m2', 'user_008_alex_taylor', 'module_002_py_vars', TRUE, 100.00, '2024-01-21 10:15:00', 1650, 'COMPLETED'),
('mod-progress_009_alex_m5', 'user_008_alex_taylor', 'module_005_react_comp', FALSE, 30.00, NULL, 720, 'IN_PROGRESS');

-- COURSE_PROGRESS_SUMMARY (prefix: "summary")
INSERT INTO COURSE_PROGRESS_SUMMARY (summary_id, user_id, course_id, overall_progress_percentage, completed_modules, total_modules, completed_quizzes, total_quizzes, total_points_earned, status) VALUES
('summary_001_john_py', 'user_001_john_doe', 'course_001_intro_prog', 75.00, 3, 4, 2, 3, 170, 'ACTIVE'),
('summary_002_john_web', 'user_001_john_doe', 'course_002_adv_web', 25.00, 1, 4, 0, 2, 0, 'ACTIVE'),
('summary_003_john_ds', 'user_001_john_doe', 'course_003_data_sci', 100.00, 4, 4, 2, 2, 200, 'COMPLETED'),
('summary_004_mike_py', 'user_004_mike_wilson', 'course_001_intro_prog', 35.00, 1, 4, 1, 3, 78, 'ACTIVE'),
('summary_005_mike_ds', 'user_004_mike_wilson', 'course_003_data_sci', 15.00, 0, 4, 0, 2, 0, 'ACTIVE'),
('summary_006_alex_py', 'user_008_alex_taylor', 'course_001_intro_prog', 50.00, 2, 4, 1, 3, 88, 'ACTIVE'),
('summary_007_alex_web', 'user_008_alex_taylor', 'course_002_adv_web', 15.00, 0, 4, 0, 2, 0, 'ACTIVE'),
('summary_008_alex_sql', 'user_008_alex_taylor', 'course_005_db_sql', 10.00, 0, 3, 0, 2, 0, 'ACTIVE');

-- COURSE_ACCESS_LOG (prefix: "log")
INSERT INTO COURSE_ACCESS_LOG (log_id, user_id, course_id, ip_address, browser_info, status) VALUES
('log_001_john_py', 'user_001_john_doe', 'course_001_intro_prog', '192.168.1.100', 'Mozilla/5.0 Chrome/120.0', 'LOGGED'),
('log_002_john_web', 'user_001_john_doe', 'course_002_adv_web', '192.168.1.100', 'Mozilla/5.0 Chrome/120.0', 'LOGGED'),
('log_003_mike_py', 'user_004_mike_wilson', 'course_001_intro_prog', '10.0.0.50', 'Mozilla/5.0 Firefox/121.0', 'LOGGED'),
('log_004_alex_py', 'user_008_alex_taylor', 'course_001_intro_prog', '172.16.0.25', 'Mozilla/5.0 Safari/17.0', 'LOGGED'),
('log_005_sarah_web', 'user_005_sarah_jones', 'course_002_adv_web', '192.168.2.15', 'Mozilla/5.0 Edge/120.0', 'IGNORED'),
('log_006_emily_py', 'user_007_emily_davis', 'course_001_intro_prog', '10.0.1.75', 'Mozilla/5.0 Chrome/119.0', 'IGNORED');

-- ADMIN_ACCESS_LOG (prefix: "admin-log")
INSERT INTO ADMIN_ACCESS_LOG (log_id, user_id, action, details, ip_address, browser_info, status) VALUES
('admin-log_001_create_user', 'user_003_admin_user', 'user_create', 'Created new user: alex_taylor', '192.168.0.10', 'Mozilla/5.0 Chrome/120.0', 'LOGGED'),
('admin-log_002_update_course', 'user_003_admin_user', 'course_update', 'Updated course: Advanced Web Development', '192.168.0.10', 'Mozilla/5.0 Chrome/120.0', 'LOGGED'),
('admin-log_003_suspend_user', 'user_003_admin_user', 'user_suspend', 'Suspended user: emily_davis', '192.168.0.10', 'Mozilla/5.0 Chrome/120.0', 'LOGGED'),
('admin-log_004_create_quiz', 'user_002_jane_smith', 'quiz_create', 'Created new quiz for course 2', '172.16.1.20', 'Mozilla/5.0 Firefox/121.0', 'LOGGED'),
('admin-log_005_unauth_access', 'user_006_robert_brown', 'course_view', 'Attempted to view admin panel', '10.0.0.100', 'Mozilla/5.0 Safari/17.0', 'REVIEWED');