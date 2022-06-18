CREATE DATABASE  IF NOT EXISTS `correlative_matter` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `correlative_matter`;
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: correlative_matter
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `Correlativa`
--

DROP TABLE IF EXISTS `Correlativa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Correlativa` (
  `idMateria` int(11) NOT NULL,
  `idMateria1` int(11) NOT NULL,
  PRIMARY KEY (`idMateria`,`idMateria1`),
  KEY `fk_Materia_has_Materia_Materia1_idx` (`idMateria1`),
  KEY `fk_Materia_has_Materia_Materia_idx` (`idMateria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Correlativa`
--

LOCK TABLES `Correlativa` WRITE;
/*!40000 ALTER TABLE `Correlativa` DISABLE KEYS */;
INSERT INTO `Correlativa` VALUES (1,0),(2,1),(3,1),(4,2),(5,2),(9,3),(6,4),(7,5),(8,5),(10,6),(11,7),(12,7),(13,8),(14,9),(12,10),(13,11),(14,11),(15,13);
/*!40000 ALTER TABLE `Correlativa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Materia`
--

DROP TABLE IF EXISTS `Materia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Materia` (
  `idMateria` int(11) NOT NULL,
  `materia` varchar(45) DEFAULT NULL,
  `cargaHoraria` float DEFAULT NULL,
  `cantAlumnos` int(11) DEFAULT NULL,
  `idSemestre` int(11) NOT NULL,
  PRIMARY KEY (`idMateria`),
  KEY `fk_Materia_Semestre1_idx` (`idSemestre`),
  CONSTRAINT `fk_Materia_Semestre1` FOREIGN KEY (`idSemestre`) REFERENCES `Semestre` (`idSemestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Materia`
--

LOCK TABLES `Materia` WRITE;
/*!40000 ALTER TABLE `Materia` DISABLE KEYS */;
INSERT INTO `Materia` VALUES (1,'Informatica 1',84,21,1),(2,'Informatica 2',96,16,2),(3,'Base de Datos 1',96,13,3),(4,'Ingenieria de Software 1',72,12,3),(5,'Ingenieria Web 1',72,9,3),(6,'Ingenieria en Software 2',84,11,4),(7,'Ingenieria Web 2',72,7,4),(8,'Redes 1',76,8,4),(9,'Base de Datos 2',84,7,5),(10,'Proceso de Software 1',72,4,5),(11,'Informatica 3',84,8,5),(12,'Procesos de Software 2',72,3,6),(13,'Redes 2',76,7,6),(14,'Base de Datos 3',86,3,7),(15,'Redes 3',68,5,7);
/*!40000 ALTER TABLE `Materia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Semestre`
--

DROP TABLE IF EXISTS `Semestre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Semestre` (
  `idSemestre` int(11) NOT NULL,
  `semestre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idSemestre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Semestre`
--

LOCK TABLES `Semestre` WRITE;
/*!40000 ALTER TABLE `Semestre` DISABLE KEYS */;
INSERT INTO `Semestre` VALUES (1,'semestre 1'),(2,'semestre 2'),(3,'semestre 3'),(4,'semestre 4'),(5,'semestre 5'),(6,'semestre 6'),(7,'semestre 7');
/*!40000 ALTER TABLE `Semestre` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-17 23:20:27
