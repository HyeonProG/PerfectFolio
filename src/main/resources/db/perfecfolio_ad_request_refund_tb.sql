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
-- Table structure for table `ad_request_refund_tb`
--

DROP TABLE IF EXISTS `ad_request_refund_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ad_request_refund_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `paymentDate` varchar(100) NOT NULL,
  `paymentAmount` varchar(100) NOT NULL,
  `refundAmount` varchar(100) NOT NULL,
  `reason` varchar(100) NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `approved` enum('승인','대기중','반려') DEFAULT '대기중' COMMENT '관리자 승인 여부',
  `reject_reason` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ad_request_refund_tb`
--

LOCK TABLES `ad_request_refund_tb` WRITE;
/*!40000 ALTER TABLE `ad_request_refund_tb` DISABLE KEYS */;
INSERT INTO `ad_request_refund_tb` VALUES (1,'2024년 9월 19일','5만원','2만원','결제 실수',1,'2024-09-19 08:18:44','승인',NULL),(2,'2024년 9월 11일','3만원','1만원','결제 실수',1,'2024-09-19 08:18:50','승인',NULL),(3,'2024년3월 2일','7만원','4만원','단순변심',1,'2024-09-19 15:40:15','승인',NULL),(4,'2024-09-13 15:15','30000','10000','단순 변심',1,'2024-09-20 03:17:36','승인',NULL),(5,'2024-09-20','10000','10000','결제 실수',1,'2024-09-20 03:35:38','대기중',NULL),(6,'2024-20-09 12:34','10000','10000','단순 변심',1,'2024-09-20 05:23:31','대기중',NULL),(7,'2024-20-09 12:34','10000','10000','단순 변심',1,'2024-09-20 05:25:51','대기중',NULL);
/*!40000 ALTER TABLE `ad_request_refund_tb` ENABLE KEYS */;
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

-- Dump completed on 2024-09-30 15:57:08
