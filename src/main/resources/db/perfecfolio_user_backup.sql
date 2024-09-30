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
-- Table structure for table `user_backup`
--

DROP TABLE IF EXISTS `user_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_backup` (
  `id` int NOT NULL DEFAULT '0',
  `user_name` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_nickname` varchar(20) DEFAULT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_birth` varchar(100) NOT NULL,
  `user_gender` enum('남성','여성','설정안함') DEFAULT NULL,
  `user_tel` varchar(13) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `social_type` varchar(30) NOT NULL,
  `tax_id` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_backup`
--

LOCK TABLES `user_backup` WRITE;
/*!40000 ALTER TABLE `user_backup` DISABLE KEYS */;
INSERT INTO `user_backup` VALUES (1,'김철수','su12345','$2a$10$Z8V54WwBiAZcaUaFweRKv.XFw38rH1hvBWqcEU9UWunm8e3D8s28u','su12345','su12345@naver.com','2010-10-11','남성','010-1234-5678','2024-01-03 01:22:35','naver',NULL),(2,'강영희','hee1234','$2a$10$YYAwfhhbd7W6g8xjgYawm.MgoVvJaf1KtGurDQz9hi.cpFrLmry5q','hee1234','hee1234@naver.com','1970-05-18','여성','010-9123-4567','2024-02-03 03:03:11','naver',NULL),(3,'이민수','minsu3456','$2a$10$VqljtJN/7wwlCytMGnefTuvIn/Jn1k3i7IVrj449lLacND9wQTIF.','minsu3456','minsu3456@naver.com','1983-06-20','남성','010-1123-4456','2024-03-03 12:22:40','naver',NULL),(4,'조연희','yeun1234','$2a$10$8yhDtd1V3yIKcZ8n4Zfviux56DRrd/dgp3YHIF5vDZwOHhnFVBYy.','yeun1234','yeun1234@naver.com','1991-12-01','여성','010-1134-5578','2024-04-03 11:07:22','naver',NULL),(5,'박민철','min4567','$2a$10$sHcnhkzB4ibQa9ZE3GG2e.vpPquRKVkrO87tbsg/XqsUqYCOUrPpS','min4567','min4567@naver.com','2005-06-01','남성','010-7789-1123','2024-03-02 23:08:15','naver',NULL),(6,'박경훈','pkh7765','$2a$10$qe4U28Wqt1SgzNtopiq7Iu40wrNGsC0Q9ZbJW3VsfzxWJysKy8HQa','pkh7765','pkh7765@naver.com','2000-04-16','남성','010-3259-4422','2024-03-28 10:44:51','naver',NULL),(7,'이민경','lmk9350','$2a$10$T0gGE2pUxuJG/XyUMH.lYObVY/r9y7GPNu7nhl3PJmOd4P1wgusru','lmk9350','lmk9350@naver.com','2003-03-04','여성','010-9966-3298','2024-03-25 11:43:41','naver',NULL),(8,'김현재','khj3309','$2a$10$JAv0GhQVlvdAkvid5LOfwukxTjK19yq6C2oRIr2YGFbNW4L6rZJbe','khj3309','khj3309@naver.com','1998-07-08','남성','010-1156-9562','2024-03-06 09:37:21','naver',NULL),(9,'김소연','ksy6650','$2a$10$qjJmukGvuc7UW7ChIvPT3eXcMt.sqSuC9Gku0gUw2nHa0BslUfIhW','ksy6650','ksy6650@naver.com','1995-09-27','여성','010-4275-3242','2024-08-16 08:38:31','naver',NULL),(10,'강현민','khm0032','$2a$10$40oxkL8LYNDdHOY2nAhbceGU9YSANfcAWFYtGEqV43qEBgIB86zCG','khm0032','khm0032@naver.com','1994-11-29','설정안함','010-6698-7754','2024-08-19 14:26:56','naver',NULL),(11,'이영수','yengsu7788','$2a$10$uKm/E65Vy3qo4pmN9D7zwe0f5z4J3YMYsTL9q5zawvWfbrZig.fsm','yengsu7788','yengsu7788@gmail.com','2000-02-20','설정안함','010-6541-9871','2024-05-17 09:00:33','google',NULL),(12,'이소윤','soyun0305','$2a$10$SBXhypMrHXPLgI.Wytis9uIEdLEje6TaSlxG4iCy9pbRwIyjNmF2K','soyun0305','soyun0305@gmail.com','2002-06-29','설정안함','010-5641-8971','2024-06-20 07:25:00','google',NULL),(13,'강민준','minjun1216','$2a$10$M9sQdeVHgOrT88dpomBNIe7gm2q6gn4wYrjMOqEoTfjzxQXcjVzfO','minjun1216','minjun1216@gmail.com','1985-06-05','남성','010-2310-0654','2024-07-15 08:16:56','google',NULL),(14,'김연아','yeona0705','$2a$10$cqQk9TaUJXG3X4LvpqqJnuuEQCrkiJEJlgzPTsRyzMp4aBrK1oNQ.','yeona0705','yeona0705@gmail.com','1997-01-16','여성','010-9870-6781','2024-08-01 14:16:35','google',NULL),(15,'강형욱','uuu0618','$2a$10$V9oiO/3wjG5TkyGYMqNmmuMUmZjaEYZruFurHKLif4tOVUrOIhsvO','uuu0618','uuu0618@gmail.com','2004-11-09','남성','010-6091-8134','2024-08-31 19:03:46','google',NULL),(16,'김연수','susu1010','$2a$10$AfZn0djKRnI7qzGvwHXJpeLrnX3n4PD0Z.XtEgt5k8iCskWndbHNS','susu1010','susu1010@naver.com','2001-10-20','남성','010-9987-0789','2024-01-07 22:21:59','local',NULL),(17,'강민영','young4567','$2a$10$4mKl7bDDa01EVZ/9GtqHvO8U481mulT0cKsIJtjtjIOzfWO2oFK3m','young4567','young4567@gmail.com','1989-07-20','여성','010-8712-4560','2024-02-17 13:07:11','local',NULL),(18,'이민형','min1111','$2a$10$qN0dpoXRp4p6kn.gD0aiKOtdThAmFKQjynMp8rFEFAIP7v3vbfwsm','min1111','min1111@kakao.com','1985-06-05','설정안함','010-6530-3208','2024-03-28 20:16:07','local',NULL),(19,'박명희','hee0789','$2a$10$SMC7NhwjkZgO/xuSqlV7uu2C1DlUYtKmzKeB4F7CAJTxbBEtE.AKi','hee0789','hee0789@naver.com','1998-12-16','여성','010-7904-9805','2024-04-26 15:31:08','local',NULL),(20,'박현철','park6598','$2a$10$QYfaMZ6gz1wFrHHVZIUMBeKk3HNV7wOJDSuaF1aRSvAA4ehsy.jca','park6598','park6598@naver.com','2003-09-21','남성','010-6490-5060','2024-03-30 11:56:46','local',NULL),(21,'박현수','susu8855','$2a$10$wB6WF2uTwUgx4ovgIepGk.5nxBeGnjFrEiFsbzEYJQ5IHH/CWBOzy','susu8855','susu8855@kakao.com','2000-10-16','남성','010-4532-8894','2024-06-01 17:54:11','kakao',NULL),(22,'이연우','yeonu6605','$2a$10$z.5oXl0l..0/aUwVwfHyvu6K85MPJce66qkRisjIf6I0ikDPv.Dgq','yeonu6605','yeonu6605@kakao.com','1993-07-20','여성','010-6652-0032','2024-06-01 07:55:49','kakao',NULL),(23,'박형석','phs1208','$2a$10$Vg05nj/qlQRzk1PRRYUH.uYAGlSLbK7qCjH8hBmY7Mqo6eajQmoou','phs1208','phs1208@kakao.com','1985-12-16','남성','010-7725-6632','2024-07-03 08:37:28','kakao',NULL),(24,'김유나','yuna0307','$2a$10$qTXSFNxz4jS6IegTNQNHQueH7RkNu6N51P.eE/TuQCLaKqqP1cqWC','yuna0307','yuna0307@kakao.com','1999-01-24','설정안함','010-4503-9830','2024-08-14 14:09:07','kakao',NULL),(25,'강형석','khs7845','$2a$10$MmQKuzLlIEtDyVzT8yfFYOTV1gBZHf9fwV/H/OYa3mvmcQS6VUMYi','khs7845','khs7845@kakao.com','2003-06-13','남성','010-5569-2202','2024-08-22 10:28:39','kakao',NULL),(26,'zl존박태현','thjjang04','$2a$10$i/AT50qAuYLXopfoVybmjem1X9SQkY1qhiD9LcXxyf7SOy5Cfit2W','어형이야','thjjang04@gmail.com','2004-04-09','남성','010-7441-8574','2024-09-12 07:33:47','local',NULL),(28,'김지니','3702917680','$2a$10$MzadVv50Rb5/vVx1SLTE9OvCpX2aDlAlHzKEeIIqJvICBl.DwPnie','동윤','ehddbs1105@gmail.com','1999-11-05','남성','010-5716-0344','2024-09-12 08:42:07','kakao',NULL),(30,'오효정','o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','$2a$10$Mm2G7.T26nXaAl9I2ltEwO7IphD/hDR.pYODFho1b8e8vDrKbRzQO','qoj','qojjop35052@naver.com','1999-11-10','여성','010-7288-7953','2024-09-12 09:46:00','naver',NULL),(31,'HJ','106901987394067060109','$2a$10$9fAbJ/rFKiq8DEmmbgPWZeiWObRd5zjyXykDaAuqoT5Ly4pk5Bpay','땅콩','chorok917@gmail.com','2024-09-04','여성','010-0000-0000','2024-09-12 16:28:10','google',NULL),(37,'프리미엄유저테스트','impremium','$2a$10$ufXHbjLcluYedH.v25DGP.ZmY4.hoSnjnuopr26ypSmg0/XXB5JXK','프리미엄유저테스트','qkrakdth@gmail.com','2004-04-08','남성','010-8888-8888','2024-09-13 03:48:17','local',NULL),(42,'퍼펙트폴리오','perfect','$2a$10$TY/xJpbf0VoCqhUUAPQxYeR7uoq1U2F1lUiaGr.fqdT8BXIoC8gMm',NULL,'perfect@gmail.com','2024-09-04','설정안함','010-0000-0000','2024-09-15 12:52:19','com',NULL),(45,'그린아카데미','rmfls','$2a$10$5XYlf9dguuOAB9NYbd0HJ.iFJ1z7mOmzLZ0F/kM.YCRiHdLiRVWeG',NULL,'js11000@naver.com','2024-09-12','설정안함','051-1234-5673','2024-09-17 09:47:02','com',NULL),(46,'이윤서','112834629667400343633','$2a$10$QoOdPzd0Y0Y39M7huIXzuOqbB0jeCxj9gwH6k5GJkxAzJdG3sNWHG','','dbstjlee@gmail.com','2024-09-19','여성','010-2222-2222','2024-09-18 15:16:02','google',NULL),(47,'조현재','113128687525658533947','$2a$10$DE8YOpOa//sRbjS.XcpZjOfkRj8rW3p4Oc/yIWkaDIKk3hHRR/3SC','홍길동','guswo515@gmail.com','2024-09-19','남성','010-1234-1234','2024-09-19 01:49:50','google',NULL),(49,'yoon','yoon','$2a$10$EEVCCo90cD3C9/m0pd4xX.Cmq9ShLjZQaR58AmODqW48WCLza4Vzm','yoon','dbstjlee@naver.com','2024-09-20','설정안함','010-1111-1111','2024-09-20 06:17:04','local',NULL),(50,'샘플사용자1','user001','$2a$10$4Ab6AC5t8BljJTLGVwWcu.7PvP18ovXw5uoyHHHyAL7BOKw9L.6Mu','nickname001','user001@invalid-email.com','1990-01-01','남성','010-0000-0001','2023-12-31 15:00:01','local',NULL);
/*!40000 ALTER TABLE `user_backup` ENABLE KEYS */;
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

-- Dump completed on 2024-09-30 15:57:14
