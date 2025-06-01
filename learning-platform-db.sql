-- Learning Platform Database Schema and Sample Data
-- All primary keys are VARCHAR(225), all tables include status field, COURSES includes name field

-- Create Tables with Updated Schema

CREATE TABLE USERS (
    user_id VARCHAR(225) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('STUDENT', 'INSTRUCTOR', 'ADMIN') DEFAULT 'STUDENT',
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED', 'DELETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE WELCOME_TEMPLATES (
    template_id VARCHAR(225) PRIMARY KEY,
    description TEXT,
    base_content TEXT,
    status ENUM('active', 'inactive', 'draft', 'archived') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE COURSES (
    course_id VARCHAR(225) PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    welcome_fk VARCHAR(225),
    welcome_mode VARCHAR(50),
    welcome_stylesheet TEXT,
    welcome_template_id VARCHAR(225),
    status ENUM('active', 'inactive', 'draft', 'archived') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (welcome_template_id) REFERENCES WELCOME_TEMPLATES(template_id)
);

CREATE TABLE CONTENT_BLOCKS (
    block_id VARCHAR(225) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    status ENUM('active', 'inactive', 'deprecated') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE COURSE_CONTENT_BLOCKS (
    content_id VARCHAR(225) PRIMARY KEY,
    course_fk VARCHAR(225) NOT NULL,
    block_id VARCHAR(225) NOT NULL,
    position INT DEFAULT 0,
    file VARCHAR(255),
    description TEXT,
    base_url VARCHAR(255),
    welcome_file_path VARCHAR(255),
    is_enabled BOOLEAN DEFAULT TRUE,
    status ENUM('active', 'inactive', 'hidden') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_fk) REFERENCES COURSES(course_id),
    FOREIGN KEY (block_id) REFERENCES CONTENT_BLOCKS(block_id)
);

CREATE TABLE COURSE_LEVELS (
    level_id VARCHAR(225) PRIMARY KEY,
    course_id VARCHAR(225) NOT NULL,
    name VARCHAR(100) NOT NULL,
    rank INT NOT NULL,
    status ENUM('active', 'inactive', 'locked') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

CREATE TABLE COURSE_MODULES (
    module_id VARCHAR(225) PRIMARY KEY,
    course_id VARCHAR(225) NOT NULL,
    level_id VARCHAR(225) NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    sequence_order INT DEFAULT 0,
    content_type VARCHAR(50),
    content_url VARCHAR(255),
    estimated_duration_minutes INT,
    is_required BOOLEAN DEFAULT TRUE,
    status ENUM('active', 'inactive', 'maintenance') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id),
    FOREIGN KEY (level_id) REFERENCES COURSE_LEVELS(level_id)
);

CREATE TABLE QUIZZES (
    quiz_id VARCHAR(225) PRIMARY KEY,
    course_id VARCHAR(225) NOT NULL,
    level_id VARCHAR(225) NOT NULL,
    file VARCHAR(255),
    is_final BOOLEAN DEFAULT FALSE,
    time_and_minutes INT DEFAULT 30,
    status ENUM('active', 'inactive', 'draft') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id),
    FOREIGN KEY (level_id) REFERENCES COURSE_LEVELS(level_id)
);

CREATE TABLE QUESTIONS (
    question_id VARCHAR(225) PRIMARY KEY,
    quiz_id VARCHAR(225) NOT NULL,
    content TEXT NOT NULL,
    type ENUM('MULTIPLE_CHOICE', 'TRUE_FALSE', 'SHORT_ANSWER') DEFAULT 'MULTIPLE_CHOICE',
    points INT DEFAULT 1,
    status ENUM('ACTIVE', 'INACTIVE', 'REVIEW') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (quiz_id) REFERENCES QUIZZES(quiz_id)
);

CREATE TABLE CHOICES (
    choice_id VARCHAR(225) PRIMARY KEY,
    question_id VARCHAR(225) NOT NULL,
    content TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (question_id) REFERENCES QUESTIONS(question_id)
);

CREATE TABLE ACHIEVEMENTS (
    achievement_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    quiz_id VARCHAR(225) NOT NULL,
    score DECIMAL(5,2),
    achieved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'revoked') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (quiz_id) REFERENCES QUIZZES(quiz_id)
);

