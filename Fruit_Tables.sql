-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: mysqldb
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_orderlist`
--

DROP TABLE IF EXISTS `t_orderlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_orderlist` (
  `date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '주문일자',
  `seq` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '일자별 주문 순번',
  `CUSTCODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '거래처 코드',
  `fruit` varchar(3) NOT NULL COMMENT '과일',
  `amount` int DEFAULT NULL COMMENT '주문 수량',
  `remark` varchar(250) DEFAULT NULL COMMENT '비고',
  PRIMARY KEY (`date`,`seq`),
  KEY `t_orderlist_t_fruitmaster_FK` (`fruit`),
  CONSTRAINT `t_orderlist_t_fruitmaster_FK` FOREIGN KEY (`fruit`) REFERENCES `t_fruitmaster` (`Fruit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='청과물센터 과일 주문 리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_orderlist`
--

LOCK TABLES `t_orderlist` WRITE;
/*!40000 ALTER TABLE `t_orderlist` DISABLE KEYS */;
INSERT INTO `t_orderlist` VALUES ('2023-11-30','1','10','ME',10,''),('2023-11-30','2','30','AP',15,''),('2023-11-30','3','40','WM',5,''),('2023-12-01','1','10','AP',5,''),('2023-12-02','1','20','WM',2,''),('2023-12-02','2','20','WM',2,''),('2023-12-02','3','20','WM',4,''),('2023-12-04','1','10','AP',3,''),('2023-12-04','10','30','ME',6,''),('2023-12-04','11','40','AP',3,''),('2023-12-04','12','20','AP',5,''),('2023-12-04','13','20','AP',4,''),('2023-12-04','14','20','AP',4,''),('2023-12-04','2','20','ME',3,''),('2023-12-04','3','20','WM',10,''),('2023-12-04','4','30','ME',3,''),('2023-12-04','5','20','ME',3,''),('2023-12-04','6','30','ME',2,''),('2023-12-04','7','20','AP',1,''),('2023-12-04','8','20','ME',2,''),('2023-12-04','9','20','WM',5,''),('2023-12-05','1','30','AP',6,''),('2023-12-05','2','40','WM',4,''),('2023-12-05','3','10','ME',2,''),('2023-12-05','4','40','ME',6,''),('2023-12-05','5','40','ME',4,''),('2023-12-05','6','30','AP',4,''),('2023-12-05','7','40','ME',4,'');
/*!40000 ALTER TABLE `t_orderlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_customer`
--

DROP TABLE IF EXISTS `t_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_customer` (
  `Cust_Id` int NOT NULL COMMENT '고객ID',
  `Name` varchar(30) NOT NULL COMMENT '고객이름',
  `Birth` varchar(10) DEFAULT NULL COMMENT '생년월일',
  `Address` varchar(50) DEFAULT NULL COMMENT '주소',
  `Phone` varchar(15) DEFAULT NULL COMMENT '연락처',
  PRIMARY KEY (`Cust_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='고객 관리 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_customer`
--

LOCK TABLES `t_customer` WRITE;
/*!40000 ALTER TABLE `t_customer` DISABLE KEYS */;
INSERT INTO `t_customer` VALUES (1,'박재정','1995','성북','1111-1111'),(2,'김범수','1979','분당','2222-2222'),(3,'박효신','1981','일산','3333-3333'),(4,'이수','1988','수원','4444'),(5,'이수','1981','인천','5555-5555'),(6,'아이유','1993','서울','6666-6666'),(7,'성시경','1979','반포','7777-7777'),(8,'임재범',NULL,NULL,'8888');
/*!40000 ALTER TABLE `t_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_fruitmaster`
--

DROP TABLE IF EXISTS `t_fruitmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_fruitmaster` (
  `Fruit` varchar(3) NOT NULL COMMENT '과일코드',
  `FruitName` varchar(20) NOT NULL COMMENT '과일명',
  `unitprice` int DEFAULT NULL COMMENT '단가',
  `disountrate` int DEFAULT NULL COMMENT '할인율(%)',
  PRIMARY KEY (`Fruit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='과일마스터';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_fruitmaster`
--

LOCK TABLES `t_fruitmaster` WRITE;
/*!40000 ALTER TABLE `t_fruitmaster` DISABLE KEYS */;
INSERT INTO `t_fruitmaster` VALUES ('AP','사과',2000,8),('ME','참외',2500,3),('WM','수박',18000,NULL);
/*!40000 ALTER TABLE `t_fruitmaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_saleshst`
--

DROP TABLE IF EXISTS `t_saleshst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_saleshst` (
  `date` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '판매일자',
  `seq` int NOT NULL COMMENT '일자 별 조회 순번',
  `Cust_id` int NOT NULL COMMENT '고객 ID',
  `fruit` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '과일',
  `amount` int NOT NULL COMMENT '수량',
  `remark` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`date`,`seq`),
  KEY `t_saleshst_t_customer_FK` (`Cust_id`),
  KEY `t_saleshst_t_fruitamster_FK` (`fruit`),
  CONSTRAINT `t_saleshst_t_customer_FK` FOREIGN KEY (`Cust_id`) REFERENCES `t_customer` (`Cust_Id`),
  CONSTRAINT `t_saleshst_t_fruitamster_FK` FOREIGN KEY (`fruit`) REFERENCES `t_fruitmaster` (`Fruit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='판매이력';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_saleshst`
--

LOCK TABLES `t_saleshst` WRITE;
/*!40000 ALTER TABLE `t_saleshst` DISABLE KEYS */;
INSERT INTO `t_saleshst` VALUES ('2023-12-01',1,1,'AP',5,NULL),('2023-12-01',2,1,'ME',4,NULL),('2023-12-01',3,1,'AP',3,NULL),('2023-12-01',4,2,'ME',3,'배달 주문 문의'),('2023-12-01',5,2,'AP',4,NULL),('2023-12-01',6,3,'AP',6,NULL),('2023-12-01',7,4,'WM',2,NULL),('2023-12-01',8,4,'AP',5,NULL),('2023-12-01',9,5,'AP',6,NULL),('2023-12-01',10,5,'ME',6,NULL),('2023-12-01',11,6,'WM',1,NULL),('2023-12-02',1,1,'WM',2,NULL),('2023-12-02',2,1,'ME',4,NULL),('2023-12-02',3,2,'WM',2,NULL),('2023-12-02',4,3,'ME',4,NULL),('2023-12-02',5,3,'WM',1,NULL),('2023-12-02',6,4,'WM',1,NULL),('2023-12-03',1,3,'ME',8,NULL),('2023-12-03',2,4,'ME',6,NULL),('2023-12-03',3,6,'ME',3,NULL),('2023-12-03',4,1,'WM',1,'배달 주문 문의'),('2023-12-03',5,2,'AP',4,NULL),('2023-12-03',6,3,'ME',4,NULL),('2023-12-03',7,6,'AP',5,'외상 후 결제'),('2023-12-03',8,6,'WM',1,NULL),('2023-12-04',1,3,'WM',2,NULL),('2023-12-04',2,2,'ME',2,NULL),('2023-12-04',3,2,'WM',1,NULL),('2023-12-04',4,5,'ME',6,'가격 할인 요청'),('2023-12-04',5,3,'AP',5,NULL),('2023-12-04',6,5,'WM',1,NULL),('2023-12-04',7,2,'AP',10,NULL),('2023-12-04',8,1,'AP',6,NULL),('2023-12-05',1,3,'AP',3,NULL),('2023-12-05',2,3,'AP',8,'외상후 결제'),('2023-12-05',3,4,'ME',6,NULL),('2023-12-05',4,4,'AP',2,NULL),('2023-12-05',5,4,'ME',5,NULL),('2023-12-05',6,5,'ME',5,NULL),('2023-12-06',1,3,'AP',5,NULL),('2023-12-06',2,3,'WM',1,NULL),('2023-12-06',3,2,'AP',10,NULL),('2023-12-06',4,2,'WM',2,NULL),('2023-12-06',5,2,'ME',3,NULL),('2023-12-06',6,1,'ME',8,NULL);
/*!40000 ALTER TABLE `t_saleshst` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-23  8:43:07
