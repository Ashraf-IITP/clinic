-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_appointment`
--

DROP TABLE IF EXISTS `ms_appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_appointment` (
  `APPOINTMENT_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `PATIENT_ID` int unsigned NOT NULL,
  `DOCTOR_ID` int unsigned NOT NULL,
  `SCHEDULE_DATE` date NOT NULL,
  `START_TIME` time NOT NULL,
  `APPOINTMENT_STATUS_ID` int unsigned NOT NULL,
  `CREATED_BY` int unsigned NOT NULL,
  `CREATED_DATE` datetime NOT NULL,
  `LAST_MODIFIED_BY` int unsigned NOT NULL,
  `LAST_MODIFIED_DATE` datetime NOT NULL,
  PRIMARY KEY (`APPOINTMENT_ID`),
  KEY `fk_appointment_patientId` (`PATIENT_ID`),
  KEY `fk_appointment_doctorId` (`DOCTOR_ID`),
  KEY `fk_appointment_appointmentStatusId` (`APPOINTMENT_STATUS_ID`),
  KEY `fk_appointment_createdBy` (`CREATED_BY`),
  KEY `fk_appointment_lastModifiedBy` (`LAST_MODIFIED_BY`),
  CONSTRAINT `fk_appointment_appointmentStatusId` FOREIGN KEY (`APPOINTMENT_STATUS_ID`) REFERENCES `ms_appointment_status` (`APPOINTMENT_STATUS_ID`),
  CONSTRAINT `fk_appointment_createdBy` FOREIGN KEY (`CREATED_BY`) REFERENCES `us_user` (`USER_ID`),
  CONSTRAINT `fk_appointment_doctorId` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `ms_doctor` (`DOCTOR_ID`),
  CONSTRAINT `fk_appointment_lastModifiedBy` FOREIGN KEY (`LAST_MODIFIED_BY`) REFERENCES `us_user` (`USER_ID`),
  CONSTRAINT `fk_appointment_patientId` FOREIGN KEY (`PATIENT_ID`) REFERENCES `ms_patient` (`PATIENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_appointment`
--

LOCK TABLES `ms_appointment` WRITE;
/*!40000 ALTER TABLE `ms_appointment` DISABLE KEYS */;
INSERT INTO `ms_appointment` VALUES (1,2,1,'2024-06-08','10:30:00',1,1,'2024-06-10 10:05:38',1,'2024-06-10 10:05:38'),(2,1,1,'2024-06-09','15:15:00',1,1,'2024-06-10 12:08:50',1,'2024-06-10 12:08:50'),(3,2,1,'2024-06-09','17:30:00',1,1,'2024-06-10 12:34:35',1,'2024-06-10 13:44:36'),(4,4,1,'2024-06-09','15:45:00',1,1,'2024-06-10 13:32:57',1,'2024-06-10 13:32:57'),(10,1,1,'2024-06-12','10:15:00',1,1,'2024-06-11 16:30:01',1,'2024-06-11 16:30:01'),(14,3,1,'2024-06-12','11:30:00',1,1,'2024-06-11 16:59:27',1,'2024-06-11 16:59:27');
/*!40000 ALTER TABLE `ms_appointment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:02

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_appointment_status`
--

DROP TABLE IF EXISTS `ms_appointment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_appointment_status` (
  `APPOINTMENT_STATUS_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `APPOINTMENT_STATUS_DESC` varchar(50) NOT NULL,
  PRIMARY KEY (`APPOINTMENT_STATUS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_appointment_status`
--

LOCK TABLES `ms_appointment_status` WRITE;
/*!40000 ALTER TABLE `ms_appointment_status` DISABLE KEYS */;
INSERT INTO `ms_appointment_status` VALUES (1,'Booked'),(2,'Completed'),(3,'Completed'),(4,'No show');
/*!40000 ALTER TABLE `ms_appointment_status` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_doctor`
--

DROP TABLE IF EXISTS `ms_doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_doctor` (
  `DOCTOR_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int unsigned NOT NULL,
  `SPECIALITY_IDS` varchar(255) NOT NULL,
  PRIMARY KEY (`DOCTOR_ID`),
  KEY `fk_doctor_userId` (`USER_ID`),
  CONSTRAINT `fk_doctor_userId` FOREIGN KEY (`USER_ID`) REFERENCES `us_user` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_doctor`
--

LOCK TABLES `ms_doctor` WRITE;
/*!40000 ALTER TABLE `ms_doctor` DISABLE KEYS */;
INSERT INTO `ms_doctor` VALUES (1,2,'1,4,5'),(6,9,'1,3,5'),(7,10,'2,3');
/*!40000 ALTER TABLE `ms_doctor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_doctor_schedule`
--

DROP TABLE IF EXISTS `ms_doctor_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_doctor_schedule` (
  `SCHEDULE_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `DOCTOR_ID` int unsigned NOT NULL,
  `SCHEDULE_DATE` date NOT NULL,
  `START_TIME` time NOT NULL,
  `STOP_TIME` time NOT NULL,
  PRIMARY KEY (`SCHEDULE_ID`),
  KEY `fk_doctorSchedule_doctorId` (`DOCTOR_ID`),
  CONSTRAINT `fk_doctorSchedule_doctorId` FOREIGN KEY (`DOCTOR_ID`) REFERENCES `ms_doctor` (`DOCTOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_doctor_schedule`
--

LOCK TABLES `ms_doctor_schedule` WRITE;
/*!40000 ALTER TABLE `ms_doctor_schedule` DISABLE KEYS */;
INSERT INTO `ms_doctor_schedule` VALUES (9,1,'2024-06-10','10:00:00','12:00:00'),(10,6,'2024-06-12','10:00:00','12:00:00');
/*!40000 ALTER TABLE `ms_doctor_schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_patient`
--

DROP TABLE IF EXISTS `ms_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_patient` (
  `PATIENT_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `PATIENT_NAME` varchar(50) NOT NULL,
  `AGE` int NOT NULL,
  `EMAIL_ID` varchar(50) NOT NULL,
  `MOBILE` varchar(10) NOT NULL,
  `GENDER` varchar(1) NOT NULL,
  PRIMARY KEY (`PATIENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_patient`
--

LOCK TABLES `ms_patient` WRITE;
/*!40000 ALTER TABLE `ms_patient` DISABLE KEYS */;
INSERT INTO `ms_patient` VALUES (1,'Raju Shrivastav',5,'raju@gmail.com','9898989898','M'),(2,'rahul',8,'saurabh@gmail.com','8787878789','M'),(3,'Patient 1',35,'patient@gmail.com','9123123214','M'),(4,'Xi jinping',65,'jingping@gmail.com','7878787878','M'),(5,'ramesh',55,'ramesh@gmail.com','7898989898','M');
/*!40000 ALTER TABLE `ms_patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_speciality`
--

DROP TABLE IF EXISTS `ms_speciality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_speciality` (
  `SPECIALITY_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `SPECIALITY_DESC` varchar(50) NOT NULL,
  PRIMARY KEY (`SPECIALITY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_speciality`
--

LOCK TABLES `ms_speciality` WRITE;
/*!40000 ALTER TABLE `ms_speciality` DISABLE KEYS */;
INSERT INTO `ms_speciality` VALUES (1,'Cardioligist'),(2,'Orthopedic'),(3,'Pediatrician'),(4,'Urologist'),(5,'Neurologist');
/*!40000 ALTER TABLE `ms_speciality` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `ms_time_slots`
--

DROP TABLE IF EXISTS `ms_time_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ms_time_slots` (
  `TIME_SLOT` time NOT NULL,
  PRIMARY KEY (`TIME_SLOT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ms_time_slots`
--

LOCK TABLES `ms_time_slots` WRITE;
/*!40000 ALTER TABLE `ms_time_slots` DISABLE KEYS */;
INSERT INTO `ms_time_slots` VALUES ('00:00:00'),('00:15:00'),('00:30:00'),('00:45:00'),('01:00:00'),('01:15:00'),('01:30:00'),('01:45:00'),('02:00:00'),('02:15:00'),('02:30:00'),('02:45:00'),('03:00:00'),('03:15:00'),('03:30:00'),('03:45:00'),('04:00:00'),('04:15:00'),('04:30:00'),('04:45:00'),('05:00:00'),('05:15:00'),('05:30:00'),('05:45:00'),('06:00:00'),('06:15:00'),('06:30:00'),('06:45:00'),('07:00:00'),('07:15:00'),('07:30:00'),('07:45:00'),('08:00:00'),('08:15:00'),('08:30:00'),('08:45:00'),('09:00:00'),('09:15:00'),('09:30:00'),('09:45:00'),('10:00:00'),('10:15:00'),('10:30:00'),('10:45:00'),('11:00:00'),('11:15:00'),('11:30:00'),('11:45:00'),('12:00:00'),('12:15:00'),('12:30:00'),('12:45:00'),('13:00:00'),('13:15:00'),('13:30:00'),('13:45:00'),('14:00:00'),('14:15:00'),('14:30:00'),('14:45:00'),('15:00:00'),('15:15:00'),('15:30:00'),('15:45:00'),('16:00:00'),('16:15:00'),('16:30:00'),('16:45:00'),('17:00:00'),('17:15:00'),('17:30:00'),('17:45:00'),('18:00:00'),('18:15:00'),('18:30:00'),('18:45:00'),('19:00:00'),('19:15:00'),('19:30:00'),('19:45:00'),('20:00:00'),('20:15:00'),('20:30:00'),('20:45:00'),('21:00:00'),('21:15:00'),('21:30:00'),('21:45:00'),('22:00:00'),('22:15:00'),('22:30:00'),('22:45:00'),('23:00:00'),('23:15:00'),('23:30:00'),('23:45:00');
/*!40000 ALTER TABLE `ms_time_slots` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Dumping events for database 'clinic'
--

--
-- Dumping routines for database 'clinic'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `us_business_function`
--

DROP TABLE IF EXISTS `us_business_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `us_business_function` (
  `BUSINESS_FUNCTION_ID` varchar(45) NOT NULL,
  `BUSINESS_FUNCTION_DESC` varchar(100) NOT NULL,
  PRIMARY KEY (`BUSINESS_FUNCTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_business_function`
--

LOCK TABLES `us_business_function` WRITE;
/*!40000 ALTER TABLE `us_business_function` DISABLE KEYS */;
INSERT INTO `us_business_function` VALUES ('ROLE_BF_DR_SCHEDULE','Manage Doctor Schedule'),('ROLE_BF_LIST_DOCTOR','View Doctor list'),('ROLE_BF_MANAGE_APPT','Create / Edit Appointment'),('ROLE_BF_MANAGE_PATIENT','Create / Edit / View / Search Patient master'),('ROLE_BF_MANAGE_RECEPTIONIST','Create / Edit Receptionist'),('ROLE_BF_MANAGE_USER','Create / Edit User'),('ROLE_BF_SHOW_HOME','Show home page'),('ROLE_BF_UPDATE_APPT','Lifececyle of an Appointment');
/*!40000 ALTER TABLE `us_business_function` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `us_role`
--

DROP TABLE IF EXISTS `us_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `us_role` (
  `ROLE_ID` varchar(25) NOT NULL,
  `ROLE_DESC` varchar(50) NOT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_role`
--

LOCK TABLES `us_role` WRITE;
/*!40000 ALTER TABLE `us_role` DISABLE KEYS */;
INSERT INTO `us_role` VALUES ('ROLE_DOCTOR','Doctor'),('ROLE_RECEPTION','Reception'),('ROLE_SUPER','Super user');
/*!40000 ALTER TABLE `us_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:02

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `us_role_business_function`
--

DROP TABLE IF EXISTS `us_role_business_function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `us_role_business_function` (
  `ROLE_ID` varchar(25) NOT NULL,
  `BUSINESS_FUNCTION_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`BUSINESS_FUNCTION_ID`),
  KEY `fk_roleBusinessFunction_roleId_idx` (`ROLE_ID`),
  KEY `fk_roleBusinessFunction_businessFunctionId_idx` (`BUSINESS_FUNCTION_ID`),
  CONSTRAINT `fk_roleBusinessFunction_businessFunctionId_idx` FOREIGN KEY (`BUSINESS_FUNCTION_ID`) REFERENCES `us_business_function` (`BUSINESS_FUNCTION_ID`),
  CONSTRAINT `fk_roleBusinessFunction_roleId_idx` FOREIGN KEY (`ROLE_ID`) REFERENCES `us_role` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_role_business_function`
--

LOCK TABLES `us_role_business_function` WRITE;
/*!40000 ALTER TABLE `us_role_business_function` DISABLE KEYS */;
INSERT INTO `us_role_business_function` VALUES ('ROLE_DOCTOR','ROLE_BF_LIST_DOCTOR'),('ROLE_DOCTOR','ROLE_BF_SHOW_HOME'),('ROLE_DOCTOR','ROLE_BF_UPDATE_APPT'),('ROLE_RECEPTION','ROLE_BF_DR_SCHEDULE'),('ROLE_RECEPTION','ROLE_BF_LIST_DOCTOR'),('ROLE_RECEPTION','ROLE_BF_MANAGE_APPT'),('ROLE_RECEPTION','ROLE_BF_MANAGE_PATIENT'),('ROLE_RECEPTION','ROLE_BF_SHOW_HOME'),('ROLE_RECEPTION','ROLE_BF_UPDATE_APPT'),('ROLE_SUPER','ROLE_BF_DR_SCHEDULE'),('ROLE_SUPER','ROLE_BF_LIST_DOCTOR'),('ROLE_SUPER','ROLE_BF_MANAGE_APPT'),('ROLE_SUPER','ROLE_BF_MANAGE_PATIENT'),('ROLE_SUPER','ROLE_BF_MANAGE_RECEPTIONIST'),('ROLE_SUPER','ROLE_BF_MANAGE_USER'),('ROLE_SUPER','ROLE_BF_SHOW_HOME'),('ROLE_SUPER','ROLE_BF_UPDATE_APPT');
/*!40000 ALTER TABLE `us_role_business_function` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:03

-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: clinic
-- ------------------------------------------------------
-- Server version	8.0.36

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

--
-- Table structure for table `us_user`
--

DROP TABLE IF EXISTS `us_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `us_user` (
  `USER_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(25) NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `PASSWORD` tinyblob,
  `ROLE_ID` varchar(25) NOT NULL,
  `ACTIVE` tinyint unsigned NOT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `unq_username` (`USERNAME`),
  KEY `fk_user_roleId` (`ROLE_ID`),
  CONSTRAINT `fk_user_roleId` FOREIGN KEY (`ROLE_ID`) REFERENCES `us_role` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `us_user`
--

LOCK TABLES `us_user` WRITE;
/*!40000 ALTER TABLE `us_user` DISABLE KEYS */;
INSERT INTO `us_user` VALUES (1,'super','Derek',_binary '$2a$10$1H8Ssl1pQXcug1A16fesrOrxkIzvNEY/Yro6AM6ldGJHf4Bi1i5ee','ROLE_SUPER',1),(2,'doc0','Tom',_binary '$2a$10$qroLSj.4isDiMAl7jQEP6.MKkqQvDUOvZwDtJ.6pN.BhsujV4Nuaq','ROLE_DOCTOR',1),(3,'receptionist','Jane Doe',_binary '$2a$10$XjZbzOTRDxiLYgprI6IyjuzIAwMTzPg6VlvcH9RwvXRYcmJn68qm2','ROLE_RECEPTION',1),(9,'doc1','Dick',_binary '$2a$10$iHJjCz4/8Ogq91EXdh/3a.XAWBfrHyil8Tu4Umh0vOJoCrSTphQo.','ROLE_DOCTOR',1),(10,'doc2','Harry',_binary '$2a$10$GKe3Urw83K4mHxM/0UUFyOtnVa1vxp3nCQcpuxvPgbmIV9IVx5lgC','ROLE_DOCTOR',1);
/*!40000 ALTER TABLE `us_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-01 21:32:02
