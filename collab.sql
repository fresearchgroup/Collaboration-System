-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: collaboration
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.04.2

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
  `body` longtext,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `published_on` datetime(6) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `published_by_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` (`created_by_id`),
  KEY `BasicArticle_articles_published_by_id_81e5e785_fk_auth_user_id` (`published_by_id`),
  KEY `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` (`state_id`),
  CONSTRAINT `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `BasicArticle_articles_published_by_id_81e5e785_fk_auth_user_id` FOREIGN KEY (`published_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
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
  `image` varchar(100) DEFAULT NULL,
  `category` varchar(100) NOT NULL,
  `tag_line` varchar(500) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `forum_link` varchar(100) DEFAULT NULL,
  `forum` int(10) unsigned DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_community_lft_d7f05a9b` (`lft`),
  KEY `Community_community_rght_6dfec445` (`rght`),
  KEY `Community_community_tree_id_bd4e2595` (`tree_id`),
  KEY `Community_community_level_db58ba5f` (`level`),
  KEY `Community_community_created_by_id_1080464d_fk_auth_user_id` (`created_by_id`),
  KEY `Community_community_parent_id_47d0e58d` (`parent_id`),
  CONSTRAINT `Community_community_created_by_id_1080464d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Community_community_parent_id_47d0e58d_fk_Community_community_id` FOREIGN KEY (`parent_id`) REFERENCES `Community_community` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
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
  KEY `Community_communityc_community_id_db58cc7f_fk_Community` (`community_id`),
  KEY `Community_communityc_course_id_1b9cc41b_fk_Course_co` (`course_id`),
  KEY `Community_communitycourses_user_id_d3572caf_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communityc_community_id_db58cc7f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Community_communityc_course_id_1b9cc41b_fk_Course_co` FOREIGN KEY (`course_id`) REFERENCES `Course_course` (`id`),
  CONSTRAINT `Community_communitycourses_user_id_d3572caf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
-- Table structure for table `Community_communitymedia`
--

DROP TABLE IF EXISTS `Community_communitymedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Community_communitymedia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `community_id` int(11) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_communitym_community_id_3ff46a01_fk_Community` (`community_id`),
  KEY `Community_communitymedia_media_id_e160518e_fk_Media_media_id` (`media_id`),
  KEY `Community_communitymedia_user_id_97a38254_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communitym_community_id_3ff46a01_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Community_communitymedia_media_id_e160518e_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `Media_media` (`id`),
  CONSTRAINT `Community_communitymedia_user_id_97a38254_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_communitymedia`
--

LOCK TABLES `Community_communitymedia` WRITE;
/*!40000 ALTER TABLE `Community_communitymedia` DISABLE KEYS */;
/*!40000 ALTER TABLE `Community_communitymedia` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
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
  `status` varchar(100) DEFAULT NULL,
  `requestedby_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_requestcom_requestedby_id_b3e83124_fk_auth_user` (`requestedby_id`),
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
  `title` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_course_created_by_id_696e3a4e_fk_auth_user_id` (`created_by_id`),
  KEY `Course_course_state_id_77c858e0_fk_workflow_states_id` (`state_id`),
  CONSTRAINT `Course_course_created_by_id_696e3a4e_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Course_course_state_id_77c858e0_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`)
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
  `types` varchar(300) DEFAULT NULL,
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
-- Table structure for table `Course_topicarticle`
--

DROP TABLE IF EXISTS `Course_topicarticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Course_topicarticle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `topics_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_topicarticle_article_id_2ab7af7f_fk_BasicArti` (`article_id`),
  KEY `Course_topicarticle_topics_id_d20b76e7_fk_Course_topics_id` (`topics_id`),
  CONSTRAINT `Course_topicarticle_article_id_2ab7af7f_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`),
  CONSTRAINT `Course_topicarticle_topics_id_d20b76e7_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `Course_topics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Course_topicarticle`
--

