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
-- Table structure for table `withdraw_reason_tb`
--

DROP TABLE IF EXISTS `withdraw_reason_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `withdraw_reason_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `reason_detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdraw_reason_tb`
--

LOCK TABLES `withdraw_reason_tb` WRITE;
/*!40000 ALTER TABLE `withdraw_reason_tb` DISABLE KEYS */;
INSERT INTO `withdraw_reason_tb` VALUES (1,'Seoyeon1','멤버십이 마음에 들지 않아요.',NULL),(2,'Jihoon9','사이트를 자주 방문하지 않아요.',NULL),(3,'Minjun7','멤버십이 마음에 들지 않아요.',NULL),(4,'Jimin4','가격이 비싸요.',NULL),(5,'Woosung2','멤버십이 마음에 들지 않아요.',NULL),(6,'Yujin3','기타 사유','test1'),(7,'Sungyeon5','기타 사유','test2'),(8,'Haneul6','기타 사유','test3'),(9,'Dongwon8','기타 사유','test4'),(10,'Jiyoung7','기타 사유','test5'),(11,'Taehun9','사이트를 자주 방문하지 않아요.',NULL),(12,'Areum1','사이트를 자주 방문하지 않아요.',NULL),(13,'Hankil2','기타 사유','test6'),(14,'Seojin3','사이트를 자주 방문하지 않아요.',NULL),(15,'Minhyuk4','가격이 비싸요.',NULL),(16,'Sumin5','가격이 비싸요.',NULL),(17,'Dohyeon7','기타 사유','test7'),(18,'Hayoung6','새 계정을 만들고 싶어요.',NULL),(19,'Eunji8','새 계정을 만들고 싶어요.',NULL),(20,'Junho9','가격이 비싸요.',NULL),(22,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','가격이 비싸요.',NULL),(23,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','사이트를 자주 방문하지 않아요.',NULL),(24,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','가격이 비싸요.',NULL),(25,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','사이트를 자주 방문하지 않아요.',NULL),(26,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','새 계정을 만들고 싶어요.',NULL),(27,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','새 계정을 만들고 싶어요.',NULL),(28,'o8jCKegV9krW4C0FPWhI22XZvYceD0Ywj2qHW7o6MdA','멤버십이 마음에 들지 않아요.',NULL),(42,'yoon','기타 사유','test 입니다!'),(43,'112834629667400343633','사이트를 자주 방문하지 않아요.',NULL);
/*!40000 ALTER TABLE `withdraw_reason_tb` ENABLE KEYS */;
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

-- Dump completed on 2024-09-30 15:57:07
