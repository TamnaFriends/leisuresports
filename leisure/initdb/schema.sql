CREATE DATABASE leisure_user_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE leisure_reservation_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE leisure_course_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE DATABASE leisure_community_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE leisure_user_db;
CREATE TABLE users (
  user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  nickname VARCHAR(40) NOT NULL UNIQUE,
  birthday CHAR(8),
  gender CHAR(1),
  agreements_json JSON,
  mfa_enabled BOOLEAN DEFAULT FALSE,
  mfa_secret VARCHAR(255),
  status VARCHAR(20) DEFAULT 'active',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME,
  recovery_codes VARCHAR(512)
);
CREATE TABLE agreements (
  agreement_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  type VARCHAR(50) NOT NULL,
  agreed BOOLEAN NOT NULL,
  agreed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  ip VARCHAR(45),
  user_agent VARCHAR(255),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

USE leisure_reservation_db;
CREATE TABLE reservations (
  reservation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  course_id BIGINT NOT NULL,
  reserved_date DATE NOT NULL,
  reserved_time TIME,
  status VARCHAR(20) DEFAULT 'active',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  -- FOREIGN KEY (user_id) REFERENCES leisure_user_db.users(user_id)
  -- FOREIGN KEY (course_id) REFERENCES leisure_course_db.courses(course_id)
);
CREATE TABLE favorites (
  favorite_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  content_id BIGINT NOT NULL,
  content_type VARCHAR(20) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_fav (user_id, content_id, content_type)
);

USE leisure_course_db;
CREATE TABLE courses (
  course_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(100) NOT NULL,
  description TEXT,
  type VARCHAR(20),
  barrier_free BOOLEAN DEFAULT FALSE,
  difficulty VARCHAR(20),
  location POINT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE course_reviews (
  review_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  course_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  rating INT,
  text TEXT,
  tip TEXT,
  danger_zone TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  -- FOREIGN KEY (course_id) REFERENCES courses(course_id)
  -- FOREIGN KEY (user_id) REFERENCES leisure_user_db.users(user_id)
);
CREATE TABLE course_records (
  record_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  course_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  path JSON,
  duration INT,
  distance DOUBLE,
  photo_urls JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  -- FOREIGN KEY (course_id) REFERENCES courses(course_id)
  -- FOREIGN KEY (user_id) REFERENCES leisure_user_db.users(user_id)
);

USE leisure_community_db;
CREATE TABLE community_posts (
  post_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  title VARCHAR(100) NOT NULL,
  content TEXT,
  post_type VARCHAR(20),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  -- FOREIGN KEY (user_id) REFERENCES leisure_user_db.users(user_id)
);
CREATE TABLE community_comments (
  comment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  post_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  content TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  -- FOREIGN KEY (post_id) REFERENCES community_posts(post_id)
  -- FOREIGN KEY (user_id) REFERENCES leisure_user_db.users(user_id)
);
