CREATE DATABASE  IF NOT EXISTS `security_database` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `security_database`;
-- MySQL dump 10.13  Distrib 5.6.20, for Linux (x86_64)
--
-- Host: localhost    Database: security_database
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_privilege`
--

DROP TABLE IF EXISTS `account_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_privilege` (
  `acc_priv_name` varchar(225) NOT NULL,
  `ap_uid` int(225) DEFAULT NULL,
  `ap_role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`acc_priv_name`),
  KEY `apuafk` (`ap_uid`),
  KEY `apurfk` (`ap_role_id`),
  CONSTRAINT `apuafk` FOREIGN KEY (`ap_uid`) REFERENCES `user_account` (`user_account_id`),
  CONSTRAINT `apurfk` FOREIGN KEY (`ap_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_privilege`
--

LOCK TABLES `account_privilege` WRITE;
/*!40000 ALTER TABLE `account_privilege` DISABLE KEYS */;
INSERT INTO `account_privilege` VALUES ('A1',121,200),('A2',131,300),('A3',141,400),('A4',151,500),('A5',161,600);
/*!40000 ALTER TABLE `account_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assigned_with`
--

DROP TABLE IF EXISTS `assigned_with`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assigned_with` (
  `aw_role_id` int(225) NOT NULL,
  `aw_uid` int(225) NOT NULL,
  PRIMARY KEY (`aw_role_id`,`aw_uid`),
  KEY `awuafk` (`aw_uid`),
  CONSTRAINT `awuafk` FOREIGN KEY (`aw_uid`) REFERENCES `user_account` (`user_account_id`),
  CONSTRAINT `awurfk` FOREIGN KEY (`aw_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assigned_with`
--

LOCK TABLES `assigned_with` WRITE;
/*!40000 ALTER TABLE `assigned_with` DISABLE KEYS */;
INSERT INTO `assigned_with` VALUES (200,121),(300,131),(400,141),(500,151),(600,161);
/*!40000 ALTER TABLE `assigned_with` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_of`
--

DROP TABLE IF EXISTS `part_of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `part_of` (
  `role_id` int(255) NOT NULL,
  `po_table_name` varchar(255) NOT NULL,
  `po_rp_name` varchar(225) NOT NULL,
  PRIMARY KEY (`role_id`,`po_table_name`,`po_rp_name`),
  KEY `pftfk` (`po_table_name`),
  KEY `pfrpfk` (`po_rp_name`),
  CONSTRAINT `pfrpfk` FOREIGN KEY (`po_rp_name`) REFERENCES `relation_privilege` (`rel_priv_name`),
  CONSTRAINT `pftfk` FOREIGN KEY (`po_table_name`) REFERENCES `table` (`table_name`),
  CONSTRAINT `pfurfk` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_of`
--

LOCK TABLES `part_of` WRITE;
/*!40000 ALTER TABLE `part_of` DISABLE KEYS */;
INSERT INTO `part_of` VALUES (200,'doctor','R1'),(300,'employee','R2'),(400,'nurse','R3'),(500,'record','R4'),(600,'room','R5');
/*!40000 ALTER TABLE `part_of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relation_privilege`
--

DROP TABLE IF EXISTS `relation_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relation_privilege` (
  `rel_priv_name` varchar(225) NOT NULL,
  `rp_role_id` int(225) DEFAULT NULL,
  `rp_table_name` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`rel_priv_name`),
  KEY `rpurfk` (`rp_role_id`),
  KEY `rptfk` (`rp_table_name`),
  CONSTRAINT `rptfk` FOREIGN KEY (`rp_table_name`) REFERENCES `table` (`table_name`),
  CONSTRAINT `rpurfk` FOREIGN KEY (`rp_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relation_privilege`
--

LOCK TABLES `relation_privilege` WRITE;
/*!40000 ALTER TABLE `relation_privilege` DISABLE KEYS */;
INSERT INTO `relation_privilege` VALUES ('delete',500,'record'),('insert',400,'nurse'),('modify',500,'room'),('R1',200,'doctor'),('R2',300,'employee'),('R3',400,'nurse'),('R4',500,'record'),('R5',500,'room'),('select',200,'doctor'),('update',300,'employee');
/*!40000 ALTER TABLE `relation_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `table`
--

DROP TABLE IF EXISTS `table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table` (
  `table_name` varchar(255) NOT NULL,
  `table_uid` int(255) DEFAULT NULL,
  `table_role_id` int(255) DEFAULT NULL,
  `table_rp_name` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`table_name`),
  KEY `turfk` (`table_role_id`),
  KEY `trpfk` (`table_rp_name`),
  CONSTRAINT `trpfk` FOREIGN KEY (`table_rp_name`) REFERENCES `relation_privilege` (`rel_priv_name`),
  CONSTRAINT `turfk` FOREIGN KEY (`table_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `table`
--

LOCK TABLES `table` WRITE;
/*!40000 ALTER TABLE `table` DISABLE KEYS */;
INSERT INTO `table` VALUES ('bill_info',121,200,'R1'),('doctor',121,200,'R1'),('employee',131,300,'R2'),('maintains',141,400,'R3'),('medicine',131,300,'R2'),('nurse',141,400,'R3'),('patient',141,400,'R3'),('permanent',131,300,'R2'),('receptionist',151,500,'R4'),('record',151,500,'R4'),('room',161,600,'R5'),('treatment',161,600,'R5'),('visiting',121,200,'R1');
/*!40000 ALTER TABLE `table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_account` (
  `user_account_id` int(225) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `area_code` int(11) DEFAULT NULL,
  `state_code` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_account`
--

LOCK TABLES `user_account` WRITE;
/*!40000 ALTER TABLE `user_account` DISABLE KEYS */;
INSERT INTO `user_account` VALUES (121,'ron','adams',23456,32145,2147483647),(131,'Mathew','Perry',55667,67834,2147483647),(141,'monica','geller',77665,87654,2147483647),(151,'ross','geller',28786,32145,2147483647),(161,'rondha','adams',23456,32145,2147483647),(171,'geetha','singh',23457,33345,2147483647),(181,'gayathri','mary',23459,32135,2147483647),(191,'ron','john',23458,32045,2147483647),(201,'kate','johny',13456,42145,2147483647),(211,'kristin','pope',89934,78654,NULL);
/*!40000 ALTER TABLE `user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `role_id` int(225) NOT NULL,
  `role_name` varchar(225) DEFAULT NULL,
  `description` varchar(225) DEFAULT NULL,
  `uid` int(225) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  KEY `ur_ua_idx` (`uid`),
  CONSTRAINT `urfk` FOREIGN KEY (`uid`) REFERENCES `user_account` (`user_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (200,'db_owner','Can do anything',121),(300,'db_securityadmin','Can modify role membership and manage permissions',131),(400,'db_accessadmin','Can add pr remove access to the DB for windows logins,group and sql server logins',141),(500,'db_datawriter','Can add,delete or change data in all user tables',151),(600,'db_datareader','Can read all data from all user tables',161);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'security_database'
--

--
-- Dumping routines for database 'security_database'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-16 21:29:02
CREATE DATABASE  IF NOT EXISTS `hospitalmanagement` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hospitalmanagement`;
-- MySQL dump 10.13  Distrib 5.6.20, for Linux (x86_64)
--
-- Host: localhost    Database: hospitalmanagement
-- ------------------------------------------------------
-- Server version	5.6.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor` (
  `doctor_id` int(11) NOT NULL,
  `specialization` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `sex` varchar(45) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `contact_info` int(11) DEFAULT NULL,
  `qualification` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicine` (
  `code` int(11) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `medicine_patient_id` int(11) NOT NULL,
  PRIMARY KEY (`code`,`medicine_patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `patient_Id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `sex` varchar(45) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `date_admitted` date DEFAULT NULL,
  `date_discharged` date DEFAULT NULL,
  `contact_info` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`patient_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permanent`
--

DROP TABLE IF EXISTS `permanent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permanent` (
  `doctor_id` int(11) NOT NULL,
  `visiting_hours` int(11) DEFAULT NULL,
  `specialization` varchar(45) DEFAULT NULL,
  `no_of_patients` int(11) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permanent`
--

LOCK TABLES `permanent` WRITE;
/*!40000 ALTER TABLE `permanent` DISABLE KEYS */;
/*!40000 ALTER TABLE `permanent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptionist`
--

DROP TABLE IF EXISTS `receptionist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receptionist` (
  `receptionist_id` int(11) NOT NULL,
  PRIMARY KEY (`receptionist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptionist`
--

LOCK TABLES `receptionist` WRITE;
/*!40000 ALTER TABLE `receptionist` DISABLE KEYS */;
/*!40000 ALTER TABLE `receptionist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `record` (
  `record_number` int(11) NOT NULL,
  `record_patient_id` int(11) DEFAULT NULL,
  `record_doctor_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`record_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `room_id` int(11) NOT NULL,
  `roomtype` varchar(45) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treatment` (
  `treatment_start_date` date DEFAULT NULL,
  `treatment_end_date` date DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `treatment_patient_Id` int(11) NOT NULL,
  PRIMARY KEY (`treatment_patient_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visiting`
--

DROP TABLE IF EXISTS `visiting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visiting` (
  `doctor_id` int(11) NOT NULL,
  `visiting_hours` int(11) DEFAULT NULL,
  `specialization` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`doctor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visiting`
--

LOCK TABLES `visiting` WRITE;
/*!40000 ALTER TABLE `visiting` DISABLE KEYS */;
/*!40000 ALTER TABLE `visiting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hospitalmanagement'
--

--
-- Dumping routines for database 'hospitalmanagement'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-16 21:29:02