CREATE TABLE QUIZ_SUBMISSIONS (
    submission_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    quiz_id VARCHAR(225) NOT NULL,
    completed_at TIMESTAMP,
    score DECIMAL(5,2),
    status ENUM('IN_PROGRESS', 'COMPLETED', 'ABANDONED') DEFAULT 'IN_PROGRESS',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (quiz_id) REFERENCES QUIZZES(quiz_id)
);

CREATE TABLE USER_ANSWERS (
    user_answer_id VARCHAR(225) PRIMARY KEY,
    submission_id VARCHAR(225) NOT NULL,
    question_id VARCHAR(225) NOT NULL,
    choice_id VARCHAR(225),
    answer_text TEXT,
    is_correct BOOLEAN DEFAULT FALSE,
    answered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('active', 'flagged') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (submission_id) REFERENCES QUIZ_SUBMISSIONS(submission_id),
    FOREIGN KEY (question_id) REFERENCES QUESTIONS(question_id),
    FOREIGN KEY (choice_id) REFERENCES CHOICES(choice_id)
);

CREATE TABLE COURSE_ENROLLMENTS (
    enrollment_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    course_id VARCHAR(225) NOT NULL,
    status ENUM('ACTIVE', 'COMPLETED', 'DROPPED', 'SUSPENDED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

CREATE TABLE COURSE_ACCESS_LOG (
    log_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    course_id VARCHAR(225) NOT NULL,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    browser_info VARCHAR(255),
    status ENUM('SUCCESS', 'FAILED', 'BLOCKED') DEFAULT 'SUCCESS',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

CREATE TABLE ADMIN_ACCESS_LOG (
    log_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    action VARCHAR(100),
    details TEXT,
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    browser_info VARCHAR(255),
    status ENUM('SUCCESS', 'FAILED', 'UNAUTHORIZED') DEFAULT 'SUCCESS',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE USER_MODULE_PROGRESS (
    progress_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    module_id VARCHAR(225) NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    progress_percentage DECIMAL(5,2) DEFAULT 0.00,
    completion_date TIMESTAMP NULL,
    time_spent_seconds INT DEFAULT 0,
    last_accessed TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'PAUSED', 'COMPLETED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (module_id) REFERENCES COURSE_MODULES(module_id)
);

CREATE TABLE COURSE_PROGRESS_SUMMARY (
    summary_id VARCHAR(225) PRIMARY KEY,
    user_id VARCHAR(225) NOT NULL,
    course_id VARCHAR(225) NOT NULL,
    overall_progress_percentage DECIMAL(5,2) DEFAULT 0.00,
    completed_modules INT DEFAULT 0,
    total_modules INT DEFAULT 0,
    completed_quizzes INT DEFAULT 0,
    total_quizzes INT DEFAULT 0,
    total_points_earned INT DEFAULT 0,
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'COMPLETED', 'ARCHIVED') DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES USERS(user_id),
    FOREIGN KEY (course_id) REFERENCES COURSES(course_id)
);

-- Insert Sample Data (using UUIDs for primary keys)

-- USERS
INSERT INTO USERS (user_id, username, email, password_hash, role, status) VALUES
('USR_001_john_doe', 'john_doe', 'john.doe@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'ACTIVE'),
('USR_002_jane_smith', 'jane_smith', 'jane.smith@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'INSTRUCTOR', 'ACTIVE'),
('USR_003_admin_user', 'admin_user', 'admin@platform.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'ADMIN', 'ACTIVE'),
('USR_004_mike_wilson', 'mike_wilson', 'mike.wilson@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'ACTIVE'),
('USR_005_sarah_jones', 'sarah_jones', 'sarah.jones@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'INACTIVE'),
('USR_006_robert_brown', 'robert_brown', 'robert.brown@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'INSTRUCTOR', 'ACTIVE'),
('USR_007_emily_davis', 'emily_davis', 'emily.davis@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'SUSPENDED'),
('USR_008_alex_taylor', 'alex_taylor', 'alex.taylor@email.com', '$2b$10$YmVhc2VkNjQgZW5jb2RlZCBwYXNzd29yZA==', 'STUDENT', 'ACTIVE');

-- WELCOME_TEMPLATES
INSERT INTO WELCOME_TEMPLATES (template_id, description, base_content, status) VALUES
('TMPL_001_standard', 'Standard Welcome Template', '<h1>Welcome to {{course_name}}!</h1><p>We are excited to have you here.</p>', 'active'),
('TMPL_002_premium', 'Premium Welcome Template', '<div class="premium-welcome"><h1>Welcome to {{course_name}}</h1><p>Your journey begins now!</p></div>', 'active'),
('TMPL_003_minimal', 'Minimal Welcome Template', '<h2>{{course_name}}</h2><p>Let\'s get started.</p>', 'active'),
('TMPL_004_interactive', 'Interactive Welcome Template', '<div class="interactive"><h1>Welcome!</h1><button>Start Learning</button></div>', 'draft');

-- COURSES
INSERT INTO COURSES (course_id, name, description, welcome_fk, welcome_mode, welcome_stylesheet, welcome_template_id, status) VALUES
('CRS_001_intro_prog', 'Introduction to Programming', 'Learn the basics of programming with Python', 'TMPL_001_standard', 'standard', 'body { font-family: Arial; }', 'TMPL_001_standard', 'active'),
('CRS_002_adv_web', 'Advanced Web Development', 'Master modern web technologies including React and Node.js', 'TMPL_002_premium', 'premium', 'body { background: #f0f0f0; }', 'TMPL_002_premium', 'active'),
('CRS_003_data_sci', 'Data Science Fundamentals', 'Explore data analysis, visualization, and machine learning basics', 'TMPL_001_standard', 'standard', 'body { color: #333; }', 'TMPL_001_standard', 'active'),
('CRS_004_mobile_dev', 'Mobile App Development', 'Build iOS and Android applications using React Native', 'TMPL_003_minimal', 'minimal', NULL, 'TMPL_003_minimal', 'draft'),
('CRS_005_db_sql', 'Database Design and SQL', 'Master relational databases and SQL queries', 'TMPL_001_standard', 'standard', 'body { font-size: 16px; }', 'TMPL_001_standard', 'active'),
('CRS_006_cloud_comp', 'Cloud Computing Essentials', 'Learn AWS, Azure, and Google Cloud Platform', 'TMPL_002_premium', 'premium', 'body { margin: 20px; }', 'TMPL_002_premium', 'inactive');

-- CONTENT_BLOCKS
INSERT INTO CONTENT_BLOCKS (block_id, name, description, status) VALUES
('BLK_001_video', 'Video Lectures', 'Video content for course modules', 'active'),
('BLK_002_reading', 'Reading Materials', 'PDF and text-based learning resources', 'active'),
('BLK_003_code', 'Code Examples', 'Sample code and programming exercises', 'active'),
('BLK_004_labs', 'Interactive Labs', 'Hands-on practice environments', 'active'),
('BLK_005_quiz', 'Quizzes', 'Assessment and knowledge checks', 'active'),
('BLK_006_forum', 'Discussion Forums', 'Community interaction and Q&A', 'active'),
('BLK_007_project', 'Project Templates', 'Starter code for course projects', 'active'),
('BLK_008_external', 'External Resources', 'Links to additional learning materials', 'deprecated');

-- COURSE_CONTENT_BLOCKS
INSERT INTO COURSE_CONTENT_BLOCKS (content_id, course_fk, block_id, position, file, description, base_url, welcome_file_path, is_enabled, status) VALUES
('CCB_001_py_intro_vid', 'CRS_001_intro_prog', 'BLK_001_video', 1, 'intro_video.mp4', 'Introduction video for Python basics', 'https://cdn.example.com/courses/1/', '/welcome/intro.html', TRUE, 'active'),
('CCB_002_py_basics_read', 'CRS_001_intro_prog', 'BLK_002_reading', 2, 'python_basics.pdf', 'Python fundamentals reading material', 'https://cdn.example.com/courses/1/', NULL, TRUE, 'active'),
('CCB_003_py_hello', 'CRS_001_intro_prog', 'BLK_003_code', 3, 'hello_world.py', 'First Python program example', 'https://cdn.example.com/courses/1/', NULL, TRUE, 'active'),
('CCB_004_react_intro', 'CRS_002_adv_web', 'BLK_001_video', 1, 'react_intro.mp4', 'Introduction to React framework', 'https://cdn.example.com/courses/2/', '/welcome/react.html', TRUE, 'active'),
('CCB_005_react_lab', 'CRS_002_adv_web', 'BLK_004_labs', 2, NULL, 'React development environment setup', 'https://labs.example.com/react/', NULL, TRUE, 'active'),
('CCB_006_ds_overview', 'CRS_003_data_sci', 'BLK_001_video', 1, 'data_science_overview.mp4', 'Overview of data science field', 'https://cdn.example.com/courses/3/', NULL, TRUE, 'active'),
('CCB_007_stats_basics', 'CRS_003_data_sci', 'BLK_002_reading', 2, 'statistics_basics.pdf', 'Statistical concepts for data science', 'https://cdn.example.com/courses/3/', NULL, TRUE, 'active'),
('CCB_008_mobile_intro', 'CRS_004_mobile_dev', 'BLK_001_video', 1, 'mobile_dev_intro.mp4', 'Mobile development introduction', 'https://cdn.example.com/courses/4/', NULL, FALSE, 'inactive');

-- COURSE_LEVELS
INSERT INTO COURSE_LEVELS (level_id, course_id, name, rank, status) VALUES
('LVL_001_py_begin', 'CRS_001_intro_prog', 'Beginner', 1, 'active'),
('LVL_002_py_inter', 'CRS_001_intro_prog', 'Intermediate', 2, 'active'),
('LVL_003_py_adv', 'CRS_001_intro_prog', 'Advanced', 3, 'active'),
('LVL_004_web_found', 'CRS_002_adv_web', 'Foundation', 1, 'active'),
('LVL_005_web_prof', 'CRS_002_adv_web', 'Professional', 2, 'active'),
('LVL_006_ds_basics', 'CRS_003_data_sci', 'Basics', 1, 'active'),
('LVL_007_ds_applied', 'CRS_003_data_sci', 'Applied Concepts', 2, 'active'),
('LVL_008_mob_start', 'CRS_004_mobile_dev', 'Getting Started', 1, 'locked'),
('LVL_009_sql_fund', 'CRS_005_db_sql', 'SQL Fundamentals', 1, 'active'),
('LVL_010_sql_adv', 'CRS_005_db_sql', 'Advanced Queries', 2, 'active');

-- COURSE_MODULES
INSERT INTO COURSE_MODULES (module_id, course_id, level_id, title, description, sequence_order, content_type, content_url, estimated_duration_minutes, is_required, status) VALUES
('MOD_001_py_intro', 'CRS_001_intro_prog', 'LVL_001_py_begin', 'Introduction to Python', 'Learn Python syntax and basic concepts', 1, 'video', '/videos/python_intro.mp4', 45, TRUE, 'active'),
('MOD_002_py_vars', 'CRS_001_intro_prog', 'LVL_001_py_begin', 'Variables and Data Types', 'Understanding Python data types', 2, 'video', '/videos/python_datatypes.mp4', 30, TRUE, 'active'),
('MOD_003_py_control', 'CRS_001_intro_prog', 'LVL_001_py_begin', 'Control Flow', 'If statements and loops in Python', 3, 'interactive', '/labs/control_flow', 60, TRUE, 'active'),
('MOD_004_py_funcs', 'CRS_001_intro_prog', 'LVL_002_py_inter', 'Functions and Modules', 'Creating reusable code', 1, 'video', '/videos/python_functions.mp4', 50, TRUE, 'active'),
('MOD_005_react_comp', 'CRS_002_adv_web', 'LVL_004_web_found', 'React Components', 'Building React components', 1, 'video', '/videos/react_components.mp4', 40, TRUE, 'active'),
('MOD_006_react_state', 'CRS_002_adv_web', 'LVL_004_web_found', 'State Management', 'Managing application state', 2, 'interactive', '/labs/react_state', 90, TRUE, 'active'),
('MOD_007_data_viz', 'CRS_003_data_sci', 'LVL_006_ds_basics', 'Data Visualization', 'Creating charts and graphs', 1, 'video', '/videos/data_viz.mp4', 55, TRUE, 'active'),
('MOD_008_pandas', 'CRS_003_data_sci', 'LVL_006_ds_basics', 'Pandas Basics', 'Data manipulation with Pandas', 2, 'interactive', '/labs/pandas_intro', 75, FALSE, 'active');

-- QUIZZES
INSERT INTO QUIZZES (quiz_id, course_id, level_id, file, is_final, time_and_minutes, status) VALUES
('QZ_001_py_basics', 'CRS_001_intro_prog', 'LVL_001_py_begin', 'python_basics_quiz.json', FALSE, 20, 'active'),
('QZ_002_py_inter', 'CRS_001_intro_prog', 'LVL_002_py_inter', 'python_intermediate_quiz.json', FALSE, 30, 'active'),
('QZ_003_py_final', 'CRS_001_intro_prog', 'LVL_003_py_adv', 'python_final_exam.json', TRUE, 60, 'active'),
('QZ_004_react_found', 'CRS_002_adv_web', 'LVL_004_web_found', 'react_foundation_quiz.json', FALSE, 25, 'active'),
('QZ_005_react_final', 'CRS_002_adv_web', 'LVL_005_web_prof', 'react_final_exam.json', TRUE, 90, 'draft'),
('QZ_006_ds_basics', 'CRS_003_data_sci', 'LVL_006_ds_basics', 'data_science_basics_quiz.json', FALSE, 30, 'active'),
('QZ_007_sql_basics', 'CRS_005_db_sql', 'LVL_009_sql_fund', 'sql_basics_quiz.json', FALSE, 25, 'active'),
('QZ_008_sql_adv', 'CRS_005_db_sql', 'LVL_010_sql_adv', 'sql_advanced_quiz.json', TRUE, 45, 'active');

-- QUESTIONS
INSERT INTO QUESTIONS (question_id, quiz_id, content, type, points, status) VALUES
('QST_001_py_var', 'QZ_001_py_basics', 'What is the correct way to declare a variable in Python?', 'MULTIPLE_CHOICE', 2, 'ACTIVE'),
('QST_002_py_compiled', 'QZ_001_py_basics', 'Python is a compiled language.', 'TRUE_FALSE', 1, 'ACTIVE'),
('QST_003_py_print', 'QZ_001_py_basics', 'What does the print() function do?', 'MULTIPLE_CHOICE', 2, 'ACTIVE'),
('QST_004_py_list', 'QZ_002_py_inter', 'What is a Python list?', 'MULTIPLE_CHOICE', 3, 'ACTIVE'),
('QST_005_py_diff', 'QZ_002_py_inter', 'Explain the difference between a list and a tuple.', 'SHORT_ANSWER', 5, 'ACTIVE'),
('QST_006_oop', 'QZ_003_py_final', 'What is object-oriented programming?', 'MULTIPLE_CHOICE', 4, 'ACTIVE'),
('QST_007_jsx', 'QZ_004_react_found', 'What is JSX in React?', 'MULTIPLE_CHOICE', 3, 'ACTIVE'),
('QST_008_react_multi', 'QZ_004_react_found', 'React components must always return multiple elements.', 'TRUE_FALSE', 2, 'ACTIVE');

-- CHOICES
INSERT INTO CHOICES (choice_id, question_id, content, is_correct, status) VALUES
('CHC_001_var_js', 'QST_001_py_var', 'var x = 5', FALSE, 'active'),
('CHC_002_py_correct', 'QST_001_py_var', 'x = 5', TRUE, 'active'),
('CHC_003_let', 'QST_001_py_var', 'let x = 5', FALSE, 'active'),
('CHC_004_declare', 'QST_001_py_var', 'declare x = 5', FALSE, 'active'),
('CHC_005_true', 'QST_002_py_compiled', 'True', FALSE, 'active'),
('CHC_006_false', 'QST_002_py_compiled', 'False', TRUE, 'active'),
('CHC_007_console', 'QST_003_py_print', 'It displays output to the console', TRUE, 'active'),
('CHC_008_input', 'QST_003_py_print', 'It reads input from the user', FALSE, 'active'),
('CHC_009_variable', 'QST_003_py_print', 'It creates a new variable', FALSE, 'active'),
('CHC_010_import', 'QST_003_py_print', 'It imports a module', FALSE, 'active'),
('CHC_011_ordered', 'QST_004_py_list', 'An ordered, mutable collection', TRUE, 'active'),
('CHC_012_immutable', 'QST_004_py_list', 'An ordered, immutable collection', FALSE, 'active'),
('CHC_013_unordered', 'QST_004_py_list', 'An unordered collection', FALSE, 'active'),
('CHC_014_jsx_xml', 'QST_007_jsx', 'JavaScript XML', TRUE, 'active'),
('CHC_015_jsx_ext', 'QST_007_jsx', 'JavaScript Extension', FALSE, 'active'),
('CHC_016_java_ext', 'QST_007_jsx', 'Java Syntax Extension', FALSE, 'active'),
('CHC_017_react_true', 'QST_008_react_multi', 'True', FALSE, 'active'),
('CHC_018_react_false', 'QST_008_react_multi', 'False', TRUE, 'active');

-- COURSE_ENROLLMENTS
INSERT INTO COURSE_ENROLLMENTS (enrollment_id, user_id, course_id, status) VALUES
('ENR_001_john_py', 'USR_001_john_doe', 'CRS_001_intro_prog', 'ACTIVE'),
('ENR_002_john_web', 'USR_001_john_doe', 'CRS_002_adv_web', 'ACTIVE'),
('ENR_003_john_ds', 'USR_001_john_doe', 'CRS_003_data_sci', 'COMPLETED'),
('ENR_004_mike_py', 'USR_004_mike_wilson', 'CRS_001_intro_prog', 'ACTIVE'),
('ENR_005_mike_ds', 'USR_004_mike_wilson', 'CRS_003_data_sci', 'ACTIVE'),
('ENR_006_sarah_web', 'USR_005_sarah_jones', 'CRS_002_adv_web', 'DROPPED'),
('ENR_007_emily_py', 'USR_007_emily_davis', 'CRS_001_intro_prog', 'SUSPENDED'),
('ENR_008_alex_py', 'USR_008_alex_taylor', 'CRS_001_intro_prog', 'ACTIVE'),
('ENR_009_alex_web', 'USR_008_alex_taylor', 'CRS_002_adv_web', 'ACTIVE'),
('ENR_010_alex_sql', 'USR_008_alex_taylor', 'CRS_005_db_sql', 'ACTIVE');

-- QUIZ_SUBMISSIONS
INSERT INTO QUIZ_SUBMISSIONS (submission_id, user_id, quiz_id, completed_at, score, status) VALUES
('SUB_001_john_q1', 'USR_001_john_doe', 'QZ_001_py_basics', '2024-01-15 10:30:00', 85.50, 'COMPLETED'),
('SUB_002_john_q2', 'USR_001_john_doe', 'QZ_002_py_inter', '2024-01-20 14:45:00', 92.00, 'COMPLETED'),
('SUB_003_john_q3', 'USR_001_john_doe', 'QZ_003_py_final', NULL, NULL, 'IN_PROGRESS'),
('SUB_004_mike_q1', 'USR_004_mike_wilson', 'QZ_001_py_basics', '2024-01-18 09:15:00', 78.00, 'COMPLETED'),
('SUB_005_alex_q1', 'USR_008_alex_taylor', 'QZ_001_py_basics', '2024-01-22 16:20:00', 88.50, 'COMPLETED'),
('SUB_006_alex_q4', 'USR_008_alex_taylor', 'QZ_004_react_found', NULL, NULL, 'ABANDONED');

-- USER_ANSWERS
INSERT INTO USER_ANSWERS (user_answer_id, submission_id, question_id, choice_id, answer_text, is_correct, status) VALUES
('ANS_001_john_q1_1', 'SUB_001_john_q1', 'QST_001_py_var', 'CHC_002_py_correct', NULL, TRUE, 'active'),
('ANS_002_john_q1_2', 'SUB_001_john_q1', 'QST_002_py_compiled', 'CHC_006_false', NULL, TRUE, 'active'),
('ANS_003_john_q1_3', 'SUB_001_john_q1', 'QST_003_py_print', 'CHC_007_console', NULL, TRUE, 'active'),
('ANS_004_john_q2_1', 'SUB_002_john_q2', 'QST_004_py_list', 'CHC_011_ordered', NULL, TRUE, 'active'),
('ANS_005_john_q2_2', 'SUB_002_john_q2', 'QST_005_py_diff', NULL, 'Lists are mutable and can be changed, tuples are immutable', TRUE, 'active'),
('ANS_006_mike_q1_1', 'SUB_004_mike_q1', 'QST_001_py_var', 'CHC_001_var_js', NULL, FALSE, 'active'),
('ANS_007_mike_q1_2', 'SUB_004_mike_q1', 'QST_002_py_compiled', 'CHC_005_true', NULL, FALSE, 'active'),
('ANS_008_mike_q1_3', 'SUB_004_mike_q1', 'QST_003_py_print', 'CHC_007_console', NULL, TRUE, 'active');

-- ACHIEVEMENTS
INSERT INTO ACHIEVEMENTS (achievement_id, user_id, quiz_id, score, status) VALUES
('ACH_001_john_q1', 'USR_001_john_doe', 'QZ_001_py_basics', 85.50, 'active'),
('ACH_002_john_q2', 'USR_001_john_doe', 'QZ_002_py_inter', 92.00, 'active'),
('ACH_003_mike_q1', 'USR_004_mike_wilson', 'QZ_001_py_basics', 78.00, 'active'),
('ACH_004_alex_q1', 'USR_008_alex_taylor', 'QZ_001_py_basics', 88.50, 'active');

-- USER_MODULE_PROGRESS
INSERT INTO USER_MODULE_PROGRESS (progress_id, user_id, module_id, is_completed, progress_percentage, completion_date, time_spent_seconds, status) VALUES
('PRG_001_john_m1', 'USR_001_john_doe', 'MOD_001_py_intro', TRUE, 100.00, '2024-01-10 11:45:00', 2700, 'COMPLETED'),
('PRG_002_john_m2', 'USR_001_john_doe', 'MOD_002_py_vars', TRUE, 100.00, '2024-01-12 10:30:00', 1800, 'COMPLETED'),
('PRG_003_john_m3', 'USR_001_john_doe', 'MOD_003_py_control', TRUE, 100.00, '2024-01-14 15:20:00', 3600, 'COMPLETED'),
('PRG_004_john_m4', 'USR_001_john_doe', 'MOD_004_py_funcs', FALSE, 65.00, NULL, 1950, 'ACTIVE'),
('PRG_005_mike_m1', 'USR_004_mike_wilson', 'MOD_001_py_intro', TRUE, 100.00, '2024-01-16 09:00:00', 2400, 'COMPLETED'),
('PRG_006_mike_m2', 'USR_004_mike_wilson', 'MOD_002_py_vars', FALSE, 45.00, NULL, 810, 'PAUSED'),
('PRG_007_alex_m1', 'USR_008_alex_taylor', 'MOD_001_py_intro', TRUE, 100.00, '2024-01-20 14:00:00', 2550, 'COMPLETED'),
('PRG_008_alex_m2', 'USR_008_alex_taylor', 'MOD_002_py_vars', TRUE, 100.00, '2024-01-21 10:15:00', 1650, 'COMPLETED'),
('PRG_009_alex_m5', 'USR_008_alex_taylor', 'MOD_005_react_comp', FALSE, 30.00, NULL, 720, 'ACTIVE');

-- COURSE_PROGRESS_SUMMARY
INSERT INTO COURSE_PROGRESS_SUMMARY (summary_id, user_id, course_id, overall_progress_percentage, completed_modules, total_modules, completed_quizzes, total_quizzes, total_points_earned, status) VALUES
('SUM_001_john_py', 'USR_001_john_doe', 'CRS_001_intro_prog', 75.00, 3, 4, 2, 3, 170, 'ACTIVE'),
('SUM_002_john_web', 'USR_001_john_doe', 'CRS_002_adv_web', 25.00, 1, 4, 0, 2, 0, 'ACTIVE'),
('SUM_003_john_ds', 'USR_001_john_doe', 'CRS_003_data_sci', 100.00, 4, 4, 2, 2, 200, 'COMPLETED'),
('SUM_004_mike_py', 'USR_004_mike_wilson', 'CRS_001_intro_prog', 35.00, 1, 4, 1, 3, 78, 'ACTIVE'),
('SUM_005_mike_ds', 'USR_004_mike_wilson', 'CRS_003_data_sci', 15.00, 0, 4, 0, 2, 0, 'ACTIVE'),
('SUM_006_alex_py', 'USR_008_alex_taylor', 'CRS_001_intro_prog', 50.00, 2, 4, 1, 3, 88, 'ACTIVE'),
('SUM_007_alex_web', 'USR_008_alex_taylor', 'CRS_002_adv_web', 15.00, 0, 4, 0, 2, 0, 'ACTIVE'),
('SUM_008_alex_sql', 'USR_008_alex_taylor', 'CRS_005_db_sql', 10.00, 0, 3, 0, 2, 0, 'ACTIVE');

-- COURSE_ACCESS_LOG (Sample recent entries)
INSERT INTO COURSE_ACCESS_LOG (log_id, user_id, course_id, ip_address, browser_info, status) VALUES
('LOG_001_john_py', 'USR_001_john_doe', 'CRS_001_intro_prog', '192.168.1.100', 'Mozilla/5.0 Chrome/120.0', 'SUCCESS'),
('LOG_002_john_web', 'USR_001_john_doe', 'CRS_002_adv_web', '192.168.1.100', 'Mozilla/5.0 Chrome/120.0', 'SUCCESS'),
('LOG_003_mike_py', 'USR_004_mike_wilson', 'CRS_001_intro_prog', '10.0.0.50', 'Mozilla/5.0 Firefox/121.0', 'SUCCESS'),
('LOG_004_alex_py', 'USR_008_alex_taylor', 'CRS_001_intro_prog', '172.16.0.25', 'Mozilla/5.0 Safari/17.0', 'SUCCESS'),
('LOG_005_sarah_web', 'USR_005_sarah_jones', 'CRS_002_adv_web', '192.168.2.15', 'Mozilla/5.0 Edge/120.0', 'FAILED'),
('LOG_006_emily_py', 'USR_007_emily_davis', 'CRS_001_intro_prog', '10.0.1.75', 'Mozilla/5.0 Chrome/119.0', 'BLOCKED');

-- ADMIN_ACCESS_LOG (Sample admin actions)
INSERT INTO ADMIN_ACCESS_LOG (log_id, user_id, action, details, ip_address, browser_info, status) VALUES
('ADM_001_create_user', 'USR_003_admin_user', 'user_create', 'Created new user: alex_taylor', '192.168.0.10', 'Mozilla/5.0 Chrome/120.0', 'SUCCESS'),
('ADM_002_update_course', 'USR_003_admin_user', 'course_update', 'Updated course: Advanced Web Development', '192.168.0.10', 'Mozilla/5.0 Chrome/120.0', 'SUCCESS'),
('ADM_003_suspend_user', 'USR_003_admin_user', 'user_suspend', 'Suspended user: emily_davis', '192.168.0.10', 'Mozilla/5.0 Chrome/120.0', 'SUCCESS'),
('ADM_004_create_quiz', 'USR_002_jane_smith', 'quiz_create', 'Created new quiz for course 2', '172.16.1.20', 'Mozilla/5.0 Firefox/121.0', 'SUCCESS'),
('ADM_005_unauth_access', 'USR_006_robert_brown', 'course_view', 'Attempted to view admin panel', '10.0.0.100', 'Mozilla/5.0 Safari/17.0', 'UNAUTHORIZED');