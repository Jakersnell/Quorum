-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema quorum
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `quorum` ;

-- -----------------------------------------------------
-- Schema quorum
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `quorum` DEFAULT CHARACTER SET utf8 ;
USE `quorum` ;

-- -----------------------------------------------------
-- Table `school`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `school` ;

CREATE TABLE IF NOT EXISTS `school` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `description` TEXT NULL,
  `created_on` DATE NULL,
  `last_update` DATE NULL,
  `founded_in` YEAR NULL,
  `image_url` VARCHAR(2000) NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(60) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `created_on` DATETIME NOT NULL,
  `email` VARCHAR(350) NULL,
  `last_update` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL,
  `role` VARCHAR(45) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `biography` TEXT NULL,
  `date_of_birth` DATE NULL,
  `profile_image_url` VARCHAR(2000) NULL,
  `school_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `fk_user_school1_idx` (`school_id` ASC),
  CONSTRAINT `fk_user_school1`
    FOREIGN KEY (`school_id`)
    REFERENCES `school` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `professor` ;

CREATE TABLE IF NOT EXISTS `professor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NULL,
  `school_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_professor_school1_idx` (`school_id` ASC),
  CONSTRAINT `fk_professor_school1`
    FOREIGN KEY (`school_id`)
    REFERENCES `school` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `course` ;

CREATE TABLE IF NOT EXISTS `course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `created_on` DATETIME NOT NULL,
  `last_update` DATETIME NOT NULL,
  `date_start` DATE NOT NULL,
  `date_end` DATE NULL,
  `school_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  `days_of_week` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_class_school1_idx` (`school_id` ASC),
  INDEX `fk_class_professor1_idx` (`professor_id` ASC),
  CONSTRAINT `fk_class_school1`
    FOREIGN KEY (`school_id`)
    REFERENCES `school` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_class_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `professor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `social_group` ;

CREATE TABLE IF NOT EXISTS `social_group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `owner_id` INT NOT NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `owner_idx` (`owner_id` ASC),
  CONSTRAINT `owner`
    FOREIGN KEY (`owner_id`)
    REFERENCES `user` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_post` ;

CREATE TABLE IF NOT EXISTS `group_post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(60) NOT NULL,
  `contents` TEXT NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `user_id` INT NOT NULL,
  `social_group_id` INT NOT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_post_user1_idx` (`user_id` ASC),
  INDEX `fk_group_post_social_group1_idx` (`social_group_id` ASC),
  CONSTRAINT `fk_group_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_post_social_group1`
    FOREIGN KEY (`social_group_id`)
    REFERENCES `social_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planner_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `planner_item` ;

CREATE TABLE IF NOT EXISTS `planner_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(200) NULL,
  `start_time` DATETIME NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `user_id` INT NOT NULL,
  `end_time` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_planner_item_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_planner_item_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contents` VARCHAR(500) NULL,
  `created_on` DATETIME NULL,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`sender_id` ASC),
  INDEX `fk_message_user2_idx` (`receiver_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `social_group_member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `social_group_member` ;

CREATE TABLE IF NOT EXISTS `social_group_member` (
  `user_id` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `group_id`),
  INDEX `fk_user_has_group_group1_idx` (`group_id` ASC),
  INDEX `fk_user_has_group_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_group_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_group_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `social_group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_follow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_follow` ;

