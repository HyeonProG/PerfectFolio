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
-- Table structure for table `ad_application`
--

DROP TABLE IF EXISTS `ad_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `view_count` int DEFAULT '0',
  `click_count` int DEFAULT '0',
  `site` text NOT NULL,
  `origin_file_name` varchar(255) NOT NULL,
  `upload_file_name` varchar(255) NOT NULL,
  `state` enum('대기','승인','중지','거절','취소') DEFAULT '대기',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_application`
--

LOCK TABLES `ad_application` WRITE;
/*!40000 ALTER TABLE `ad_application` DISABLE KEYS */;
INSERT INTO `ad_application` VALUES (31,1,'boottent','boottent',30,7,'https://boottent.com/','boottent.png','51bf659a-7b7e-4c95-b6e8-0c9dda665219_boottent.png','승인','2024-09-23 01:03:48'),(32,1,'elice','elice',322,23,'https://elice.training/','elice.png','a9ec1b34-2091-440e-8af8-2495679754d8_elice.png','승인','2024-09-23 01:04:05'),(33,1,'naebaecamp','naebaecamp',351,43,'https://nbcamp.spartacodingclub.kr/','naebaecamp.png','1b2d1a63-9c1a-4f7e-bf7e-4e042d03ff23_naebaecamp.png','승인','2024-09-23 01:04:25'),(34,1,'boottent2','boottent2',131,36,'https://boottent.com/','boottent2.png','fa84378d-7765-4339-aa2d-ffef9b68dab9_boottent2.png','승인','2024-09-23 01:04:41'),(36,1,'bootcamp','bootcamp',0,0,'https://www.naver.com','fa84378d-7765-4339-aa2d-ffef9b68dab9_boottent2.png','b2bba8d2-1b9e-4f25-9bac-f4f5b202c5ed_fa84378d-7765-4339-aa2d-ffef9b68dab9_boottent2.png','중지','2024-09-25 03:18:08'),(37,1,'adimage','adimage',4,1,'https://www.naver.com','fa84378d-7765-4339-aa2d-ffef9b68dab9_boottent2.png','94b470f1-7780-4f55-a69b-ef406e77d9ae_fa84378d-7765-4339-aa2d-ffef9b68dab9_boottent2.png','승인','2024-09-25 03:31:26'),(38,5,'adimage','adimage',50,2,'https://www.naver.com','a9ec1b34-2091-440e-8af8-2495679754d8_elice.png','4d10a7b6-e4c8-4032-b82a-b92cd6e2a153_a9ec1b34-2091-440e-8af8-2495679754d8_elice.png','승인','2024-09-25 08:29:58');
/*!40000 ALTER TABLE `ad_application` ENABLE KEYS */;
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

-- Dump completed on 2024-09-30 15:57:18