LOCK TABLES `Course_topicarticle` WRITE;
/*!40000 ALTER TABLE `Course_topicarticle` DISABLE KEYS */;
/*!40000 ALTER TABLE `Course_topicarticle` ENABLE KEYS */;
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
  `course_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Course_topics_course_id_9e18b74c_fk_Course_course_id` (`course_id`),
  KEY `Course_topics_lft_90a2e5bc` (`lft`),
  KEY `Course_topics_rght_01583e2c` (`rght`),
  KEY `Course_topics_tree_id_b199de91` (`tree_id`),
  KEY `Course_topics_level_a7ab2ea8` (`level`),
  KEY `Course_topics_parent_id_adff4cae` (`parent_id`),
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
  `image` varchar(100) DEFAULT NULL,
  `visibility` tinyint(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
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
  KEY `Group_grouparticles_group_id_84ee212d_fk_Group_group_id` (`group_id`),
  KEY `Group_grouparticles_user_id_12983c5c_fk_auth_user_id` (`user_id`),
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
-- Table structure for table `Group_groupinvitations`
--

DROP TABLE IF EXISTS `Group_groupinvitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_groupinvitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invitedat` datetime(6) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `invitedby_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Group_groupinvitations_group_id_48a7f8e2_fk_Group_group_id` (`group_id`),
  KEY `Group_groupinvitations_invitedby_id_f7a8ea5c_fk_auth_user_id` (`invitedby_id`),
  KEY `Group_groupinvitations_role_id_20c49c7f_fk_auth_group_id` (`role_id`),
  KEY `Group_groupinvitations_user_id_a4a046d3_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Group_groupinvitations_group_id_48a7f8e2_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  CONSTRAINT `Group_groupinvitations_invitedby_id_f7a8ea5c_fk_auth_user_id` FOREIGN KEY (`invitedby_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Group_groupinvitations_role_id_20c49c7f_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Group_groupinvitations_user_id_a4a046d3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_groupinvitations`
--

LOCK TABLES `Group_groupinvitations` WRITE;
/*!40000 ALTER TABLE `Group_groupinvitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_groupinvitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Group_groupmedia`
--

DROP TABLE IF EXISTS `Group_groupmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Group_groupmedia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Group_groupmedia_group_id_73f1a47c_fk_Group_group_id` (`group_id`),
  KEY `Group_groupmedia_media_id_bb652569_fk_Media_media_id` (`media_id`),
  KEY `Group_groupmedia_user_id_e6917c04_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Group_groupmedia_group_id_73f1a47c_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  CONSTRAINT `Group_groupmedia_media_id_bb652569_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `Media_media` (`id`),
  CONSTRAINT `Group_groupmedia_user_id_e6917c04_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Group_groupmedia`
--

LOCK TABLES `Group_groupmedia` WRITE;
/*!40000 ALTER TABLE `Group_groupmedia` DISABLE KEYS */;
/*!40000 ALTER TABLE `Group_groupmedia` ENABLE KEYS */;
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
  KEY `Group_groupmembership_role_id_bb865ffb_fk_auth_group_id` (`role_id`),
  KEY `Group_groupmembership_user_id_e4f5757f_fk_auth_user_id` (`user_id`),
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
-- Table structure for table `Media_media`
--

DROP TABLE IF EXISTS `Media_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Media_media` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mediatype` varchar(10) NOT NULL,
  `title` varchar(100) NOT NULL,
  `mediafile` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `published_on` datetime(6) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `published_by_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Media_media_created_by_id_ae93f7fb_fk_auth_user_id` (`created_by_id`),
  KEY `Media_media_published_by_id_83121da5_fk_auth_user_id` (`published_by_id`),
  KEY `Media_media_state_id_46785feb_fk_workflow_states_id` (`state_id`),
  CONSTRAINT `Media_media_created_by_id_ae93f7fb_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Media_media_published_by_id_83121da5_fk_auth_user_id` FOREIGN KEY (`published_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Media_media_state_id_46785feb_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Media_media`
--

LOCK TABLES `Media_media` WRITE;
/*!40000 ALTER TABLE `Media_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `Media_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_articleflaglogs`
--

DROP TABLE IF EXISTS `Reputation_articleflaglogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_articleflaglogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Reputation_articlefl_reason_id_200b641a_fk_Reputatio` (`reason_id`),
  KEY `Reputation_articlefl_resource_id_21412c4c_fk_BasicArti` (`resource_id`),
  KEY `Reputation_articleflaglogs_user_id_4bce74ef_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Reputation_articlefl_reason_id_200b641a_fk_Reputatio` FOREIGN KEY (`reason_id`) REFERENCES `Reputation_flagreason` (`id`),
  CONSTRAINT `Reputation_articlefl_resource_id_21412c4c_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `BasicArticle_articles` (`id`),
  CONSTRAINT `Reputation_articleflaglogs_user_id_4bce74ef_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_articleflaglogs`
--

LOCK TABLES `Reputation_articleflaglogs` WRITE;
/*!40000 ALTER TABLE `Reputation_articleflaglogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_articleflaglogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_articlescorelog`
--

DROP TABLE IF EXISTS `Reputation_articlescorelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_articlescorelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upvote` int(11) DEFAULT NULL,
  `downvote` int(11) DEFAULT NULL,
  `reported` int(11) DEFAULT NULL,
  `publish` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resource_id` (`resource_id`),
  CONSTRAINT `Reputation_articlesc_resource_id_ddac6fc9_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `BasicArticle_articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_articlescorelog`
--

LOCK TABLES `Reputation_articlescorelog` WRITE;
/*!40000 ALTER TABLE `Reputation_articlescorelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_articlescorelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_articleuserscorelogs`
--

DROP TABLE IF EXISTS `Reputation_articleuserscorelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_articleuserscorelogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upvoted` tinyint(1) NOT NULL,
  `downvoted` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Reputation_articleus_resource_id_2a10325b_fk_BasicArti` (`resource_id`),
  KEY `Reputation_articleuserscorelogs_user_id_77095608_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Reputation_articleus_resource_id_2a10325b_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `BasicArticle_articles` (`id`),
  CONSTRAINT `Reputation_articleuserscorelogs_user_id_77095608_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_articleuserscorelogs`
--

LOCK TABLES `Reputation_articleuserscorelogs` WRITE;
/*!40000 ALTER TABLE `Reputation_articleuserscorelogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_articleuserscorelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_communityreputaion`
--

DROP TABLE IF EXISTS `Reputation_communityreputaion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_communityreputaion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) DEFAULT NULL,
  `community_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Reputation_community_community_id_9fe0df3b_fk_Community` (`community_id`),
  KEY `Reputation_communityreputaion_user_id_fce03592_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Reputation_community_community_id_9fe0df3b_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  CONSTRAINT `Reputation_communityreputaion_user_id_fce03592_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_communityreputaion`
--

LOCK TABLES `Reputation_communityreputaion` WRITE;
/*!40000 ALTER TABLE `Reputation_communityreputaion` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_communityreputaion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_flagreason`
--

DROP TABLE IF EXISTS `Reputation_flagreason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_flagreason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_flagreason`
--

LOCK TABLES `Reputation_flagreason` WRITE;
/*!40000 ALTER TABLE `Reputation_flagreason` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_flagreason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_mediaflaglogs`
--

DROP TABLE IF EXISTS `Reputation_mediaflaglogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_mediaflaglogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Reputation_mediaflag_reason_id_b7bf0680_fk_Reputatio` (`reason_id`),
  KEY `Reputation_mediaflaglogs_resource_id_1fe0b6c8_fk_Media_media_id` (`resource_id`),
  KEY `Reputation_mediaflaglogs_user_id_6d095f7f_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Reputation_mediaflag_reason_id_b7bf0680_fk_Reputatio` FOREIGN KEY (`reason_id`) REFERENCES `Reputation_flagreason` (`id`),
  CONSTRAINT `Reputation_mediaflaglogs_resource_id_1fe0b6c8_fk_Media_media_id` FOREIGN KEY (`resource_id`) REFERENCES `Media_media` (`id`),
  CONSTRAINT `Reputation_mediaflaglogs_user_id_6d095f7f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_mediaflaglogs`
--

LOCK TABLES `Reputation_mediaflaglogs` WRITE;
/*!40000 ALTER TABLE `Reputation_mediaflaglogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_mediaflaglogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_mediascorelog`
--

DROP TABLE IF EXISTS `Reputation_mediascorelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_mediascorelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upvote` int(11) DEFAULT NULL,
  `downvote` int(11) DEFAULT NULL,
  `reported` int(11) DEFAULT NULL,
  `publish` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resource_id` (`resource_id`),
  CONSTRAINT `Reputation_mediascorelog_resource_id_c3f674e3_fk_Media_media_id` FOREIGN KEY (`resource_id`) REFERENCES `Media_media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_mediascorelog`
--

LOCK TABLES `Reputation_mediascorelog` WRITE;
/*!40000 ALTER TABLE `Reputation_mediascorelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_mediascorelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_mediauserscorelogs`
--

DROP TABLE IF EXISTS `Reputation_mediauserscorelogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_mediauserscorelogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upvoted` tinyint(1) NOT NULL,
  `downvoted` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Reputation_mediauser_resource_id_461aadb0_fk_Media_med` (`resource_id`),
  KEY `Reputation_mediauserscorelogs_user_id_ef68208e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Reputation_mediauser_resource_id_461aadb0_fk_Media_med` FOREIGN KEY (`resource_id`) REFERENCES `Media_media` (`id`),
  CONSTRAINT `Reputation_mediauserscorelogs_user_id_ef68208e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_mediauserscorelogs`
--

LOCK TABLES `Reputation_mediauserscorelogs` WRITE;
/*!40000 ALTER TABLE `Reputation_mediauserscorelogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_mediauserscorelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_resourcescore`
--

DROP TABLE IF EXISTS `Reputation_resourcescore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_resourcescore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `can_vote_unpublished` tinyint(1) NOT NULL,
  `upvote_value` int(11) DEFAULT NULL,
  `downvote_value` int(11) DEFAULT NULL,
  `can_report` tinyint(1) NOT NULL,
  `publish_value` int(11) DEFAULT NULL,
  `resource_type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_resourcescore`
--

LOCK TABLES `Reputation_resourcescore` WRITE;
/*!40000 ALTER TABLE `Reputation_resourcescore` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_resourcescore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_userscore`
--

DROP TABLE IF EXISTS `Reputation_userscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_userscore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` int(11) DEFAULT NULL,
  `publisher` int(11) DEFAULT NULL,
  `role_score` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_userscore`
--

LOCK TABLES `Reputation_userscore` WRITE;
/*!40000 ALTER TABLE `Reputation_userscore` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_userscore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskQueue_task`
--

DROP TABLE IF EXISTS `TaskQueue_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaskQueue_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `tfile` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskQueue_task`
--

LOCK TABLES `TaskQueue_task` WRITE;
/*!40000 ALTER TABLE `TaskQueue_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `TaskQueue_task` ENABLE KEYS */;
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
-- Table structure for table `actstream_action`
--

DROP TABLE IF EXISTS `actstream_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actstream_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_object_id` varchar(255) NOT NULL,
  `verb` varchar(255) NOT NULL,
  `description` longtext,
  `target_object_id` varchar(255) DEFAULT NULL,
  `action_object_object_id` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `public` tinyint(1) NOT NULL,
  `data` longtext,
  `action_object_content_type_id` int(11) DEFAULT NULL,
  `actor_content_type_id` int(11) NOT NULL,
  `target_content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `actstream_action_action_object_conten_ee623c15_fk_django_co` (`action_object_content_type_id`),
  KEY `actstream_action_actor_content_type_i_d5e5ec2a_fk_django_co` (`actor_content_type_id`),
  KEY `actstream_action_target_content_type__187fa164_fk_django_co` (`target_content_type_id`),
  KEY `actstream_action_actor_object_id_72ef0cfa` (`actor_object_id`),
  KEY `actstream_action_verb_83f768b7` (`verb`),
  KEY `actstream_action_target_object_id_e080d801` (`target_object_id`),
  KEY `actstream_action_action_object_object_id_6433bdf7` (`action_object_object_id`),
  KEY `actstream_action_timestamp_a23fe3ae` (`timestamp`),
  KEY `actstream_action_public_ac0653e9` (`public`),
  CONSTRAINT `actstream_action_action_object_conten_ee623c15_fk_django_co` FOREIGN KEY (`action_object_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `actstream_action_actor_content_type_i_d5e5ec2a_fk_django_co` FOREIGN KEY (`actor_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `actstream_action_target_content_type__187fa164_fk_django_co` FOREIGN KEY (`target_content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actstream_action`
--

LOCK TABLES `actstream_action` WRITE;
/*!40000 ALTER TABLE `actstream_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `actstream_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actstream_follow`
--

DROP TABLE IF EXISTS `actstream_follow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actstream_follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` varchar(255) NOT NULL,
  `actor_only` tinyint(1) NOT NULL,
  `started` datetime(6) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `actstream_follow_user_id_content_type_id_object_id_63ca7c27_uniq` (`user_id`,`content_type_id`,`object_id`),
  KEY `actstream_follow_content_type_id_ba287eb9_fk_django_co` (`content_type_id`),
  KEY `actstream_follow_object_id_d790e00d` (`object_id`),
  KEY `actstream_follow_started_254c63bd` (`started`),
  CONSTRAINT `actstream_follow_content_type_id_ba287eb9_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `actstream_follow_user_id_e9d4e1ff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actstream_follow`
--

LOCK TABLES `actstream_follow` WRITE;
/*!40000 ALTER TABLE `actstream_follow` DISABLE KEYS */;
/*!40000 ALTER TABLE `actstream_follow` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add comment',8,'add_xtdcomment'),(23,'Can change comment',8,'change_xtdcomment'),(24,'Can delete comment',8,'delete_xtdcomment'),(25,'Can moderate comments',8,'can_moderate'),(26,'Can add black listed domain',9,'add_blacklisteddomain'),(27,'Can change black listed domain',9,'change_blacklisteddomain'),(28,'Can delete black listed domain',9,'delete_blacklisteddomain'),(29,'Can add comment',10,'add_comment'),(30,'Can change comment',10,'change_comment'),(31,'Can delete comment',10,'delete_comment'),(32,'Can moderate comments',10,'can_moderate'),(33,'Can add comment flag',11,'add_commentflag'),(34,'Can change comment flag',11,'change_commentflag'),(35,'Can delete comment flag',11,'delete_commentflag'),(36,'Can add community',12,'add_community'),(37,'Can change community',12,'change_community'),(38,'Can delete community',12,'delete_community'),(39,'Can add community articles',13,'add_communityarticles'),(40,'Can change community articles',13,'change_communityarticles'),(41,'Can delete community articles',13,'delete_communityarticles'),(42,'Can add community courses',14,'add_communitycourses'),(43,'Can change community courses',14,'change_communitycourses'),(44,'Can delete community courses',14,'delete_communitycourses'),(45,'Can add community groups',15,'add_communitygroups'),(46,'Can change community groups',15,'change_communitygroups'),(47,'Can delete community groups',15,'delete_communitygroups'),(48,'Can add community media',16,'add_communitymedia'),(49,'Can change community media',16,'change_communitymedia'),(50,'Can delete community media',16,'delete_communitymedia'),(51,'Can add community membership',17,'add_communitymembership'),(52,'Can change community membership',17,'change_communitymembership'),(53,'Can delete community membership',17,'delete_communitymembership'),(54,'Can add request community creation',18,'add_requestcommunitycreation'),(55,'Can change request community creation',18,'change_requestcommunitycreation'),(56,'Can delete request community creation',18,'delete_requestcommunitycreation'),(57,'Can add favourite',19,'add_favourite'),(58,'Can change favourite',19,'change_favourite'),(59,'Can delete favourite',19,'delete_favourite'),(60,'Can add profile image',20,'add_profileimage'),(61,'Can change profile image',20,'change_profileimage'),(62,'Can delete profile image',20,'delete_profileimage'),(63,'Can add articles',21,'add_articles'),(64,'Can change articles',21,'change_articles'),(65,'Can delete articles',21,'delete_articles'),(66,'Can add article view logs',22,'add_articleviewlogs'),(67,'Can change article view logs',22,'change_articleviewlogs'),(68,'Can delete article view logs',22,'delete_articleviewlogs'),(69,'Can add group',23,'add_group'),(70,'Can change group',23,'change_group'),(71,'Can delete group',23,'delete_group'),(72,'Can add group articles',24,'add_grouparticles'),(73,'Can change group articles',24,'change_grouparticles'),(74,'Can delete group articles',24,'delete_grouparticles'),(75,'Can add group invitations',25,'add_groupinvitations'),(76,'Can change group invitations',25,'change_groupinvitations'),(77,'Can delete group invitations',25,'delete_groupinvitations'),(78,'Can add group media',26,'add_groupmedia'),(79,'Can change group media',26,'change_groupmedia'),(80,'Can delete group media',26,'delete_groupmedia'),(81,'Can add group membership',27,'add_groupmembership'),(82,'Can change group membership',27,'change_groupmembership'),(83,'Can delete group membership',27,'delete_groupmembership'),(84,'Can add revision',28,'add_revision'),(85,'Can change revision',28,'change_revision'),(86,'Can delete revision',28,'delete_revision'),(87,'Can add version',29,'add_version'),(88,'Can change version',29,'change_version'),(89,'Can delete version',29,'delete_version'),(90,'Can add Token',30,'add_token'),(91,'Can change Token',30,'change_token'),(92,'Can delete Token',30,'delete_token'),(93,'Can add states',31,'add_states'),(94,'Can change states',31,'change_states'),(95,'Can delete states',31,'delete_states'),(96,'Can add transitions',32,'add_transitions'),(97,'Can change transitions',32,'change_transitions'),(98,'Can delete transitions',32,'delete_transitions'),(99,'Can add association',33,'add_association'),(100,'Can change association',33,'change_association'),(101,'Can delete association',33,'delete_association'),(102,'Can add code',34,'add_code'),(103,'Can change code',34,'change_code'),(104,'Can delete code',34,'delete_code'),(105,'Can add nonce',35,'add_nonce'),(106,'Can change nonce',35,'change_nonce'),(107,'Can delete nonce',35,'delete_nonce'),(108,'Can add user social auth',36,'add_usersocialauth'),(109,'Can change user social auth',36,'change_usersocialauth'),(110,'Can delete user social auth',36,'delete_usersocialauth'),(111,'Can add partial',37,'add_partial'),(112,'Can change partial',37,'change_partial'),(113,'Can delete partial',37,'delete_partial'),(114,'Can add feedback',38,'add_feedback'),(115,'Can change feedback',38,'change_feedback'),(116,'Can delete feedback',38,'delete_feedback'),(117,'Can add faq',39,'add_faq'),(118,'Can change faq',39,'change_faq'),(119,'Can delete faq',39,'delete_faq'),(120,'Can add faq category',40,'add_faqcategory'),(121,'Can change faq category',40,'change_faqcategory'),(122,'Can delete faq category',40,'delete_faqcategory'),(123,'Can add course',41,'add_course'),(124,'Can change course',41,'change_course'),(125,'Can delete course',41,'delete_course'),(126,'Can add links',42,'add_links'),(127,'Can change links',42,'change_links'),(128,'Can delete links',42,'delete_links'),(129,'Can add topic article',43,'add_topicarticle'),(130,'Can change topic article',43,'change_topicarticle'),(131,'Can delete topic article',43,'delete_topicarticle'),(132,'Can add topics',44,'add_topics'),(133,'Can change topics',44,'change_topics'),(134,'Can delete topics',44,'delete_topics'),(135,'Can add videos',45,'add_videos'),(136,'Can change videos',45,'change_videos'),(137,'Can delete videos',45,'delete_videos'),(138,'Can add notification',46,'add_notification'),(139,'Can change notification',46,'change_notification'),(140,'Can delete notification',46,'delete_notification'),(141,'Can add action',47,'add_action'),(142,'Can change action',47,'change_action'),(143,'Can delete action',47,'delete_action'),(144,'Can add follow',48,'add_follow'),(145,'Can change follow',48,'change_follow'),(146,'Can delete follow',48,'delete_follow'),(147,'Can add type',49,'add_notificationtype'),(148,'Can change type',49,'change_notificationtype'),(149,'Can delete type',49,'delete_notificationtype'),(150,'Can add settings',50,'add_settings'),(151,'Can change settings',50,'change_settings'),(152,'Can delete settings',50,'delete_settings'),(153,'Can add notification',51,'add_notification'),(154,'Can change notification',51,'change_notification'),(155,'Can delete notification',51,'delete_notification'),(156,'Can add subscription',52,'add_subscription'),(157,'Can change subscription',52,'change_subscription'),(158,'Can delete subscription',52,'delete_subscription'),(159,'Can add kv store',53,'add_kvstore'),(160,'Can change kv store',53,'change_kvstore'),(161,'Can delete kv store',53,'delete_kvstore'),(162,'Can add article',54,'add_article'),(163,'Can change article',54,'change_article'),(164,'Can delete article',54,'delete_article'),(165,'Can edit all articles and lock/unlock/restore',54,'moderate'),(166,'Can change ownership of any article',54,'assign'),(167,'Can assign permissions to other users',54,'grant'),(168,'Can add Article for object',55,'add_articleforobject'),(169,'Can change Article for object',55,'change_articleforobject'),(170,'Can delete Article for object',55,'delete_articleforobject'),(171,'Can add article plugin',56,'add_articleplugin'),(172,'Can change article plugin',56,'change_articleplugin'),(173,'Can delete article plugin',56,'delete_articleplugin'),(174,'Can add article revision',57,'add_articlerevision'),(175,'Can change article revision',57,'change_articlerevision'),(176,'Can delete article revision',57,'delete_articlerevision'),(177,'Can add reusable plugin',58,'add_reusableplugin'),(178,'Can change reusable plugin',58,'change_reusableplugin'),(179,'Can delete reusable plugin',58,'delete_reusableplugin'),(180,'Can add revision plugin',59,'add_revisionplugin'),(181,'Can change revision plugin',59,'change_revisionplugin'),(182,'Can delete revision plugin',59,'delete_revisionplugin'),(183,'Can add revision plugin revision',60,'add_revisionpluginrevision'),(184,'Can change revision plugin revision',60,'change_revisionpluginrevision'),(185,'Can delete revision plugin revision',60,'delete_revisionpluginrevision'),(186,'Can add simple plugin',61,'add_simpleplugin'),(187,'Can change simple plugin',61,'change_simpleplugin'),(188,'Can delete simple plugin',61,'delete_simpleplugin'),(189,'Can add URL path',62,'add_urlpath'),(190,'Can change URL path',62,'change_urlpath'),(191,'Can delete URL path',62,'delete_urlpath'),(192,'Can add attachment',63,'add_attachment'),(193,'Can change attachment',63,'change_attachment'),(194,'Can delete attachment',63,'delete_attachment'),(195,'Can add attachment revision',64,'add_attachmentrevision'),(196,'Can change attachment revision',64,'change_attachmentrevision'),(197,'Can delete attachment revision',64,'delete_attachmentrevision'),(198,'Can add article subscription',65,'add_articlesubscription'),(199,'Can change article subscription',65,'change_articlesubscription'),(200,'Can delete article subscription',65,'delete_articlesubscription'),(201,'Can add image',66,'add_image'),(202,'Can change image',66,'change_image'),(203,'Can delete image',66,'delete_image'),(204,'Can add image revision',67,'add_imagerevision'),(205,'Can change image revision',67,'change_imagerevision'),(206,'Can delete image revision',67,'delete_imagerevision'),(207,'Can add article flag logs',68,'add_articleflaglogs'),(208,'Can change article flag logs',68,'change_articleflaglogs'),(209,'Can delete article flag logs',68,'delete_articleflaglogs'),(210,'Can add article score log',69,'add_articlescorelog'),(211,'Can change article score log',69,'change_articlescorelog'),(212,'Can delete article score log',69,'delete_articlescorelog'),(213,'Can add article user score logs',70,'add_articleuserscorelogs'),(214,'Can change article user score logs',70,'change_articleuserscorelogs'),(215,'Can delete article user score logs',70,'delete_articleuserscorelogs'),(216,'Can add community reputaion',71,'add_communityreputaion'),(217,'Can change community reputaion',71,'change_communityreputaion'),(218,'Can delete community reputaion',71,'delete_communityreputaion'),(219,'Can add flag reason',72,'add_flagreason'),(220,'Can change flag reason',72,'change_flagreason'),(221,'Can delete flag reason',72,'delete_flagreason'),(222,'Can add media flag logs',73,'add_mediaflaglogs'),(223,'Can change media flag logs',73,'change_mediaflaglogs'),(224,'Can delete media flag logs',73,'delete_mediaflaglogs'),(225,'Can add media score log',74,'add_mediascorelog'),(226,'Can change media score log',74,'change_mediascorelog'),(227,'Can delete media score log',74,'delete_mediascorelog'),(228,'Can add media user score logs',75,'add_mediauserscorelogs'),(229,'Can change media user score logs',75,'change_mediauserscorelogs'),(230,'Can delete media user score logs',75,'delete_mediauserscorelogs'),(231,'Can add resource score',76,'add_resourcescore'),(232,'Can change resource score',76,'change_resourcescore'),(233,'Can delete resource score',76,'delete_resourcescore'),(234,'Can add user score',77,'add_userscore'),(235,'Can change user score',77,'change_userscore'),(236,'Can delete user score',77,'delete_userscore'),(237,'Can add ether article',78,'add_etherarticle'),(238,'Can change ether article',78,'change_etherarticle'),(239,'Can delete ether article',78,'delete_etherarticle'),(240,'Can add ether community',79,'add_ethercommunity'),(241,'Can change ether community',79,'change_ethercommunity'),(242,'Can delete ether community',79,'delete_ethercommunity'),(243,'Can add ether group',80,'add_ethergroup'),(244,'Can change ether group',80,'change_ethergroup'),(245,'Can delete ether group',80,'delete_ethergroup'),(246,'Can add ether user',81,'add_etheruser'),(247,'Can change ether user',81,'change_etheruser'),(248,'Can delete ether user',81,'delete_etheruser'),(249,'Can add media',82,'add_media'),(250,'Can change media',82,'change_media'),(251,'Can delete media',82,'delete_media'),(252,'Can add media metadata',83,'add_mediametadata'),(253,'Can change media metadata',83,'change_mediametadata'),(254,'Can delete media metadata',83,'delete_mediametadata'),(255,'Can add metadata',84,'add_metadata'),(256,'Can change metadata',84,'change_metadata'),(257,'Can delete metadata',84,'delete_metadata'),(258,'Can add task',85,'add_task'),(259,'Can change task',85,'change_task'),(260,'Can delete task',85,'delete_task'),(261,'Can add Forum',86,'add_forum'),(262,'Can change Forum',86,'change_forum'),(263,'Can delete Forum',86,'delete_forum'),(264,'Can add Post',87,'add_post'),(265,'Can change Post',87,'change_post'),(266,'Can delete Post',87,'delete_post'),(267,'Can add Topic',88,'add_topic'),(268,'Can change Topic',88,'change_topic'),(269,'Can delete Topic',88,'delete_topic'),(270,'Can add Attachment',89,'add_attachment'),(271,'Can change Attachment',89,'change_attachment'),(272,'Can delete Attachment',89,'delete_attachment'),(273,'Can add Topic poll',90,'add_topicpoll'),(274,'Can change Topic poll',90,'change_topicpoll'),(275,'Can delete Topic poll',90,'delete_topicpoll'),(276,'Can add Topic poll option',91,'add_topicpolloption'),(277,'Can change Topic poll option',91,'change_topicpolloption'),(278,'Can delete Topic poll option',91,'delete_topicpolloption'),(279,'Can add Topic poll vote',92,'add_topicpollvote'),(280,'Can change Topic poll vote',92,'change_topicpollvote'),(281,'Can delete Topic poll vote',92,'delete_topicpollvote'),(282,'Can add Forum track',93,'add_forumreadtrack'),(283,'Can change Forum track',93,'change_forumreadtrack'),(284,'Can delete Forum track',93,'delete_forumreadtrack'),(285,'Can add Topic track',94,'add_topicreadtrack'),(286,'Can change Topic track',94,'change_topicreadtrack'),(287,'Can delete Topic track',94,'delete_topicreadtrack'),(288,'Can add Forum profile',95,'add_forumprofile'),(289,'Can change Forum profile',95,'change_forumprofile'),(290,'Can delete Forum profile',95,'delete_forumprofile'),(291,'Can add Forum permission',96,'add_forumpermission'),(292,'Can change Forum permission',96,'change_forumpermission'),(293,'Can delete Forum permission',96,'delete_forumpermission'),(294,'Can add Group forum permission',97,'add_groupforumpermission'),(295,'Can change Group forum permission',97,'change_groupforumpermission'),(296,'Can delete Group forum permission',97,'delete_groupforumpermission'),(297,'Can add User forum permission',98,'add_userforumpermission'),(298,'Can change User forum permission',98,'change_userforumpermission'),(299,'Can delete User forum permission',98,'delete_userforumpermission'),(300,'',4,'create_article'),(301,'',4,'edit_article');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$py0SAPXSetIb$UIUPfaZcrzVWa0IFHsTnop7ft0LwsafPoGHVWaM/428=','2019-01-28 10:58:18.459496',1,'admin','','','admin@mail.com',1,1,'2018-12-24 08:21:27.850862');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2018-12-24 08:23:17.401809','1','Collaboration System',1,'[{\"added\": {}}]',86,1),(2,'2018-12-28 12:18:01.155843','1','Aticle 1',1,'[{\"added\": {}}]',21,1),(3,'2018-12-28 12:18:28.222168','2','Apphook',1,'[{\"added\": {}}]',21,1),(4,'2019-01-10 11:25:50.566668','1','Collab',3,'',12,1),(5,'2019-01-10 11:25:50.573020','5','had',3,'',12,1),(6,'2019-01-10 11:25:50.579043','2','Collaboration System',3,'',12,1),(7,'2019-01-10 11:25:50.716756','3','had',3,'',12,1),(8,'2019-01-10 11:25:50.733040','4','task ',3,'',12,1),(9,'2019-01-10 14:21:26.428300','1','draft',2,'[{\"changed\": {\"fields\": [\"initial\"]}}]',31,1),(10,'2019-01-10 14:21:39.571782','3','publish',2,'[{\"changed\": {\"fields\": [\"final\"]}}]',31,1),(11,'2019-01-28 10:58:39.116718','7','test',3,'',21,1),(12,'2019-01-28 10:58:39.127993','6','hello',3,'',21,1),(13,'2019-01-28 10:58:39.154346','5','Computer Science',3,'',21,1),(14,'2019-01-28 10:58:39.160504','4','Temple',3,'',21,1),(15,'2019-01-28 10:58:39.263324','3','hello',3,'',21,1),(16,'2019-01-28 10:58:39.269399','2','Apphook',3,'',21,1),(17,'2019-01-28 10:58:39.275479','1','Aticle 1',3,'',21,1),(18,'2019-01-28 11:00:00.133025','1','Collaboration System',3,'',86,1),(19,'2019-01-28 11:00:00.139167','2','Collab',3,'',86,1),(20,'2019-01-28 11:00:00.145019','3','Collaboration System',3,'',86,1),(21,'2019-01-28 11:00:00.150910','4','had',3,'',86,1),(22,'2019-01-28 11:00:00.156655','5','task ',3,'',86,1),(23,'2019-01-28 11:00:00.218485','6','Collab',3,'',86,1),(24,'2019-01-28 11:03:58.861380','7','Collaboration System',1,'[{\"added\": {}}]',86,1),(25,'2019-01-28 11:07:19.518365','2','abhi',3,'',4,1),(26,'2019-01-28 11:07:19.524585','3','manas',3,'',4,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (47,'actstream','action'),(48,'actstream','follow'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(30,'authtoken','token'),(21,'BasicArticle','articles'),(22,'BasicArticle','articleviewlogs'),(12,'Community','community'),(13,'Community','communityarticles'),(14,'Community','communitycourses'),(15,'Community','communitygroups'),(16,'Community','communitymedia'),(17,'Community','communitymembership'),(18,'Community','requestcommunitycreation'),(5,'contenttypes','contenttype'),(41,'Course','course'),(42,'Course','links'),(43,'Course','topicarticle'),(44,'Course','topics'),(45,'Course','videos'),(10,'django_comments','comment'),(11,'django_comments','commentflag'),(9,'django_comments_xtd','blacklisteddomain'),(8,'django_comments_xtd','xtdcomment'),(51,'django_nyt','notification'),(49,'django_nyt','notificationtype'),(50,'django_nyt','settings'),(52,'django_nyt','subscription'),(78,'etherpad','etherarticle'),(79,'etherpad','ethercommunity'),(80,'etherpad','ethergroup'),(81,'etherpad','etheruser'),(86,'forum','forum'),(89,'forum_attachments','attachment'),(87,'forum_conversation','post'),(88,'forum_conversation','topic'),(95,'forum_member','forumprofile'),(96,'forum_permission','forumpermission'),(97,'forum_permission','groupforumpermission'),(98,'forum_permission','userforumpermission'),(90,'forum_polls','topicpoll'),(91,'forum_polls','topicpolloption'),(92,'forum_polls','topicpollvote'),(93,'forum_tracking','forumreadtrack'),(94,'forum_tracking','topicreadtrack'),(23,'Group','group'),(24,'Group','grouparticles'),(25,'Group','groupinvitations'),(26,'Group','groupmedia'),(27,'Group','groupmembership'),(82,'Media','media'),(83,'metadata','mediametadata'),(84,'metadata','metadata'),(46,'notifications','notification'),(68,'Reputation','articleflaglogs'),(69,'Reputation','articlescorelog'),(70,'Reputation','articleuserscorelogs'),(71,'Reputation','communityreputaion'),(72,'Reputation','flagreason'),(73,'Reputation','mediaflaglogs'),(74,'Reputation','mediascorelog'),(75,'Reputation','mediauserscorelogs'),(76,'Reputation','resourcescore'),(77,'Reputation','userscore'),(28,'reversion','revision'),(29,'reversion','version'),(6,'sessions','session'),(7,'sites','site'),(33,'social_django','association'),(34,'social_django','code'),(35,'social_django','nonce'),(37,'social_django','partial'),(36,'social_django','usersocialauth'),(85,'TaskQueue','task'),(53,'thumbnail','kvstore'),(19,'UserRolesPermission','favourite'),(20,'UserRolesPermission','profileimage'),(39,'webcontent','faq'),(40,'webcontent','faqcategory'),(38,'webcontent','feedback'),(54,'wiki','article'),(55,'wiki','articleforobject'),(56,'wiki','articleplugin'),(57,'wiki','articlerevision'),(58,'wiki','reusableplugin'),(59,'wiki','revisionplugin'),(60,'wiki','revisionpluginrevision'),(61,'wiki','simpleplugin'),(62,'wiki','urlpath'),(63,'wiki_attachments','attachment'),(64,'wiki_attachments','attachmentrevision'),(66,'wiki_images','image'),(67,'wiki_images','imagerevision'),(65,'wiki_notifications','articlesubscription'),(31,'workflow','states'),(32,'workflow','transitions');
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
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'workflow','0001_initial','2018-12-24 08:16:07.767499'),(2,'contenttypes','0001_initial','2018-12-24 08:16:08.460735'),(3,'auth','0001_initial','2018-12-24 08:16:17.817039'),(4,'BasicArticle','0001_initial','2018-12-24 08:16:21.976723'),(5,'contenttypes','0002_remove_content_type_name','2018-12-24 08:16:23.430196'),(6,'auth','0002_alter_permission_name_max_length','2018-12-24 08:16:23.647556'),(7,'auth','0003_alter_user_email_max_length','2018-12-24 08:16:23.781399'),(8,'auth','0004_alter_user_username_opts','2018-12-24 08:16:23.839249'),(9,'auth','0005_alter_user_last_login_null','2018-12-24 08:16:24.440808'),(10,'auth','0006_require_contenttypes_0002','2018-12-24 08:16:24.511265'),(11,'auth','0007_alter_validators_add_error_messages','2018-12-24 08:16:24.588943'),(12,'auth','0008_alter_user_username_max_length','2018-12-24 08:16:24.716989'),(13,'Media','0001_initial','2018-12-24 08:16:27.674210'),(14,'Group','0001_initial','2018-12-24 08:16:41.434677'),(15,'Course','0001_initial','2018-12-24 08:16:52.884581'),(16,'Community','0001_initial','2018-12-24 08:17:02.951510'),(17,'Community','0002_auto_20181224_0729','2018-12-24 08:17:19.230938'),(18,'Reputation','0001_initial','2018-12-24 08:17:36.797636'),(19,'TaskQueue','0001_initial','2018-12-24 08:17:37.134445'),(20,'UserRolesPermission','0001_initial','2018-12-24 08:17:39.681328'),(21,'actstream','0001_initial','2018-12-24 08:17:47.552935'),(22,'actstream','0002_remove_action_data','2018-12-24 08:17:47.641328'),(23,'admin','0001_initial','2018-12-24 08:17:49.637846'),(24,'admin','0002_logentry_remove_auto_add','2018-12-24 08:17:49.863564'),(25,'authtoken','0001_initial','2018-12-24 08:17:51.300095'),(26,'authtoken','0002_auto_20160226_1747','2018-12-24 08:17:52.427570'),(27,'sites','0001_initial','2018-12-24 08:17:52.805556'),(28,'django_comments','0001_initial','2018-12-24 08:17:58.607636'),(29,'django_comments','0002_update_user_email_field_length','2018-12-24 08:17:58.767052'),(30,'django_comments','0003_add_submit_date_index','2018-12-24 08:17:59.092024'),(31,'django_comments_xtd','0001_initial','2018-12-24 08:18:00.754663'),(32,'django_comments_xtd','0002_blacklisteddomain','2018-12-24 08:18:01.397863'),(33,'django_comments_xtd','0003_auto_20170220_1333','2018-12-24 08:18:01.446358'),(34,'django_comments_xtd','0004_auto_20170221_1510','2018-12-24 08:18:01.519834'),(35,'django_comments_xtd','0005_auto_20170920_1247','2018-12-24 08:18:01.597063'),(36,'django_nyt','0001_initial','2018-12-24 08:18:02.893358'),(37,'django_nyt','0002_notification_settings','2018-12-24 08:18:04.772464'),(38,'django_nyt','0003_subscription','2018-12-24 08:18:07.746247'),(39,'django_nyt','0004_notification_subscription','2018-12-24 08:18:09.150246'),(40,'django_nyt','0005__v_0_9_2','2018-12-24 08:18:15.931405'),(41,'django_nyt','0006_auto_20141229_1630','2018-12-24 08:18:16.951047'),(42,'django_nyt','0007_add_modified_and_default_settings','2018-12-24 08:18:18.373167'),(43,'django_nyt','0008_auto_20161023_1641','2018-12-24 08:18:21.262768'),(44,'etherpad','0001_initial','2018-12-24 08:18:26.198416'),(45,'forum','0001_initial','2018-12-24 08:18:29.790929'),(46,'forum_conversation','0001_initial','2018-12-24 08:18:39.704563'),(47,'forum_conversation','0002_post_anonymous_key','2018-12-24 08:18:40.415003'),(48,'forum_conversation','0003_auto_20160228_2051','2018-12-24 08:18:40.672112'),(49,'forum_conversation','0004_auto_20160427_0502','2018-12-24 08:18:42.761887'),(50,'forum_conversation','0005_auto_20160607_0455','2018-12-24 08:18:43.387609'),(51,'forum_conversation','0006_post_enable_signature','2018-12-24 08:18:44.543119'),(52,'forum_conversation','0007_auto_20160903_0450','2018-12-24 08:18:48.691855'),(53,'forum_conversation','0008_auto_20160903_0512','2018-12-24 08:18:48.825919'),(54,'forum_conversation','0009_auto_20160925_2126','2018-12-24 08:18:48.905270'),(55,'forum_conversation','0010_auto_20170120_0224','2018-12-24 08:18:50.485548'),(56,'forum','0002_auto_20150725_0512','2018-12-24 08:18:50.570096'),(57,'forum','0003_remove_forum_is_active','2018-12-24 08:18:51.367197'),(58,'forum','0004_auto_20170504_2108','2018-12-24 08:18:53.415187'),(59,'forum','0005_auto_20170504_2113','2018-12-24 08:18:53.514926'),(60,'forum','0006_auto_20170523_2036','2018-12-24 08:18:55.235173'),(61,'forum','0007_auto_20170523_2140','2018-12-24 08:18:55.335461'),(62,'forum','0008_forum_last_post','2018-12-24 08:18:57.673708'),(63,'forum','0009_auto_20170928_2327','2018-12-24 08:18:57.766730'),(64,'forum_attachments','0001_initial','2018-12-24 08:18:58.893464'),(65,'forum_member','0001_initial','2018-12-24 08:19:00.238804'),(66,'forum_member','0002_auto_20160225_0515','2018-12-24 08:19:00.319285'),(67,'forum_member','0003_auto_20160227_2122','2018-12-24 08:19:00.402095'),(68,'forum_permission','0001_initial','2018-12-24 08:19:07.322743'),(69,'forum_permission','0002_auto_20160607_0500','2018-12-24 08:19:08.892449'),(70,'forum_permission','0003_remove_forumpermission_name','2018-12-24 08:19:09.695000'),(71,'forum_polls','0001_initial','2018-12-24 08:19:14.464315'),(72,'forum_polls','0002_auto_20151105_0029','2018-12-24 08:19:16.928111'),(73,'forum_tracking','0001_initial','2018-12-24 08:19:21.781407'),(74,'forum_tracking','0002_auto_20160607_0502','2018-12-24 08:19:22.651023'),(75,'metadata','0001_initial','2018-12-24 08:19:25.757071'),(76,'notifications','0001_initial','2018-12-24 08:19:29.874974'),(77,'notifications','0002_auto_20150224_1134','2018-12-24 08:19:31.656377'),(78,'notifications','0003_notification_data','2018-12-24 08:19:32.501101'),(79,'notifications','0004_auto_20150826_1508','2018-12-24 08:19:32.691532'),(80,'notifications','0005_auto_20160504_1520','2018-12-24 08:19:32.785597'),(81,'notifications','0006_indexes','2018-12-24 08:19:34.101823'),(82,'reversion','0001_initial','2018-12-24 08:19:37.928107'),(83,'reversion','0002_auto_20141216_1509','2018-12-24 08:19:37.969740'),(84,'reversion','0003_auto_20160601_1600','2018-12-24 08:19:38.093834'),(85,'reversion','0004_auto_20160611_1202','2018-12-24 08:19:38.177982'),(86,'sessions','0001_initial','2018-12-24 08:19:38.813131'),(87,'sites','0002_alter_domain_unique','2018-12-24 08:19:39.122210'),(88,'default','0001_initial','2018-12-24 08:19:42.681194'),(89,'social_auth','0001_initial','2018-12-24 08:19:42.731022'),(90,'default','0002_add_related_name','2018-12-24 08:19:43.792197'),(91,'social_auth','0002_add_related_name','2018-12-24 08:19:43.825093'),(92,'default','0003_alter_email_max_length','2018-12-24 08:19:43.934590'),(93,'social_auth','0003_alter_email_max_length','2018-12-24 08:19:43.967219'),(94,'default','0004_auto_20160423_0400','2018-12-24 08:19:44.053037'),(95,'social_auth','0004_auto_20160423_0400','2018-12-24 08:19:44.092365'),(96,'social_auth','0005_auto_20160727_2333','2018-12-24 08:19:44.350848'),(97,'social_django','0006_partial','2018-12-24 08:19:45.085879'),(98,'social_django','0007_code_timestamp','2018-12-24 08:19:46.180602'),(99,'social_django','0008_partial_timestamp','2018-12-24 08:19:47.083420'),(100,'thumbnail','0001_initial','2018-12-24 08:19:47.386184'),(101,'webcontent','0001_initial','2018-12-24 08:19:48.122008'),(102,'webcontent','0002_auto_20180124_1328','2018-12-24 08:19:50.424271'),(103,'webcontent','0003_auto_20180124_1452','2018-12-24 08:19:51.945946'),(104,'webcontent','0004_delete_faq','2018-12-24 08:19:52.206099'),(105,'webcontent','0005_faq','2018-12-24 08:19:52.541358'),(106,'webcontent','0006_faqcategory','2018-12-24 08:19:52.916177'),(107,'webcontent','0007_remove_faq_category','2018-12-24 08:19:53.706846'),(108,'webcontent','0008_faq_category','2018-12-24 08:19:55.261645'),(109,'webcontent','0009_faq_order','2018-12-24 08:19:55.963028'),(110,'webcontent','0010_remove_faq_order','2018-12-24 08:19:56.615350'),(111,'webcontent','0011_faq_order','2018-12-24 08:19:57.291159'),(112,'webcontent','0012_auto_20180125_1628','2018-12-24 08:19:58.093935'),(113,'webcontent','0013_auto_20180125_1634','2018-12-24 08:19:59.045304'),(114,'webcontent','0014_auto_20180125_1636','2018-12-24 08:19:59.163889'),(115,'webcontent','0015_auto_20180125_1643','2018-12-24 08:20:00.098699'),(116,'wiki','0001_initial','2018-12-24 08:20:29.544037'),(117,'wiki','0002_urlpath_moved_to','2018-12-24 08:20:32.084323'),(118,'wiki_attachments','0001_initial','2018-12-24 08:20:37.946909'),(119,'wiki_attachments','0002_auto_20151118_1816','2018-12-24 08:20:38.035758'),(120,'wiki_images','0001_initial','2018-12-24 08:20:40.452625'),(121,'wiki_images','0002_auto_20151118_1811','2018-12-24 08:20:40.568265'),(122,'wiki_notifications','0001_initial','2018-12-24 08:20:43.026360'),(123,'wiki_notifications','0002_auto_20151118_1811','2018-12-24 08:20:43.104764'),(124,'reversion','0001_squashed_0004_auto_20160611_1202','2018-12-24 08:20:43.155775'),(125,'social_django','0004_auto_20160423_0400','2018-12-24 08:20:43.201522'),(126,'social_django','0005_auto_20160727_2333','2018-12-24 08:20:43.242772'),(127,'social_django','0001_initial','2018-12-24 08:20:43.284599'),(128,'social_django','0003_alter_email_max_length','2018-12-24 08:20:43.326183'),(129,'social_django','0002_add_related_name','2018-12-24 08:20:43.368110'),(130,'workflow','0002_auto_20190110_1419','2019-01-10 14:19:40.059025');
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
INSERT INTO `django_session` VALUES ('0xevg3iygyu2t8hh2c2imk0rvyqqvvqq','OTAxYjcyODQ1ODA4MzFkNmQ3MTBkNmQzZmUxZDkxYmRlZjM2YTk1ODp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNjhhODgyMGYwZmExNGRlNjlmOWNmOGZhYTc0NGExYjMiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODA2MGQ1MDAzMzRkZGU0NjcyMDU3ZmVhMDE0NDhhZWE4MGM4Zjk1MiJ9','2019-01-28 13:07:25.246208'),('0yngigekr2e3so848c3zf4gkdr0yby53','OWY3Y2QwYTkwN2RkODQ0OWRiMTc4YjllMWQ5MWMwOGY4YjQzNTA5Nzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNjM5ZWQ4MTE1MDUzNDM5YmI1ODIzM2Q5NDViNmM3MDAiLCJfYXV0aF91c2VyX2lkIjoiMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOThlZmIyMTRmNWI5ZWNjOTU2OTM4NDgxNTJkYjNmOTI1NGQ3ZDA5NiJ9','2019-01-11 11:04:38.576858'),('1a72ovi6r6o9gi38n0bhuyubdffsp0zj','YmI5ODdmNjYzYTcxZDVjYTYwYzMxZWJiMDliYjM1NzU3ZDIxMDNhZjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiOGY3NmI0MjZjNWYxNDcyZjk0NDZkNTJhYTE1ZTVjYTIifQ==','2018-12-28 15:25:22.381512'),('488m2i3ekgfzznlvltdji1430ic9cl2p','YjU2MDEwOTEzNzVkMjA3ZmQyMjkyYjNiMTQ3Njg0MWUwMTFlOTA4ZDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNmZhODc1M2YyMGUyNDkxODk5ZThhMmFhZmY5YmFiMmIifQ==','2018-12-28 14:51:19.152393'),('57p54zw4486mdrs1ihi80zoqsklf2y15','MjQwYjAyNGViYTBhNjRjZWI4NWJkOWVmODI4OWMyNDU0NWFlOWY4OTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMTcxYjBiY2Y4OThmNDMyNWIyMGQxOWVjNjNjMmZiYTYifQ==','2018-12-28 15:30:18.821246'),('6v97osqj2m3ok7uaj5pelkn5y79qe9ij','N2ZlODYzNTM1ZmI4MDFhNmQ3MGI0NzBhZTJhNmQzODk5OGQ3ZTRmNDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiZmI5ZjUwMDE2NWFhNDZiMzhhYzBmZTUyMjcyMTRjNmIifQ==','2019-01-14 14:16:55.401494'),('76oevonqiaapa92n06x1t6fol5bghmv1','YjI5MDE4YTg5NDMwY2FkODhjODAxMDg0NTlkZDcxOThmZGUxYTBkNzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNzlhZTk5YWQ4YWYwNDlhMTgzMjA1MjI4YzI3YmU0MGQifQ==','2018-12-28 15:31:11.849838'),('7fk6zojxal4r4tdw45psoj357foi7y66','OTBjYzRkZjhjYWM1ZjAzNTc1NDNlMWVhNThmNzYzZTlhNWVmYTQzZTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMTQ0OWQ4YTYzNTRjNGI5ZjgyZGIwNGMyNjE2NGY1OTgifQ==','2018-12-28 15:37:31.210135'),('7s8ypslrxjd7yd2chckcv2yx5em5s1wj','MzI5NTVjMzkyNzBlM2ExNjBjNmUzZjg1NTA1Yjg5YmVlMTUwNDgzMzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMTljOTJhYzkwNTgwNDA5Y2JiODc2OGFlNDBlZTljODkiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODA2MGQ1MDAzMzRkZGU0NjcyMDU3ZmVhMDE0NDhhZWE4MGM4Zjk1MiJ9','2019-01-24 13:47:55.179692'),('9u1ytskhl6ctg0zkvxgbr398hu9rwsx6','YTMyNzI0YjRkZmZhNDJmMTVjNTZiZTMzMzY5MWQ5MTY2YzFkNmI3Yjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNDUxNmE0N2Q5NjcwNGIyNmEzYjNkMGZlZWMzZWMzZjEifQ==','2019-01-14 14:17:23.223212'),('absobo5x73q3u4306awslvpupgau6unn','NGFlZjBlYzMxZmYzY2JmMzk5ZjliYTllZjViM2IxYjQxNGY4NTk2NDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYzk1ZDZlNGY3MWVjNGY1YjlmM2I4ZTg1NDE0MDU4NTIifQ==','2018-12-28 15:22:34.707388'),('aeo3pz16wcsbtiyjgs7ox3hcf5gsy7bm','Y2I5ZDdmMDc0NDRjNGMzZTMyNzE0ODgzODdhYmRkZDUwMjg3NmM0ODp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNGI1ODc5MWQyNGQ4NDRjY2FmY2Y3NThhZWE4NGRiMjQifQ==','2018-12-28 14:21:13.142234'),('anzmlojhxk9srb4igzgcbo3m9mfq90b4','YWE4ZmM5NDJmYjFjNWE2MGEwNTNkOTdjMTgyMGMwOGQ0M2JjNmVjZTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNWJiMjgwYzc5OTU5NDU3MjgwNDVkNTI4OWMzZjc5YTkiLCJfYXV0aF91c2VyX2lkIjoiMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOThlZmIyMTRmNWI5ZWNjOTU2OTM4NDgxNTJkYjNmOTI1NGQ3ZDA5NiJ9','2019-01-14 14:24:56.800073'),('b1r9pth8cxc7hw2cn3tik0ni15pke3iu','N2ZlNjFhMmJmOGRkNzU5YTU4NjQxNjAzYTMyYjk2Yjc0ODU2NDJiODp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiM2IyMzNiMTdhYjAyNDUyMzg1YTY3MzM0NGRhMjhkYzAifQ==','2018-12-28 15:37:19.440537'),('bylyjcai05q7phmqpeg8ph59i8cxq4qc','YTk3ZDdlMTJlY2Q4NGNjOWU4MDY3MWUwMTA4YzdiMWM3ZjU1NDQ0Nzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYzQwMWQ4OTAxZmNlNDVlYWE0NjY2OTRmNjUwYmRlMDAifQ==','2018-12-28 15:17:32.100715'),('djp0qqy7hyua9an4fbq515s7v9k5h3zw','MWZkMTUxZTdmNGJjMTVkNGI1NWM1YzM2MDIzNzM4ZGU1ODJhNGJjYzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiZTE1ZTVmYTJkYjgyNDY3Yzk3YjFmNTQxODRlNTJlYjIiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODA2MGQ1MDAzMzRkZGU0NjcyMDU3ZmVhMDE0NDhhZWE4MGM4Zjk1MiJ9','2018-12-24 14:49:23.891474'),('e33er23tzjw8rslzsg35vxsghocgotwp','MDIxMjY5YzZkZTdkOThiMmRmMGVkNzAzNGRlNjgzZGRmOWUyMzlhYTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiZDMxYmE3NTA2ZmVlNDhmNjgwNDFkNWEzMTc5MzUyZDMifQ==','2018-12-31 09:25:29.853991'),('f00tahea88po4ixzonsuq0txqyj2jj69','Y2UzNzc4ZGM5ZmJhMWIxNjEwOThjMzQxMWI4YmM0ZmZmMzViNmY2Zjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMjAxZmMzYmY3NmE2NDcyY2FhZGM0OGM3N2Q4NGY5OTQifQ==','2018-12-28 15:19:14.510286'),('ftfyqld3gsrhhtga25zxv683j2u63a3q','ZDZlYzQwOWM1YmRiMDY5MTljNWM2ZDJmYWI1NTIwMDlmYzAwMGFlMTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMDFkMGExNGNhMDA1NDU4YTlkN2NlZmFjM2ViNjgyMzQifQ==','2018-12-28 14:20:57.138644'),('gg3cmyvgwqqe81tzd7e0u118951w0kor','MDUyNTg2MGIyMmI1NGQyODkxZThmM2M1NzI4MWJhNzAzYWQzMzExNTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNTg0OTc3M2MxM2VmNDU0Zjg1ZTFmZjJjNTk2ZDAxMjIifQ==','2018-12-28 15:28:25.586488'),('ijduqut9bxs76cr6jcjy3ptxocp1y2sq','OWEwNjlkNzY3MjI0YjY0YTMyNWQwMjQ5YTExNDg3ZGU0MWE3ZGIzYTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYmQ5OGFlYWY1NDBlNGJiOGE1OWY0MDNiMTFjMTA4MWYifQ==','2018-12-28 14:20:56.861336'),('ittbwtwyitpsgsazvwzk5a7o2cgm8hm0','MGNjZjgzNWIzZmQ3MzlkODAyN2M0ZmY4ZjVkNWFhODcyZTkxZDZhMjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiOTBiM2VlMGRkZDUzNGJlZDk2MTJhMmFjNGI4NWM2NTAifQ==','2018-12-28 15:24:36.353604'),('kkrja41y91my5jzv0ig5c9de2l05et9e','MzkzZjc2MDY5NmMxNjk3MWI3Y2I3NzAzYzkyOTJmOTBkZDMzOTA2Mjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMjk5M2QxNjIzMDc4NDQwMzk2OGRjZDc2MTlkMmQ0YTkifQ==','2019-01-03 15:08:30.418058'),('l7znqfpdq32rx3jsdvhk61y2ck64f9ej','MGMwNzE3ODc0Mjc3ODg4YmQzMjlmOGIwOTI3YjIxODQwMjdhYjM2Yzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYjY5NTIwYTY3OTEwNGYwNTg5NmYwZTA0NGI4NTliM2EifQ==','2018-12-31 11:22:51.654857'),('lxw5hutlwvj35p083epm7icfre9b5g5j','ZDY2ZGViZTQ2OTZiNjMxYTY3MjIyOTkxNzBiMWViMmUzYThmMmJkYzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNjU0YTQzZjIzYTI0NDRmODg0YzUzYTAxNjRhYWQwYmYiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODA2MGQ1MDAzMzRkZGU0NjcyMDU3ZmVhMDE0NDhhZWE4MGM4Zjk1MiJ9','2018-12-24 10:55:05.173960'),('m5pg73g8hd5j1svj1qd81edat0c9863o','MWI5ZDcwNDA4OTFmYmU2NTZiNjI2MWY4MDI3YTlkY2RlNzBlYWY5Mzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiM2ExYTU4NjExM2QzNDBlMGEwZTBmMmE5NjI5NjVkOGIifQ==','2018-12-28 15:24:54.908567'),('mjfa6f86bjs8uduij8f74xapewwszmm4','OTVlN2E4NzExZmJjN2ZkZTNlMjY5OWE0YzMxNzk0ZDFhMTc2ZTFlYTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiN2JjZmNlZjkyYTU0NDc3N2FkNzkwMDM5MjQ5YTFlMTkifQ==','2018-12-28 15:20:11.181549'),('ovo8qt8kodn4p5ckuxf2v8hipepv1j1i','MzIzOGI3YzYwM2RjMTI4OWEzMWZjZTlhYWM3OGI0ZjQwODA0OWE4ZDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMzYxOTZhYzViM2U4NDBjOTk2Nzk5MTYzNzNkOGRkN2UifQ==','2019-01-15 13:06:07.138417'),('qazn2fsdfskjk1mb1gtnhg8b118nik0i','MTQ1MzkzNDU1MzMyMWQ5YmVmMzExZmE0YzY3Yzc1NmQyNDM5ZGIxYTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNDQ4YzMyMGE5ZjVhNGFkOGFhYTk1N2ZiY2VlZWI2ODUifQ==','2019-01-14 14:17:23.774526'),('qp6g4ryuz8qwqr5l4mn7372hik3jtip5','NTQwOTI0YzEyZWFiNzFjNGJlOGUwZDU2OGFkNTQ1MDk3NGM3NmNhNTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYTEzOTgxNjVhNzY1NDg4Mzg4YTczM2E2ZDMyYzk0OTUifQ==','2019-01-14 14:16:54.961435'),('sfaztb64k65t5ytz0enzsig1y80fmx96','MmRlMGQ3YzZjYmQ5N2FmMWQ0MzVhOThjOGI2ODhmYjM5NzhlZTJkYjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiMjhlMTdmMTM3NmMxNGJlMGE0ZDY4MzFjMzA1ZGQxZGMifQ==','2018-12-28 15:25:42.159685'),('t41u89hqv3scvsm7ylu6fz8cebtsnhgx','MGJkMGQ1NzZjODE4YmNkNTFmN2I2NjRiNDdhYWMyYTc3Y2FhZjJkYTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiY2ZkN2Q0MTVkNzYwNDZhZDhhMjYzY2I1MDUxNTIyZmQifQ==','2018-12-28 15:23:55.575402'),('tunqr7uzos0s22jmh4kvm2hvsynidil1','MzRkMDNiYTYwMmU4Y2EwMDc3NTJiMjVkMmQ1N2QxODE3OWZjMDViNTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiN2MyZTY3Y2M4N2RkNDIzZThlM2JhYzk1Y2U4ZWI1MDIiLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiMDRkYzYwMTI4ZjFiOTRmMmRjM2EzNzYwMjNhNGZkNTAwNzA1NTdiYSJ9','2019-01-14 14:12:28.896643'),('tvev7jwea9v19jynpuq8a443prw5cmmq','MWFlMmIzNzY4MzAxMGZlN2MwOGI4M2M4NmFhMTBkMThiMTA2NGViZDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYTkzYjA3OTgyYTNlNDg4ZmJiYzIzMzQ3MjE0ZGI1MzQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODA2MGQ1MDAzMzRkZGU0NjcyMDU3ZmVhMDE0NDhhZWE4MGM4Zjk1MiJ9','2018-12-28 14:33:01.323687'),('w7t3vdy791egvt3bfflrtf00jj2inbpy','MzUwYTBjZjg1NzE2N2M1ZmJhY2IyZTBjYzc2ZjE1N2IzYzEyNzMxOTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiZTRjMWNhOTBkZjViNDQ5Y2E0NWZkYWM4NDBhYTcyZGQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODA2MGQ1MDAzMzRkZGU0NjcyMDU3ZmVhMDE0NDhhZWE4MGM4Zjk1MiJ9','2019-01-10 11:01:40.176716'),('y1fywikmi7ipgnq9u2l3avgi09cv84t7','NTQ2NzJmYTFlYTliMGI3YzViMDgyYTZhNTQ5MGE2MjliMDIzMmJmZTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiZGRiOGMyNjFjMjY0NDQzOThiZjgxODBmMDJjMTEyMjYifQ==','2018-12-28 14:52:11.632785'),('z121tmv9flatoaewx2pocj0cyq3phu5z','Yzg5NTRkMTczNWI4NWNmNzVlMzEzMzIxNjFlNjc5MTYzMGM4ZDc3MTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYzExYjgzZDZiMjBlNDhjMWE5Y2Y2ZThhYjE2OGM5MGQifQ==','2018-12-28 15:36:25.279468');
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
-- Table structure for table `etherpad_etherarticle`
--

DROP TABLE IF EXISTS `etherpad_etherarticle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etherpad_etherarticle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_ether_id` longtext NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `etherpad_etherarticl_article_id_af7a9005_fk_BasicArti` (`article_id`),
  CONSTRAINT `etherpad_etherarticl_article_id_af7a9005_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etherpad_etherarticle`
--

LOCK TABLES `etherpad_etherarticle` WRITE;
/*!40000 ALTER TABLE `etherpad_etherarticle` DISABLE KEYS */;
/*!40000 ALTER TABLE `etherpad_etherarticle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etherpad_ethercommunity`
--

DROP TABLE IF EXISTS `etherpad_ethercommunity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etherpad_ethercommunity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `community_ether_id` longtext NOT NULL,
  `community_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `etherpad_ethercommun_community_id_8610cc18_fk_Community` (`community_id`),
  CONSTRAINT `etherpad_ethercommun_community_id_8610cc18_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etherpad_ethercommunity`
--

LOCK TABLES `etherpad_ethercommunity` WRITE;
/*!40000 ALTER TABLE `etherpad_ethercommunity` DISABLE KEYS */;
/*!40000 ALTER TABLE `etherpad_ethercommunity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etherpad_ethergroup`
--

DROP TABLE IF EXISTS `etherpad_ethergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etherpad_ethergroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_ether_id` longtext NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `etherpad_ethergroup_group_id_a1912466_fk_Group_group_id` (`group_id`),
  CONSTRAINT `etherpad_ethergroup_group_id_a1912466_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etherpad_ethergroup`
--

LOCK TABLES `etherpad_ethergroup` WRITE;
/*!40000 ALTER TABLE `etherpad_ethergroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `etherpad_ethergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etherpad_etheruser`
--

DROP TABLE IF EXISTS `etherpad_etheruser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etherpad_etheruser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_ether_id` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `etherpad_etheruser_user_id_1c71c453_fk_auth_user_id` (`user_id`),
  CONSTRAINT `etherpad_etheruser_user_id_1c71c453_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etherpad_etheruser`
--

LOCK TABLES `etherpad_etheruser` WRITE;
/*!40000 ALTER TABLE `etherpad_etheruser` DISABLE KEYS */;
/*!40000 ALTER TABLE `etherpad_etheruser` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_forum`
--

LOCK TABLES `forum_forum` WRITE;
/*!40000 ALTER TABLE `forum_forum` DISABLE KEYS */;
INSERT INTO `forum_forum` VALUES (7,'2019-01-28 11:03:58.855316','2019-01-28 11:03:58.855369','Collaboration System','collaboration-system','','',NULL,0,0,0,NULL,1,'<p></p>',1,2,1,0,NULL,0,0,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_permission_groupforumpermission`
--

LOCK TABLES `forum_permission_groupforumpermission` WRITE;
/*!40000 ALTER TABLE `forum_permission_groupforumpermission` DISABLE KEYS */;
INSERT INTO `forum_permission_groupforumpermission` VALUES (1,1,NULL,1,2),(2,1,NULL,1,1),(3,1,NULL,1,7),(4,1,NULL,1,8),(5,1,NULL,1,5),(6,1,NULL,1,6),(7,1,NULL,1,9),(8,1,NULL,1,4),(9,1,NULL,1,3),(10,1,NULL,2,2),(11,1,NULL,2,1),(12,1,NULL,2,7),(13,1,NULL,2,8),(14,1,NULL,2,5),(15,1,NULL,2,6),(16,1,NULL,2,9),(17,1,NULL,2,4),(18,1,NULL,2,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_permission_userforumpermission`
--

LOCK TABLES `forum_permission_userforumpermission` WRITE;
/*!40000 ALTER TABLE `forum_permission_userforumpermission` DISABLE KEYS */;
INSERT INTO `forum_permission_userforumpermission` VALUES (1,1,1,NULL,2,NULL),(2,1,1,NULL,1,NULL);
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
-- Table structure for table `metadata_mediametadata`
--

DROP TABLE IF EXISTS `metadata_mediametadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadata_mediametadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `media_id` int(11) DEFAULT NULL,
  `metadata_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `metadata_mediametadata_media_id_a7be17b3_fk_Media_media_id` (`media_id`),
  KEY `metadata_mediametada_metadata_id_9c2895f2_fk_metadata_` (`metadata_id`),
  CONSTRAINT `metadata_mediametada_metadata_id_9c2895f2_fk_metadata_` FOREIGN KEY (`metadata_id`) REFERENCES `metadata_metadata` (`id`),
  CONSTRAINT `metadata_mediametadata_media_id_a7be17b3_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `Media_media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadata_mediametadata`
--

LOCK TABLES `metadata_mediametadata` WRITE;
/*!40000 ALTER TABLE `metadata_mediametadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadata_mediametadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metadata_metadata`
--

DROP TABLE IF EXISTS `metadata_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadata_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metadata_metadata`
--

LOCK TABLES `metadata_metadata` WRITE;
/*!40000 ALTER TABLE `metadata_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `metadata_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications_notification`
--

DROP TABLE IF EXISTS `notifications_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(20) NOT NULL,
  `unread` tinyint(1) NOT NULL,
  `actor_object_id` varchar(255) NOT NULL,
  `verb` varchar(255) NOT NULL,
  `description` longtext,
  `target_object_id` varchar(255) DEFAULT NULL,
  `action_object_object_id` varchar(255) DEFAULT NULL,
  `timestamp` datetime(6) NOT NULL,
  `public` tinyint(1) NOT NULL,
  `action_object_content_type_id` int(11) DEFAULT NULL,
  `actor_content_type_id` int(11) NOT NULL,
  `recipient_id` int(11) NOT NULL,
  `target_content_type_id` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL,
  `emailed` tinyint(1) NOT NULL,
  `data` longtext,
  PRIMARY KEY (`id`),
  KEY `notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co` (`action_object_content_type_id`),
  KEY `notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co` (`actor_content_type_id`),
  KEY `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` (`recipient_id`),
  KEY `notifications_notifi_target_content_type__ccb24d88_fk_django_co` (`target_content_type_id`),
  KEY `notifications_notification_deleted_b32b69e6` (`deleted`),
  KEY `notifications_notification_emailed_23a5ad81` (`emailed`),
  KEY `notifications_notification_public_1bc30b1c` (`public`),
  KEY `notifications_notification_unread_cce4be30` (`unread`),
  CONSTRAINT `notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co` FOREIGN KEY (`action_object_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co` FOREIGN KEY (`actor_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `notifications_notifi_target_content_type__ccb24d88_fk_django_co` FOREIGN KEY (`target_content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notification`
--

LOCK TABLES `notifications_notification` WRITE;
/*!40000 ALTER TABLE `notifications_notification` DISABLE KEYS */;
INSERT INTO `notifications_notification` VALUES (1,'info',1,'1','Your are now an admin',NULL,'1',NULL,'2018-12-24 08:23:30.867692',1,NULL,4,1,12,0,0,NULL),(2,'info',1,'1','Your are now an admin',NULL,'2',NULL,'2018-12-24 08:41:31.440550',1,NULL,4,1,12,0,0,NULL),(3,'info',1,'1','Your are now an admin',NULL,'3',NULL,'2018-12-24 08:47:18.917284',1,NULL,4,1,12,0,0,NULL),(4,'info',1,'1','Your are now an admin',NULL,'4',NULL,'2018-12-24 08:48:45.317384',1,NULL,4,1,12,0,0,NULL),(6,'info',1,'1','Welcome to the community',NULL,'6',NULL,'2019-01-11 07:26:26.252038',1,NULL,4,1,12,0,0,NULL),(7,'info',1,'2','Congratulations! Your role has been upgraded from Author to Publisher',NULL,'6',NULL,'2019-01-11 07:28:55.700465',1,NULL,4,1,12,0,0,NULL),(10,'info',1,'3','This article is publishable',NULL,'4',NULL,'2019-01-11 07:32:01.709824',1,NULL,4,1,21,0,0,NULL),(14,'info',1,'3','This article is publishable',NULL,'4',NULL,'2019-01-11 07:38:38.366858',1,NULL,4,1,21,0,0,NULL),(17,'info',1,'3','This article is published',NULL,'4',NULL,'2019-01-11 07:40:31.964254',1,NULL,4,1,21,0,0,NULL),(19,'info',1,'2','This article is publishable',NULL,'5',NULL,'2019-01-14 09:51:13.500187',1,NULL,4,1,21,0,0,NULL),(22,'info',1,'3','This article is published',NULL,'5',NULL,'2019-01-14 09:52:11.550177',1,NULL,4,1,21,0,0,NULL),(24,'info',1,'2','This article is publishable',NULL,'6',NULL,'2019-01-14 12:10:17.935383',1,NULL,4,1,21,0,0,NULL),(27,'info',1,'2','This article is published',NULL,'6',NULL,'2019-01-14 12:12:05.016977',1,NULL,4,1,21,0,0,NULL),(29,'info',1,'2','This article is publishable',NULL,'7',NULL,'2019-01-15 10:21:05.752404',1,NULL,4,1,21,0,0,NULL);
/*!40000 ALTER TABLE `notifications_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nyt_notification`
--

DROP TABLE IF EXISTS `nyt_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nyt_notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `is_viewed` tinyint(1) NOT NULL,
  `is_emailed` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `occurrences` int(10) unsigned NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `modified` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nyt_notification_subscription_id_5a132ae1_fk_nyt_subscription_id` (`subscription_id`),
  KEY `nyt_notification_user_id_acbb5c10_fk_auth_user_id` (`user_id`),
  CONSTRAINT `nyt_notification_subscription_id_5a132ae1_fk_nyt_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `nyt_subscription` (`id`),
  CONSTRAINT `nyt_notification_user_id_acbb5c10_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nyt_notification`
--

LOCK TABLES `nyt_notification` WRITE;
/*!40000 ALTER TABLE `nyt_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `nyt_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nyt_notificationtype`
--

DROP TABLE IF EXISTS `nyt_notificationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nyt_notificationtype` (
  `key` varchar(128) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`key`),
  KEY `nyt_notificationtype_content_type_id_18800dea_fk_django_co` (`content_type_id`),
  CONSTRAINT `nyt_notificationtype_content_type_id_18800dea_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nyt_notificationtype`
--

LOCK TABLES `nyt_notificationtype` WRITE;
/*!40000 ALTER TABLE `nyt_notificationtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `nyt_notificationtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nyt_settings`
--

DROP TABLE IF EXISTS `nyt_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nyt_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `interval` smallint(6) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nyt_settings_user_id_1fad6d98_fk_auth_user_id` (`user_id`),
  CONSTRAINT `nyt_settings_user_id_1fad6d98_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nyt_settings`
--

LOCK TABLES `nyt_settings` WRITE;
/*!40000 ALTER TABLE `nyt_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nyt_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nyt_subscription`
--

DROP TABLE IF EXISTS `nyt_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nyt_subscription` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settings_id` int(11) NOT NULL,
  `notification_type_id` varchar(128) NOT NULL,
  `object_id` varchar(64) DEFAULT NULL,
  `send_emails` tinyint(1) NOT NULL,
  `latest_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nyt_subscription_settings_id_761bae06_fk_nyt_settings_id` (`settings_id`),
  KEY `nyt_subscription_notification_type_id_ca8af379_fk_nyt_notif` (`notification_type_id`),
  KEY `nyt_subscription_latest_id_bbb7d98b_fk_nyt_notification_id` (`latest_id`),
  CONSTRAINT `nyt_subscription_latest_id_bbb7d98b_fk_nyt_notification_id` FOREIGN KEY (`latest_id`) REFERENCES `nyt_notification` (`id`),
  CONSTRAINT `nyt_subscription_notification_type_id_ca8af379_fk_nyt_notif` FOREIGN KEY (`notification_type_id`) REFERENCES `nyt_notificationtype` (`key`),
  CONSTRAINT `nyt_subscription_settings_id_761bae06_fk_nyt_settings_id` FOREIGN KEY (`settings_id`) REFERENCES `nyt_settings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nyt_subscription`
--

LOCK TABLES `nyt_subscription` WRITE;
/*!40000 ALTER TABLE `nyt_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `nyt_subscription` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_revision`
--

LOCK TABLES `reversion_revision` WRITE;
/*!40000 ALTER TABLE `reversion_revision` DISABLE KEYS */;
INSERT INTO `reversion_revision` VALUES (1,'2018-12-28 12:18:00.597700','Added.',1),(2,'2018-12-28 12:18:28.011985','Added.',1),(3,'2019-01-10 11:28:20.345454','',NULL),(4,'2019-01-10 11:33:33.080862','',NULL),(5,'2019-01-10 11:35:02.787642','',NULL),(6,'2019-01-10 11:35:20.888815','',NULL),(7,'2019-01-10 17:09:30.649221','',NULL),(8,'2019-01-10 17:20:42.370700','',NULL),(9,'2019-01-11 07:32:01.140283','',NULL),(10,'2019-01-11 07:38:37.276295','',NULL),(11,'2019-01-11 07:40:31.350574','',NULL),(12,'2019-01-14 09:50:26.825130','',NULL),(13,'2019-01-14 09:50:31.496488','',NULL),(14,'2019-01-14 09:50:47.102438','',NULL),(15,'2019-01-14 09:51:13.059554','',NULL),(16,'2019-01-14 09:52:11.117379','',NULL),(17,'2019-01-14 10:47:29.267903','',NULL),(18,'2019-01-14 10:47:32.702065','',NULL),(19,'2019-01-14 10:48:02.456828','',NULL),(20,'2019-01-14 11:43:46.089740','',NULL),(21,'2019-01-14 12:09:05.026654','',NULL),(22,'2019-01-14 12:09:36.771006','',NULL),(23,'2019-01-14 12:10:17.490795','',NULL),(24,'2019-01-14 12:12:04.561873','',NULL),(25,'2019-01-15 10:20:30.247597','',NULL),(26,'2019-01-15 10:20:33.378416','',NULL),(27,'2019-01-15 10:20:48.122739','',NULL),(28,'2019-01-15 10:21:05.284235','',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reversion_version`
--

LOCK TABLES `reversion_version` WRITE;
/*!40000 ALTER TABLE `reversion_version` DISABLE KEYS */;
INSERT INTO `reversion_version` VALUES (1,'1','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 1, \"fields\": {\"title\": \"Aticle 1\", \"body\": \"res\", \"image\": \"article/4e9323a7-4ccb-49bb-b60d-3088140a63eb.jpeg\", \"created_at\": \"2018-12-28T12:18:00.904Z\", \"created_by\": 1, \"published_on\": \"2018-12-03T12:17:44Z\", \"published_by\": 1, \"views\": 0, \"state\": 3}}]','Aticle 1',21,1,'default'),(2,'2','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 2, \"fields\": {\"title\": \"Apphook\", \"body\": \"tesrt\", \"image\": \"article/242cf9ad-948a-473a-baa4-00e856b1db05.jpeg\", \"created_at\": \"2018-12-28T12:18:28.220Z\", \"created_by\": 1, \"published_on\": \"2018-12-04T12:18:21Z\", \"published_by\": 1, \"views\": 0, \"state\": 3}}]','Apphook',21,2,'default'),(3,'3','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 3, \"fields\": {\"title\": \"hello\", \"body\": \"\", \"image\": \"\", \"created_at\": \"2019-01-10T11:28:20.468Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','hello',21,3,'default'),(4,'1','json','[{\"model\": \"Community.communityarticles\", \"pk\": 1, \"fields\": {\"article\": 3, \"user\": 2, \"community\": 6}}]','CommunityArticles object',13,3,'default'),(5,'1','json','[{\"model\": \"etherpad.etherarticle\", \"pk\": 1, \"fields\": {\"article\": 3, \"article_ether_id\": \"g.z2BRQmvrcHnNY58U$3\"}}]','EtherArticle object',78,3,'default'),(6,'3','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 3, \"fields\": {\"title\": \"hello\", \"body\": \"\", \"image\": \"\", \"created_at\": \"2019-01-10T11:28:20.468Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','hello',21,4,'default'),(7,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','Temple',21,5,'default'),(8,'2','json','[{\"model\": \"Community.communityarticles\", \"pk\": 2, \"fields\": {\"article\": 4, \"user\": 2, \"community\": 6}}]','CommunityArticles object',13,5,'default'),(9,'2','json','[{\"model\": \"etherpad.etherarticle\", \"pk\": 2, \"fields\": {\"article\": 4, \"article_ether_id\": \"g.z2BRQmvrcHnNY58U$4\"}}]','EtherArticle object',78,5,'default'),(10,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"<!DOCTYPE HTML><html><body>this is a collab<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','Temple',21,6,'default'),(11,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"<!DOCTYPE HTML><html><body>this is a collab ssssss sss<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 2, \"state\": 2}}]','Temple',21,7,'default'),(12,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"<!DOCTYPE HTML><html><body>this is a collab ssssss sss ssssss<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 2, \"state\": 5}}]','Temple',21,8,'default'),(13,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"<!DOCTYPE HTML><html><body>this is a collab ssssss sss ssssss<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 5, \"state\": 5}}]','Temple',21,9,'default'),(14,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"<!DOCTYPE HTML><html><body>this is a collab ssssss sss ssssss<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 5, \"state\": 5}}]','Temple',21,10,'default'),(15,'4','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 4, \"fields\": {\"title\": \"Temple\", \"body\": \"<!DOCTYPE HTML><html><body>this is a collab ssssss sss ssssss<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-10T11:35:03.121Z\", \"created_by\": 2, \"published_on\": \"2019-01-11T07:40:31.684\", \"published_by\": 3, \"views\": 5, \"state\": 3}}]','Temple',21,11,'default'),(16,'5','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 5, \"fields\": {\"title\": \"Computer Science\", \"body\": \"\", \"image\": \"\", \"created_at\": \"2019-01-14T09:50:26.926Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','Computer Science',21,12,'default'),(17,'3','json','[{\"model\": \"Community.communityarticles\", \"pk\": 3, \"fields\": {\"article\": 5, \"user\": 2, \"community\": 6}}]','CommunityArticles object',13,12,'default'),(18,'3','json','[{\"model\": \"etherpad.etherarticle\", \"pk\": 3, \"fields\": {\"article\": 5, \"article_ether_id\": \"g.z2BRQmvrcHnNY58U$5\"}}]','EtherArticle object',78,12,'default'),(19,'5','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 5, \"fields\": {\"title\": \"Computer Science\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T09:50:26.926Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','Computer Science',21,13,'default'),(20,'5','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 5, \"fields\": {\"title\": \"Computer Science\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T09:50:26.926Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 1, \"state\": 2}}]','Computer Science',21,14,'default'),(21,'5','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 5, \"fields\": {\"title\": \"Computer Science\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T09:50:26.926Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 1, \"state\": 5}}]','Computer Science',21,15,'default'),(22,'5','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 5, \"fields\": {\"title\": \"Computer Science\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T09:50:26.926Z\", \"created_by\": 2, \"published_on\": \"2019-01-14T09:52:11.344\", \"published_by\": 3, \"views\": 2, \"state\": 3}}]','Computer Science',21,16,'default'),(23,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','hello',21,17,'default'),(24,'4','json','[{\"model\": \"Community.communityarticles\", \"pk\": 4, \"fields\": {\"article\": 6, \"user\": 3, \"community\": 6}}]','CommunityArticles object',13,17,'default'),(25,'4','json','[{\"model\": \"etherpad.etherarticle\", \"pk\": 4, \"fields\": {\"article\": 6, \"article_ether_id\": \"g.z2BRQmvrcHnNY58U$6\"}}]','EtherArticle object',78,17,'default'),(26,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','hello',21,18,'default'),(27,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 1, \"state\": 1}}]','hello',21,19,'default'),(28,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 1, \"state\": 2}}]','hello',21,20,'default'),(29,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 2, \"state\": 2}}]','hello',21,21,'default'),(30,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 2, \"state\": 2}}]','hello',21,22,'default'),(31,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": null, \"published_by\": null, \"views\": 2, \"state\": 5}}]','hello',21,23,'default'),(32,'6','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 6, \"fields\": {\"title\": \"hello\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-14T10:47:29.354Z\", \"created_by\": 3, \"published_on\": \"2019-01-14T12:12:04.807\", \"published_by\": 2, \"views\": 2, \"state\": 3}}]','hello',21,24,'default'),(33,'7','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 7, \"fields\": {\"title\": \"test\", \"body\": \"\", \"image\": \"\", \"created_at\": \"2019-01-15T10:20:30.349Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','test',21,25,'default'),(34,'5','json','[{\"model\": \"Community.communityarticles\", \"pk\": 5, \"fields\": {\"article\": 7, \"user\": 2, \"community\": 6}}]','CommunityArticles object',13,25,'default'),(35,'5','json','[{\"model\": \"etherpad.etherarticle\", \"pk\": 5, \"fields\": {\"article\": 7, \"article_ether_id\": \"g.z2BRQmvrcHnNY58U$7\"}}]','EtherArticle object',78,25,'default'),(36,'7','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 7, \"fields\": {\"title\": \"test\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-15T10:20:30.349Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 0, \"state\": 1}}]','test',21,26,'default'),(37,'7','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 7, \"fields\": {\"title\": \"test\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-15T10:20:30.349Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 1, \"state\": 2}}]','test',21,27,'default'),(38,'7','json','[{\"model\": \"BasicArticle.articles\", \"pk\": 7, \"fields\": {\"title\": \"test\", \"body\": \"<!DOCTYPE HTML><html><body>Enter Your Article Here :)<br></body></html>\", \"image\": \"\", \"created_at\": \"2019-01-15T10:20:30.349Z\", \"created_by\": 2, \"published_on\": null, \"published_by\": null, \"views\": 1, \"state\": 5}}]','test',21,28,'default');
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
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `store` (
  `key` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `value` longtext COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES ('MYSQL_MIGRATION_LEVEL','1'),('mapper2author:2','\"a.OlwffK0YeTBMXtZf\"'),('globalAuthor:a.OlwffK0YeTBMXtZf','{\"colorId\":19,\"name\":\"abhi\",\"timestamp\":1547119472603,\"padIDs\":{\"g.z2BRQmvrcHnNY58U$4\":1}}'),('sessionstorage:IQxR_UtubUzW-d9pCTu9E5dh5jXk023h','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('mapper2group:6','\"g.z2BRQmvrcHnNY58U\"'),('group:g.z2BRQmvrcHnNY58U','{\"pads\":{\"g.z2BRQmvrcHnNY58U$3\":1,\"g.z2BRQmvrcHnNY58U$4\":1,\"g.z2BRQmvrcHnNY58U$5\":1,\"g.z2BRQmvrcHnNY58U$6\":1,\"g.z2BRQmvrcHnNY58U$7\":1}}'),('groups','{\"g.z2BRQmvrcHnNY58U\":1}'),('sessionstorage:2tbtlKp_wlq3jDlZ_fccSmH061urIPVi','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.5dea158d4456f3e67833fe3798c29b98','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547148489}'),('group2sessions:g.z2BRQmvrcHnNY58U','{\"sessionIDs\":{\"s.5dea158d4456f3e67833fe3798c29b98\":1,\"s.648bc0a4c0305a06baf6444ddd1811db\":1,\"s.8aec4ca18a8e57244a8382e5869238a4\":1,\"s.2d1175b085471e40beebff18d390ecd4\":1,\"s.bd237ae99e96c58b9f008526dd8e6dba\":1,\"s.5f8be6aa43cb90ac9d64913cfa6f35b5\":1,\"s.96b7349d8179da01ad5bd59fca45bbe8\":1,\"s.61c6c9375f9bc26e2300464b85ad9ceb\":1,\"s.a7cc9cb95766ad5b9e7ee63da6912d00\":1,\"s.caabf5abfbe4bb264f8c86a4a7ef8063\":1,\"s.907fb9ca0f95f688723869508c279922\":1,\"s.27b6437fabbacf024fb2d6afa43022e2\":1,\"s.4c80dabd41f5b3ce2667b94b949d4961\":1,\"s.95d4988b8c37561e3497c377b3eecba8\":1,\"s.c4485e67610cdae72d095946ddd7928f\":1,\"s.82c173ff45bfc4f505ff8125c9778e89\":1,\"s.552e1474dbc217159a3496fd22748cbb\":1,\"s.74564e51e0f569d147fcfc14efed1e8e\":1,\"s.ac87ddd42218c42920d2c237bbe70777\":1,\"s.dd50eb35e0ee83aa67d7858000bc079d\":1,\"s.c95ef1be43c1c0f33d4ff77f99565c7e\":1,\"s.87f968fae4b13c607f1b703bdd9e240a\":1,\"s.33ae5dbcde34d97355097f4b1914a6d3\":1,\"s.cbd4efd6b9948c642c39eee1273aa117\":1,\"s.6f09af5d23b0b5d17b8e52da10cf66ac\":1,\"s.765678061374a5de5df221b31ab00988\":1,\"s.a501ca3ba096c02cc82874ecf11abb69\":1,\"s.e55a7c481ddd4ece087949329f45650e\":1,\"s.819c760b48ba9a58393b63423a9d8c26\":1,\"s.a17a940994f36de53f9f303e4c5b55ae\":1,\"s.93fac687e80943fbaadce39d01d145e9\":1,\"s.f90f0f178aa6f1575eab00ab0cccb105\":1,\"s.316976aab3dbed1634fa95c2b4ded539\":1,\"s.fe85763cc0f6c3e8005a741ddc5b9688\":1,\"s.5c50c298ff26c2b2ef5d2339cccfdbbb\":1,\"s.e8496dda1b2c47394d2c56310f1053e1\":1,\"s.6c37b5632421a2ec8f0367c9bd0e0839\":1,\"s.56585c4397548ae6811a72ee416f3484\":1,\"s.f167e7f049eb0fbd3f436370ead764c8\":1,\"s.6294d9b2204e2a9eb96b1d23341721a5\":1,\"s.ddbf6c8670daa9f77952b83afacaaa37\":1,\"s.01aee2cc809b0b5c31d337fb9bc6282e\":1,\"s.74079bb05c5934fce64ab08cfe2e32b4\":1,\"s.6e8a1c431e59015c236f34a6157dc39d\":1,\"s.d0996d0d1c274c4922d332622b8cd9d0\":1,\"s.9e1a101692c2ebc687a945f101871798\":1,\"s.47244598fc4e0769154cf28b134a13f5\":1,\"s.a18cdb35e572afd42829517ba4d888ce\":1,\"s.2582489deb40f4911b34388ebf1e28d6\":1,\"s.4350156c0f1af6b4d4a4574f9ace5156\":1,\"s.70884516b52d82659567e7c84c067cc1\":1,\"s.1379fe65f5fdfa700f4ba72ce6875376\":1,\"s.2533eae83b12585534efaec89d4b6644\":1,\"s.45f5c8594c79516987aba434bf4f0fcc\":1,\"s.764ebec0ce2398a33da96648c61bfa29\":1,\"s.22ce0e4be57799768a6c3ce4c9167cf3\":1,\"s.c55fa7c24f98d40fa84d7b8725053260\":1}}'),('author2sessions:a.OlwffK0YeTBMXtZf','{\"sessionIDs\":{\"s.5dea158d4456f3e67833fe3798c29b98\":1,\"s.648bc0a4c0305a06baf6444ddd1811db\":1,\"s.8aec4ca18a8e57244a8382e5869238a4\":1,\"s.2d1175b085471e40beebff18d390ecd4\":1,\"s.bd237ae99e96c58b9f008526dd8e6dba\":1,\"s.5f8be6aa43cb90ac9d64913cfa6f35b5\":1,\"s.96b7349d8179da01ad5bd59fca45bbe8\":1,\"s.61c6c9375f9bc26e2300464b85ad9ceb\":1,\"s.a7cc9cb95766ad5b9e7ee63da6912d00\":1,\"s.caabf5abfbe4bb264f8c86a4a7ef8063\":1,\"s.907fb9ca0f95f688723869508c279922\":1,\"s.27b6437fabbacf024fb2d6afa43022e2\":1,\"s.4c80dabd41f5b3ce2667b94b949d4961\":1,\"s.95d4988b8c37561e3497c377b3eecba8\":1,\"s.c4485e67610cdae72d095946ddd7928f\":1,\"s.82c173ff45bfc4f505ff8125c9778e89\":1,\"s.552e1474dbc217159a3496fd22748cbb\":1,\"s.74564e51e0f569d147fcfc14efed1e8e\":1,\"s.ac87ddd42218c42920d2c237bbe70777\":1,\"s.dd50eb35e0ee83aa67d7858000bc079d\":1,\"s.c95ef1be43c1c0f33d4ff77f99565c7e\":1,\"s.87f968fae4b13c607f1b703bdd9e240a\":1,\"s.33ae5dbcde34d97355097f4b1914a6d3\":1,\"s.316976aab3dbed1634fa95c2b4ded539\":1,\"s.fe85763cc0f6c3e8005a741ddc5b9688\":1,\"s.5c50c298ff26c2b2ef5d2339cccfdbbb\":1,\"s.01aee2cc809b0b5c31d337fb9bc6282e\":1,\"s.6e8a1c431e59015c236f34a6157dc39d\":1,\"s.d0996d0d1c274c4922d332622b8cd9d0\":1,\"s.9e1a101692c2ebc687a945f101871798\":1,\"s.47244598fc4e0769154cf28b134a13f5\":1,\"s.a18cdb35e572afd42829517ba4d888ce\":1,\"s.2533eae83b12585534efaec89d4b6644\":1,\"s.45f5c8594c79516987aba434bf4f0fcc\":1,\"s.764ebec0ce2398a33da96648c61bfa29\":1,\"s.22ce0e4be57799768a6c3ce4c9167cf3\":1,\"s.c55fa7c24f98d40fa84d7b8725053260\":1}}'),('sessionstorage:PAakK2V6plFhlfVv0vWDsW2s_3F_rifG','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$3','{\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"},\"pool\":{\"numToAttrib\":{},\"nextNum\":0},\"head\":0,\"chatHead\":-1,\"publicStatus\":false,\"passwordHash\":null,\"savedRevisions\":[]}'),('pad:g.z2BRQmvrcHnNY58U$3:revs:0','{\"changeset\":\"Z:1>q+q$Enter Your Article Here :)\",\"meta\":{\"author\":\"\",\"timestamp\":1547119700804,\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"}}}'),('sessionstorage:MEev_9ao-iNg_JDDaF2TKDesaTJfbsCZ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:iAS1KXi4uAEj0D8ZNPDnQcygLnEFBCIK','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('token2author:t.EOEK1j24QHHyXiRgrr55','\"a.rlYU1VkBVU8on3ve\"'),('globalAuthor:a.rlYU1VkBVU8on3ve','{\"colorId\":32,\"name\":null,\"timestamp\":1547119704931}'),('session:s.648bc0a4c0305a06baf6444ddd1811db','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547148885}'),('sessionstorage:WeYAhNRTw0ldwSRacRVlhC-wdZjUSCbs','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$4','{\"atext\":{\"text\":\"this is a collab ssssss sss ssssss\\n\",\"attribs\":\"*0+y|1+1\"},\"pool\":{\"numToAttrib\":{\"0\":[\"author\",\"a.OlwffK0YeTBMXtZf\"]},\"nextNum\":1},\"head\":16,\"chatHead\":-1,\"publicStatus\":false,\"passwordHash\":null,\"savedRevisions\":[]}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:0','{\"changeset\":\"Z:1>q+q$Enter Your Article Here :)\",\"meta\":{\"author\":\"\",\"timestamp\":1547120103472,\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"}}}'),('sessionstorage:JJ_kAKnKXT1xN_KApxDRr9KlIP8qC19m','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:1Hk__hXnmRtcVZ4AmRxER3kayPu9G3Qa','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('token2author:t.kPBuuIMl31WXPrEPpybU','\"a.OEzNToyQg0FpSrZV\"'),('globalAuthor:a.OEzNToyQg0FpSrZV','{\"colorId\":61,\"name\":null,\"timestamp\":1547547652503}'),('pad2readonly:g.z2BRQmvrcHnNY58U$4','\"r.abf0cfcbeb89e48c1465a21839b824ab\"'),('readonly2pad:r.abf0cfcbeb89e48c1465a21839b824ab','\"g.z2BRQmvrcHnNY58U$4\"'),('pad:g.z2BRQmvrcHnNY58U$4:revs:1','{\"changeset\":\"Z:r<p-q*0+1$t\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120114531}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:2','{\"changeset\":\"Z:2>4=1*0+4$his \",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120115029}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:3','{\"changeset\":\"Z:6>2=5*0+2$is\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120115527}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:4','{\"changeset\":\"Z:8>3=7*0+3$ a \",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120116028}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:5','{\"changeset\":\"Z:b>1=a*0+1$c\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120116528}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:6','{\"changeset\":\"Z:c>3=b*0+3$oll\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120117028}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:7','{\"changeset\":\"Z:f>2=e*0+2$ab\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547120117528}}'),('sessionstorage:rayjK4QBNr1ZjT59Seou5YbnCljfz8He','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:2z0r7vG0OqZFyHNNp02_GY_zq15p6VKT','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.8aec4ca18a8e57244a8382e5869238a4','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547148928}'),('sessionstorage:oa5gxbtisrURLRoshWX-lSGhHdKcs-bV','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:LCoz9mh6rmVVmVAn1ug5bBT1fK2XB13p','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.2d1175b085471e40beebff18d390ecd4','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547148993}'),('sessionstorage:XmIGhMvqMRBHupXSP6u8WB2Prk9dYHqp','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.bd237ae99e96c58b9f008526dd8e6dba','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547149319}'),('sessionstorage:ebqc2pHqMRQHfNWMi8TCG7CnRDdiGJud','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:sUTC-uk5tDpYaIaRmWSv2xbcKONGhuGz','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.5f8be6aa43cb90ac9d64913cfa6f35b5','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547159397}'),('sessionstorage:szvhJRGv54RmmWrz-GHCYUIbPJ_HFe4y','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.96b7349d8179da01ad5bd59fca45bbe8','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547161205}'),('sessionstorage:oO4bpr4vKMAwbrl_-GGntYHURuOAQZvD','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.61c6c9375f9bc26e2300464b85ad9ceb','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547161235}'),('sessionstorage:IH1xMGkIsL_w6YfYV9mTZ-Wsp0O8VKqh','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.a7cc9cb95766ad5b9e7ee63da6912d00','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547161243}'),('sessionstorage:qCms5HOTv1Rz1xieitypV5W1Tw1sG1Vx','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.caabf5abfbe4bb264f8c86a4a7ef8063','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547161410}'),('sessionstorage:cetNpskbgH4Mc8hX3b0kPOa38HW7C-Dq','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.907fb9ca0f95f688723869508c279922','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547161508}'),('sessionstorage:YOW-edSKy0LrDHgPT295xOD0ofrE3NWQ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:GQrp5KZmp4xWXOLh9Q7Oh9w698hLnQ85','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.27b6437fabbacf024fb2d6afa43022e2','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547165156}'),('sessionstorage:8VMu0IGQIjTHdPKTWXIeinABtPw3TbZy','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.4c80dabd41f5b3ce2667b94b949d4961','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547168455}'),('sessionstorage:CLy8bmDRxvcnF7ja-NXQFfBrrgE7U9Jp','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:8','{\"changeset\":\"Z:h>1=g*0+1$ \",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547139693453}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:9','{\"changeset\":\"Z:i>2=h*0+2$ss\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547139693953}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:10','{\"changeset\":\"Z:k>3=j*0+3$sss\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547139694454}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:11','{\"changeset\":\"Z:n>1=m*0+1$s\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547139695009}}'),('session:s.95d4988b8c37561e3497c377b3eecba8','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547168954}'),('sessionstorage:_ZlN70sR21GW-R5BVs7UcK7bUSyN8oyQ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:12','{\"changeset\":\"Z:o>1=n*0+1$ \",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547140165008}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:13','{\"changeset\":\"Z:p>3=o*0+3$sss\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547140165508}}'),('sessionstorage:AAqVRCGTwzVqQmGNsMX0tHl32R2FSUyw','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:5N208ZF7DN6szdUr44tRICCYuAI26AQg','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.c4485e67610cdae72d095946ddd7928f','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169081}'),('sessionstorage:8xlaVtYlKwFne1OwQdt7TYTtnqlTfeQI','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:14','{\"changeset\":\"Z:s>1=r*0+1$ \",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547140737335}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:15','{\"changeset\":\"Z:t>3=s*0+3$sss\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547140737835}}'),('pad:g.z2BRQmvrcHnNY58U$4:revs:16','{\"changeset\":\"Z:w>3=v*0+3$sss\",\"meta\":{\"author\":\"a.OlwffK0YeTBMXtZf\",\"timestamp\":1547140738335}}'),('sessionstorage:8nOIg8MG2vb9oS-VjbSH5p3c_Rh9RhsM','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:sJN9KlPRSKZSbVvohSoENnz0iwMNd78p','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.82c173ff45bfc4f505ff8125c9778e89','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169602}'),('sessionstorage:FAZT7K9o8huVTzbnUvTksXiSXtebWta1','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.552e1474dbc217159a3496fd22748cbb','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169606}'),('sessionstorage:RQRsYn6Xeib3oFDPvhvbRd_1AiZ7kIN1','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:2vq-urHncMpiBj4MAoN2ZJZGK23CVdos','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.74564e51e0f569d147fcfc14efed1e8e','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169621}'),('sessionstorage:5Jw-FGO88D5xPVFGAs3T93BF2mHn8ud-','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:yvh592fvJjzwnwRLp3ZEzUsp0WjW_BP2','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:5RQoy-H5YSwzKUDh19TpF_hcVOi-yhzJ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.ac87ddd42218c42920d2c237bbe70777','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169693}'),('sessionstorage:xTWQUnNcJIispvp7DYATt-L_TcNUCquf','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.dd50eb35e0ee83aa67d7858000bc079d','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169702}'),('sessionstorage:x-ntAbdtHGS2eTyaFsjfGqwUhVMKlC-h','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:-NDWTrWMYVhUYwXF3Nq2epzQuVlsDtwH','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.c95ef1be43c1c0f33d4ff77f99565c7e','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169719}'),('sessionstorage:HRuwKqWFo3IEi9uj7Qa1nq_wl_dBXkMc','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.87f968fae4b13c607f1b703bdd9e240a','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169838}'),('sessionstorage:YbROGqlEZ_v1oUQqaY_czfqfv2x1pqy6','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:2Br4jGcVDcFl-HSvoagaMeAlVUfKZ-iP','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.33ae5dbcde34d97355097f4b1914a6d3','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547169868}'),('sessionstorage:ybtS_M8xlokEyus1fZ3F9xydmzqVU8WQ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:xYUcYZfkjwQsAGfJrgmk9EphksJaCwGN','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:MZjB2dV4oC1m8sdo1wDipoZ7cwDqwnSn','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:jZbQBcVzhRYYoUFzfX8bvIir8-fFw-gd','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:RA0pfe7bJ4gPq-3QVA8vFv-7uF-SC0Hz','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:_kAbJXoJWMuCvOUgMo8iPL64lhM2fRmM','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:OPJLu91T7l_NoHZDOR8HV_Yqg5t9fBTP','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:PjliGCHzWf5aj1yknhyyI1zCRVLMYG6-','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:RPC-05BIf9wg-x91PCT8JTuQIptF6h3q','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:bEslLLnDnk1dIhg9Eo7DyO_yLd1NE6bV','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('mapper2author:3','\"a.2fwGRgMDoEtrQQIz\"'),('globalAuthor:a.2fwGRgMDoEtrQQIz','{\"colorId\":2,\"name\":\"manas\",\"timestamp\":1547191791936}'),('sessionstorage:sPfCI5ym7Y-Yxzd9scJPM-Z4kzn5S2-S','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:wUj8pAifxVznDgsYAjkJv0INLa3PaJI4','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.cbd4efd6b9948c642c39eee1273aa117','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547220651}'),('author2sessions:a.2fwGRgMDoEtrQQIz','{\"sessionIDs\":{\"s.cbd4efd6b9948c642c39eee1273aa117\":1,\"s.6f09af5d23b0b5d17b8e52da10cf66ac\":1,\"s.765678061374a5de5df221b31ab00988\":1,\"s.a501ca3ba096c02cc82874ecf11abb69\":1,\"s.e55a7c481ddd4ece087949329f45650e\":1,\"s.819c760b48ba9a58393b63423a9d8c26\":1,\"s.a17a940994f36de53f9f303e4c5b55ae\":1,\"s.93fac687e80943fbaadce39d01d145e9\":1,\"s.f90f0f178aa6f1575eab00ab0cccb105\":1,\"s.e8496dda1b2c47394d2c56310f1053e1\":1,\"s.6c37b5632421a2ec8f0367c9bd0e0839\":1,\"s.56585c4397548ae6811a72ee416f3484\":1,\"s.f167e7f049eb0fbd3f436370ead764c8\":1,\"s.6294d9b2204e2a9eb96b1d23341721a5\":1,\"s.ddbf6c8670daa9f77952b83afacaaa37\":1,\"s.74079bb05c5934fce64ab08cfe2e32b4\":1,\"s.2582489deb40f4911b34388ebf1e28d6\":1,\"s.4350156c0f1af6b4d4a4574f9ace5156\":1,\"s.70884516b52d82659567e7c84c067cc1\":1,\"s.1379fe65f5fdfa700f4ba72ce6875376\":1}}'),('sessionstorage:ajcY6zAS4xAQ7-bvp-fsR9z-3g_0kMM4','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.6f09af5d23b0b5d17b8e52da10cf66ac','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547220661}'),('sessionstorage:xG78JX9Tn8XpIWwyfg5NY_EiWy1cYm6-','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Poz96W3ddxJfB4qQVe8wGQ-pv3hM1gVT','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Ycn9ScYKjXHqozqlDKI_5FBHSNR12moj','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.765678061374a5de5df221b31ab00988','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547220759}'),('sessionstorage:328srv1s3V56GfydisftnqlcIjhHsTqc','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.a501ca3ba096c02cc82874ecf11abb69','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547220761}'),('sessionstorage:NKrbrioTg2kXEgGrRf-zKz3X4vDxc2C9','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.e55a7c481ddd4ece087949329f45650e','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547221015}'),('sessionstorage:YhGg390H3jSWYYN3vofWo-RDtcQSq1K5','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:9WY59gZIPVLW1jJuz8NBAjafLHiU4A1b','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:xE2kVldA28yciQYH1BwkboxJnP3bUtAS','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.819c760b48ba9a58393b63423a9d8c26','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547221097}'),('sessionstorage:yZW8AKxXTcNdYVpQTgUaN6iurAwuCBsK','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.a17a940994f36de53f9f303e4c5b55ae','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547221105}'),('sessionstorage:cfqOctnxTAw41v2-lKXAYMF1BID8BH9D','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.93fac687e80943fbaadce39d01d145e9','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547221110}'),('sessionstorage:PcyXC-sFHiUS0M51bxU5PexgBHf3Ptek','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:_nVxMe0JJTM5WHebixv5xMxN33BeKfHB','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:8Da64II_-0QT6bKhF05-6ajULOfgFPWK','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:YsMwBvnRZPJRIcyZLHmLW3zdqBvCEc-r','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.f90f0f178aa6f1575eab00ab0cccb105','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547221224}'),('sessionstorage:hIoqgsInvLgPfn0VYF9MhWxI1jjMyGZL','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Bugfa8wFPGfjPu74HMRGJRwzL-edJNcE','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:7NrpQCN34xcXbSYXqgWoA2mTIbKktWpS','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Ga6BasTHwiE0UdCX9ZdhT3ftcHYI81YO','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:OCvn19dDtNJ0pl2dk4mEsbIr7CM16Zd8','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:MUGmt-9RGfcaer1dpi7xVaHcZm3CB3Bc','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:pQm9uKtQSnmW-U55SY6Elb2lwr2xv49X','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:pUaFN9w1ATjdujlLtuGsikXX2N5I9pzf','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:2vBKj_5J07X5dk68pSRWqp3AYcwbP3f7','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:LfW3IoVB4Mgq3GAHlURLjoxvX2Wm6xSX','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:OeMM9nSjty-ik8K9fExEZd0D0Y5EMHKF','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:g88tvvXHAyWl3j8HsavpJ8I-zfeYMekg','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Cw4pTml-oQJug1W8tEezdWLCaDtK8kiE','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:O-IRSkSYneoz4VJekSfu-KipRa3A3BTk','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.316976aab3dbed1634fa95c2b4ded539','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547488205}'),('sessionstorage:iXzHtXVKlzPfYFyVAwZkiZczgkOmsu9j','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$5','{\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"},\"pool\":{\"numToAttrib\":{},\"nextNum\":0},\"head\":0,\"chatHead\":-1,\"publicStatus\":false,\"passwordHash\":null,\"savedRevisions\":[]}'),('pad:g.z2BRQmvrcHnNY58U$5:revs:0','{\"changeset\":\"Z:1>q+q$Enter Your Article Here :)\",\"meta\":{\"author\":\"\",\"timestamp\":1547459427198,\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"}}}'),('sessionstorage:9VMd-G0VMI-2YngR9bPPxpFrkWJdqeZ7','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad2readonly:g.z2BRQmvrcHnNY58U$5','\"r.bb18b3ac8cd05a51bcf1491b43357736\"'),('readonly2pad:r.bb18b3ac8cd05a51bcf1491b43357736','\"g.z2BRQmvrcHnNY58U$5\"'),('sessionstorage:O7lq6_Zl_dGYF6eZl4-D-Bpn7PNPbZbj','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:zlu06JU1AqkbekBTaCLfcpLcKSxgfXC-','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.fe85763cc0f6c3e8005a741ddc5b9688','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547488238}'),('sessionstorage:COUpoL2YjxShZp-5gOrPBUSqtMNMKIqj','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:6F4vACosJ9u1w2cfWM18K2LKAa2JUfIU','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:OuUkucnhRFAZpJ7KXnLbuEOeJaFun6cI','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:TImQjzAtNW2zWprffw6t7wK7en8JGedl','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.5c50c298ff26c2b2ef5d2339cccfdbbb','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547488252}'),('sessionstorage:25uNTG9ezYmbRFFgGau4WIWxqNBCxtwY','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:gt3GBRqP6o2j3XNLOOKbZ8Ca_sIQg4ZA','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:VNvEV257lZs-pnY_XDAf_bl08gs7z_8q','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:BHmJXpRIQ8S4a-sD1llkM2kIPUTX4lQL','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Hp3dj0S3xKgsJbTHpfHr-8qgTyUFd87B','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:O78HC5lp2f5SXEj9HPjh0nqgkuddl8J4','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:kCgeRRiMKqYDVIe0QNyLsxedETqLqfMI','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.e8496dda1b2c47394d2c56310f1053e1','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547488325}'),('sessionstorage:kpU8p2cAuQ8ExW8HGqcYVALbmphuODcR','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:aPUR9aZYZvoCTK7vbY5O5b9TALMy3OMW','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:G1tjYyBTm71X6tOL6SPMc4ZTNaQ_6Iyw','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:5zVe_ADpiJV8bwNiSGklYKnZoReRygei','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:zn1YqbpcnTbIhtad2ef4vyUMRajYnNmx','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.6c37b5632421a2ec8f0367c9bd0e0839','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547491645}'),('sessionstorage:OjD6VO2wrrhYERHVoQT86ZrXwboWNAf3','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$6','{\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"},\"pool\":{\"numToAttrib\":{},\"nextNum\":0},\"head\":0,\"chatHead\":-1,\"publicStatus\":false,\"passwordHash\":null,\"savedRevisions\":[]}'),('pad:g.z2BRQmvrcHnNY58U$6:revs:0','{\"changeset\":\"Z:1>q+q$Enter Your Article Here :)\",\"meta\":{\"author\":\"\",\"timestamp\":1547462849653,\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"}}}'),('sessionstorage:M6Ei7jsJ6WGn5Gg1qZGQ5Wl4Vwt350G-','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad2readonly:g.z2BRQmvrcHnNY58U$6','\"r.e54c411757f2952385f4cdd2b5d213f1\"'),('readonly2pad:r.e54c411757f2952385f4cdd2b5d213f1','\"g.z2BRQmvrcHnNY58U$6\"'),('sessionstorage:xh36ERgLMAKD_SHTRkXTAVlhso1wUFwQ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:fawyK6DBejRq9xlcPtwsRZLzv6mC1Trd','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.56585c4397548ae6811a72ee416f3484','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547491659}'),('sessionstorage:6zjSyVYp-NG0RWCyvKxR8CriWD_qci8R','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.f167e7f049eb0fbd3f436370ead764c8','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547491660}'),('sessionstorage:vMg0-vFrlNv4mlmPypnbaFQkV4_z2SXc','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:nV3wo-SUiEb07z8eYP-9gUCSLEAreAKt','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:9bBQlHK_7SpGep6LDN5S2BRGOBOQRjWC','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:hBN55jChxsrv9cDN14Jmc6iSKOeAfNip','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.6294d9b2204e2a9eb96b1d23341721a5','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547491687}'),('sessionstorage:6xcxRKfm717DGDs6oHeRb6FVkSKBXwLf','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:VwdYhMeBih0C_hB7fT5Ii9hoHghEnWgz','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:TryUhPS1-ovwjpfR5ocT8CGHfNisKELx','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:PGXpnN0tLFB9faTfWHU1BQpPGro8VQTT','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.ddbf6c8670daa9f77952b83afacaaa37','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547495022}'),('sessionstorage:5wQ5qvEKT_UnZvmfeaRGltb3O3HS6ZqH','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:oCuVF8ImQ_i3uNbERcm05NmfxjRK67Or','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:VtfZLISbLsdaOFWcCVz0WErmorpUfWpL','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:06n3K9bbR2hqdFyBBpRFEHCzL32C-Km_','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:wwLEpeCmNWX8MNZp1UCUljCbcu3cJebd','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.01aee2cc809b0b5c31d337fb9bc6282e','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547495079}'),('sessionstorage:LDDiMQOSt0K5_mnlXTtKibPLGZHXwh8m','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:IjYrGgRW3TO8gbok4iHr5C_F7LSzg39Z','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('token2author:t.PKrGwPIxCXyhgIzrd3aR','\"a.07HjdvdLb63oxiaL\"'),('globalAuthor:a.07HjdvdLb63oxiaL','{\"colorId\":35,\"name\":null,\"timestamp\":1547467918304}'),('session:s.74079bb05c5934fce64ab08cfe2e32b4','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547495086}'),('sessionstorage:Y6k30qbmisZVqK9PlzWNr52m1Mk0xZyy','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:51QQ4wvbsskNzPE_5fGgbli8rICM_nVt','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.6e8a1c431e59015c236f34a6157dc39d','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547495135}'),('sessionstorage:qZmm6E2ugqrQClaXh8fisJhIbUsEyjJN','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:kinenEOADkvqlf3ePneCi1gCvsK4Fh5B','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.d0996d0d1c274c4922d332622b8cd9d0','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547495966}'),('sessionstorage:rnykOT4mtyA33pWWCITD_FWpcuDv_f3N','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:iB09-9BmFvyYA03Xbpka5_TP2DQfvSKv','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.9e1a101692c2ebc687a945f101871798','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547496010}'),('sessionstorage:kUNbeZQ9Qt_p5Q1YOUGV9IFDbuVR4B6P','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.47244598fc4e0769154cf28b134a13f5','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547496020}'),('sessionstorage:wNPh3AkqFYBI5LsU8V7tkyLu5M3AYiP1','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:p5BsQXrcLe7N3I6K9tmVfg05wjB7oumH','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.a18cdb35e572afd42829517ba4d888ce','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547496079}'),('sessionstorage:0by7pkY3SFLN2KZLp4xfyYXEdsQXJ4AE','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:DFVr7QUvA2-Nuvgr7Yt6qX3YqGvthA8U','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:abw_BMiEwsHKDFpE2X_9sB9MCGz5MXPv','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.2582489deb40f4911b34388ebf1e28d6','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547496160}'),('sessionstorage:EZkPJuXS8yRcRRA3RAdgaf2c43Hs6MZ5','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:pu_eaw0a-cHFVlcgpTWJFMiBiKfp_jQv','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Z7M_GWXTcHQfasmMM752rcpkThfINfOC','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.4350156c0f1af6b4d4a4574f9ace5156','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547496190}'),('sessionstorage:zrRGCImVFJnShHFDAmyrQeLS5FRZWlLT','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:h4Bp6PDhWf_jnFw3-Q-kQZ5XvxFgZFO6','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:CAQ48D2IymQz6NaXo7RlDjzlYieHcqR4','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.70884516b52d82659567e7c84c067cc1','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547496537}'),('sessionstorage:9hisdQyhxqVkW97J5c5nQ2fp1fWphOmZ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:7SMYQDbo7dnNeEWOUVIt56jiZfuGuXOc','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:a-S7n_u8r1iVsiv3xZgCSM5xdTAsodqI','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:KzZGlwk6rgPEiWRYa3u5MNIgEeZnJCTB','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.1379fe65f5fdfa700f4ba72ce6875376','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.2fwGRgMDoEtrQQIz\",\"validUntil\":1547496553}'),('sessionstorage:HGtzOT3Ai-D2H3Q_NgKXKj5YkFUlmdnX','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:l9xUL_Bw5n-iquE3U0Uu1mibHJA6ZJ3i','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:wAgpy_8bcGihL9cOYadHrs_lyQf03mtI','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:t832FfBqipvo0V-1RowNFNmNjc98NlpJ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:cHLiXoCbDg4LIkgeSH1JMEURfKXG_XhS','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:c285E-DdaNOqjxDz3RglKE-QHYrFHqiN','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:27yO0WSE9Pmzfix5yGRE-g9GXXH_RXQ1','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:MGwOvipcl-woFnFb_0hj4FM8YTPyPdW9','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:5bCieVYBgdPyFEV_FyDiP8Jx8WVqJdDA','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.2533eae83b12585534efaec89d4b6644','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547496622}'),('sessionstorage:RPH1Fmuuqk2stjPgTSismEj_kYa6drbs','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:v2enmaqMHqUij9YFhAbkersiFCDhPGso','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.45f5c8594c79516987aba434bf4f0fcc','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547496717}'),('sessionstorage:kQK9L9rncfQ-GRkGmmLtmkrm7e5orovI','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:N5ilTPn0I2cTZptrx16LX2obg9uYFEy5','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:DEydFwaNZHHNNlsiK2a3Vt7r3vl0scRJ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:Vmgy3vn9XOX-3hy9NEJoFoMtNKx0MmRR','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:uOebvA296sMO0lnskEzYKcdgTdtcNAWY','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:mv7b73qoHAIJ_xwI7I-WFd4qPP1GFA6Y','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:4AsOVPvFabDy5JVN_I4u-eQIJPEoYBIY','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:v0rf8tQV2TWvdh-IiSuyIbyKQknb-lvm','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.764ebec0ce2398a33da96648c61bfa29','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547576424}'),('sessionstorage:RGCo9qiA1E8q6_99jGRpuaDmTv2zfHpj','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad:g.z2BRQmvrcHnNY58U$7','{\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"},\"pool\":{\"numToAttrib\":{},\"nextNum\":0},\"head\":0,\"chatHead\":-1,\"publicStatus\":false,\"passwordHash\":null,\"savedRevisions\":[]}'),('pad:g.z2BRQmvrcHnNY58U$7:revs:0','{\"changeset\":\"Z:1>q+q$Enter Your Article Here :)\",\"meta\":{\"author\":\"\",\"timestamp\":1547547630591,\"atext\":{\"text\":\"Enter Your Article Here :)\\n\",\"attribs\":\"|1+r\"}}}'),('sessionstorage:O8JhN59lP6WhlkDWoGlTOLvgojdEr4aw','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('pad2readonly:g.z2BRQmvrcHnNY58U$7','\"r.c4f4b01ee54f4b35ed9e2e02703f8aa6\"'),('readonly2pad:r.c4f4b01ee54f4b35ed9e2e02703f8aa6','\"g.z2BRQmvrcHnNY58U$7\"'),('sessionstorage:aD79aochj2jxTnjj3jdAnpWRCxFYdJ1I','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:RB1H3iXaxqnq9pKi7dEFQRbfFEuTqxD8','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.22ce0e4be57799768a6c3ce4c9167cf3','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547576437}'),('sessionstorage:tJ-O6shdLKHMdR5Y_uWYOcZyJsdao81R','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:hVeEUKUEOwn1LUTlBTOuF5bdcjY9Pvj8','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:9CHTplw1czMVjcjGrD3Ooy99mZWR5FjZ','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:5IQna1EXEML89x6P4lZZKzyqzsrqVw2v','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('session:s.c55fa7c24f98d40fa84d7b8725053260','{\"groupID\":\"g.z2BRQmvrcHnNY58U\",\"authorID\":\"a.OlwffK0YeTBMXtZf\",\"validUntil\":1547576451}'),('sessionstorage:-F2N65Lp1IviwYlTDNCbNaMhSR7h2AFW','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:cTBZ3C9MmgB_62baoGT6XqJNHN-jK5ds','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:RWTIZgGjkFQeqIJMfQ4Y-drRLPtAyMT6','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:CHZiuZu8cxZVbPFViuccdE7AlwvGYUI2','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}'),('sessionstorage:6x18d_uUjrIU8G3TGLlZhzeB997oJCEN','{\"cookie\":{\"path\":\"/\",\"_expires\":null,\"originalMaxAge\":null,\"httpOnly\":true,\"secure\":false}}');
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbnail_kvstore`
--

DROP TABLE IF EXISTS `thumbnail_kvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbnail_kvstore`
--

LOCK TABLES `thumbnail_kvstore` WRITE;
/*!40000 ALTER TABLE `thumbnail_kvstore` DISABLE KEYS */;
/*!40000 ALTER TABLE `thumbnail_kvstore` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webcontent_faq`
--

LOCK TABLES `webcontent_faq` WRITE;
/*!40000 ALTER TABLE `webcontent_faq` DISABLE KEYS */;
INSERT INTO `webcontent_faq` VALUES (1,'What are collaborative communities?','The portal for ‘Collaborative Communities’ will allow individual users to form communities, participate in various activities defined within the community, and thus, enhance its value for the society in terms of education.',1,1),(2,'Why do we need collaborative communities?','‘Collaborative Communities’ helps us to know what other communities can offer and share resources  to achieve a common goal.',1,2),(3,'What type of collaborative communities will you find?','You will find communities from various education fields which come together and contribute to it.',1,3),(4,'What are the key features of collaborative communities?','Collaborative Communities allow a particular community to share resources and idea. It also increases the community awareness.',1,4),(5,'How to register on this website?','Click on \'Sign-Up\' button on the top right corner, and fill the required details as prompted.\r\n',1,5),(6,'I have forgotten my password. What should I do?','Click on forgot password message and enter your email id. You will receive a link to your email for resetting your password.',1,6),(7,'What is a community?','Set of people coming together to achieve a common goal by sharing ideas and information by performing various activities within it.',2,0.5),(8,'What is a group?','A group is nothing but a sub-community which is formed by a group of people of a particular community.',3,0.5),(9,'How to join a community? ',' Navigate to \'Collaborative Communities\' homepage. Assuming that you have logged in, click ‘Communities’ and then click on any desired community. Click ‘Join us’\r\nYou will now be an \'Author\' in the community.\r\n',2,1),(10,'How to leave a community? ','Navigate to the desired community and click ‘Unsubscribe\' and follow the steps given on the screen. \r\n',2,2),(11,'How do I know which communities I am subscribed to? ','Assuming that you have logged in, click on your username > ‘Dashboard’. You will be able to see your subscribed communities under ‘My Communities’\r\n',2,3),(12,'Can I create a community?','No, you cannot create a community. In case you feel the need of a community and it does not make sense in creating a group under a community, only then you may request for creation of a community. You may do so by clicking your username and ‘Request community creation’. Fill the details and follow the instructions.',2,4),(13,'What are the different roles?','Roles are associated with a community and group. A community has (a) author, (b) publisher, and (c) community admin; while a group has (a) author, (b) publisher, and (c) group admin, i.e. a person can be an author in one community/group, a publisher in other, and admin in other. Each of these roles have some set of privileges.',5,1),(14,'Who is an author and what are the privileges?','An author is a member of a community or group who can contribute by creating resources like basic articles and groups in a community.',5,2),(15,'Who is a publisher and what are the privileges?','A publisher is a member of a community or group who has all the privileges as that of an author but is also responsible for publishing articles contributed by other authors in that community/group.',5,3),(16,'Who is an admin of community/group and what are the privileges?','An admin of a community or group has all the privileges as that of a publisher but is also responsible for maintaining the decorum of the community or group. He/she can edit the community/group information, change role of a member, and add or remove a member to/from community/group. <br /><br />\r\n\r\n<b>Note:</b> The person requesting for a community becomes the community admin of that community. The person who creates a group in the community becomes the group admin of that group.',5,4),(17,'Who can create a resource and how?','A resource is created in a community/group. Any member belonging to the community/group can create it. Go to the desired community/group and click \'Create Article\'. Fill up the ‘title’, ‘body’, and ‘image (optional)’, and click \'Create\'. Every resource created follows a workflow from its initial state to final (Publish) state. For more details, please refer to the questions in the \'Workflow\' category.',5,5),(18,'Who will publish my resource and when?','The publisher of the community/group publishes the resource. It will be published based on the states given in the workflow category.',5,6),(19,'I am a publisher of a community/group, can I publish a resource created by me?','No, a publisher cannot publish the resource created by him/her. Other publishers belonging to that community/group can publish it.',5,7),(20,'What is a workflow?','A workflow follows certain steps from initial state to the final state for a resource created by a member of community/group.',6,1),(21,'What workflow is followed in a community/group?','The workflow goes from \'Draft\' state to \'Visible, \'Publishable\', and finally \'Publish\' state in a community; while \'Draft\' to \'Private\', and finally \'Visible\' state in a group. To know more about the states, refer respective questions given below.',6,2),(22,'What is draft state?','When a resource is created, it is initially in this state. At this time only the person who has created it can view. This is true for community as well as group.',6,3),(23,'What is visible state?','This state belongs to community as well as group.\r\nIf a resource in the community is changed to \'Visible\' state, the resource can be viewed and edited by all members of the community. Whereas if the resource in a group is changed to \'Visible\' state, then all the members of the community can view it but cannot edit it.',6,4),(24,'What is publishable state?','This state only belongs to the resource created in the community. In this state the resource is only visible to the community members. The publisher of the community will publish it or reject it.',6,5),(25,'What is publish state?','In this state the resource is published and is visible to anonymous and authenticated users of the system as well. Once it is published then the resource cannot be edited by anyone.',6,6),(26,'What is the flow of the state and who is authorised for changing the states.','',6,7),(27,'How do I know which groups I am subscribed to?','Assuming that you have logged in, click on your username > ‘Dashboard’. You will be able to see your subscribed communities under ‘My Groups’',3,2),(29,'What workflow is followed by a group? ','The workflow goes from \'Draft\' state to visible state in a group. To know about the states, refer respective questions given below. ',3,3),(30,'What is a draft state? ','When a resource is created, it is initially in this state. At this time only the person who has created it can view.',3,4),(31,'What is visible state? ','Content is visible to all members of the community.  Members can comment and edit it.',3,5),(32,'What are the responsibilities of group admin? ','Any community member who creates a group in that particular community becomes a group admin of that particular group. He/she has the right to add/remove people to and from the group and change roles of the group members. He/she can make article visible.',3,6),(33,'Information about a public group in a community and a private group in a community?','Community is always public and available for the authenticated user to join.  Public Group: There can be 0 to N public groups in a community. Any member of the community can create a public group and any member of the community can join it.  Private Group: There can be 0 to N private groups in a community. Any member of the community can create a private group but only invited members can join it.',3,7),(37,'What type of resource tools are available for use?','As of now, our portal has \'Basic Article\' as a tool to offer. We plan to offer other tools like video, audio, etc. as well, in our next release.',4,1),(38,'How to join a group?','Navigate to \'Collaborative Communities\' homepage. Assuming that you have logged in, click ‘Communities’ and then click on any desired community. You will see a list of groups in that community. Click on the desired group and click ‘Join us’ You will now be an \'Author\' in the group.',3,1),(39,'How to leave a group?','Navigate to the desired group and click ‘Unsubscribe\' and follow the steps given on the screen.',3,1.5),(40,'Can I create a group and how?','Yes, you can create a group under a community. Go to the desired community and check whether a similar group exists. Only if it does not exist, then you may create a group by clicking \'Create Group\'. Fill in the details and follow the instructions on the screen.',3,2.5),(41,'Can I edit a resource created by someone else','Yes, as name \'Collaborative Communities\' suggests you can edit and collaborate resources created by other members of your community/group.',5,8),(42,'Can I delete a resource','No, you cannot delete any resource, except the one which is created by you and is in its initial state (draft) only.',5,9),(43,'What is private state?','This state only belongs to a group. When a resource from \'Draft\' state is changed to \'Private\' state, it can be viewed by all members of the group.',6,3.5);
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
-- Table structure for table `wiki_article`
--

DROP TABLE IF EXISTS `wiki_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `group_read` tinyint(1) NOT NULL,
  `group_write` tinyint(1) NOT NULL,
  `other_read` tinyint(1) NOT NULL,
  `other_write` tinyint(1) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `current_revision_id` (`current_revision_id`),
  KEY `wiki_article_group_id_bf035c83_fk_auth_group_id` (`group_id`),
  KEY `wiki_article_owner_id_956bc94a_fk_auth_user_id` (`owner_id`),
  CONSTRAINT `wiki_article_current_revision_id_fc83ea0a_fk_wiki_arti` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  CONSTRAINT `wiki_article_group_id_bf035c83_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `wiki_article_owner_id_956bc94a_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_article`
--

LOCK TABLES `wiki_article` WRITE;
/*!40000 ALTER TABLE `wiki_article` DISABLE KEYS */;
INSERT INTO `wiki_article` VALUES (1,'2019-01-28 11:04:26.206575','2019-01-28 11:04:26.571579',1,1,1,1,1,NULL,NULL);
/*!40000 ALTER TABLE `wiki_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_articleforobject`
--

DROP TABLE IF EXISTS `wiki_articleforobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_articleforobject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(10) unsigned NOT NULL,
  `is_mptt` tinyint(1) NOT NULL,
  `article_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_articleforobject_content_type_id_object_id_046be756_uniq` (`content_type_id`,`object_id`),
  KEY `wiki_articleforobject_article_id_7d67d809_fk_wiki_article_id` (`article_id`),
  CONSTRAINT `wiki_articleforobjec_content_type_id_ba569059_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `wiki_articleforobject_article_id_7d67d809_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articleforobject`
--

LOCK TABLES `wiki_articleforobject` WRITE;
/*!40000 ALTER TABLE `wiki_articleforobject` DISABLE KEYS */;
INSERT INTO `wiki_articleforobject` VALUES (1,1,1,1,62);
/*!40000 ALTER TABLE `wiki_articleforobject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_articleplugin`
--

DROP TABLE IF EXISTS `wiki_articleplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_articleplugin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_articleplugin_article_id_9ab0e854_fk_wiki_article_id` (`article_id`),
  CONSTRAINT `wiki_articleplugin_article_id_9ab0e854_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articleplugin`
--

LOCK TABLES `wiki_articleplugin` WRITE;
/*!40000 ALTER TABLE `wiki_articleplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_articleplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_articlerevision`
--

DROP TABLE IF EXISTS `wiki_articlerevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_articlerevision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `content` longtext NOT NULL,
  `title` varchar(512) NOT NULL,
  `article_id` int(11) NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_articlerevision_article_id_revision_number_5bcd5334_uniq` (`article_id`,`revision_number`),
  KEY `wiki_articlerevision_previous_revision_id_bcfaf4c9_fk_wiki_arti` (`previous_revision_id`),
  KEY `wiki_articlerevision_user_id_c687e4de_fk_auth_user_id` (`user_id`),
  CONSTRAINT `wiki_articlerevision_article_id_e0fb2474_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  CONSTRAINT `wiki_articlerevision_previous_revision_id_bcfaf4c9_fk_wiki_arti` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  CONSTRAINT `wiki_articlerevision_user_id_c687e4de_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articlerevision`
--

LOCK TABLES `wiki_articlerevision` WRITE;
/*!40000 ALTER TABLE `wiki_articlerevision` DISABLE KEYS */;
INSERT INTO `wiki_articlerevision` VALUES (1,1,'','',NULL,'2019-01-28 11:04:26.340606','2019-01-28 11:04:26.340659',0,0,'','Collaboration System',1,NULL,1);
/*!40000 ALTER TABLE `wiki_articlerevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_attachments_attachment`
--

DROP TABLE IF EXISTS `wiki_attachments_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_attachments_attachment` (
  `reusableplugin_ptr_id` int(11) NOT NULL,
  `original_filename` varchar(256) DEFAULT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`reusableplugin_ptr_id`),
  UNIQUE KEY `current_revision_id` (`current_revision_id`),
  CONSTRAINT `wiki_attachments_att_current_revision_id_d30f6b77_fk_wiki_atta` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_attachments_attachmentrevision` (`id`),
  CONSTRAINT `wiki_attachments_att_reusableplugin_ptr_i_856ba17c_fk_wiki_reus` FOREIGN KEY (`reusableplugin_ptr_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_attachments_attachment`
--

LOCK TABLES `wiki_attachments_attachment` WRITE;
/*!40000 ALTER TABLE `wiki_attachments_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_attachments_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_attachments_attachmentrevision`
--

DROP TABLE IF EXISTS `wiki_attachments_attachmentrevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_attachments_attachmentrevision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `file` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `attachment_id` int(11) NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_attachments_att_attachment_id_32ffc4ea_fk_wiki_atta` (`attachment_id`),
  KEY `wiki_attachments_att_previous_revision_id_e7f09093_fk_wiki_atta` (`previous_revision_id`),
  KEY `wiki_attachments_att_user_id_2da908ac_fk_auth_user` (`user_id`),
  CONSTRAINT `wiki_attachments_att_attachment_id_32ffc4ea_fk_wiki_atta` FOREIGN KEY (`attachment_id`) REFERENCES `wiki_attachments_attachment` (`reusableplugin_ptr_id`),
  CONSTRAINT `wiki_attachments_att_previous_revision_id_e7f09093_fk_wiki_atta` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_attachments_attachmentrevision` (`id`),
  CONSTRAINT `wiki_attachments_att_user_id_2da908ac_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_attachments_attachmentrevision`
--

LOCK TABLES `wiki_attachments_attachmentrevision` WRITE;
/*!40000 ALTER TABLE `wiki_attachments_attachmentrevision` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_attachments_attachmentrevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_images_image`
--

DROP TABLE IF EXISTS `wiki_images_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_images_image` (
  `revisionplugin_ptr_id` int(11) NOT NULL,
  PRIMARY KEY (`revisionplugin_ptr_id`),
  CONSTRAINT `wiki_images_image_revisionplugin_ptr_i_d230f69d_fk_wiki_revi` FOREIGN KEY (`revisionplugin_ptr_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_images_image`
--

LOCK TABLES `wiki_images_image` WRITE;
/*!40000 ALTER TABLE `wiki_images_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_images_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_images_imagerevision`
--

DROP TABLE IF EXISTS `wiki_images_imagerevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_images_imagerevision` (
  `revisionpluginrevision_ptr_id` int(11) NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`revisionpluginrevision_ptr_id`),
  CONSTRAINT `wiki_images_imagerev_revisionpluginrevisi_ecb726e8_fk_wiki_revi` FOREIGN KEY (`revisionpluginrevision_ptr_id`) REFERENCES `wiki_revisionpluginrevision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_images_imagerevision`
--

LOCK TABLES `wiki_images_imagerevision` WRITE;
/*!40000 ALTER TABLE `wiki_images_imagerevision` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_images_imagerevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_notifications_articlesubscription`
--

DROP TABLE IF EXISTS `wiki_notifications_articlesubscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_notifications_articlesubscription` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  UNIQUE KEY `subscription_id` (`subscription_id`),
  UNIQUE KEY `wiki_notifications_artic_subscription_id_articlep_6898a80a_uniq` (`subscription_id`,`articleplugin_ptr_id`),
  CONSTRAINT `wiki_notifications_a_articleplugin_ptr_id_c9190941_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  CONSTRAINT `wiki_notifications_a_subscription_id_bd1f8af5_fk_nyt_subsc` FOREIGN KEY (`subscription_id`) REFERENCES `nyt_subscription` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_notifications_articlesubscription`
--

LOCK TABLES `wiki_notifications_articlesubscription` WRITE;
/*!40000 ALTER TABLE `wiki_notifications_articlesubscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_notifications_articlesubscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_reusableplugin`
--

DROP TABLE IF EXISTS `wiki_reusableplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_reusableplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  CONSTRAINT `wiki_reusableplugin_articleplugin_ptr_id_c1737239_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_reusableplugin`
--

LOCK TABLES `wiki_reusableplugin` WRITE;
/*!40000 ALTER TABLE `wiki_reusableplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_reusableplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_reusableplugin_articles`
--

DROP TABLE IF EXISTS `wiki_reusableplugin_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_reusableplugin_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reusableplugin_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_reusableplugin_arti_reusableplugin_id_articl_302a7a01_uniq` (`reusableplugin_id`,`article_id`),
  KEY `wiki_reusableplugin__article_id_8a09d39e_fk_wiki_arti` (`article_id`),
  CONSTRAINT `wiki_reusableplugin__article_id_8a09d39e_fk_wiki_arti` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  CONSTRAINT `wiki_reusableplugin__reusableplugin_id_52618a1c_fk_wiki_reus` FOREIGN KEY (`reusableplugin_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_reusableplugin_articles`
--

LOCK TABLES `wiki_reusableplugin_articles` WRITE;
/*!40000 ALTER TABLE `wiki_reusableplugin_articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_reusableplugin_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_revisionplugin`
--

DROP TABLE IF EXISTS `wiki_revisionplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_revisionplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  UNIQUE KEY `current_revision_id` (`current_revision_id`),
  CONSTRAINT `wiki_revisionplugin_articleplugin_ptr_id_95c295f2_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  CONSTRAINT `wiki_revisionplugin_current_revision_id_46514536_fk_wiki_revi` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_revisionplugin`
--

LOCK TABLES `wiki_revisionplugin` WRITE;
/*!40000 ALTER TABLE `wiki_revisionplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_revisionplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_revisionpluginrevision`
--

DROP TABLE IF EXISTS `wiki_revisionpluginrevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_revisionpluginrevision` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revision_number` int(11) NOT NULL,
  `user_message` longtext NOT NULL,
  `automatic_log` longtext NOT NULL,
  `ip_address` char(39) DEFAULT NULL,
  `modified` datetime(6) NOT NULL,
  `created` datetime(6) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `plugin_id` int(11) NOT NULL,
  `previous_revision_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wiki_revisionpluginr_plugin_id_c8f4475b_fk_wiki_revi` (`plugin_id`),
  KEY `wiki_revisionpluginr_previous_revision_id_38c877c0_fk_wiki_revi` (`previous_revision_id`),
  KEY `wiki_revisionpluginrevision_user_id_ee40f729_fk_auth_user_id` (`user_id`),
  CONSTRAINT `wiki_revisionpluginr_plugin_id_c8f4475b_fk_wiki_revi` FOREIGN KEY (`plugin_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`),
  CONSTRAINT `wiki_revisionpluginr_previous_revision_id_38c877c0_fk_wiki_revi` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`),
  CONSTRAINT `wiki_revisionpluginrevision_user_id_ee40f729_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_revisionpluginrevision`
--

LOCK TABLES `wiki_revisionpluginrevision` WRITE;
/*!40000 ALTER TABLE `wiki_revisionpluginrevision` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_revisionpluginrevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_simpleplugin`
--

DROP TABLE IF EXISTS `wiki_simpleplugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_simpleplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `article_revision_id` int(11) NOT NULL,
  PRIMARY KEY (`articleplugin_ptr_id`),
  KEY `wiki_simpleplugin_article_revision_id_cff7df92_fk_wiki_arti` (`article_revision_id`),
  CONSTRAINT `wiki_simpleplugin_article_revision_id_cff7df92_fk_wiki_arti` FOREIGN KEY (`article_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  CONSTRAINT `wiki_simpleplugin_articleplugin_ptr_id_2b99b828_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_simpleplugin`
--

LOCK TABLES `wiki_simpleplugin` WRITE;
/*!40000 ALTER TABLE `wiki_simpleplugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `wiki_simpleplugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wiki_urlpath`
--

DROP TABLE IF EXISTS `wiki_urlpath`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wiki_urlpath` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `moved_to_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wiki_urlpath_site_id_parent_id_slug_e4942e5d_uniq` (`site_id`,`parent_id`,`slug`),
  KEY `wiki_urlpath_article_id_9ef0c0fb_fk_wiki_article_id` (`article_id`),
  KEY `wiki_urlpath_slug_39d212eb` (`slug`),
  KEY `wiki_urlpath_lft_46bfd227` (`lft`),
  KEY `wiki_urlpath_rght_186fc98e` (`rght`),
  KEY `wiki_urlpath_tree_id_090b475d` (`tree_id`),
  KEY `wiki_urlpath_level_57f17cfd` (`level`),
  KEY `wiki_urlpath_parent_id_a6e675ac` (`parent_id`),
  KEY `wiki_urlpath_moved_to_id_4718abf8` (`moved_to_id`),
  CONSTRAINT `wiki_urlpath_article_id_9ef0c0fb_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  CONSTRAINT `wiki_urlpath_moved_to_id_4718abf8_fk_wiki_urlpath_id` FOREIGN KEY (`moved_to_id`) REFERENCES `wiki_urlpath` (`id`),
  CONSTRAINT `wiki_urlpath_parent_id_a6e675ac_fk_wiki_urlpath_id` FOREIGN KEY (`parent_id`) REFERENCES `wiki_urlpath` (`id`),
  CONSTRAINT `wiki_urlpath_site_id_319be912_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_urlpath`
--

LOCK TABLES `wiki_urlpath` WRITE;
/*!40000 ALTER TABLE `wiki_urlpath` DISABLE KEYS */;
INSERT INTO `wiki_urlpath` VALUES (1,NULL,1,2,1,0,1,NULL,1,NULL);
/*!40000 ALTER TABLE `wiki_urlpath` ENABLE KEYS */;
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
  `final` tinyint(1) NOT NULL,
  `initial` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_states`
--

LOCK TABLES `workflow_states` WRITE;
/*!40000 ALTER TABLE `workflow_states` DISABLE KEYS */;
INSERT INTO `workflow_states` VALUES (1,'draft','save as draft state',0,1),(2,'visible','this state make the content visible to community',0,0),(3,'publish','save as visible state',1,0),(4,'private','this state make the content visible to group',0,0),(5,'publishable','this content makes the content ready for publishing',0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_transitions`
--

LOCK TABLES `workflow_transitions` WRITE;
/*!40000 ALTER TABLE `workflow_transitions` DISABLE KEYS */;
INSERT INTO `workflow_transitions` VALUES (1,'Make Visible to Group',1,4),(3,'Make Visible to Community',4,2),(4,'Ready for Publishing',2,5),(5,'Publish',5,3),(6,'Publish',5,2);
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

-- Dump completed on 2019-01-28 16:41:11
