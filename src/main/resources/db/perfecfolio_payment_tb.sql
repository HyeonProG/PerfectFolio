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
-- Table structure for table `payment_tb`
--

DROP TABLE IF EXISTS `payment_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `last_transaction_key` varchar(64) NOT NULL,
  `payment_key` varchar(255) NOT NULL,
  `order_id` varchar(64) NOT NULL,
  `order_name` varchar(30) NOT NULL,
  `billing_key` varchar(255) NOT NULL,
  `customer_key` varchar(255) NOT NULL,
  `amount` int NOT NULL,
  `total_amount` int NOT NULL,
  `requested_at` varchar(255) NOT NULL,
  `approved_at` varchar(255) NOT NULL,
  `cancel` enum('Y','N') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_tb`
--

LOCK TABLES `payment_tb` WRITE;
/*!40000 ALTER TABLE `payment_tb` DISABLE KEYS */;
INSERT INTO `payment_tb` VALUES (19,1,'\"48721A5FC18A590C1A48A442885A4697\"','\"tviva2024090612182129w88\"','\"c477a5a4-8c9f-44b3-9fb8-531231debf18\"','\"정기 결제\"','MRwKeLWtA-sYf5Jkb5dDfEk7tdfq4K7sJKdLosll5VQ=','zea452l7km',10000,10000,'\"2024-09-06T12:18:21+09:00\"','\"2024-09-06T12:18:21+09:00\"','Y'),(20,2,'3E4513B98BB4BB1EB75ABF4FCADBB4DC','tviva202409081914436Q246','ab2b01f0-e857-4da1-98cf-a3fd1182c1a7','정기 결제','BtDlcU1euxwsLegvamoKsBVvOadGoMT2FC52m7yRfZw=','ntuwhl4ssu',10000,10000,'2024-09-08T19:14:43+09:00','2024-09-08T19:14:43+09:00','Y'),(21,3,'D74F2A17B2EF0710D66CFB6023F02C38','tviva20240909224623bIC46','8b0798c2-d25b-48ab-b25f-499644de8b54','정기 결제','2pIJU97I8ibPRT8LpWutDk9GYPova7XsiEPpLMYnCBg=','r1u8579ft3',10000,10000,'2024-09-09T22:46:23+09:00','2024-09-09T22:46:23+09:00','N'),(22,28,'5A61E4D28CCE29A34A340934D1ED3E20','tviva20240911144053hSk17','c5cee739-c8ee-4d89-893e-b6edd4c95537','정기 결제','ADsGj61Y7d6k5fiU5C3Uloq_Er82J3evOFQQ3rKEDfs=','eng0miqjch',10000,10000,'2024-09-11T14:40:53+09:00','2024-09-11T14:40:53+09:00','N'),(24,30,'DE612CF011BF73AB5B182CE208E794C4','tviva20240912194402ciqs2','fd2452da-cba2-480e-838f-1a5dbfd42e09','정기 결제','124t1pA2jvT69I8sb6uw59EI516qoZEyE3YTVuj-IWA=','80xuk5rnfd',10000,10000,'2024-09-12T19:44:02+09:00','2024-09-12T19:44:02+09:00','N'),(25,31,'ABC89DCF7DB154D8F2EC393AAE28763C','tviva20240913013137cKUt5','bcd834b8-54ec-40f6-89ae-add07f5a96d5','정기 결제','zC-0xGTQsZa87uqdsxLbrfj7ij3Shwn565H2F0pWPbg=','tvrg2c5xs7',10000,10000,'2024-09-13T01:31:37+09:00','2024-09-13T01:31:37+09:00','N'),(26,31,'A3B26BC87DDAF73AC90408114FFD457E','tviva20240913112636bbNr9','9226b05b-ded4-4112-b44b-c33294fa2035','정기 결제','b_jUOwMMUf4vhqHkbsspJ5GusIC11_oO96B6qI70ra4=','axp2w6tj2v',10000,10000,'2024-09-13T11:26:36+09:00','2024-09-13T11:26:36+09:00','N'),(27,30,'A132C9B7585F1B5B2933C6A2DC716E7C','tviva20240913120529lyZQ0','566fd73e-d9e3-4335-bb05-f6b918e0de0a','정기 결제','SG4fXm5p1hbaTKqE9UIJw5lzrBzMFSF52pKzSGQOQ80=','dvzhy3b35y',10000,10000,'2024-09-13T12:05:29+09:00','2024-09-13T12:05:30+09:00','N'),(28,30,'61252322F6F7A8BAB01E07E31F061EA3','tviva20240913121004hjXj3','eb8a37bd-0652-459b-b421-6d72e973d841','정기 결제','DNRQylp5yp9YryCLWzkJ1ygsVGMcrVoG_Q2XaFNfLBY=','1qx3c59im7',10000,10000,'2024-09-13T12:10:04+09:00','2024-09-13T12:10:04+09:00','N'),(29,30,'59210730E499E206767C117A9680C7E0','tviva20240913125124cpOQ2','e423a6e9-8f68-4374-bf84-cffc59a759fb','정기 결제','RpfeGkAV8YjGNsSPxi3N_NVKrhOR6yFo4lZl47gc0WY=','ppcz95bfml',10000,10000,'2024-09-13T12:51:24+09:00','2024-09-13T12:51:24+09:00','N'),(30,31,'BB91F3361C3BE7E8378A6FA3A7BADD85','tviva20240913144833kXfN5','ca98b6c3-d345-40ef-b3ed-b7530ed01682','정기 결제','C7aF3opIxA3KVYsCW6T8JKsxsyz2q4HXbjpVVnjcA3w=','htg2797rtb',10000,10000,'2024-09-13T14:48:33+09:00','2024-09-13T14:48:33+09:00','N'),(31,31,'CCC84D47946F8B62B4F880781B45FD9B','tviva20240913155045eTNy2','42260d4e-2944-412b-8cd5-95f0e05408d4','Premium','UD6molOdT4uIO5pjYkUvJSz9szSfs3SE5np7ivr_xe8=','cmuik1ad75',12900,12900,'2024-09-13T15:50:45+09:00','2024-09-13T15:50:45+09:00','N'),(32,500,'338A1C3CC6C305727C92BF3B150E0182','tviva202409231244288rVr9','2d7cd336-6d59-4472-9272-3ce49bc05a40','basic','z6tfMyiQ6zbleLhhYN_vP0boq8aKQFYtJL3JRY0KKX4=','gp78x3mvvh',5900,5900,'2024-09-23T12:44:28+09:00','2024-09-23T12:44:28+09:00','N'),(33,501,'B39ECC16E6B9C7A3A3B6755B8CFB23A0','tviva202409231300168ucK0','d03e5c97-6bf7-4992-b96b-cc9940853c2f','basic','RFrjhERO0TQRegJ7LELlJCEjkCa7vvmny8iR0c4MmQo=','i6gpnc1rc6',5900,5900,'2024-09-23T13:00:16+09:00','2024-09-23T13:00:16+09:00','N'),(34,502,'E07A9A84BEDEF620741F67A113FB046E','tviva202409231311295Acp3','8c993406-03f3-4cbc-a290-d04e0a1af877','premium','Sa3Vp96QNV807pObOhGuLcSFK0h4_qXZDowj1tE5XY8=','ttfjays9br',12900,12900,'2024-09-23T13:11:29+09:00','2024-09-23T13:11:29+09:00','N'),(35,503,'62CE6EE95F732B0F85AAB867F5D8F5DE','tviva202409231326085Cie2','d8fcfc66-09c7-46a7-a7ef-4cd9eef7422b','basic','v-wI5-7Bamv2_EXS6Xe2jfsHzrKWYiVs-aWtIKj3o-w=','4wu7nce6bh',5900,5900,'2024-09-23T13:26:08+09:00','2024-09-23T13:26:08+09:00','N'),(36,504,'6488E46BC95AA5EED1E73E7ADA40D081','tviva20240925182200BmMP5','b345bb10-bab0-440f-ac7e-aa6990715432','basic','fzNiB5I5c3s8OZn4oUshC7M5L1sJymCMEunCAjtNH8Q=','8hlgnjh4ob',5900,5900,'2024-09-25T18:22:00+09:00','2024-09-25T18:22:00+09:00','N'),(37,47,'BDDE6133479532446DAA3CE940CDE599','tviva20240925183648Osyj9','5644edc6-1543-4f76-b3f0-76d3a3aeb239','premium','S2EhmevzVe6Mu3_D0wazmysxMukSZu6nPmzrOtr2dcY=','ggakmjyhke',12900,12900,'2024-09-25T18:36:48+09:00','2024-09-25T18:36:48+09:00','N'),(38,505,'EC0E4DC2E5A0B49FB4803A84FD9DC9AD','tviva20240925184227DqSg8','03b1bb30-6ab6-4cca-a56e-6df2a2a2bb43','basic','H2ealzJvR-rnXbL4K1xB71Nxfn6oM8u8q7QeVnsgCYs=','1oxh6le6uj',5900,5900,'2024-09-25T18:42:27+09:00','2024-09-25T18:42:27+09:00','N'),(39,506,'45DD8B46C51C8435C96460BD906A098C','tviva20240925190517A8GM4','9239e7eb-6008-4784-88b0-cb1b325feacd','basic','W_OfObKlGcZjHGLQOkGWkiGE41gMNfSikgwwYW6CRb8=','zsjhidnopu',5900,5900,'2024-09-25T19:05:17+09:00','2024-09-25T19:05:18+09:00','N'),(40,507,'988C555ECC23EA6B629A302CB0ADFAF7','tviva20240925192029Cj4s2','32983206-ce73-4277-9fd9-ae0ad8728ee2','basic','ces8aTyi0kVkeAtVQnUC5q2do7C6sxKZzumyVGr001o=','kcrikqrxd0',5900,5900,'2024-09-25T19:20:29+09:00','2024-09-25T19:20:29+09:00','N'),(41,508,'9882190815D858FFE363EEA0E984455F','tviva20240925192202zTQS8','e384b346-1507-4058-9f39-0414f334a711','basic','PCIuwQwM99Qn1GbO2K-FMsalclaWdbNG-qtztkAWrLs=','88r9nbuxzc',5900,5900,'2024-09-25T19:22:02+09:00','2024-09-25T19:22:03+09:00','N');
/*!40000 ALTER TABLE `payment_tb` ENABLE KEYS */;
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
