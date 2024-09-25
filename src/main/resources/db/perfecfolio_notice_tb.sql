-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
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
-- Table structure for table `notice_tb`
--

DROP TABLE IF EXISTS `notice_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_tb` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categories` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `views` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_tb`
--

LOCK TABLES `notice_tb` WRITE;
/*!40000 ALTER TABLE `notice_tb` DISABLE KEYS */;
INSERT INTO `notice_tb` VALUES (237,'업데이트','이용 약관 변경','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-04-02 18:29:10',804),(238,'공지사항','고객센터 이전','휴무일 안내드립니다. 이용에 착오 없으시기 바랍니다.','2024-07-14 20:35:08',620),(239,'업데이트','운영 정책 변경','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-01-07 20:25:04',181),(240,'공지사항','긴급 서버 점검','계정 보안 강화를 위해 비밀번호를 변경해 주세요.','2024-08-14 05:03:53',623),(241,'이벤트','긴급 서버 점검','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-09-14 18:56:56',220),(242,'업데이트','운영 정책 변경','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-05-24 08:16:58',461),(243,'업데이트','공지사항 확인 요청','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-03-13 01:09:23',101),(244,'점검','회원 가입 혜택','운영 정책이 일부 변경되었습니다. 변경된 사항을 꼭 확인해 주세요.','2024-06-19 03:17:01',502),(245,'공지사항','보안 패치 안내','포인트 적립 방법에 대해 안내드립니다. 자세한 사항은 공지를 확인해주세요.','2024-07-27 04:22:44',833),(246,'공지사항','보안 패치 안내','특별 할인 이벤트가 진행 중입니다. 지금 바로 참여하세요!','2024-04-01 10:40:44',615),(247,'점검','시스템 유지보수','이번 업데이트를 통해 새로운 기능이 추가되었습니다. 자세한 사항은 공지를 확인해주세요.','2024-05-03 12:18:27',216),(248,'공지사항','공지사항 확인 요청','서버 점검이 진행될 예정입니다. 서비스 이용에 참고하시기 바랍니다.','2024-02-22 09:13:59',656),(249,'기타','앱 사용법 안내','보안 패치가 적용되었습니다. 고객님의 안전한 서비스 이용을 위해 보안을 강화했습니다.','2024-02-26 22:48:24',703),(250,'업데이트','긴급 서버 점검','일부 결제 오류가 발생하고 있습니다. 고객센터로 문의 주시면 빠르게 처리해드리겠습니다.','2024-07-28 11:47:29',273),(251,'공지사항','이용 약관 변경','고객센터 이전 안내드립니다. 새로운 주소로 방문해 주세요.','2024-02-17 07:00:15',554),(252,'점검','업데이트 내용 공지','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-06-18 18:58:54',724),(253,'이벤트','결제 오류 안내','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-03-17 23:04:29',666),(254,'업데이트','운영 정책 변경','새로운 기능이 추가되었습니다. 더욱 편리해진 서비스를 이용해보세요.','2024-08-15 11:33:38',252),(255,'이벤트','긴급 서버 점검','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-03-19 17:52:04',37),(256,'점검','고객센터 이전','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-02-19 02:34:51',195),(257,'공지사항','이벤트 참여 방법','특별 할인 이벤트가 진행 중입니다. 지금 바로 참여하세요!','2024-01-23 19:07:00',311),(258,'이벤트','고객센터 이전','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-01-24 22:41:55',424),(259,'점검','결제 오류 안내','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-02-16 00:27:28',284),(260,'공지사항','보안 패치 안내','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-01-18 16:45:52',466),(261,'이벤트','할인 이벤트','운영 정책이 일부 변경되었습니다. 변경된 사항을 꼭 확인해 주세요.','2024-09-01 23:19:58',893),(262,'기타','이용 약관 변경','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-05-06 18:00:31',359),(263,'이벤트','포인트 적립 안내','특별 할인 이벤트가 진행 중입니다. 지금 바로 참여하세요!','2024-04-04 14:03:13',999),(264,'이벤트','서비스 점검 안내','일부 결제 오류가 발생하고 있습니다. 고객센터로 문의 주시면 빠르게 처리해드리겠습니다.','2024-01-14 00:11:18',813),(265,'이벤트','업데이트 내용 공지','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-04-30 05:38:26',515),(266,'업데이트','휴무일 안내','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-06-15 16:49:24',493),(267,'점검','모바일 앱 업데이트','계정 보안 강화를 위해 비밀번호를 변경해 주세요.','2024-06-06 20:55:19',319),(268,'기타','결제 오류 안내','계정 보안 강화를 위해 비밀번호를 변경해 주세요.','2024-03-30 20:18:45',368),(269,'공지사항','긴급 서버 점검','휴무일 안내드립니다. 이용에 착오 없으시기 바랍니다.','2024-01-25 10:03:37',107),(270,'기타','이용 약관 변경','포인트 적립 방법에 대해 안내드립니다. 자세한 사항은 공지를 확인해주세요.','2024-04-15 02:23:31',202),(271,'이벤트','보안 패치 안내','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-03-02 08:33:40',423),(272,'점검','이용 약관 변경','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-03-23 04:28:55',596),(273,'공지사항','시스템 유지보수','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-05-29 17:10:24',235),(274,'업데이트','고객센터 이전','일부 결제 오류가 발생하고 있습니다. 고객센터로 문의 주시면 빠르게 처리해드리겠습니다.','2024-02-11 23:59:16',412),(275,'공지사항','앱 사용법 안내','운영 정책이 일부 변경되었습니다. 변경된 사항을 꼭 확인해 주세요.','2024-08-23 16:44:26',710),(276,'기타','업데이트 내용 공지','보안 패치가 적용되었습니다. 고객님의 안전한 서비스 이용을 위해 보안을 강화했습니다.','2024-06-04 15:01:50',751),(277,'공지사항','긴급 서버 점검','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-03-02 05:43:01',829),(278,'기타','결제 오류 안내','새로운 기능이 추가되었습니다. 더욱 편리해진 서비스를 이용해보세요.','2024-07-15 09:15:14',872),(279,'공지사항','새로운 기능 추가','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-01-31 06:47:17',936),(280,'기타','업데이트 내용 공지','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-05-04 16:25:24',75),(281,'공지사항','이벤트 참여 방법','고객센터 이전 안내드립니다. 새로운 주소로 방문해 주세요.','2024-01-01 11:31:22',230),(282,'이벤트','고객센터 이전','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-09-06 11:52:08',95),(283,'공지사항','앱 사용법 안내','중요 공지사항이 있으니 확인 부탁드립니다.','2024-02-21 12:35:13',569),(284,'점검','운영 정책 변경','모바일 앱이 업데이트되었습니다. 최신 버전으로 업데이트하고 새로운 기능을 사용해보세요.','2024-02-28 23:16:57',523),(285,'공지사항','결제 오류 안내','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-01-23 17:37:31',412),(286,'공지사항','모바일 앱 업데이트','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-03-17 12:22:37',902),(287,'이벤트','이용 약관 변경','회원 가입 시 다양한 혜택을 제공해드립니다. 지금 바로 가입해보세요.','2024-08-05 19:12:44',164),(288,'이벤트','이용 약관 변경','특별 할인 이벤트가 진행 중입니다. 지금 바로 참여하세요!','2024-02-18 03:42:52',235),(289,'점검','시스템 유지보수','보안 패치가 적용되었습니다. 고객님의 안전한 서비스 이용을 위해 보안을 강화했습니다.','2024-08-05 08:54:49',113),(290,'이벤트','회원 가입 혜택','포인트 적립 방법에 대해 안내드립니다. 자세한 사항은 공지를 확인해주세요.','2024-03-05 11:38:07',780),(291,'공지사항','결제 오류 안내','운영 정책이 일부 변경되었습니다. 변경된 사항을 꼭 확인해 주세요.','2024-05-25 19:59:31',676),(292,'업데이트','시스템 유지보수','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-05-31 15:13:45',437),(293,'업데이트','이벤트 참여 방법','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-01-21 16:59:49',241),(294,'이벤트','계정 보안 강화','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-04-09 16:08:31',247),(295,'업데이트','업데이트 내용 공지','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-04-26 15:12:40',879),(296,'기타','앱 사용법 안내','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-03-07 07:38:09',411),(297,'업데이트','고객센터 이전','이번 업데이트를 통해 새로운 기능이 추가되었습니다. 자세한 사항은 공지를 확인해주세요.','2024-08-21 11:29:22',401),(298,'업데이트','이용 약관 변경','특별 할인 이벤트가 진행 중입니다. 지금 바로 참여하세요!','2024-07-05 18:58:07',696),(299,'점검','할인 이벤트','회원 가입 시 다양한 혜택을 제공해드립니다. 지금 바로 가입해보세요.','2024-08-22 18:54:59',975),(300,'점검','모바일 앱 업데이트','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-03-29 10:56:19',456),(301,'기타','할인 이벤트','특별 할인 이벤트가 진행 중입니다. 지금 바로 참여하세요!','2024-02-19 13:11:07',82),(302,'점검','고객센터 이전','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-08-27 08:45:02',620),(303,'공지사항','모바일 앱 업데이트','고객센터 이전 안내드립니다. 새로운 주소로 방문해 주세요.','2024-08-31 09:35:40',936),(304,'기타','운영 정책 변경','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-08-11 23:49:06',180),(305,'이벤트','이벤트 참여 방법','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-05-14 13:04:00',34),(306,'업데이트','업데이트 내용 공지','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-01-30 20:35:34',669),(307,'공지사항','휴무일 안내','회원 가입 시 다양한 혜택을 제공해드립니다. 지금 바로 가입해보세요.','2024-06-10 19:52:50',448),(308,'업데이트','신규 상품 출시','보안 패치가 적용되었습니다. 고객님의 안전한 서비스 이용을 위해 보안을 강화했습니다.','2024-02-28 02:26:25',391),(309,'업데이트','신규 상품 출시','휴무일 안내드립니다. 이용에 착오 없으시기 바랍니다.','2024-01-27 10:28:20',28),(310,'이벤트','앱 사용법 안내','모바일 앱이 업데이트되었습니다. 최신 버전으로 업데이트하고 새로운 기능을 사용해보세요.','2024-04-05 09:44:31',771),(311,'기타','계정 보안 강화','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-05-11 10:17:40',759),(312,'이벤트','결제 오류 안내','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-03-10 17:29:49',384),(313,'점검','신규 상품 출시','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-03-07 13:47:56',617),(314,'점검','앱 사용법 안내','서버 점검이 진행될 예정입니다. 서비스 이용에 참고하시기 바랍니다.','2024-08-22 03:22:36',337),(315,'업데이트','운영 정책 변경','계정 보안 강화를 위해 비밀번호를 변경해 주세요.','2024-02-19 10:34:38',856),(316,'기타','신규 상품 출시','계정 보안 강화를 위해 비밀번호를 변경해 주세요.','2024-01-08 00:45:33',425),(317,'공지사항','앱 사용법 안내','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-03-11 14:19:25',744),(318,'이벤트','이벤트 참여 방법','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-04-24 17:41:02',628),(319,'이벤트','계정 보안 강화','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-03-22 11:26:46',967),(320,'이벤트','계정 보안 강화','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-02-25 23:36:15',911),(321,'기타','시스템 유지보수','이벤트 참여 방법을 안내드립니다. 참여하시고 다양한 혜택을 받아보세요!','2024-02-29 21:15:47',43),(322,'이벤트','휴무일 안내','휴무일 안내드립니다. 이용에 착오 없으시기 바랍니다.','2024-06-28 06:36:15',987),(323,'업데이트','이용 약관 변경','이번 업데이트를 통해 새로운 기능이 추가되었습니다. 자세한 사항은 공지를 확인해주세요.','2024-05-28 01:18:18',609),(324,'기타','신규 상품 출시','모바일 앱이 업데이트되었습니다. 최신 버전으로 업데이트하고 새로운 기능을 사용해보세요.','2024-09-14 01:52:38',141),(325,'점검','새로운 기능 추가','중요 공지사항이 있으니 확인 부탁드립니다.','2024-05-23 01:32:17',259),(326,'이벤트','운영 정책 변경','휴무일 안내드립니다. 이용에 착오 없으시기 바랍니다.','2024-08-06 00:44:26',67),(327,'기타','서비스 점검 안내','앱 사용 방법에 대한 자세한 안내입니다. 편리하게 이용하시길 바랍니다.','2024-04-07 22:11:25',870),(328,'공지사항','시스템 유지보수','휴무일 안내드립니다. 이용에 착오 없으시기 바랍니다.','2024-04-12 15:39:05',306),(329,'공지사항','운영 정책 변경','포인트 적립 방법에 대해 안내드립니다. 자세한 사항은 공지를 확인해주세요.','2024-02-15 01:46:30',815),(330,'공지사항','회원 가입 혜택','시스템 유지보수 작업이 예정되어 있습니다. 서비스 이용에 참고해 주세요.','2024-06-25 21:15:07',164),(331,'업데이트','공지사항 확인 요청','고객센터 이전 안내드립니다. 새로운 주소로 방문해 주세요.','2024-08-02 13:52:52',868),(332,'업데이트','공지사항 확인 요청','긴급 서버 점검이 예정되어 있습니다. 불편을 드려 죄송합니다.','2024-05-23 11:04:57',442),(333,'공지사항','공지사항 확인 요청','새로운 기능이 추가되었습니다. 더욱 편리해진 서비스를 이용해보세요.','2024-01-24 01:38:22',273),(334,'이벤트','이용 약관 변경','이용 약관이 변경되었습니다. 확인 후 동의해 주세요.','2024-01-27 05:18:35',845),(335,'이벤트','휴무일 안내','신규 상품이 출시되었습니다. 많은 관심 부탁드립니다.','2024-04-29 16:50:08',405),(336,'공지사항','이벤트 참여 방법','중요 공지사항이 있으니 확인 부탁드립니다.','2024-06-08 16:18:27',416);
/*!40000 ALTER TABLE `notice_tb` ENABLE KEYS */;
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

-- Dump completed on 2024-09-25  9:58:36
