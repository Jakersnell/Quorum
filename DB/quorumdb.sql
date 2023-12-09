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
  `founded_on` DATE NULL,
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
  `created_on` DATE NULL,
  `last_update` DATE NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `course` ;

CREATE TABLE IF NOT EXISTS `course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `created_on` DATE NOT NULL,
  `last_update` DATE NOT NULL,
  `date_start` DATE NOT NULL,
  `date_end` DATE NULL,
  `school_id` INT NOT NULL,
  `professor_id` INT NOT NULL,
  `enabled` TINYINT NULL,
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
  `id` INT NOT NULL,
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
  `id` INT NOT NULL,
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
  `rating` INT NULL,
  `content` TEXT NULL,
  `created_on` DATETIME NULL,
  `last_update` DATETIME NULL,
  `enabled` TINYINT NULL,
  PRIMARY KEY (`user_id`, `professor_id`),
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
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `quorum`;
INSERT INTO `user` (`id`, `username`, `password`, `created_on`, `email`, `last_update`, `enabled`, `role`, `first_name`, `last_name`, `biography`, `date_of_birth`, `profile_image_url`, `school_id`) VALUES (1, 'jtester', 'jtest1', '2021-09-15', 'john.doe@gmail.com', '2021-09-15', 1, 'user', NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;

