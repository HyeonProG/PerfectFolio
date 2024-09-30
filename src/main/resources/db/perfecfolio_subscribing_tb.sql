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
-- Table structure for table `subscribing_tb`
--

DROP TABLE IF EXISTS `subscribing_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribing_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscribing` enum('Y','N') NOT NULL,
  `order_name` varchar(10) NOT NULL,
  `billing_key` varchar(255) NOT NULL,
  `customer_key` varchar(255) NOT NULL,
  `amount` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `next_pay` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribing_tb`
--

LOCK TABLES `subscribing_tb` WRITE;
/*!40000 ALTER TABLE `subscribing_tb` DISABLE KEYS */;
INSERT INTO `subscribing_tb` VALUES (1,'N','정기 결제','b_jUOwMMUf4vhqHkbsspJ5GusIC11_oO96B6qI70ra4=','axp2w6tj2v',10000,31,'2024-09-13 02:26:36','2024-10-13'),(2,'Y','basic','qpdlwlr','qpdlwlrdlqslek',10000,26,'2024-09-13 03:01:50','2024-10-13'),(3,'N','정기 결제','SG4fXm5p1hbaTKqE9UIJw5lzrBzMFSF52pKzSGQOQ80=','dvzhy3b35y',10000,30,'2024-09-13 03:05:30','2024-10-13'),(4,'N','정기 결제','DNRQylp5yp9YryCLWzkJ1ygsVGMcrVoG_Q2XaFNfLBY=','1qx3c59im7',10000,30,'2024-09-13 03:10:05','2024-10-13'),(5,'Y','premium','qpdlwlr','qpdlwlrdlqslek',10000,37,'2024-09-13 03:49:05','2024-10-13'),(6,'Y','premium','qpdlwlr','qpdlwlrdlqslek',10000,37,'2024-09-13 03:49:42','2024-10-13'),(7,'N','정기 결제','RpfeGkAV8YjGNsSPxi3N_NVKrhOR6yFo4lZl47gc0WY=','ppcz95bfml',10000,30,'2024-09-13 03:51:24','2024-10-13'),(8,'N','정기 결제','C7aF3opIxA3KVYsCW6T8JKsxsyz2q4HXbjpVVnjcA3w=','htg2797rtb',10000,31,'2024-09-13 05:48:34','2024-10-13'),(9,'Y','premium','qpdlwlr','qpdlwlrdlqslek',10000,37,'2024-09-13 06:23:21','2024-10-13'),(10,'N','Premium','UD6molOdT4uIO5pjYkUvJSz9szSfs3SE5np7ivr_xe8=','cmuik1ad75',12900,31,'2024-09-13 06:50:45','2024-10-13'),(11,'Y','premium','testAnalystic','insertTest',12900,1,'2024-09-19 01:47:19','0000-00-00'),(12,'Y','basic','z6tfMyiQ6zbleLhhYN_vP0boq8aKQFYtJL3JRY0KKX4=','gp78x3mvvh',5900,500,'2024-09-23 03:44:29','2024-10-23'),(13,'N','basic','RFrjhERO0TQRegJ7LELlJCEjkCa7vvmny8iR0c4MmQo=','i6gpnc1rc6',5900,501,'2024-09-23 04:00:16','2024-10-23'),(14,'N','premium','Sa3Vp96QNV807pObOhGuLcSFK0h4_qXZDowj1tE5XY8=','ttfjays9br',12900,502,'2024-09-23 04:11:30','2024-10-23'),(15,'Y','basic','v-wI5-7Bamv2_EXS6Xe2jfsHzrKWYiVs-aWtIKj3o-w=','4wu7nce6bh',5900,503,'2024-09-23 04:26:08','2024-10-23'),(16,'N','basic','fzNiB5I5c3s8OZn4oUshC7M5L1sJymCMEunCAjtNH8Q=','8hlgnjh4ob',5900,504,'2024-09-25 09:22:01','2024-10-25'),(17,'Y','premium','S2EhmevzVe6Mu3_D0wazmysxMukSZu6nPmzrOtr2dcY=','ggakmjyhke',12900,47,'2024-09-25 09:36:48','2024-10-25'),(18,'N','basic','H2ealzJvR-rnXbL4K1xB71Nxfn6oM8u8q7QeVnsgCYs=','1oxh6le6uj',5900,505,'2024-09-25 09:42:27','2024-10-25'),(19,'N','basic','W_OfObKlGcZjHGLQOkGWkiGE41gMNfSikgwwYW6CRb8=','zsjhidnopu',5900,506,'2024-09-25 10:05:18','2024-10-25'),(20,'N','basic','ces8aTyi0kVkeAtVQnUC5q2do7C6sxKZzumyVGr001o=','kcrikqrxd0',5900,507,'2024-09-25 10:20:30','2024-10-25'),(21,'Y','basic','PCIuwQwM99Qn1GbO2K-FMsalclaWdbNG-qtztkAWrLs=','88r9nbuxzc',5900,508,'2024-09-25 10:22:03','2024-10-25');
/*!40000 ALTER TABLE `subscribing_tb` ENABLE KEYS */;
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

-- Dump completed on 2024-09-30 15:57:13