CREATE TABLE IF NOT EXISTS `user_follow` (
  `user_id` INT NOT NULL,
  `following_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `following_id`),
  INDEX `fk_user_has_user_user2_idx` (`following_id` ASC),
  INDEX `fk_user_has_user_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_user_user2`
    FOREIGN KEY (`following_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `group_post_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `group_post_comment` ;

CREATE TABLE IF NOT EXISTS `group_post_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contents` TEXT NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `user_id` INT NOT NULL,
  `group_post_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_post_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_group_post_comment_group_post1_idx` (`group_post_id` ASC),
  INDEX `fk_group_post_comment_group_post_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_group_post_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_post_comment_group_post1`
    FOREIGN KEY (`group_post_id`)
    REFERENCES `group_post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_group_post_comment_group_post_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `group_post_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `course_schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `course_schedule` ;

CREATE TABLE IF NOT EXISTS `course_schedule` (
  `course_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`course_id`, `user_id`),
  INDEX `fk_course_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_course_has_user_course1_idx` (`course_id` ASC),
  CONSTRAINT `fk_course_has_user_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `professor_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `professor_rating` ;

CREATE TABLE IF NOT EXISTS `professor_rating` (
  `user_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `rating` INT NOT NULL,
  `content` TEXT NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  PRIMARY KEY (`user_id`, `professor_id`, `enabled`),
  INDEX `fk_user_has_professor_professor1_idx` (`professor_id` ASC),
  INDEX `fk_user_has_professor_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_professor_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_professor_professor1`
    FOREIGN KEY (`professor_id`)
    REFERENCES `professor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS admin;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'admin' IDENTIFIED BY 'admin';

GRANT ALL ON * TO 'admin';
SET SQL_MODE = '';
DROP USER IF EXISTS dev;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'dev' IDENTIFIED BY 'dev';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'dev';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `school`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `school` (`id`, `name`, `description`, `created_on`, `last_update`, `founded_in`, `image_url`, `enabled`) VALUES (1, 'Metropolitan Tech', 'A leading institution in technology and engineering studies', '2023-01-12', '2023-04-07', 1950, 'http://example.com/metropolitantech.jpg', 1);
INSERT INTO `school` (`id`, `name`, `description`, `created_on`, `last_update`, `founded_in`, `image_url`, `enabled`) VALUES (2, 'Harborview Arts College', 'Dedicated to the fine arts, with a focus on contemporary artistic practices', '2023-02-20', '2023-03-25', 1923, 'http://example.com/harborviewarts.jpg', 1);
INSERT INTO `school` (`id`, `name`, `description`, `created_on`, `last_update`, `founded_in`, `image_url`, `enabled`) VALUES (3, 'Rivertown College', 'Known for its strong programs in environmental science and sustainability', '2023-03-18', '2023-04-08', 1978, 'http://example.com/rivertowncollege.jpg', 1);
INSERT INTO `school` (`id`, `name`, `description`, `created_on`, `last_update`, `founded_in`, `image_url`, `enabled`) VALUES (4, 'Crestview Business School', 'Offers top-ranked undergraduate and graduate programs in business \nadministration', '2023-01-25', '2023-04-03', 1960, 'http://example.com/crestviewbusiness.jpg', 1);
INSERT INTO `school` (`id`, `name`, `description`, `created_on`, `last_update`, `founded_in`, `image_url`, `enabled`) VALUES (5, 'Avalon Liberal Arts', 'A small, prestigious college emphasizing liberal arts and critical thinking', '2023-02-05', '2023-03-30', 1905, 'http://example.com/avalonliberalarts.jpg', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (1, 'johnsmith', 'password123', '2023-01-01 08:00:00', 'john.smith@email.com', '2023-04-01 09:00:00', 1, 'student', 'John', 'Smith', 'Biography of John \nSmith', '2001-05-10', 'http://example.com/johnsmith.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (2, 'emilyjones', 'password123', '2023-01-02 08:00:00', 'emily.jones@email.com', '2023-04-01 09:30:00', 1, 'student', 'Emily', 'Jones', 'Biography of Emily \nJones', '2002-04-15', 'http://example.com/emilyjones.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (3, 'mikeross', 'password123', '2023-01-03 08:00:00', 'mike.ross@email.com', '2023-04-01 10:00:00', 1, 'student', 'Mike', 'Ross', 'Biography of Mike \nRoss', '2003-03-20', 'http://example.com/mikeross.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (4, 'sarahlee', 'password123', '2023-01-04 08:00:00', 'sarah.lee@email.com', '2023-04-01 10:30:00', 1, 'student', 'Sarah', 'Lee', 'Biography of Sarah \nLee', '2004-02-25', 'http://example.com/sarahlee.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (5, 'davidbrown', 'password123', '2023-01-05 08:00:00', 'david.brown@email.com', '2023-04-01 11:00:00', 1, 'student', 'David', 'Brown', 'Biography of David \nBrown', '2005-01-30', 'http://example.com/davidbrown.jpg', 1);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (6, 'janesmith', 'password123', '2023-01-06 08:00:00', 'jane.smith@email.com', '2023-04-01 09:00:00', 1, 'student', 'Jane', 'Smith', 'Biography of Jane \nSmith', '2001-06-12', 'http://example.com/janesmith.jpg', 2);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (7, 'jackjohnson', 'password123', '2023-01-07 08:00:00', 'jack.johnson@email.com', '2023-04-01 09:30:00', 1, 'student', 'Jack', 'Johnson', 'Biography of Jack \nJohnson', '2002-05-17', 'http://example.com/jackjohnson.jpg', 2);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (8, 'amymiller', 'password123', '2023-01-08 08:00:00', 'amy.miller@email.com', '2023-04-01 10:00:00', 1, 'student', 'Amy', 'Miller', 'Biography of Amy \nMiller', '2003-04-22', 'http://example.com/amymiller.jpg', 2);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (9, 'brianevans', 'password123', '2023-01-09 08:00:00', 'brian.evans@email.com', '2023-04-01 10:30:00', 1, 'student', 'Brian', 'Evans', 'Biography of Brian \nEvans', '2004-03-27', 'http://example.com/brianevans.jpg', 2);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (10, 'oliviawilliams', 'password123', '2023-01-10 08:00:00', 'olivia.williams@email.com', '2023-04-01 11:00:00', 1, 'student', 'Olivia', 'Williams', 'Biography of Olivia \nWilliams', '2005-02-01', 'http://example.com/oliviawilliams.jpg', 2);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (11, 'alexturner', 'password123', '2023-01-11 08:00:00', 'alex.turner@email.com', '2023-04-01 09:00:00', 1, 'student', 'Alex', 'Turner', 'Biography of Alex \nTurner', '2001-07-14', 'http://example.com/alexturner.jpg', 3);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (12, 'sophiawilson', 'password123', '2023-01-12 08:00:00', 'sophia.wilson@email.com', '2023-04-01 09:30:00', 1, 'student', 'Sophia', 'Wilson', 'Biography of Sophia \nWilson', '2002-06-19', 'http://example.com/sophiawilson.jpg', 3);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (13, 'jacobmoore', 'password123', '2023-01-13 08:00:00', 'jacob.moore@email.com', '2023-04-01 10:00:00', 1, 'student', 'Jacob', 'Moore', 'Biography of Jacob \nMoore', '2003-05-24', 'http://example.com/jacobmoore.jpg', 3);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (14, 'chloekim', 'password123', '2023-01-14 08:00:00', 'chloe.kim@email.com', '2023-04-01 10:30:00', 1, 'student', 'Chloe', 'Kim', 'Biography of Chloe \nKim', '2004-04-29', 'http://example.com/chloekim.jpg', 3);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (15, 'lukedavis', 'password123', '2023-01-15 08:00:00', 'luke.davis@email.com', '2023-04-01 11:00:00', 1, 'student', 'Luke', 'Davis', 'Biography of Luke \nDavis', '2005-03-05', 'http://example.com/lukedavis.jpg', 3);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (16, 'emmawatson', 'password123', '2023-01-16 08:00:00', 'emma.watson@email.com', '2023-04-01 09:00:00', 1, 'student', 'Emma', 'Watson', 'Biography of Emma \nWatson', '2001-08-16', 'http://example.com/emmawatson.jpg', 4);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (17, 'liamgarcia', 'password123', '2023-01-17 08:00:00', 'liam.garcia@email.com', '2023-04-01 09:30:00', 1, 'student', 'Liam', 'Garcia', 'Biography of Liam \nGarcia', '2002-07-21', 'http://example.com/liamgarcia.jpg', 4);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (18, 'zoemartinez', 'password123', '2023-01-18 08:00:00', 'zoe.martinez@email.com', '2023-04-01 10:00:00', 1, 'student', 'Zoe', 'Martinez', 'Biography of Zoe \nMartinez', '2003-06-26', 'http://example.com/zoemartinez.jpg', 4);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (19, 'ryanthomas', 'password123', '2023-01-19 08:00:00', 'ryan.thomas@email.com', '2023-04-01 10:30:00', 1, 'student', 'Ryan', 'Thomas', 'Biography of Ryan \nThomas', '2004-05-31', 'http://example.com/ryanthomas.jpg', 4);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (20, 'isabellaking', 'password123', '2023-01-20 08:00:00', 'isabella.king@email.com', '2023-04-01 11:00:00', 1, 'student', 'Isabella', 'King', 'Biography of Isabella \nKing', '2005-04-05', 'http://example.com/isabellaking.jpg', 4);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (21, 'maxroberts', 'password123', '2023-01-21 08:00:00', 'max.roberts@email.com', '2023-04-01 09:00:00', 1, 'student', 'Max', 'Roberts', 'Biography of Max \nRoberts', '2001-09-18', 'http://example.com/maxroberts.jpg', 5);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (22, 'avawhite', 'password123', '2023-01-22 08:00:00', 'ava.white@email.com', '2023-04-01 09:30:00', 1, 'student', 'Ava', 'White', 'Biography of Ava \nWhite', '2002-08-23', 'http://example.com/avawhite.jpg', 5);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (23, 'ethanjohnson', 'password123', '2023-01-23 08:00:00', 'ethan.johnson@email.com', '2023-04-01 10:00:00', 1, 'student', 'Ethan', 'Johnson', 'Biography of Ethan \nJohnson', '2003-07-28', 'http://example.com/ethanjohnson.jpg', 5);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (24, 'madisonsmith', 'password123', '2023-01-24 08:00:00', 'madison.smith@email.com', '2023-04-01 10:30:00', 1, 'student', 'Madison', 'Smith', 'Biography of Madison \nSmith', '2004-06-02', 'http://example.com/madisonsmith.jpg', 5);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (25, 'oliverwilliams', 'password123', '2023-01-25 08:00:00', 'oliver.williams@email.com', '2023-04-01 11:00:00', 1, 'student', 'Oliver', 'Williams', 'Biography of Oliver \nWilliams', '2005-05-08', 'http://example.com/oliverwilliams.jpg', 5);
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (26, 'admin', 'admin123', '2023-01-25 08:00:00', 'admin@quorum.com', '2023-01-25 08:00:00', 1, 'admin', NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `professor`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (1, 'Elizabeth', 'Jones', '2023-02-07', '2023-06-07', 1, 1);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (2, 'Linda', 'Garcia', '2023-01-30', '2023-12-11', 0, 1);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (3, 'John', 'Garcia', '2023-02-25', '2023-05-21', 1, 1);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (4, 'Michael', 'Williams', '2023-11-25', '2023-12-23', 1, 1);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (5, 'Patricia', 'Martinez', '2023-08-17', '2023-12-25', 0, 2);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (6, 'Mary', 'Brown', '2023-12-19', '2023-12-26', 1, 2);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (7, 'John', 'Smith', '2023-10-11', '2023-11-11', 0, 2);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (8, 'Robert', 'Smith', '2023-04-11', '2023-05-22', 1, 2);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (9, 'Jennifer', 'Brown', '2023-02-03', '2023-06-25', 1, 2);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (10, 'William', 'Brown', '2023-12-25', '2023-12-30', 1, 3);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (11, 'John', 'Miller', '2023-02-10', '2023-11-10', 1, 3);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (12, 'Mary', 'Williams', '2023-06-24', '2023-07-20', 0, 3);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (13, 'Linda', 'Garcia', '2023-01-27', '2023-07-07', 0, 3);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (14, 'James', 'Brown', '2023-10-18', '2023-10-23', 0, 4);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (15, 'Linda', 'Jones', '2023-01-13', '2023-01-16', 0, 4);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (16, 'Robert', 'Smith', '2023-02-04', '2023-02-08', 0, 4);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (17, 'William', 'Garcia', '2023-10-02', '2023-12-24', 0, 4);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (18, 'Linda', 'Davis', '2023-07-22', '2023-07-28', 1, 4);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (19, 'Robert', 'Rodriguez', '2023-11-11', '2023-12-17', 1, 5);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (20, 'James', 'Jones', '2023-08-27', '2023-10-07', 0, 5);
INSERT INTO `professor` (`id`, `first_name`, `last_name`, `created_on`, `last_update`, `enabled`, `school_id`) VALUES (21, 'Patricia', 'Jones', '2023-01-30', '2023-04-11', 1, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `course`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (1, 'Introduction to Computer Science', '2023-02-07', '2023-06-07', '2023-02-15', '2023-05-15', 1, 1, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (2, 'Data Structures and Algorithms', '2023-01-30', '2023-12-11', '2023-02-20', '2023-06-20', 1, 1, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (3, 'Database Management Systems', '2023-02-25', '2023-05-21', '2023-03-10', '2023-06-10', 1, 1, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (4, 'Art History: Renaissance to Modernism', '2023-11-25', '2023-12-23', '2023-01-15', '2023-05-15', 2, 2, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (5, 'Contemporary Art Practices', '2023-08-17', '2023-12-25', '2023-01-30', '2023-06-30', 2, 2, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (6, 'Environmental Science Fundamentals', '2023-12-19', '2023-12-26', '2023-02-05', '2023-05-05', 3, 3, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (7, 'Sustainability and Society', '2023-10-11', '2023-11-11', '2023-02-20', '2023-06-20', 3, 3, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (8, 'Business Administration Principles', '2023-04-11', '2023-05-22', '2023-03-01', '2023-06-01', 4, 4, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (9, 'Leadership and Management', '2023-02-03', '2023-06-25', '2023-03-15', '2023-06-15', 4, 4, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (10, 'English Literature: Shakespeare', '2023-12-25', '2023-12-30', '2023-02-15', '2023-05-15', 5, 5, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (11, 'Modern American Literature', '2023-02-10', '2023-11-10', '2023-03-01', '2023-06-01', 5, 5, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (12, 'Classical Music History', '2023-06-24', '2023-07-20', '2023-03-10', '2023-06-10', 1, 6, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (13, 'Music Theory and Composition', '2023-01-27', '2023-07-07', '2023-01-30', '2023-06-30', 1, 6, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (14, 'Financial Accounting', '2023-10-18', '2023-10-23', '2023-02-05', '2023-05-05', 2, 7, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (15, 'Marketing Strategies', '2023-01-13', '2023-01-16', '2023-02-20', '2023-06-20', 2, 7, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (16, 'Entrepreneurship and Innovation', '2023-02-04', '2023-02-08', '2023-03-01', '2023-06-01', 2, 7, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (17, 'Environmental Policy and Law', '2023-10-02', '2023-12-24', '2023-03-15', '2023-06-15', 3, 8, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (18, 'Climate Change Science', '2023-07-22', '2023-07-28', '2023-01-15', '2023-05-15', 3, 8, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (19, 'Investment Analysis', '2023-11-11', '2023-12-17', '2023-03-10', '2023-06-10', 4, 9, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (20, 'Financial Management', '2023-08-27', '2023-10-07', '2023-02-20', '2023-06-20', 4, 9, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');
INSERT INTO `course` (`id`, `title`, `created_on`, `last_update`, `date_start`, `date_end`, `school_id`, `professor_id`, `enabled`, `days_of_week`) VALUES (21, 'Psychology: Mind and Behavior', '2023-01-30', '2023-04-11', '2023-01-15', '2023-05-15', 5, 10, 1, 'MONDAY/TUESDAY/THURSDAY/FRIDAY');

COMMIT;


-- -----------------------------------------------------
-- Data for table `social_group`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (1, 'Theatre Troupe', 'An acting group for staging plays and developing theatrical skills.', '2023-03-16 14:48:58', '2023-03-24 14:48:58', 1, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (2, 'Debate Team', 'A team focused on honing debating skills and participating in regional and national debates.', '2023-08-04 07:45:54', '2023-08-09 07:45:54', 2, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (3, 'Art Collective', 'A space for artists to collaborate, exhibit, and critique each other\'s work.', '2023-06-03 02:44:07', '2023-06-12 02:44:07', 3, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (4, 'Literature Society', 'A community of book lovers sharing insights and discussions on various literary works.', '2023-02-04 21:39:47', '2023-02-05 21:39:47', 4, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (5, 'Painting Club', 'A community of college painters.', '2023-06-03 14:39:53', '2023-06-11 14:39:53', 5, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (6, 'Advanced Robotics Club', 'A group for robotics enthusiasts to design, build, and compete in robotics competitions.', '2023-10-14 05:08:01', '2023-10-20 05:08:01', 6, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (7, 'Science Society', 'A society for discussing scientific advancements and conducting experiments.', '2023-02-20 17:22:53', '2023-02-22 17:22:53', 7, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (8, 'Robotics Club', 'A group for robotics enthusiasts to design, build, and compete in robotics competitions.', '2023-02-15 17:37:30', '2023-02-16 17:37:30', 8, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (9, 'Coding Ninjas', 'A coding group focusing on developing programming skills and participating in hackathons.', '2023-08-12 19:21:24', '2023-08-15 19:21:24', 9, 1);
INSERT INTO `social_group` (`id`, `name`, `description`, `created_on`, `last_update`, `owner_id`, `enabled`) VALUES (10, 'Photography Club', 'A group for photography enthusiasts to share tips and organize photo walks.', '2023-09-16 17:34:47', '2023-09-24 17:34:47', 10, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_post`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (1, 'New Play Auditions', 'Auditions for our upcoming play are next week!', '2023-07-01 07:01:14', '2023-07-10 07:01:14', 3, 1, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (2, 'Workshop Announcement', 'Join our acting workshop this Friday.', '2023-12-02 01:08:24', '2023-12-08 01:08:24', 2, 1, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (3, 'Debate Topic Suggestions', 'Looking for topic suggestions for our next debate.', '2023-01-27 00:36:17', '2023-01-31 00:36:17', 9, 2, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (4, 'Debate Practice Session', 'Practice session this Wednesday at 5 PM.', '2023-09-25 20:44:14', '2023-10-03 20:44:14', 9, 2, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (5, 'Art Exhibition', 'Our annual art exhibition is coming up next month.', '2023-10-20 11:03:27', '2023-10-26 11:03:27', 7, 3, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (6, 'Collaborative Project', 'Looking for artists to collaborate on a mural.', '2023-09-09 14:20:22', '2023-09-14 14:20:22', 6, 3, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (7, 'Book Club Meeting', 'Our next book club meeting is on Tuesday.', '2023-09-25 03:30:56', '2023-10-04 03:30:56', 10, 4, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (8, 'Author Visit', 'An acclaimed author is visiting our campus next week.', '2023-11-11 03:25:13', '2023-11-13 03:25:13', 10, 4, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (9, 'Photo Walk', 'Join us for a photo walk this weekend.', '2023-06-23 05:09:12', '2023-06-27 05:09:12', 4, 5, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (10, 'Photography Contest', 'Submit your best shots for our annual contest.', '2023-01-28 14:49:40', '2023-02-03 14:49:40', 6, 5, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (11, 'Robotics Competition', 'We are participating in a robotics competition next month.', '2023-06-25 20:13:16', '2023-06-26 20:13:16', 7, 6, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (12, 'Build Session', 'Join us for a robot build session this Saturday.', '2023-02-02 08:44:43', '2023-02-10 08:44:43', 2, 6, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (13, 'Science Fair', 'We are hosting a science fair next month.', '2023-03-16 09:57:01', '2023-03-24 09:57:01', 6, 7, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (14, 'Guest Lecture', 'A guest lecture on quantum physics is scheduled for next week.', '2023-06-16 08:11:46', '2023-06-23 08:11:46', 4, 7, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (15, 'Robotics Competition', 'We are participating in a robotics competition next month.', '2023-10-31 08:50:04', '2023-11-06 08:50:04', 7, 8, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (16, 'Build Session', 'Join us for a robot build session this Saturday.', '2023-12-25 11:56:37', '2024-01-03 11:56:37', 9, 8, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (17, 'Hackathon', 'Our team is participating in a 24-hour hackathon.', '2023-03-26 02:46:30', '2023-04-04 02:46:30', 2, 9, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (18, 'Coding Workshop', 'We are organizing a Python workshop next Friday.', '2023-03-20 00:13:43', '2023-03-27 00:13:43', 2, 9, 0);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (19, 'Photo Walk', 'Join us for a photo walk this weekend.', '2023-04-28 10:46:02', '2023-05-05 10:46:02', 2, 10, 1);
INSERT INTO `group_post` (`id`, `title`, `contents`, `created_on`, `last_update`, `user_id`, `social_group_id`, `enabled`) VALUES (20, 'Photography Contest', 'Submit your best shots for our annual contest.', '2023-09-03 18:23:05', '2023-09-08 18:23:05', 2, 10, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `planner_item`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (1, 'Study Group', 'Meeting up with the study group for a review session.', '2023-10-18 01:04:54', '2023-09-23 01:04:54', '2023-10-03 01:04:54', 1, '2023-10-18 02:04:54');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (2, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-06-13 22:05:23', '2023-05-26 22:05:23', '2023-05-27 22:05:23', 1, '2023-06-14 00:05:23');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (3, 'Tutoring Session', 'Attending a tutoring session for calculus.', '2023-05-29 12:07:02', '2023-05-12 12:07:02', '2023-05-15 12:07:02', 1, '2023-05-29 13:07:02');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (4, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-11-11 22:16:28', '2023-10-29 22:16:28', '2023-11-08 22:16:28', 1, '2023-11-11 23:16:28');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (5, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-10-03 11:01:36', '2023-09-19 11:01:36', '2023-09-23 11:01:36', 1, '2023-10-03 13:01:36');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (6, 'Study Group', 'Meeting up with the study group for a review session.', '2023-11-27 01:24:12', '2023-11-13 01:24:12', '2023-11-14 01:24:12', 2, '2023-11-27 03:24:12');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (7, 'Project Meeting', 'Discussing our group project\'s progress.', '2023-02-17 04:17:51', '2023-01-19 04:17:51', '2023-01-22 04:17:51', 2, '2023-02-17 07:17:51');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (8, 'Study Group', 'Meeting up with the study group for a review session.', '2023-08-20 08:19:15', '2023-07-22 08:19:15', '2023-07-28 08:19:15', 2, '2023-08-20 09:19:15');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (9, 'Study Group', 'Meeting up with the study group for a review session.', '2023-09-28 14:32:19', '2023-08-30 14:32:19', '2023-09-06 14:32:19', 2, '2023-09-28 16:32:19');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (10, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-07-23 13:57:33', '2023-06-24 13:57:33', '2023-06-27 13:57:33', 2, '2023-07-23 16:57:33');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (11, 'Library Research', 'Researching for my term paper at the library.', '2023-01-16 16:00:54', '2023-01-06 16:00:54', '2023-01-16 16:00:54', 3, '2023-01-16 19:00:54');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (12, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-02-02 13:53:20', '2023-01-07 13:53:20', '2023-01-14 13:53:20', 3, '2023-02-02 15:53:20');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (13, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-01-10 16:17:12', '2022-12-25 16:17:12', '2022-12-31 16:17:12', 3, '2023-01-10 19:17:12');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (14, 'Tutoring Session', 'Attending a tutoring session for calculus.', '2023-01-19 13:31:05', '2023-01-17 13:31:05', '2023-01-23 13:31:05', 3, '2023-01-19 14:31:05');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (15, 'Study Group', 'Meeting up with the study group for a review session.', '2023-02-22 17:29:31', '2023-02-15 17:29:31', '2023-02-24 17:29:31', 3, '2023-02-22 18:29:31');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (16, 'Library Research', 'Researching for my term paper at the library.', '2023-06-26 00:51:32', '2023-06-08 00:51:32', '2023-06-12 00:51:32', 4, '2023-06-26 03:51:32');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (17, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-01-17 04:31:11', '2022-12-29 04:31:11', '2023-01-04 04:31:11', 4, '2023-01-17 05:31:11');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (18, 'Library Research', 'Researching for my term paper at the library.', '2023-10-17 04:08:31', '2023-09-23 04:08:31', '2023-10-02 04:08:31', 4, '2023-10-17 05:08:31');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (19, 'Lab Work', 'Completing experiments for my chemistry lab.', '2023-06-15 07:15:43', '2023-05-24 07:15:43', '2023-05-30 07:15:43', 4, '2023-06-15 09:15:43');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (20, 'Project Meeting', 'Discussing our group project\'s progress.', '2023-11-21 05:34:48', '2023-10-27 05:34:48', '2023-11-05 05:34:48', 4, '2023-11-21 07:34:48');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (21, 'Tutoring Session', 'Attending a tutoring session for calculus.', '2023-02-02 11:11:16', '2023-01-21 11:11:16', '2023-01-26 11:11:16', 5, '2023-02-02 12:11:16');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (22, 'Study Group', 'Meeting up with the study group for a review session.', '2023-05-20 23:09:10', '2023-05-12 23:09:10', '2023-05-17 23:09:10', 5, '2023-05-21 02:09:10');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (23, 'Study Group', 'Meeting up with the study group for a review session.', '2023-02-02 06:04:39', '2023-01-18 06:04:39', '2023-01-21 06:04:39', 5, '2023-02-02 08:04:39');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (24, 'Library Research', 'Researching for my term paper at the library.', '2023-12-02 14:59:13', '2023-11-04 14:59:13', '2023-11-11 14:59:13', 5, '2023-12-02 15:59:13');
INSERT INTO `planner_item` (`id`, `title`, `description`, `start_time`, `created_on`, `last_update`, `user_id`, `end_time`) VALUES (25, 'Project Meeting', 'Discussing our group project\'s progress.', '2023-04-04 16:29:19', '2023-03-20 16:29:19', '2023-03-28 16:29:19', 5, '2023-04-04 18:29:19');

COMMIT;


-- -----------------------------------------------------
-- Data for table `message`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (1, 'Can you send me the notes from today\'s lecture?', '2023-08-31 18:24:58', 17, 19);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (2, 'Don\'t forget our project meeting this afternoon.', '2023-05-17 14:24:51', 11, 12);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (3, 'Hey, are you going to the study group session tomorrow?', '2023-12-09 04:25:13', 2, 12);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (4, 'How was your weekend? We should hang out soon.', '2023-09-04 00:03:29', 12, 2);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (5, 'Don\'t forget our project meeting this afternoon.', '2023-02-26 23:37:52', 10, 5);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (6, 'Hey, are you going to the study group session tomorrow?', '2023-10-24 09:20:40', 20, 3);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (7, 'Hey, are you going to the study group session tomorrow?', '2023-06-24 07:10:30', 12, 11);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (8, 'Could you help me with the math homework?', '2023-09-25 00:37:12', 16, 24);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (9, 'Are you available for a group study session this weekend?', '2023-09-01 05:03:41', 6, 1);
INSERT INTO `message` (`id`, `contents`, `created_on`, `sender_id`, `receiver_id`) VALUES (10, 'Let\'s catch up over coffee this week.', '2023-10-10 11:02:59', 16, 21);

COMMIT;


-- -----------------------------------------------------
-- Data for table `social_group_member`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (1, 8);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (1, 10);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (1, 5);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (1, 2);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (2, 1);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (2, 10);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (2, 9);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (2, 6);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (3, 6);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (3, 1);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (4, 8);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (4, 5);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (4, 9);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (4, 7);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (5, 2);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (5, 8);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (6, 3);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (6, 7);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (6, 5);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (7, 7);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (7, 6);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (7, 8);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (7, 3);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (8, 6);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (8, 1);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (9, 2);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (9, 7);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (9, 8);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (10, 4);
INSERT INTO `social_group_member` (`user_id`, `group_id`) VALUES (10, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_follow`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (1, 6);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (9, 1);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (4, 1);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (10, 4);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (8, 4);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (9, 6);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (10, 6);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (3, 8);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (5, 3);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (10, 3);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (2, 10);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (6, 7);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (2, 1);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (7, 2);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (4, 8);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (6, 3);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (5, 7);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (1, 10);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (9, 5);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (10, 7);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (3, 9);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (4, 6);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (5, 1);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (8, 10);
INSERT INTO `user_follow` (`user_id`, `following_id`) VALUES (8, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `group_post_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `group_post_comment` (`id`, `contents`, `created_on`, `last_update`, `user_id`, `group_post_id`, `in_reply_to_id`, `enabled`) VALUES (1, 'This is going to be so exciting!', '2023-02-11 06:10:08', '2023-02-19 06:10:08', 3, 1, NULL, 1);
INSERT INTO `group_post_comment` (`id`, `contents`, `created_on`, `last_update`, `user_id`, `group_post_id`, `in_reply_to_id`, `enabled`) VALUES (2, 'Great initiative!', '2023-01-10 20:13:09', '2023-01-17 20:13:09', 8, 2, NULL, 1);
INSERT INTO `group_post_comment` (`id`, `contents`, `created_on`, `last_update`, `user_id`, `group_post_id`, `in_reply_to_id`, `enabled`) VALUES (3, 'Great initiative!', '2023-06-28 21:15:17', '2023-07-05 21:15:17', 1, 20, NULL, 1);
INSERT INTO `group_post_comment` (`id`, `contents`, `created_on`, `last_update`, `user_id`, `group_post_id`, `in_reply_to_id`, `enabled`) VALUES (4, 'Like it!', '2023-06-28 21:30:17', '2023-06-28 21:30:17', 1, 20, 3, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `course_schedule`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (1, 1);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (1, 2);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (1, 3);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (1, 4);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (1, 5);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (2, 6);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (2, 7);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (2, 8);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (2, 9);
INSERT INTO `course_schedule` (`course_id`, `user_id`) VALUES (2, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `professor_rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (1, 1, 4, 'Professor Jones is an excellent teacher. Her lectures are engaging and she provides clear explanations.', '2023-04-15 10:30:00', '2023-04-15 10:30:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (2, 1, 5, 'Professor Jones is the best! Her passion for the subject is contagious, and she\'s always available to help.', '2023-04-16 14:45:00', '2023-04-16 14:45:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (3, 1, 4, 'I\'ve learned so much from Professor Jones. Her assignments are challenging but rewarding.', '2023-04-17 09:15:00', '2023-04-17 09:15:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (4, 1, 5, 'Professor Jones is a true expert in her field. I feel lucky to have had her as my professor.', '2023-04-18 11:20:00', '2023-04-18 11:20:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (5, 1, 4, 'I enjoyed Professor Jones\' class. Her knowledge and teaching style made the subject interesting.', '2023-04-19 13:55:00', '2023-04-19 13:55:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (6, 2, 3, 'Professor Garcia\'s class was okay. I found some topics confusing, but she was helpful during office hours.', '2023-04-20 10:10:00', '2023-04-20 10:10:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (7, 2, 2, 'Professor Garcia\'s teaching style didn\'t work for me. I struggled to grasp the material.', '2023-04-21 14:30:00', '2023-04-21 14:30:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (8, 2, 3, 'I think Professor Garcia knows the subject well, but her lectures could be more engaging.', '2023-04-22 09:45:00', '2023-04-22 09:45:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (9, 2, 2, 'I didn\'t enjoy Professor Garcia\'s class. The assignments were confusing, and I felt lost.', '2023-04-23 11:55:00', '2023-04-23 11:55:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (10, 3, 5, 'Professor John Garcia is fantastic! His explanations are crystal clear, and he\'s very approachable.', '2023-04-24 13:40:00', '2023-04-24 13:40:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (11, 3, 4, 'I learned a lot from Professor John Garcia. His lectures are engaging, and he\'s a great teacher.', '2023-04-25 10:25:00', '2023-04-25 10:25:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (12, 3, 5, 'Professor John Garcia is the best! His passion for the subject is contagious.', '2023-04-26 12:15:00', '2023-04-26 12:15:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (13, 3, 4, 'Professor John Garcia\'s class was great. The material was challenging but interesting.', '2023-04-27 14:05:00', '2023-04-27 14:05:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (14, 3, 5, 'I loved Professor John Garcia\'s class. He\'s an excellent teacher and very knowledgeable.', '2023-04-28 09:50:00', '2023-04-28 09:50:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (15, 4, 4, 'Professor Michael Williams is a good teacher. His lectures are clear, and he\'s helpful during office hours.', '2023-04-29 11:20:00', '2023-04-29 11:20:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (16, 4, 3, 'I found Professor Michael Williams\' class to be average. Some parts were interesting, but others were dull.', '2023-04-30 13:30:00', '2023-04-30 13:30:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (17, 4, 4, 'Professor Michael Williams knows his stuff, but I wish he used more real-world examples in class.', '2023-05-01 10:15:00', '2023-05-01 10:15:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (18, 4, 3, 'Professor Michael Williams\' class was okay. I learned, but it wasn\'t the most exciting.', '2023-05-02 12:10:00', '2023-05-02 12:10:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (19, 4, 4, 'I enjoyed Professor Michael Williams\' class. He\'s knowledgeable and approachable.', '2023-05-03 14:00:00', '2023-05-03 14:00:00', 1);
INSERT INTO `professor_rating` (`user_id`, `professor_id`, `rating`, `content`, `created_on`, `last_update`, `enabled`) VALUES (20, 5, 4, 'Professor Patricia Martinez is a good teacher. Her class is engaging, and she provides helpful resources.', '2023-05-04 09:30:00', '2023-05-04 09:30:00', 1);

COMMIT;

