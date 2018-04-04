-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: base
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

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
-- Table structure for table `BasicArticle_articles`
--

DROP TABLE IF EXISTS `BasicArticle_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BasicArticle_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `body` text CHARACTER SET utf8,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL,
  `state_id` int(11) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` (`created_by_id`),
  KEY `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` (`state_id`),
  CONSTRAINT `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BasicArticle_articles`
--

LOCK TABLES `BasicArticle_articles` WRITE;
/*!40000 ALTER TABLE `BasicArticle_articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `BasicArticle_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BasicArticle_articleviewlogs`
--

DROP TABLE IF EXISTS `BasicArticle_articleviewlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BasicArticle_articleviewlogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(40) NOT NULL,
  `session` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `BasicArticle_article_article_id_164e59b4_fk_BasicArti` (`article_id`),
  CONSTRAINT `BasicArticle_article_article_id_164e59b4_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BasicArticle_articleviewlogs`
--

LOCK TABLES `BasicArticle_articleviewlogs` WRITE;
/*!40000 ALTER TABLE `BasicArticle_articleviewlogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `BasicArticle_articleviewlogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Community_community`
--

DROP TABLE IF EXISTS `Community_community`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_community` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` longtext NOT NULL,
  `category` varchar(100) NOT NULL,
  `created_at` datetime(6),
  `tag_line` varchar(500) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `forum_link` varchar(100) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_community_created_by_id_1080464d_fk_auth_user_id` (`created_by_id`),
  CONSTRAINT `Community_community_created_by_id_1080464d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_community`
--

LOCK TABLES `Community_community` WRITE;
/*!40000 ALTER TABLE `Community_community` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_community` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Community_communityarticles`
--

DROP TABLE IF EXISTS `Community_communityarticles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_communityarticles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `community_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_communitya_article_id_c9af3fed_fk_BasicArti` (`article_id`),
  KEY `Community_communitya_community_id_39b5841f_fk_Community` (`community_id`),
  KEY `Community_communityarticles_user_id_04d18793_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communitya_article_id_c9af3fed_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`),
  CONSTRAINT `Community_communitya_community_id_39b5841f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Community_communityarticles_user_id_04d18793_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_communityarticles`
--

LOCK TABLES `Community_communityarticles` WRITE;
/*!40000 ALTER TABLE `Community_communityarticles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_communityarticles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Community_communitycourses`
--

DROP TABLE IF EXISTS `Community_communitycourses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_communitycourses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `community_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_communityc_community_id_f1b76f0f_fk_Community` (`community_id`),
  KEY `Community_communitycoure_course_id_e2dda6e7_fk_Course_course_id` (`course_id`),
  KEY `Community_communitycoure_user_id_69c835fe_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communityc_community_id_f1b76f0f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Community_communitycoure_course_id_e2dda6e7_fk_Course_course_id` FOREIGN KEY (`course_id`) REFERENCES `Course_course` (`id`),
  CONSTRAINT `Community_communitycoure_user_id_69c835fe_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_communitycourses`
--

LOCK TABLES `Community_communitycourses` WRITE;
/*!40000 ALTER TABLE `Community_communitycourses` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_communitycourses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Community_communitygroups`
--

DROP TABLE IF EXISTS `Community_communitygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_communitygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `community_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_communityg_community_id_3e76934c_fk_Community` (`community_id`),
  KEY `Community_communitygroups_group_id_a2ce7b35_fk_Group_group_id` (`group_id`),
  KEY `Community_communitygroups_user_id_eaead89d_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communityg_community_id_3e76934c_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Community_communitygroups_group_id_a2ce7b35_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  CONSTRAINT `Community_communitygroups_user_id_eaead89d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_communitygroups`
--

LOCK TABLES `Community_communitygroups` WRITE;
/*!40000 ALTER TABLE `Community_communitygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_communitygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Community_communitymembership`
--

DROP TABLE IF EXISTS `Community_communitymembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_communitymembership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `community_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_communitym_community_id_8a39991d_fk_Community` (`community_id`),
  KEY `Community_communitymembership_role_id_9c581fd0_fk_auth_group_id` (`role_id`),
  KEY `Community_communitymembership_user_id_5dd1c26b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communitym_community_id_8a39991d_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Community_communitymembership_role_id_9c581fd0_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Community_communitymembership_user_id_5dd1c26b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_communitymembership`
--

LOCK TABLES `Community_communitymembership` WRITE;
/*!40000 ALTER TABLE `Community_communitymembership` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_communitymembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Community_requestcommunitycreation`
--

DROP TABLE IF EXISTS `Community_requestcommunitycreation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_requestcommunitycreation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `desc` longtext NOT NULL,
  `category` varchar(100) NOT NULL,
  `tag_line` varchar(500) DEFAULT NULL,
  `purpose` longtext NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `requestedby_id` int(11) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_requestcommunitycreation_requestedby_id_b3e83124` (`requestedby_id`),
  CONSTRAINT `Community_requestcom_requestedby_id_b3e83124_fk_auth_user` FOREIGN KEY (`requestedby_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_requestcommunitycreation`
--

LOCK TABLES `Community_requestcommunitycreation` WRITE;
/*!40000 ALTER TABLE `Community_requestcommunitycreation` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_requestcommunitycreation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course_course`
--

DROP TABLE IF EXISTS `Course_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course_course`
--

LOCK TABLES `Course_course` WRITE;
/*!40000 ALTER TABLE `Course_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course_links`
--

DROP TABLE IF EXISTS `Course_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(300) NOT NULL,
  `desc` longtext NOT NULL,
  `topics_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_links_topics_id_096bf6bd_fk_Course_topics_id` (`topics_id`),
  CONSTRAINT `Course_links_topics_id_096bf6bd_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `Course_topics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course_links`
--

LOCK TABLES `Course_links` WRITE;
/*!40000 ALTER TABLE `Course_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course_topics`
--

DROP TABLE IF EXISTS `Course_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course_topics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_topics_lft_90a2e5bc` (`lft`),
  KEY `Course_topics_rght_01583e2c` (`rght`),
  KEY `Course_topics_tree_id_b199de91` (`tree_id`),
  KEY `Course_topics_level_a7ab2ea8` (`level`),
  KEY `Course_topics_parent_id_adff4cae` (`parent_id`),
  KEY `Course_topics_course_id_9e18b74c_fk_Course_course_id` (`course_id`),
  CONSTRAINT `Course_topics_course_id_9e18b74c_fk_Course_course_id` FOREIGN KEY (`course_id`) REFERENCES `Course_course` (`id`),
  CONSTRAINT `Course_topics_parent_id_adff4cae_fk_Course_topics_id` FOREIGN KEY (`parent_id`) REFERENCES `Course_topics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course_topics`
--

LOCK TABLES `Course_topics` WRITE;
/*!40000 ALTER TABLE `Course_topics` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course_topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Course_videos`
--

DROP TABLE IF EXISTS `Course_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video` varchar(300) NOT NULL,
  `desc` longtext NOT NULL,
  `topics_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_videos_topics_id_568227cc_fk_Course_topics_id` (`topics_id`),
  CONSTRAINT `Course_videos_topics_id_568227cc_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `Course_topics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course_videos`
--

LOCK TABLES `Course_videos` WRITE;
/*!40000 ALTER TABLE `Course_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_group`
--

DROP TABLE IF EXISTS `Group_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `desc` longtext NOT NULL,
  `visibility` tinyint(1) NOT NULL,
  `created_at` datetime(6),
  `image` varchar(100) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Group_group_created_by_id_b1ee0c6d_fk_auth_user_id` (`created_by_id`),
  CONSTRAINT `Group_group_created_by_id_b1ee0c6d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_group`
--

LOCK TABLES `Group_group` WRITE;
/*!40000 ALTER TABLE `Group_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_grouparticles`
--

DROP TABLE IF EXISTS `Group_grouparticles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_grouparticles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Group_grouparticles_article_id_eac38398_fk_BasicArti` (`article_id`),
  KEY `Group_grouparticles_user_id_12983c5c_fk_auth_user_id` (`user_id`),
  KEY `Group_grouparticles_group_id_84ee212d_fk_Group_group_id` (`group_id`),
  CONSTRAINT `Group_grouparticles_article_id_eac38398_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`),
  CONSTRAINT `Group_grouparticles_group_id_84ee212d_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  CONSTRAINT `Group_grouparticles_user_id_12983c5c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_grouparticles`
--

LOCK TABLES `Group_grouparticles` WRITE;
/*!40000 ALTER TABLE `Group_grouparticles` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_grouparticles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_groupmembership`
--

DROP TABLE IF EXISTS `Group_groupmembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_groupmembership` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Group_groupmembership_group_id_adce78b5_fk_Group_group_id` (`group_id`),
  KEY `Group_groupmembership_user_id_e4f5757f_fk_auth_user_id` (`user_id`),
  KEY `Group_groupmembership_role_id_bb865ffb_fk_auth_group_id` (`role_id`),
  CONSTRAINT `Group_groupmembership_group_id_adce78b5_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  CONSTRAINT `Group_groupmembership_role_id_bb865ffb_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Group_groupmembership_user_id_e4f5757f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_groupmembership`
--

LOCK TABLES `Group_groupmembership` WRITE;
/*!40000 ALTER TABLE `Group_groupmembership` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_groupmembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRolesPermission_favourite`
--

DROP TABLE IF EXISTS `UserRolesPermission_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserRolesPermission_favourite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource` int(10) unsigned NOT NULL,
  `category` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UserRolesPermission_favourite_user_id_14680490_fk_auth_user_id` (`user_id`),
  CONSTRAINT `UserRolesPermission_favourite_user_id_14680490_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRolesPermission_favourite`
--

LOCK TABLES `UserRolesPermission_favourite` WRITE;
/*!40000 ALTER TABLE `UserRolesPermission_favourite` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserRolesPermission_favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserRolesPermission_profileimage`
--

DROP TABLE IF EXISTS `UserRolesPermission_profileimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserRolesPermission_profileimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `UserRolesPermission__user_id_2e95d164_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserRolesPermission_profileimage`
--

LOCK TABLES `UserRolesPermission_profileimage` WRITE;
/*!40000 ALTER TABLE `UserRolesPermission_profileimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserRolesPermission_profileimage` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'author'),(3,'community_admin'),(4,'group_admin'),(2,'publisher');
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
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add black listed domain',8,'add_blacklisteddomain'),(23,'Can change black listed domain',8,'change_blacklisteddomain'),(24,'Can delete black listed domain',8,'delete_blacklisteddomain'),(25,'Can add comment',9,'add_xtdcomment'),(26,'Can change comment',9,'change_xtdcomment'),(27,'Can delete comment',9,'delete_xtdcomment'),(28,'Can moderate comments',9,'can_moderate'),(29,'Can add comment',10,'add_comment'),(30,'Can change comment',10,'change_comment'),(31,'Can delete comment',10,'delete_comment'),(32,'Can moderate comments',10,'can_moderate'),(33,'Can add comment flag',11,'add_commentflag'),(34,'Can change comment flag',11,'change_commentflag'),(35,'Can delete comment flag',11,'delete_commentflag'),(36,'Can add community groups',12,'add_communitygroups'),(37,'Can change community groups',12,'change_communitygroups'),(38,'Can delete community groups',12,'delete_communitygroups'),(39,'Can add community articles',13,'add_communityarticles'),(40,'Can change community articles',13,'change_communityarticles'),(41,'Can delete community articles',13,'delete_communityarticles'),(42,'Can add request community creation',14,'add_requestcommunitycreation'),(43,'Can change request community creation',14,'change_requestcommunitycreation'),(44,'Can delete request community creation',14,'delete_requestcommunitycreation'),(45,'Can add community',15,'add_community'),(46,'Can change community',15,'change_community'),(47,'Can delete community',15,'delete_community'),(48,'Can add community membership',16,'add_communitymembership'),(49,'Can change community membership',16,'change_communitymembership'),(50,'Can delete community membership',16,'delete_communitymembership'),(51,'Can add community courses',17,'add_communitycourses'),(52,'Can change community courses',17,'change_communitycourses'),(53,'Can delete community courses',17,'delete_communitycourses'),(54,'Can add profile image',18,'add_profileimage'),(55,'Can change profile image',18,'change_profileimage'),(56,'Can delete profile image',18,'delete_profileimage'),(57,'Can add favourite',19,'add_favourite'),(58,'Can change favourite',19,'change_favourite'),(59,'Can delete favourite',19,'delete_favourite'),(60,'Can add article view logs',20,'add_articleviewlogs'),(61,'Can change article view logs',20,'change_articleviewlogs'),(62,'Can delete article view logs',20,'delete_articleviewlogs'),(63,'Can add articles',21,'add_articles'),(64,'Can change articles',21,'change_articles'),(65,'Can delete articles',21,'delete_articles'),(66,'Can add group articles',22,'add_grouparticles'),(67,'Can change group articles',22,'change_grouparticles'),(68,'Can delete group articles',22,'delete_grouparticles'),(69,'Can add group membership',23,'add_groupmembership'),(70,'Can change group membership',23,'change_groupmembership'),(71,'Can delete group membership',23,'delete_groupmembership'),(72,'Can add group',24,'add_group'),(73,'Can change group',24,'change_group'),(74,'Can delete group',24,'delete_group'),(75,'Can add revision',25,'add_revision'),(76,'Can change revision',25,'change_revision'),(77,'Can delete revision',25,'delete_revision'),(78,'Can add version',26,'add_version'),(79,'Can change version',26,'change_version'),(80,'Can delete version',26,'delete_version'),(81,'Can add Token',27,'add_token'),(82,'Can change Token',27,'change_token'),(83,'Can delete Token',27,'delete_token'),(84,'Can add states',28,'add_states'),(85,'Can change states',28,'change_states'),(86,'Can delete states',28,'delete_states'),(87,'Can add transitions',29,'add_transitions'),(88,'Can change transitions',29,'change_transitions'),(89,'Can delete transitions',29,'delete_transitions'),(90,'Can add association',30,'add_association'),(91,'Can change association',30,'change_association'),(92,'Can delete association',30,'delete_association'),(93,'Can add partial',31,'add_partial'),(94,'Can change partial',31,'change_partial'),(95,'Can delete partial',31,'delete_partial'),(96,'Can add nonce',32,'add_nonce'),(97,'Can change nonce',32,'change_nonce'),(98,'Can delete nonce',32,'delete_nonce'),(99,'Can add user social auth',33,'add_usersocialauth'),(100,'Can change user social auth',33,'change_usersocialauth'),(101,'Can delete user social auth',33,'delete_usersocialauth'),(102,'Can add code',34,'add_code'),(103,'Can change code',34,'change_code'),(104,'Can delete code',34,'delete_code'),(105,'Can add faq',35,'add_faq'),(106,'Can change faq',35,'change_faq'),(107,'Can delete faq',35,'delete_faq'),(108,'Can add faq category',36,'add_faqcategory'),(109,'Can change faq category',36,'change_faqcategory'),(110,'Can delete faq category',36,'delete_faqcategory'),(111,'Can add feedback',37,'add_feedback'),(112,'Can change feedback',37,'change_feedback'),(113,'Can delete feedback',37,'delete_feedback'),(114,'Can add links',38,'add_links'),(115,'Can change links',38,'change_links'),(116,'Can delete links',38,'delete_links'),(117,'Can add videos',39,'add_videos'),(118,'Can change videos',39,'change_videos'),(119,'Can delete videos',39,'delete_videos'),(120,'Can add course',40,'add_course'),(121,'Can change course',40,'change_course'),(122,'Can delete course',40,'delete_course'),(123,'Can add topics',41,'add_topics'),(124,'Can change topics',41,'change_topics'),(125,'Can delete topics',41,'delete_topics'),(126,'Can add Forum',42,'add_forum'),(127,'Can change Forum',42,'change_forum'),(128,'Can delete Forum',42,'delete_forum'),(129,'Can add Topic',43,'add_topic'),(130,'Can change Topic',43,'change_topic'),(131,'Can delete Topic',43,'delete_topic'),(132,'Can add Post',44,'add_post'),(133,'Can change Post',44,'change_post'),(134,'Can delete Post',44,'delete_post'),(135,'Can add Attachment',45,'add_attachment'),(136,'Can change Attachment',45,'change_attachment'),(137,'Can delete Attachment',45,'delete_attachment'),(138,'Can add Topic poll',46,'add_topicpoll'),(139,'Can change Topic poll',46,'change_topicpoll'),(140,'Can delete Topic poll',46,'delete_topicpoll'),(141,'Can add Topic poll vote',47,'add_topicpollvote'),(142,'Can change Topic poll vote',47,'change_topicpollvote'),(143,'Can delete Topic poll vote',47,'delete_topicpollvote'),(144,'Can add Topic poll option',48,'add_topicpolloption'),(145,'Can change Topic poll option',48,'change_topicpolloption'),(146,'Can delete Topic poll option',48,'delete_topicpolloption'),(147,'Can add Forum track',49,'add_forumreadtrack'),(148,'Can change Forum track',49,'change_forumreadtrack'),(149,'Can delete Forum track',49,'delete_forumreadtrack'),(150,'Can add Topic track',50,'add_topicreadtrack'),(151,'Can change Topic track',50,'change_topicreadtrack'),(152,'Can delete Topic track',50,'delete_topicreadtrack'),(153,'Can add Forum profile',51,'add_forumprofile'),(154,'Can change Forum profile',51,'change_forumprofile'),(155,'Can delete Forum profile',51,'delete_forumprofile'),(156,'Can add User forum permission',52,'add_userforumpermission'),(157,'Can change User forum permission',52,'change_userforumpermission'),(158,'Can delete User forum permission',52,'delete_userforumpermission'),(159,'Can add Group forum permission',53,'add_groupforumpermission'),(160,'Can change Group forum permission',53,'change_groupforumpermission'),(161,'Can delete Group forum permission',53,'delete_groupforumpermission'),(162,'Can add Forum permission',54,'add_forumpermission'),(163,'Can change Forum permission',54,'change_forumpermission'),(164,'Can delete Forum permission',54,'delete_forumpermission');
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
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$d83Rwzcuvqo4$0WoDwnrEo+dYnvBz+uW6ISv/2GqHbvdOYL4hZAUaapk=','2018-04-04 07:28:43.063490',1,'admin','','','admin@mail.com',1,1,'2018-04-04 07:28:01.344285');
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
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-04-04 07:31:19.602176','1','Collabortaion System',1,'[{\"added\": {}}]',42,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_flags`
--

DROP TABLE IF EXISTS `django_comment_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `flag` varchar(30) NOT NULL,
  `flag_date` datetime(6) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_comment_flags_user_id_comment_id_flag_537f77a7_uniq` (`user_id`,`comment_id`,`flag`),
  KEY `django_comment_flags_comment_id_d8054933_fk_django_comments_id` (`comment_id`),
  KEY `django_comment_flags_flag_8b141fcb` (`flag`),
  CONSTRAINT `django_comment_flags_comment_id_d8054933_fk_django_comments_id` FOREIGN KEY (`comment_id`) REFERENCES `django_comments` (`id`),
  CONSTRAINT `django_comment_flags_user_id_f3f81f0a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_flags`
--

LOCK TABLES `django_comment_flags` WRITE;
/*!40000 ALTER TABLE `django_comment_flags` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comments`
--

DROP TABLE IF EXISTS `django_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_pk` longtext NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(254) NOT NULL,
  `user_url` varchar(200) NOT NULL,
  `comment` longtext NOT NULL,
  `submit_date` datetime(6) NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `is_removed` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `django_comments_content_type_id_c4afe962_fk_django_co` (`content_type_id`),
  KEY `django_comments_site_id_9dcf666e_fk_django_site_id` (`site_id`),
  KEY `django_comments_user_id_a0a440a1_fk_auth_user_id` (`user_id`),
  KEY `django_comments_submit_date_514ed2d9` (`submit_date`),
  CONSTRAINT `django_comments_content_type_id_c4afe962_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_comments_site_id_9dcf666e_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `django_comments_user_id_a0a440a1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comments`
--

LOCK TABLES `django_comments` WRITE;
/*!40000 ALTER TABLE `django_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comments_xtd_blacklisteddomain`
--

DROP TABLE IF EXISTS `django_comments_xtd_blacklisteddomain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comments_xtd_blacklisteddomain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_comments_xtd_blacklisteddomain_domain_43b81328` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comments_xtd_blacklisteddomain`
--

LOCK TABLES `django_comments_xtd_blacklisteddomain` WRITE;
/*!40000 ALTER TABLE `django_comments_xtd_blacklisteddomain` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comments_xtd_blacklisteddomain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comments_xtd_xtdcomment`
--

DROP TABLE IF EXISTS `django_comments_xtd_xtdcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comments_xtd_xtdcomment` (
  `comment_ptr_id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL,
  `order` int(11) NOT NULL,
  `followup` tinyint(1) NOT NULL,
  PRIMARY KEY (`comment_ptr_id`),
  KEY `django_comments_xtd_xtdcomment_thread_id_e192a27a` (`thread_id`),
  KEY `django_comments_xtd_xtdcomment_order_36db562d` (`order`),
  CONSTRAINT `django_comments_xtd__comment_ptr_id_01d47130_fk_django_co` FOREIGN KEY (`comment_ptr_id`) REFERENCES `django_comments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comments_xtd_xtdcomment`
--

LOCK TABLES `django_comments_xtd_xtdcomment` WRITE;
/*!40000 ALTER TABLE `django_comments_xtd_xtdcomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comments_xtd_xtdcomment` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(27,'authtoken','token'),(21,'BasicArticle','articles'),(20,'BasicArticle','articleviewlogs'),(15,'Community','community'),(13,'Community','communityarticles'),(17,'Community','communitycourses'),(12,'Community','communitygroups'),(16,'Community','communitymembership'),(14,'Community','requestcommunitycreation'),(5,'contenttypes','contenttype'),(40,'Course','course'),(38,'Course','links'),(41,'Course','topics'),(39,'Course','videos'),(10,'django_comments','comment'),(11,'django_comments','commentflag'),(8,'django_comments_xtd','blacklisteddomain'),(9,'django_comments_xtd','xtdcomment'),(42,'forum','forum'),(45,'forum_attachments','attachment'),(44,'forum_conversation','post'),(43,'forum_conversation','topic'),(51,'forum_member','forumprofile'),(54,'forum_permission','forumpermission'),(53,'forum_permission','groupforumpermission'),(52,'forum_permission','userforumpermission'),(46,'forum_polls','topicpoll'),(48,'forum_polls','topicpolloption'),(47,'forum_polls','topicpollvote'),(49,'forum_tracking','forumreadtrack'),(50,'forum_tracking','topicreadtrack'),(24,'Group','group'),(22,'Group','grouparticles'),(23,'Group','groupmembership'),(25,'reversion','revision'),(26,'reversion','version'),(6,'sessions','session'),(7,'sites','site'),(30,'social_django','association'),(34,'social_django','code'),(32,'social_django','nonce'),(31,'social_django','partial'),(33,'social_django','usersocialauth'),(19,'UserRolesPermission','favourite'),(18,'UserRolesPermission','profileimage'),(35,'webcontent','faq'),(36,'webcontent','faqcategory'),(37,'webcontent','feedback'),(28,'workflow','states'),(29,'workflow','transitions');
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
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'workflow','0001_initial','2018-04-04 07:23:35.283675'),(2,'contenttypes','0001_initial','2018-04-04 07:23:35.993220'),(3,'auth','0001_initial','2018-04-04 07:23:46.270496'),(4,'BasicArticle','0001_initial','2018-04-04 07:23:46.574373'),(5,'BasicArticle','0002_articles_created_by','2018-04-04 07:23:48.425674'),(6,'BasicArticle','0003_remove_articles_created_by','2018-04-04 07:23:49.052672'),(7,'BasicArticle','0004_articles_state','2018-04-04 07:23:50.233101'),(8,'BasicArticle','0005_remove_articles_state','2018-04-04 07:23:50.817665'),(9,'BasicArticle','0006_articles_created_by','2018-04-04 07:23:52.163897'),(10,'BasicArticle','0007_articles_views','2018-04-04 07:23:52.767180'),(11,'BasicArticle','0008_articleviewlogs','2018-04-04 07:23:54.043629'),(12,'BasicArticle','0009_articles_state','2018-04-04 07:23:55.573053'),(13,'BasicArticle','0010_articles_image','2018-04-04 07:23:56.109155'),(14,'BasicArticle','0011_auto_20180118_0858','2018-04-04 07:23:56.156798'),(15,'BasicArticle','0012_auto_20180123_0846','2018-04-04 07:23:56.851658'),(16,'BasicArticle','0013_auto_20180227_1136','2018-04-04 07:23:56.908565'),(17,'Course','0001_initial','2018-04-04 07:23:59.929361'),(18,'Course','0002_links_topics','2018-04-04 07:24:01.298423'),(19,'Course','0003_topics_course','2018-04-04 07:24:03.195903'),(20,'contenttypes','0002_remove_content_type_name','2018-04-04 07:24:04.282692'),(21,'auth','0002_alter_permission_name_max_length','2018-04-04 07:24:04.393824'),(22,'auth','0003_alter_user_email_max_length','2018-04-04 07:24:04.510883'),(23,'auth','0004_alter_user_username_opts','2018-04-04 07:24:04.558933'),(24,'auth','0005_alter_user_last_login_null','2018-04-04 07:24:05.112109'),(25,'auth','0006_require_contenttypes_0002','2018-04-04 07:24:05.153968'),(26,'auth','0007_alter_validators_add_error_messages','2018-04-04 07:24:05.209627'),(27,'auth','0008_alter_user_username_max_length','2018-04-04 07:24:05.588649'),(28,'Community','0001_initial','2018-04-04 07:24:12.322783'),(29,'Group','0001_initial','2018-04-04 07:24:14.536330'),(30,'Group','0002_auto_20171122_1432','2018-04-04 07:24:15.999228'),(31,'Community','0002_auto_20171120_1202','2018-04-04 07:24:17.227905'),(32,'Community','0003_communitygroups','2018-04-04 07:24:20.004229'),(33,'Community','0004_suggestcommunity','2018-04-04 07:24:20.293628'),(34,'Community','0005_auto_20180102_0842','2018-04-04 07:24:20.739530'),(35,'Community','0006_auto_20180102_0902','2018-04-04 07:24:20.911135'),(36,'Community','0007_requestcommunitycreation_user','2018-04-04 07:24:21.433957'),(37,'Community','0008_auto_20180102_0951','2018-04-04 07:24:23.414564'),(38,'Community','0009_auto_20180102_1007','2018-04-04 07:24:25.170783'),(39,'Community','0010_requestcommunitycreation_status','2018-04-04 07:24:25.688947'),(40,'Community','0011_auto_20180102_1027','2018-04-04 07:24:27.777831'),(41,'Community','0012_community_image','2018-04-04 07:24:28.346480'),(42,'Community','0013_remove_community_image','2018-04-04 07:24:29.122133'),(43,'Community','0014_community_image','2018-04-04 07:24:29.868768'),(44,'Community','0015_auto_20180125_1103','2018-04-04 07:24:31.338424'),(45,'Community','0016_auto_20180125_1147','2018-04-04 07:24:32.359735'),(46,'Community','0017_community_forum_link','2018-04-04 07:24:32.836035'),(47,'Community','0018_community_created_by','2018-04-04 07:24:34.379971'),(48,'Community','0019_auto_20180227_1138','2018-04-04 07:24:34.442627'),(49,'Course','0004_course_community','2018-04-04 07:24:35.659842'),(50,'Course','0005_auto_20180316_0929','2018-04-04 07:24:37.815453'),(51,'Community','0020_communitycoure','2018-04-04 07:24:40.824243'),(52,'Community','0021_auto_20180316_0930','2018-04-04 07:24:41.094634'),(53,'Community','0022_auto_20180316_1028','2018-04-04 07:24:41.316197'),(54,'Course','0006_auto_20180321_1206','2018-04-04 07:24:41.525070'),(55,'Group','0003_groupmembership','2018-04-04 07:24:44.775868'),(56,'Group','0004_auto_20171123_1614','2018-04-04 07:24:46.647306'),(57,'Group','0005_groupmembership_group_admin','2018-04-04 07:24:47.816426'),(58,'Group','0006_grouparticles','2018-04-04 07:24:50.733649'),(59,'Group','0007_auto_20171129_1330','2018-04-04 07:24:52.304638'),(60,'Group','0008_remove_groupmembership_group_admin','2018-04-04 07:24:53.149743'),(61,'Group','0009_group_created_at','2018-04-04 07:24:53.702644'),(62,'Group','0010_group_image','2018-04-04 07:24:54.278841'),(63,'Group','0011_group_created_by','2018-04-04 07:24:56.124765'),(64,'Group','0012_auto_20180227_1134','2018-04-04 07:24:56.223534'),(65,'UserRolesPermission','0001_initial','2018-04-04 07:24:57.352201'),(66,'UserRolesPermission','0002_auto_20180102_1430','2018-04-04 07:24:58.447235'),(67,'UserRolesPermission','0003_profile','2018-04-04 07:24:59.458386'),(68,'UserRolesPermission','0004_auto_20180116_0947','2018-04-04 07:25:01.606544'),(69,'UserRolesPermission','0005_auto_20180227_1128','2018-04-04 07:25:01.665938'),(70,'UserRolesPermission','0006_favourite','2018-04-04 07:25:02.850913'),(71,'UserRolesPermission','0005_auto_20180227_1043','2018-04-04 07:25:03.034826'),(72,'UserRolesPermission','0007_merge_20180321_1208','2018-04-04 07:25:03.101555'),(73,'UserRolesPermission','0008_auto_20180321_1224','2018-04-04 07:25:03.168592'),(74,'admin','0001_initial','2018-04-04 07:25:05.548946'),(75,'admin','0002_logentry_remove_auto_add','2018-04-04 07:25:05.683179'),(76,'authtoken','0001_initial','2018-04-04 07:25:06.787707'),(77,'authtoken','0002_auto_20160226_1747','2018-04-04 07:25:07.831313'),(78,'sites','0001_initial','2018-04-04 07:25:08.218815'),(79,'django_comments','0001_initial','2018-04-04 07:25:14.330318'),(80,'django_comments','0002_update_user_email_field_length','2018-04-04 07:25:14.624224'),(81,'django_comments','0003_add_submit_date_index','2018-04-04 07:25:14.974305'),(82,'django_comments_xtd','0001_initial','2018-04-04 07:25:16.710744'),(83,'django_comments_xtd','0002_blacklisteddomain','2018-04-04 07:25:17.305348'),(84,'django_comments_xtd','0003_auto_20170220_1333','2018-04-04 07:25:17.362431'),(85,'django_comments_xtd','0004_auto_20170221_1510','2018-04-04 07:25:17.418639'),(86,'django_comments_xtd','0005_auto_20170920_1247','2018-04-04 07:25:17.479251'),(87,'forum','0001_initial','2018-04-04 07:25:21.156469'),(88,'forum_conversation','0001_initial','2018-04-04 07:25:30.497896'),(89,'forum_conversation','0002_post_anonymous_key','2018-04-04 07:25:31.601384'),(90,'forum_conversation','0003_auto_20160228_2051','2018-04-04 07:25:31.666206'),(91,'forum_conversation','0004_auto_20160427_0502','2018-04-04 07:25:33.656587'),(92,'forum_conversation','0005_auto_20160607_0455','2018-04-04 07:25:34.249776'),(93,'forum_conversation','0006_post_enable_signature','2018-04-04 07:25:35.560595'),(94,'forum_conversation','0007_auto_20160903_0450','2018-04-04 07:25:39.567182'),(95,'forum_conversation','0008_auto_20160903_0512','2018-04-04 07:25:39.641987'),(96,'forum_conversation','0009_auto_20160925_2126','2018-04-04 07:25:39.805376'),(97,'forum_conversation','0010_auto_20170120_0224','2018-04-04 07:25:41.461324'),(98,'forum','0002_auto_20150725_0512','2018-04-04 07:25:41.515045'),(99,'forum','0003_remove_forum_is_active','2018-04-04 07:25:42.338341'),(100,'forum','0004_auto_20170504_2108','2018-04-04 07:25:44.195866'),(101,'forum','0005_auto_20170504_2113','2018-04-04 07:25:44.281628'),(102,'forum','0006_auto_20170523_2036','2018-04-04 07:25:45.840988'),(103,'forum','0007_auto_20170523_2140','2018-04-04 07:25:45.933914'),(104,'forum','0008_forum_last_post','2018-04-04 07:25:47.780581'),(105,'forum','0009_auto_20170928_2327','2018-04-04 07:25:47.866790'),(106,'forum_attachments','0001_initial','2018-04-04 07:25:49.102182'),(107,'forum_member','0001_initial','2018-04-04 07:25:50.130097'),(108,'forum_member','0002_auto_20160225_0515','2018-04-04 07:25:50.201956'),(109,'forum_member','0003_auto_20160227_2122','2018-04-04 07:25:50.277253'),(110,'forum_permission','0001_initial','2018-04-04 07:25:57.424527'),(111,'forum_permission','0002_auto_20160607_0500','2018-04-04 07:25:59.343077'),(112,'forum_permission','0003_remove_forumpermission_name','2018-04-04 07:25:59.904781'),(113,'forum_polls','0001_initial','2018-04-04 07:26:04.555206'),(114,'forum_polls','0002_auto_20151105_0029','2018-04-04 07:26:06.629738'),(115,'forum_tracking','0001_initial','2018-04-04 07:26:11.539169'),(116,'forum_tracking','0002_auto_20160607_0502','2018-04-04 07:26:12.313269'),(117,'reversion','0001_initial','2018-04-04 07:26:16.398899'),(118,'reversion','0002_auto_20141216_1509','2018-04-04 07:26:16.433291'),(119,'reversion','0003_auto_20160601_1600','2018-04-04 07:26:16.466361'),(120,'reversion','0004_auto_20160611_1202','2018-04-04 07:26:16.499703'),(121,'sessions','0001_initial','2018-04-04 07:26:17.259305'),(122,'sites','0002_alter_domain_unique','2018-04-04 07:26:17.526492'),(123,'default','0001_initial','2018-04-04 07:26:21.036455'),(124,'social_auth','0001_initial','2018-04-04 07:26:21.102886'),(125,'default','0002_add_related_name','2018-04-04 07:26:22.049036'),(126,'social_auth','0002_add_related_name','2018-04-04 07:26:22.090449'),(127,'default','0003_alter_email_max_length','2018-04-04 07:26:22.641866'),(128,'social_auth','0003_alter_email_max_length','2018-04-04 07:26:22.791388'),(129,'default','0004_auto_20160423_0400','2018-04-04 07:26:22.869150'),(130,'social_auth','0004_auto_20160423_0400','2018-04-04 07:26:22.949007'),(131,'social_auth','0005_auto_20160727_2333','2018-04-04 07:26:23.275091'),(132,'social_django','0006_partial','2018-04-04 07:26:24.053205'),(133,'social_django','0007_code_timestamp','2018-04-04 07:26:24.864359'),(134,'social_django','0008_partial_timestamp','2018-04-04 07:26:25.816915'),(135,'webcontent','0001_initial','2018-04-04 07:26:26.590366'),(136,'webcontent','0002_auto_20180124_1328','2018-04-04 07:26:28.644291'),(137,'webcontent','0003_auto_20180124_1452','2018-04-04 07:26:29.898139'),(138,'webcontent','0004_delete_faq','2018-04-04 07:26:30.356370'),(139,'webcontent','0005_faq','2018-04-04 07:26:30.894529'),(140,'webcontent','0006_faqcategory','2018-04-04 07:26:31.246438'),(141,'webcontent','0007_remove_faq_category','2018-04-04 07:26:31.703336'),(142,'webcontent','0008_faq_category','2018-04-04 07:26:33.207016'),(143,'webcontent','0009_faq_order','2018-04-04 07:26:33.752222'),(144,'webcontent','0010_remove_faq_order','2018-04-04 07:26:34.378431'),(145,'webcontent','0011_faq_order','2018-04-04 07:26:34.964232'),(146,'webcontent','0012_auto_20180125_1628','2018-04-04 07:26:35.635409'),(147,'webcontent','0013_auto_20180125_1634','2018-04-04 07:26:36.453553'),(148,'webcontent','0014_auto_20180125_1636','2018-04-04 07:26:36.580096'),(149,'webcontent','0015_auto_20180125_1643','2018-04-04 07:26:37.566563'),(150,'workflow','0002_transitions_role','2018-04-04 07:26:39.694643'),(151,'workflow','0003_auto_20180108_1348','2018-04-04 07:26:43.257516'),(152,'workflow','0004_auto_20180108_1504','2018-04-04 07:26:44.762688'),(153,'social_django','0003_alter_email_max_length','2018-04-04 07:26:44.808055'),(154,'reversion','0001_squashed_0004_auto_20160611_1202','2018-04-04 07:26:44.855162'),(155,'social_django','0001_initial','2018-04-04 07:26:44.905260'),(156,'social_django','0002_add_related_name','2018-04-04 07:26:44.971973'),(157,'social_django','0005_auto_20160727_2333','2018-04-04 07:26:45.030492'),(158,'social_django','0004_auto_20160423_0400','2018-04-04 07:26:45.071945');
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
INSERT INTO `django_session` VALUES ('zv6orfgi8o7utx5ayrzl00q5stxechmu','Yjk3MTlhMzdkYWI4ODE5MzRhNjBhZjhiNjMxNWE1Y2Q1ZmY4MWNiODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYW5vbnltb3VzX2ZvcnVtX2tleSI6IjFhMmMyMWVmMTUwYzQ1ZWM5NDFjYTkzYzdmM2JmZGJlIiwiX2F1dGhfdXNlcl9oYXNoIjoiNjg3YmQ4YTRkYTA1MjhkNGJhMzAyYzViYTA4NzVlYTAxZGVkYjQ0MyJ9','2018-04-04 08:03:55.223770');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_attachments_attachment`
--

DROP TABLE IF EXISTS `forum_attachments_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_attachments_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_attachments_at_post_id_0476a843_fk_forum_con` (`post_id`),
  CONSTRAINT `forum_attachments_at_post_id_0476a843_fk_forum_con` FOREIGN KEY (`post_id`) REFERENCES `forum_conversation_post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_attachments_attachment`
--

LOCK TABLES `forum_attachments_attachment` WRITE;
/*!40000 ALTER TABLE `forum_attachments_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_attachments_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_conversation_post`
--

DROP TABLE IF EXISTS `forum_conversation_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_conversation_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `poster_ip` char(39) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `username` varchar(155) DEFAULT NULL,
  `approved` tinyint(1) NOT NULL,
  `update_reason` varchar(255) DEFAULT NULL,
  `updates_count` int(10) unsigned NOT NULL,
  `_content_rendered` longtext,
  `poster_id` int(11) DEFAULT NULL,
  `topic_id` int(11) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `anonymous_key` varchar(100) DEFAULT NULL,
  `enable_signature` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_conversation_post_poster_id_19c4e995_fk_auth_user_id` (`poster_id`),
  KEY `forum_conversation_p_topic_id_f6aaa418_fk_forum_con` (`topic_id`),
  KEY `forum_conversation_post_updated_by_id_86093355_fk_auth_user_id` (`updated_by_id`),
  KEY `forum_conversation_post_approved_a1090910` (`approved`),
  KEY `forum_conversation_post_enable_signature_b1ce8b55` (`enable_signature`),
  CONSTRAINT `forum_conversation_p_topic_id_f6aaa418_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`),
  CONSTRAINT `forum_conversation_post_poster_id_19c4e995_fk_auth_user_id` FOREIGN KEY (`poster_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `forum_conversation_post_updated_by_id_86093355_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_conversation_post`
--

LOCK TABLES `forum_conversation_post` WRITE;
/*!40000 ALTER TABLE `forum_conversation_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_conversation_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_conversation_topic`
--

DROP TABLE IF EXISTS `forum_conversation_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_conversation_topic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` smallint(5) unsigned NOT NULL,
  `status` int(10) unsigned NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `posts_count` int(10) unsigned NOT NULL,
  `views_count` int(10) unsigned NOT NULL,
  `last_post_on` datetime(6) DEFAULT NULL,
  `forum_id` int(11) NOT NULL,
  `poster_id` int(11) DEFAULT NULL,
  `first_post_id` int(11) DEFAULT NULL,
  `last_post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_conversation_topic_forum_id_e9cfe592_fk_forum_forum_id` (`forum_id`),
  KEY `forum_conversation_topic_poster_id_0dd4fa07_fk_auth_user_id` (`poster_id`),
  KEY `forum_conversation_topic_slug_c74ce2cc` (`slug`),
  KEY `forum_conversation_topic_type_92971eb5` (`type`),
  KEY `forum_conversation_topic_status_e78d0ae4` (`status`),
  KEY `forum_conversation_topic_approved_ad3fcbf9` (`approved`),
  KEY `forum_conversation_t_last_post_id_e14396a2_fk_forum_con` (`last_post_id`),
  KEY `forum_conversation_t_first_post_id_ca473bd1_fk_forum_con` (`first_post_id`),
  CONSTRAINT `forum_conversation_t_first_post_id_ca473bd1_fk_forum_con` FOREIGN KEY (`first_post_id`) REFERENCES `forum_conversation_post` (`id`),
  CONSTRAINT `forum_conversation_t_last_post_id_e14396a2_fk_forum_con` FOREIGN KEY (`last_post_id`) REFERENCES `forum_conversation_post` (`id`),
  CONSTRAINT `forum_conversation_topic_forum_id_e9cfe592_fk_forum_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  CONSTRAINT `forum_conversation_topic_poster_id_0dd4fa07_fk_auth_user_id` FOREIGN KEY (`poster_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_conversation_topic`
--

LOCK TABLES `forum_conversation_topic` WRITE;
/*!40000 ALTER TABLE `forum_conversation_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_conversation_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_conversation_topic_subscribers`
--

DROP TABLE IF EXISTS `forum_conversation_topic_subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_conversation_topic_subscribers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_conversation_topic_topic_id_user_id_b2c961d5_uniq` (`topic_id`,`user_id`),
  KEY `forum_conversation_t_user_id_7e386a79_fk_auth_user` (`user_id`),
  CONSTRAINT `forum_conversation_t_topic_id_34ebca87_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`),
  CONSTRAINT `forum_conversation_t_user_id_7e386a79_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_conversation_topic_subscribers`
--

LOCK TABLES `forum_conversation_topic_subscribers` WRITE;
/*!40000 ALTER TABLE `forum_conversation_topic_subscribers` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_conversation_topic_subscribers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_forum`
--

DROP TABLE IF EXISTS `forum_forum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext,
  `image` varchar(100) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `link_redirects` tinyint(1) NOT NULL,
  `type` smallint(5) unsigned NOT NULL,
  `link_redirects_count` int(10) unsigned NOT NULL,
  `last_post_on` datetime(6) DEFAULT NULL,
  `display_sub_forum_list` tinyint(1) NOT NULL,
  `_description_rendered` longtext,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `direct_posts_count` int(10) unsigned NOT NULL,
  `direct_topics_count` int(10) unsigned NOT NULL,
  `last_post_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_forum_slug_b9acc50d` (`slug`),
  KEY `forum_forum_type_30239563` (`type`),
  KEY `forum_forum_lft_ad1dea6a` (`lft`),
  KEY `forum_forum_rght_72abf953` (`rght`),
  KEY `forum_forum_tree_id_84a9227d` (`tree_id`),
  KEY `forum_forum_level_8a349c84` (`level`),
  KEY `forum_forum_parent_id_22edea05` (`parent_id`),
  KEY `forum_forum_last_post_id_81b59e37_fk_forum_conversation_post_id` (`last_post_id`),
  CONSTRAINT `forum_forum_last_post_id_81b59e37_fk_forum_conversation_post_id` FOREIGN KEY (`last_post_id`) REFERENCES `forum_conversation_post` (`id`),
  CONSTRAINT `forum_forum_parent_id_22edea05_fk_forum_forum_id` FOREIGN KEY (`parent_id`) REFERENCES `forum_forum` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_forum`
--

LOCK TABLES `forum_forum` WRITE;
/*!40000 ALTER TABLE `forum_forum` DISABLE KEYS */;
INSERT INTO `forum_forum` VALUES (1,'2018-04-04 07:31:19.601315','2018-04-04 07:31:19.601362','Collabortaion System','collabortaion-system','Collaborative Communities’ helps us to know what other communities can offer and share resources to achieve a common goal. This forum will help us disscuss about the system  and its features that can be upgraded.','',NULL,0,0,0,NULL,1,'<p>Collaborative Communities’ helps us to know what other communities can offer and share resources to achieve a common goal. This forum will help us disscuss about the system  and its features that can be upgraded.</p>',1,2,1,0,NULL,0,0,NULL);
/*!40000 ALTER TABLE `forum_forum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_member_forumprofile`
--

DROP TABLE IF EXISTS `forum_member_forumprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_member_forumprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(100) DEFAULT NULL,
  `signature` longtext,
  `posts_count` int(10) unsigned NOT NULL,
  `_signature_rendered` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `forum_member_forumprofile_user_id_9d6b9b6b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_member_forumprofile`
--

LOCK TABLES `forum_member_forumprofile` WRITE;
/*!40000 ALTER TABLE `forum_member_forumprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_member_forumprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_permission_forumpermission`
--

DROP TABLE IF EXISTS `forum_permission_forumpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_permission_forumpermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codename` varchar(150) NOT NULL,
  `is_global` tinyint(1) NOT NULL,
  `is_local` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codename` (`codename`),
  KEY `forum_permission_forumpermission_is_global_5772ce17` (`is_global`),
  KEY `forum_permission_forumpermission_is_local_92cef3ca` (`is_local`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_permission_forumpermission`
--

LOCK TABLES `forum_permission_forumpermission` WRITE;
/*!40000 ALTER TABLE `forum_permission_forumpermission` DISABLE KEYS */;
INSERT INTO `forum_permission_forumpermission` VALUES (1,'can_see_forum',1,1),(2,'can_read_forum',1,1),(3,'can_start_new_topics',1,1),(4,'can_reply_to_topics',1,1),(5,'can_post_announcements',1,1),(6,'can_post_stickies',1,1),(7,'can_delete_own_posts',1,1),(8,'can_edit_own_posts',1,1),(9,'can_post_without_approval',1,1),(10,'can_create_polls',1,1),(11,'can_vote_in_polls',1,1),(12,'can_attach_file',1,1),(13,'can_download_file',1,1),(14,'can_lock_topics',0,1),(15,'can_move_topics',0,1),(16,'can_edit_posts',0,1),(17,'can_delete_posts',0,1),(18,'can_approve_posts',0,1),(19,'can_reply_to_locked_topics',0,1);
/*!40000 ALTER TABLE `forum_permission_forumpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_permission_groupforumpermission`
--

DROP TABLE IF EXISTS `forum_permission_groupforumpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_permission_groupforumpermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `has_perm` tinyint(1) NOT NULL,
  `forum_id` int(11) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_permission_groupfo_permission_id_forum_id_g_a1e477c8_uniq` (`permission_id`,`forum_id`,`group_id`),
  KEY `forum_permission_gro_forum_id_d59d5cac_fk_forum_for` (`forum_id`),
  KEY `forum_permission_gro_group_id_b515635b_fk_auth_grou` (`group_id`),
  KEY `forum_permission_groupforumpermission_has_perm_48cae01d` (`has_perm`),
  CONSTRAINT `forum_permission_gro_forum_id_d59d5cac_fk_forum_for` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  CONSTRAINT `forum_permission_gro_group_id_b515635b_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `forum_permission_gro_permission_id_2475fe70_fk_forum_per` FOREIGN KEY (`permission_id`) REFERENCES `forum_permission_forumpermission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_permission_groupforumpermission`
--

LOCK TABLES `forum_permission_groupforumpermission` WRITE;
/*!40000 ALTER TABLE `forum_permission_groupforumpermission` DISABLE KEYS */;
INSERT INTO `forum_permission_groupforumpermission` VALUES (1,1,NULL,1,2),(2,1,NULL,1,3),(3,1,NULL,1,9),(4,1,NULL,1,8),(5,1,NULL,1,5),(6,1,NULL,1,1),(7,1,NULL,1,6),(8,1,NULL,1,7),(9,1,NULL,1,4);
/*!40000 ALTER TABLE `forum_permission_groupforumpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_permission_userforumpermission`
--

DROP TABLE IF EXISTS `forum_permission_userforumpermission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_permission_userforumpermission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `has_perm` tinyint(1) NOT NULL,
  `anonymous_user` tinyint(1) NOT NULL,
  `forum_id` int(11) DEFAULT NULL,
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_permission_userfor_permission_id_forum_id_u_024a3693_uniq` (`permission_id`,`forum_id`,`user_id`),
  KEY `forum_permission_use_forum_id_f781f4d6_fk_forum_for` (`forum_id`),
  KEY `forum_permission_use_user_id_8106d02d_fk_auth_user` (`user_id`),
  KEY `forum_permission_userforumpermission_anonymous_user_8aabbd9d` (`anonymous_user`),
  KEY `forum_permission_userforumpermission_has_perm_1b5ee7ac` (`has_perm`),
  CONSTRAINT `forum_permission_use_forum_id_f781f4d6_fk_forum_for` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  CONSTRAINT `forum_permission_use_permission_id_9090e930_fk_forum_per` FOREIGN KEY (`permission_id`) REFERENCES `forum_permission_forumpermission` (`id`),
  CONSTRAINT `forum_permission_use_user_id_8106d02d_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_permission_userforumpermission`
--

LOCK TABLES `forum_permission_userforumpermission` WRITE;
/*!40000 ALTER TABLE `forum_permission_userforumpermission` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_permission_userforumpermission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_polls_topicpoll`
--

DROP TABLE IF EXISTS `forum_polls_topicpoll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_polls_topicpoll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `question` varchar(255) NOT NULL,
  `duration` int(10) unsigned DEFAULT NULL,
  `max_options` smallint(5) unsigned NOT NULL,
  `user_changes` tinyint(1) NOT NULL,
  `topic_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `topic_id` (`topic_id`),
  CONSTRAINT `forum_polls_topicpol_topic_id_1b827b83_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_polls_topicpoll`
--

LOCK TABLES `forum_polls_topicpoll` WRITE;
/*!40000 ALTER TABLE `forum_polls_topicpoll` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_polls_topicpoll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_polls_topicpolloption`
--

DROP TABLE IF EXISTS `forum_polls_topicpolloption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_polls_topicpolloption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  `poll_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_polls_topicpol_poll_id_a54cbd58_fk_forum_pol` (`poll_id`),
  CONSTRAINT `forum_polls_topicpol_poll_id_a54cbd58_fk_forum_pol` FOREIGN KEY (`poll_id`) REFERENCES `forum_polls_topicpoll` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_polls_topicpolloption`
--

LOCK TABLES `forum_polls_topicpolloption` WRITE;
/*!40000 ALTER TABLE `forum_polls_topicpolloption` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_polls_topicpolloption` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_polls_topicpollvote`
--

DROP TABLE IF EXISTS `forum_polls_topicpollvote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_polls_topicpollvote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime(6) NOT NULL,
  `poll_option_id` int(11) NOT NULL,
  `voter_id` int(11) DEFAULT NULL,
  `anonymous_key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `forum_polls_topicpol_poll_option_id_a075b665_fk_forum_pol` (`poll_option_id`),
  KEY `forum_polls_topicpollvote_voter_id_0a287559_fk_auth_user_id` (`voter_id`),
  CONSTRAINT `forum_polls_topicpol_poll_option_id_a075b665_fk_forum_pol` FOREIGN KEY (`poll_option_id`) REFERENCES `forum_polls_topicpolloption` (`id`),
  CONSTRAINT `forum_polls_topicpollvote_voter_id_0a287559_fk_auth_user_id` FOREIGN KEY (`voter_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_polls_topicpollvote`
--

LOCK TABLES `forum_polls_topicpollvote` WRITE;
/*!40000 ALTER TABLE `forum_polls_topicpollvote` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_polls_topicpollvote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_tracking_forumreadtrack`
--

DROP TABLE IF EXISTS `forum_tracking_forumreadtrack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_tracking_forumreadtrack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mark_time` datetime(6) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_tracking_forumreadtrack_user_id_forum_id_3e64777a_uniq` (`user_id`,`forum_id`),
  KEY `forum_tracking_forum_forum_id_bbd3fb47_fk_forum_for` (`forum_id`),
  KEY `forum_tracking_forumreadtrack_mark_time_72eec39e` (`mark_time`),
  CONSTRAINT `forum_tracking_forum_forum_id_bbd3fb47_fk_forum_for` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  CONSTRAINT `forum_tracking_forumreadtrack_user_id_932d4605_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_tracking_forumreadtrack`
--

LOCK TABLES `forum_tracking_forumreadtrack` WRITE;
/*!40000 ALTER TABLE `forum_tracking_forumreadtrack` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_tracking_forumreadtrack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forum_tracking_topicreadtrack`
--

DROP TABLE IF EXISTS `forum_tracking_topicreadtrack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forum_tracking_topicreadtrack` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mark_time` datetime(6) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `forum_tracking_topicreadtrack_user_id_topic_id_6fe3e105_uniq` (`user_id`,`topic_id`),
  KEY `forum_tracking_topic_topic_id_9a53bd45_fk_forum_con` (`topic_id`),
  KEY `forum_tracking_topicreadtrack_mark_time_7dafc483` (`mark_time`),
  CONSTRAINT `forum_tracking_topic_topic_id_9a53bd45_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`),
  CONSTRAINT `forum_tracking_topicreadtrack_user_id_2762562b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_tracking_topicreadtrack`
--

LOCK TABLES `forum_tracking_topicreadtrack` WRITE;
/*!40000 ALTER TABLE `forum_tracking_topicreadtrack` DISABLE KEYS */;
/*!40000 ALTER TABLE `forum_tracking_topicreadtrack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_revision`
--

DROP TABLE IF EXISTS `reversion_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_revision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime(6) NOT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reversion_revision_user_id_17095f45_fk_auth_user_id` (`user_id`),
  KEY `reversion_revision_date_created_96f7c20c` (`date_created`),
  CONSTRAINT `reversion_revision_user_id_17095f45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_revision`
--

LOCK TABLES `reversion_revision` WRITE;
/*!40000 ALTER TABLE `reversion_revision` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_revision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reversion_version`
--

DROP TABLE IF EXISTS `reversion_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reversion_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(191) NOT NULL,
  `format` varchar(255) NOT NULL,
  `serialized_data` longtext NOT NULL,
  `object_repr` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reversion_version_db_content_type_id_objec_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`),
  KEY `reversion_version_content_type_id_7d0ff25c_fk_django_co` (`content_type_id`),
  KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`),
  CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_version`
--

LOCK TABLES `reversion_version` WRITE;
/*!40000 ALTER TABLE `reversion_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `reversion_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_association`
--

DROP TABLE IF EXISTS `social_auth_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_association` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_association`
--

LOCK TABLES `social_auth_association` WRITE;
/*!40000 ALTER TABLE `social_auth_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_code`
--

DROP TABLE IF EXISTS `social_auth_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `code` varchar(32) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  KEY `social_auth_code_code_a2393167` (`code`),
  KEY `social_auth_code_timestamp_176b341f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_code`
--

LOCK TABLES `social_auth_code` WRITE;
/*!40000 ALTER TABLE `social_auth_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_nonce`
--

DROP TABLE IF EXISTS `social_auth_nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_nonce` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_nonce`
--

LOCK TABLES `social_auth_nonce` WRITE;
/*!40000 ALTER TABLE `social_auth_nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_partial`
--

DROP TABLE IF EXISTS `social_auth_partial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_partial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) unsigned NOT NULL,
  `backend` varchar(32) NOT NULL,
  `data` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `social_auth_partial_token_3017fea3` (`token`),
  KEY `social_auth_partial_timestamp_50f2119f` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_partial`
--

LOCK TABLES `social_auth_partial` WRITE;
/*!40000 ALTER TABLE `social_auth_partial` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_partial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `social_auth_usersocialauth`
--

DROP TABLE IF EXISTS `social_auth_usersocialauth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `social_auth_usersocialauth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  KEY `social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id` (`user_id`),
  CONSTRAINT `social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `social_auth_usersocialauth`
--

LOCK TABLES `social_auth_usersocialauth` WRITE;
/*!40000 ALTER TABLE `social_auth_usersocialauth` DISABLE KEYS */;
/*!40000 ALTER TABLE `social_auth_usersocialauth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webcontent_faq`
--

DROP TABLE IF EXISTS `webcontent_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webcontent_faq` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(200) NOT NULL,
  `answer` longtext NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `flow` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `webcontent_faq_category_id_b92f315f_fk_webcontent_faqcategory_id` (`category_id`),
  CONSTRAINT `webcontent_faq_category_id_b92f315f_fk_webcontent_faqcategory_id` FOREIGN KEY (`category_id`) REFERENCES `webcontent_faqcategory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webcontent_faq`
--

LOCK TABLES `webcontent_faq` WRITE;
/*!40000 ALTER TABLE `webcontent_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `webcontent_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webcontent_faqcategory`
--

DROP TABLE IF EXISTS `webcontent_faqcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webcontent_faqcategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `desc` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webcontent_faqcategory`
--

LOCK TABLES `webcontent_faqcategory` WRITE;
/*!40000 ALTER TABLE `webcontent_faqcategory` DISABLE KEYS */;
INSERT INTO `webcontent_faqcategory` VALUES (1,'General','General faq question'),(2,'Community','Category for community faqs.'),(3,'Group','category for groups faq'),(4,'Resource','category for resource faqs'),(5,'Roles and Permissions','categories for roles'),(6,'Workflow','category for workflow');
/*!40000 ALTER TABLE `webcontent_faqcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webcontent_feedback`
--

DROP TABLE IF EXISTS `webcontent_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `webcontent_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `provided_at` datetime(6),
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webcontent_feedback_user_id_943add81_fk_auth_user_id` (`user_id`),
  CONSTRAINT `webcontent_feedback_user_id_943add81_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webcontent_feedback`
--

LOCK TABLES `webcontent_feedback` WRITE;
/*!40000 ALTER TABLE `webcontent_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `webcontent_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_states`
--

DROP TABLE IF EXISTS `workflow_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `desc` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_states`
--

LOCK TABLES `workflow_states` WRITE;
/*!40000 ALTER TABLE `workflow_states` DISABLE KEYS */;
INSERT INTO `workflow_states` VALUES (1,'draft','save as draft state'),(2,'visible','this state make the content visible to community'),(3,'publish','save as visible state'),(4,'private','this state make the content visible to group'),(5,'publishable','this content makes the content ready for publishing');
/*!40000 ALTER TABLE `workflow_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workflow_transitions`
--

DROP TABLE IF EXISTS `workflow_transitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workflow_transitions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `from_state_id` int(11) DEFAULT NULL,
  `to_state_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_transitions_from_state_id_5ff9ea9d_fk_workflow_` (`from_state_id`),
  KEY `workflow_transitions_to_state_id_8d6c5cc6_fk_workflow_states_id` (`to_state_id`),
  CONSTRAINT `workflow_transitions_from_state_id_5ff9ea9d_fk_workflow_` FOREIGN KEY (`from_state_id`) REFERENCES `workflow_states` (`id`),
  CONSTRAINT `workflow_transitions_to_state_id_8d6c5cc6_fk_workflow_states_id` FOREIGN KEY (`to_state_id`) REFERENCES `workflow_states` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_transitions`
--

LOCK TABLES `workflow_transitions` WRITE;
/*!40000 ALTER TABLE `workflow_transitions` DISABLE KEYS */;
INSERT INTO `workflow_transitions` VALUES (1,'Make Visible to Group',1,4),(3,'Make Visible to Community',4,2),(4,'Ready for Publishing',2,5),(5,'Publish',5,3);
/*!40000 ALTER TABLE `workflow_transitions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-04 13:08:16
