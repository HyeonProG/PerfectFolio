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
-- Table structure for table `question_tb`
--

DROP TABLE IF EXISTS `question_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `question_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categories` varchar(30) NOT NULL COMMENT '회원정보, 구독/결제, 포트폴리오',
  `title` varchar(30) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `writer` varchar(30) NOT NULL,
  `content` varchar(255) NOT NULL,
  `created_at` date NOT NULL,
  `views` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_tb`
--

LOCK TABLES `question_tb` WRITE;
/*!40000 ALTER TABLE `question_tb` DISABLE KEYS */;
INSERT INTO `question_tb` VALUES (2,'포트폴리오','포트폴리오 질문','34','오효정','포트폴리오 질문 포트폴리오 질문','2024-08-30',6),(5,'구독/결제','정기 결제 문의','37','HJ','정기 결제 문의 정기 결제 문의','2024-09-01',8),(6,'회원정보','아이디 수정 요청','34','오효정','아이디를 수정하고 싶습니다.','2024-09-01',2),(8,'회원정보','이메일 수정 요청','37','HJ','이메일 수정 요청 이메일 수정 요청','2024-09-03',2),(9,'구독/결제','연 단위 결제 문의','37','HJ','연 단위 결제 문의 연 단위 결제 문의','2024-09-03',0),(10,'포트폴리오','새로운 언어 추가 질문','37','HJ','새로운 언어 추가 질문 새로운 언어 추가 질문','2024-09-03',6),(11,'회원정보','이름을 수정하고 싶습니다.','50','땅콩','이름 이름 이름 이름','2024-09-04',6),(12,'회원정보','이름을 수정하고 싶습니다.222','50','땅콩','이름 이름 이름 이름','2024-09-04',26),(14,'포트폴리오','질문','31','HJ','ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ','2024-09-20',6),(15,'회원정보','ㅁㅁㅁㅁ','31','HJ','ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ','2024-09-20',6),(16,'구독/결제','ㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂ','31','HJ','ㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂ','2024-09-20',23),(17,'회원정보','333333333333333','31','HJ','333333333333333333333','2024-09-20',44);
/*!40000 ALTER TABLE `question_tb` ENABLE KEYS */;
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

-- Dump completed on 2024-09-30 15:57:21
