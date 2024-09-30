-- MySQL dump 10.13  Distrib 8.0.38, for macos14 (arm64)
--
-- Host: jayden-test-db.cx6kukwuo709.ap-northeast-2.rds.amazonaws.com    Database: perfecfolio
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `user_withdraw_tb`
--

DROP TABLE IF EXISTS `user_withdraw_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_withdraw_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_nickname` varchar(20) DEFAULT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_birth` varchar(255) NOT NULL,
  `user_gender` enum('남성','여성','설정안함') DEFAULT NULL,
  `user_tel` varchar(13) NOT NULL,
  `created_at` varchar(30) NOT NULL,
  `social_type` varchar(30) NOT NULL,
  `withdraw_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_withdraw_tb`
--

LOCK TABLES `user_withdraw_tb` WRITE;
/*!40000 ALTER TABLE `user_withdraw_tb` DISABLE KEYS */;
INSERT INTO `user_withdraw_tb` VALUES (1,'이서연','Seoyeon1','Seoyeon1*','Seoyeon1','Seoyeon1@kakao.com','1997-01-05','여성','010-1145-5678','2024-01-05 14:23:45','kakao','2024-01-12 00:15:30'),(2,'박지훈','Jihoon9','Jihoon9*','Jihoon9','Jihoon9@naver.com','1998-01-11','남성','010-2345-6789','2024-02-14 11:00:00','naver','2024-02-13 07:30:10'),(3,'김민준','Minjun7','Minjun7*','Minjun7','Minjun7@gmail.com','1991-01-19','남성','010-3456-7890','2024-03-25 10:10:15','google','2024-03-14 09:20:55'),(4,'한지민','Jimin4','Jimin4!','Jimin4','Jimin4@naver.com','1990-01-25','여성','010-4567-8901','2024-04-12 13:32:10','local','2024-04-15 05:22:33'),(5,'정우성','Woosung2','Woosung2*','Woosung2','Woosung2@kakao.com','1980-01-30','설정안함','010-5678-9012','2024-05-03 08:45:25','kakao','2024-05-08 04:05:40'),(6,'최유진','Yujin3','Yujin3*','Yujin3','Yujin3@naver.com','1970-02-01','여성','010-6789-0123','2024-06-21 09:55:10','naver','2024-06-25 08:15:30'),(7,'조성현','Sungyeon5','Sungyeon5*','Sungyeon5','Sungyeon5@gmail.com','1990-02-08','남성','010-7890-1234','2024-07-10 12:22:05','google','2024-07-14 23:00:50'),(8,'송하늘','Haneul6','Haneul6!','Haneul6','Haneul6@naver.com','2000-02-14','설정안함','010-8901-2345','2024-08-02 15:00:00','local','2024-08-10 11:20:00'),(9,'강동원','Dongwon8','Dongwon8*','Dongwon8','Dongwon8@kakao.com','2001-02-22','남성','010-9012-3456','2024-08-20 16:18:30','kakao','2024-08-25 10:45:10'),(10,'오지영','Jiyoung7','Jiyoung7*','Jiyoung7','Jiyoung7@naver.com','2004-02-28','여성','010-0123-4567','2024-09-01 10:30:15','naver','2024-09-05 12:30:25'),(11,'임태훈','Taehun9','Taehun9*','Taehun9','Taehun9@gmail.com','1995-03-02','남성','010-7778-9988','2024-01-12 15:45:45','google','2024-01-20 02:00:20'),(12,'윤아름','Areum1','Areum1!','Areum1','Areum1@naver.com','1996-03-08','설정안함','010-4456-7753','2024-02-05 10:55:10','local','2024-02-09 22:50:30'),(13,'류한길','Hankil2','Hankil2*','Hankil2','Hankil2@kakao.com','1995-03-15','여성','010-8824-7890','2024-03-18 12:20:05','kakao','2024-03-25 06:30:25'),(14,'문서진','Seojin3','Seojin3*','Seojin3','Seojin3@naver.com','1996-03-21','남성','010-0035-8901','2024-04-01 11:55:30','naver','2024-04-08 04:40:15'),(15,'서민혁','Minhyuk4','Minhyuk4*','Minhyuk4','Minhyuk4@gmail.com','1999-03-29','설정안함','010-9950-9012','2024-05-10 08:25:10','google','2024-05-20 05:00:30'),(16,'한수민','Sumin5','Sumin5!','Sumin5','Sumin5@gmail.com','1999-04-02','여성','010-3364-0123','2024-06-15 14:10:55','local','2024-06-20 07:30:10'),(17,'김도현','Dohyeon7','Dohyeon7*','Dohyeon7','Dohyeon7@kakao.com','1983-04-10','남성','010-9924-7865','2024-07-05 09:30:25','kakao','2024-07-12 03:45:55'),(18,'강하영','Hayoung6','Hayoung6*','Hayoung6','Hayoung6@naver.com','1985-04-15','설정안함','010-1123-9987','2024-08-10 10:15:20','naver','2024-08-15 06:55:00'),(19,'장은지','Eunji8','Eunji8*','Eunji8','Eunji8@gmail.com','1973-04-22','여성','010-4532-8875','2024-09-01 14:00:00','google','2024-09-03 08:20:10'),(20,'이준호','Junho9','Junho9!','Junho9','Junho9@gmail.com','1972-04-28','남성','010-6657-9980','2024-09-05 11:35:45','local','2024-09-10 09:05:30'),(44,'yoon','yoon','$2a$10$jnhF0xWZzIm8SAfgGyW4t.ylbbFjT7hTe8zHVBFbjYM6Ii7HEP/Tu','','dbstjlee@naver.com','2000-10-19','여성','010-1111-2222','2024-09-27 15:36:26','local','2024-09-27 06:36:52'),(45,'이윤서','112834629667400343633','$2a$10$/ARcdSTqpRVpD1fkCudEe.UL6Qmr.famHZboMFI8r/F1mln62LZ/6','','dbstjlee@gmail.com','2000-10-19','여성','010-2222-3333','2024-09-27 15:37:57','google','2024-09-27 06:38:31');
/*!40000 ALTER TABLE `user_withdraw_tb` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-30 15:57:12
