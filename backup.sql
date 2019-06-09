-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: bet
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

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
-- Table structure for table `accounts_action`
--

DROP TABLE IF EXISTS `accounts_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_action`
--

LOCK TABLES `accounts_action` WRITE;
/*!40000 ALTER TABLE `accounts_action` DISABLE KEYS */;
INSERT INTO `accounts_action` VALUES (1,'Win'),(2,'Draw'),(3,'Loss');
/*!40000 ALTER TABLE `accounts_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_bet`
--

DROP TABLE IF EXISTS `accounts_bet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_bet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `money` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_bet_action_id_3f1f4924_fk_accounts_matchaction_id` (`action_id`),
  KEY `accounts_bet_user_id_05e8cf33_fk_auth_user_id` (`user_id`),
  CONSTRAINT `accounts_bet_action_id_3f1f4924_fk_accounts_matchaction_id` FOREIGN KEY (`action_id`) REFERENCES `accounts_matchaction` (`id`),
  CONSTRAINT `accounts_bet_user_id_05e8cf33_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_bet`
--

LOCK TABLES `accounts_bet` WRITE;
/*!40000 ALTER TABLE `accounts_bet` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_bet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_club`
--

DROP TABLE IF EXISTS `accounts_club`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_club` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `count_game` int(11) NOT NULL,
  `win_count_game` int(11) NOT NULL,
  `logo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_club`
--

LOCK TABLES `accounts_club` WRITE;
/*!40000 ALTER TABLE `accounts_club` DISABLE KEYS */;
INSERT INTO `accounts_club` VALUES (1,'Juventus',0,0,'https://s5o.ru/storage/simple/ru/edt/49/4d/86/12/rue5fcd992f47.jpg'),(2,'Atletico',0,0,'https://upload.wikimedia.org/wikipedia/ru/thumb/c/c1/Atletico_Madrid_logo.svg/764px-Atletico_Madrid_logo.svg.png'),(3,'PSG',0,0,'https://upload.wikimedia.org/wikipedia/ru/3/3d/FC_Paris_Saint-Germain_Logo.png'),(4,'Manchecter United',0,0,'http://toplogos.ru/images/logo-manchester-united.jpg'),(5,'Bayern',0,0,'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg/220px-FC_Bayern_M%C3%BCnchen_logo_%282017%29.svg');
/*!40000 ALTER TABLE `accounts_club` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_match`
--

DROP TABLE IF EXISTS `accounts_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_match` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` datetime(6) NOT NULL,
  `goal_1` int(11) NOT NULL,
  `goal_2` int(11) NOT NULL,
  `club_1_id` int(11) DEFAULT NULL,
  `club_2_id` int(11) DEFAULT NULL,
  `description` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_match_club_1_id_8efdd2eb_fk_accounts_club_id` (`club_1_id`),
  KEY `accounts_match_club_2_id_f44bfdd2_fk_accounts_club_id` (`club_2_id`),
  CONSTRAINT `accounts_match_club_1_id_8efdd2eb_fk_accounts_club_id` FOREIGN KEY (`club_1_id`) REFERENCES `accounts_club` (`id`),
  CONSTRAINT `accounts_match_club_2_id_f44bfdd2_fk_accounts_club_id` FOREIGN KEY (`club_2_id`) REFERENCES `accounts_club` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_match`
--

LOCK TABLES `accounts_match` WRITE;
/*!40000 ALTER TABLE `accounts_match` DISABLE KEYS */;
INSERT INTO `accounts_match` VALUES (1,'2018-12-18 21:06:44.000000',0,0,3,2,'desc'),(2,'2018-12-18 21:06:53.000000',0,0,4,1,'desc'),(3,'2018-12-18 21:07:02.000000',0,0,5,1,'desc'),(4,'2018-12-18 21:07:13.000000',0,0,2,3,'desc');
/*!40000 ALTER TABLE `accounts_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_matchaction`
--

DROP TABLE IF EXISTS `accounts_matchaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_matchaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coefficient` double NOT NULL,
  `action_id` int(11) DEFAULT NULL,
  `match_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accounts_matchaction_action_id_88a3b5ca_fk_accounts_action_id` (`action_id`),
  KEY `accounts_matchaction_match_id_811711e2_fk_accounts_match_id` (`match_id`),
  CONSTRAINT `accounts_matchaction_action_id_88a3b5ca_fk_accounts_action_id` FOREIGN KEY (`action_id`) REFERENCES `accounts_action` (`id`),
  CONSTRAINT `accounts_matchaction_match_id_811711e2_fk_accounts_match_id` FOREIGN KEY (`match_id`) REFERENCES `accounts_match` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_matchaction`
--

LOCK TABLES `accounts_matchaction` WRITE;
/*!40000 ALTER TABLE `accounts_matchaction` DISABLE KEYS */;
INSERT INTO `accounts_matchaction` VALUES (1,1.5,1,1),(2,3.4,2,1),(3,2.55,3,1),(4,5.2,2,3);
/*!40000 ALTER TABLE `accounts_matchaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_profile`
--

DROP TABLE IF EXISTS `accounts_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `money_count` decimal(10,2) NOT NULL,
  `second_name` varchar(50) NOT NULL,
  `group_id_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `accounts_profile_group_id_id_caa2de77_fk_accounts_usergroup_id` (`group_id_id`),
  CONSTRAINT `accounts_profile_group_id_id_caa2de77_fk_accounts_usergroup_id` FOREIGN KEY (`group_id_id`) REFERENCES `accounts_usergroup` (`id`),
  CONSTRAINT `accounts_profile_user_id_49a85d32_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_profile`
--

LOCK TABLES `accounts_profile` WRITE;
/*!40000 ALTER TABLE `accounts_profile` DISABLE KEYS */;
INSERT INTO `accounts_profile` VALUES (1,1,'',0.00,'',NULL),(2,2,'',0.00,'',NULL);
/*!40000 ALTER TABLE `accounts_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_usergroup`
--

DROP TABLE IF EXISTS `accounts_usergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_usergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_usergroup`
--

LOCK TABLES `accounts_usergroup` WRITE;
/*!40000 ALTER TABLE `accounts_usergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_usergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add profile',7,'add_profile'),(26,'Can change profile',7,'change_profile'),(27,'Can delete profile',7,'delete_profile'),(28,'Can view profile',7,'view_profile'),(29,'Can add action',8,'add_action'),(30,'Can change action',8,'change_action'),(31,'Can delete action',8,'delete_action'),(32,'Can view action',8,'view_action'),(33,'Can add club',9,'add_club'),(34,'Can change club',9,'change_club'),(35,'Can delete club',9,'delete_club'),(36,'Can view club',9,'view_club'),(37,'Can add match',10,'add_match'),(38,'Can change match',10,'change_match'),(39,'Can delete match',10,'delete_match'),(40,'Can view match',10,'view_match'),(41,'Can add user group',11,'add_usergroup'),(42,'Can change user group',11,'change_usergroup'),(43,'Can delete user group',11,'delete_usergroup'),(44,'Can view user group',11,'view_usergroup'),(45,'Can add bet',12,'add_bet'),(46,'Can change bet',12,'change_bet'),(47,'Can delete bet',12,'delete_bet'),(48,'Can view bet',12,'view_bet'),(49,'Can add match action',13,'add_matchaction'),(50,'Can change match action',13,'change_matchaction'),(51,'Can delete match action',13,'delete_matchaction'),(52,'Can view match action',13,'view_matchaction');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$0kwER897myWq$qrqeHx35pDhh6LqveuQSI3L/RQfwd31ElGOHIwIVTA0=','2018-12-18 21:04:51.344425',1,'light','','','',1,1,'2018-12-18 21:03:50.154816'),(2,'pbkdf2_sha256$120000$UpYhgroGvIj5$LPLmVJsjBLSR7ZwZ9daxdiUsFHLzo2ll2ve94oY6J8g=',NULL,0,'test','','','',0,1,'2018-12-18 21:24:04.299713');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-12-18 21:05:05.107634','5','Bayern',2,'[{\"changed\": {\"fields\": [\"logo\"]}}]',9,1),(2,'2018-12-18 21:05:14.100682','4','Manchecter United',2,'[{\"changed\": {\"fields\": [\"logo\"]}}]',9,1),(3,'2018-12-18 21:05:29.598733','3','PSG',2,'[{\"changed\": {\"fields\": [\"logo\"]}}]',9,1),(4,'2018-12-18 21:06:01.767079','5','Bayern',2,'[{\"changed\": {\"fields\": [\"logo\"]}}]',9,1),(5,'2018-12-18 21:06:15.190913','2','Atletico',2,'[{\"changed\": {\"fields\": [\"logo\"]}}]',9,1),(6,'2018-12-18 21:06:24.815821','1','Juventus',2,'[{\"changed\": {\"fields\": [\"logo\"]}}]',9,1),(7,'2018-12-18 21:06:45.491716','1','PSG-Atletico',1,'[{\"added\": {}}]',10,1),(8,'2018-12-18 21:06:55.199014','2','Manchecter United-Juventus',1,'[{\"added\": {}}]',10,1),(9,'2018-12-18 21:07:04.064497','3','Bayern-Juventus',1,'[{\"added\": {}}]',10,1),(10,'2018-12-18 21:07:15.326507','4','Atletico-PSG',1,'[{\"added\": {}}]',10,1),(11,'2018-12-18 21:09:11.875621','1','Action object (1)',1,'[{\"added\": {}}]',8,1),(12,'2018-12-18 21:09:46.447132','2','Draw',1,'[{\"added\": {}}]',8,1),(13,'2018-12-18 21:11:15.809973','3','Loss',1,'[{\"added\": {}}]',8,1),(14,'2018-12-18 21:11:44.140150','1','MatchAction object (1)',1,'[{\"added\": {}}]',13,1),(15,'2018-12-18 21:14:14.825662','2','PSG-Atletico. Draw',1,'[{\"added\": {}}]',13,1),(16,'2018-12-18 21:14:39.977210','3','PSG-Atletico. Loss',1,'[{\"added\": {}}]',13,1),(17,'2018-12-18 21:15:31.371850','4','Bayern-Juventus. Draw',1,'[{\"added\": {}}]',13,1),(18,'2018-12-18 21:24:04.389205','2','test',1,'[{\"added\": {}}]',4,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (8,'accounts','action'),(12,'accounts','bet'),(9,'accounts','club'),(10,'accounts','match'),(13,'accounts','matchaction'),(7,'accounts','profile'),(11,'accounts','usergroup'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2018-12-18 21:03:23.841496'),(2,'auth','0001_initial','2018-12-18 21:03:24.099046'),(3,'accounts','0001_initial','2018-12-18 21:03:24.220640'),(4,'accounts','0002_plan_name','2018-12-18 21:03:24.252756'),(5,'accounts','0003_auto_20180618_1048','2018-12-18 21:03:24.310585'),(6,'accounts','0004_auto_20180618_1049','2018-12-18 21:03:24.376585'),(7,'accounts','0005_auto_20181217_1731','2018-12-18 21:03:24.551523'),(8,'accounts','0006_auto_20181217_1801','2018-12-18 21:03:24.900615'),(9,'accounts','0007_auto_20181217_1804','2018-12-18 21:03:25.062894'),(10,'accounts','0008_auto_20181217_1808','2018-12-18 21:03:25.281266'),(11,'accounts','0009_auto_20181217_1815','2018-12-18 21:03:25.322617'),(12,'accounts','0010_club_logo','2018-12-18 21:03:25.377064'),(13,'accounts','0011_auto_20181217_1853','2018-12-18 21:03:25.401601'),(14,'accounts','0012_auto_20181218_2059','2018-12-18 21:03:25.637708'),(15,'admin','0001_initial','2018-12-18 21:03:25.712537'),(16,'admin','0002_logentry_remove_auto_add','2018-12-18 21:03:25.732114'),(17,'admin','0003_logentry_add_action_flag_choices','2018-12-18 21:03:25.772528'),(18,'contenttypes','0002_remove_content_type_name','2018-12-18 21:03:25.822761'),(19,'auth','0002_alter_permission_name_max_length','2018-12-18 21:03:25.828801'),(20,'auth','0003_alter_user_email_max_length','2018-12-18 21:03:25.840665'),(21,'auth','0004_alter_user_username_opts','2018-12-18 21:03:25.850832'),(22,'auth','0005_alter_user_last_login_null','2018-12-18 21:03:25.869937'),(23,'auth','0006_require_contenttypes_0002','2018-12-18 21:03:25.871056'),(24,'auth','0007_alter_validators_add_error_messages','2018-12-18 21:03:25.877941'),(25,'auth','0008_alter_user_username_max_length','2018-12-18 21:03:25.888736'),(26,'auth','0009_alter_user_last_name_max_length','2018-12-18 21:03:25.900608'),(27,'sessions','0001_initial','2018-12-18 21:03:25.918264'),(28,'accounts','0013_auto_20181218_2133','2018-12-18 21:33:53.451664');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('nl634cuf7fxu4g537ma7ar4sm9gdltkk','N2ExNDczMTU0ZDBkOWQ4MjNmZjY0ODY2OTAzOTdjN2EwNDJiZTM3NTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYzhlZmRlNGVhMGE1MTQzOTYwMTk4MWVmY2M2YTg1ZjI3Y2M2ZmMwIn0=','2019-01-01 21:04:51.347411');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-19  1:56:20
