-- MySQL dump 10.13  Distrib 5.7.23, for osx10.14 (x86_64)
--
-- Host: localhost    Database: collaboration
-- ------------------------------------------------------
-- Server version	8.0.12

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add comment',8,'add_xtdcomment'),(23,'Can change comment',8,'change_xtdcomment'),(24,'Can delete comment',8,'delete_xtdcomment'),(25,'Can moderate comments',8,'can_moderate'),(26,'Can add black listed domain',9,'add_blacklisteddomain'),(27,'Can change black listed domain',9,'change_blacklisteddomain'),(28,'Can delete black listed domain',9,'delete_blacklisteddomain'),(29,'Can add comment',10,'add_comment'),(30,'Can change comment',10,'change_comment'),(31,'Can delete comment',10,'delete_comment'),(32,'Can moderate comments',10,'can_moderate'),(33,'Can add comment flag',11,'add_commentflag'),(34,'Can change comment flag',11,'change_commentflag'),(35,'Can delete comment flag',11,'delete_commentflag'),(36,'Can add community',12,'add_community'),(37,'Can change community',12,'change_community'),(38,'Can delete community',12,'delete_community'),(39,'Can add community articles',13,'add_communityarticles'),(40,'Can change community articles',13,'change_communityarticles'),(41,'Can delete community articles',13,'delete_communityarticles'),(42,'Can add community courses',14,'add_communitycourses'),(43,'Can change community courses',14,'change_communitycourses'),(44,'Can delete community courses',14,'delete_communitycourses'),(45,'Can add community groups',15,'add_communitygroups'),(46,'Can change community groups',15,'change_communitygroups'),(47,'Can delete community groups',15,'delete_communitygroups'),(48,'Can add community media',16,'add_communitymedia'),(49,'Can change community media',16,'change_communitymedia'),(50,'Can delete community media',16,'delete_communitymedia'),(51,'Can add community membership',17,'add_communitymembership'),(52,'Can change community membership',17,'change_communitymembership'),(53,'Can delete community membership',17,'delete_communitymembership'),(54,'Can add request community creation',18,'add_requestcommunitycreation'),(55,'Can change request community creation',18,'change_requestcommunitycreation'),(56,'Can delete request community creation',18,'delete_requestcommunitycreation'),(57,'Can add favourite',19,'add_favourite'),(58,'Can change favourite',19,'change_favourite'),(59,'Can delete favourite',19,'delete_favourite'),(60,'Can add profile image',20,'add_profileimage'),(61,'Can change profile image',20,'change_profileimage'),(62,'Can delete profile image',20,'delete_profileimage'),(63,'Can add articles',21,'add_articles'),(64,'Can change articles',21,'change_articles'),(65,'Can delete articles',21,'delete_articles'),(66,'Can add article view logs',22,'add_articleviewlogs'),(67,'Can change article view logs',22,'change_articleviewlogs'),(68,'Can delete article view logs',22,'delete_articleviewlogs'),(69,'Can add group',23,'add_group'),(70,'Can change group',23,'change_group'),(71,'Can delete group',23,'delete_group'),(72,'Can add group articles',24,'add_grouparticles'),(73,'Can change group articles',24,'change_grouparticles'),(74,'Can delete group articles',24,'delete_grouparticles'),(75,'Can add group invitations',25,'add_groupinvitations'),(76,'Can change group invitations',25,'change_groupinvitations'),(77,'Can delete group invitations',25,'delete_groupinvitations'),(78,'Can add group media',26,'add_groupmedia'),(79,'Can change group media',26,'change_groupmedia'),(80,'Can delete group media',26,'delete_groupmedia'),(81,'Can add group membership',27,'add_groupmembership'),(82,'Can change group membership',27,'change_groupmembership'),(83,'Can delete group membership',27,'delete_groupmembership'),(84,'Can add revision',28,'add_revision'),(85,'Can change revision',28,'change_revision'),(86,'Can delete revision',28,'delete_revision'),(87,'Can add version',29,'add_version'),(88,'Can change version',29,'change_version'),(89,'Can delete version',29,'delete_version'),(90,'Can add Token',30,'add_token'),(91,'Can change Token',30,'change_token'),(92,'Can delete Token',30,'delete_token'),(93,'Can add states',31,'add_states'),(94,'Can change states',31,'change_states'),(95,'Can delete states',31,'delete_states'),(96,'Can add transitions',32,'add_transitions'),(97,'Can change transitions',32,'change_transitions'),(98,'Can delete transitions',32,'delete_transitions'),(99,'Can add association',33,'add_association'),(100,'Can change association',33,'change_association'),(101,'Can delete association',33,'delete_association'),(102,'Can add code',34,'add_code'),(103,'Can change code',34,'change_code'),(104,'Can delete code',34,'delete_code'),(105,'Can add nonce',35,'add_nonce'),(106,'Can change nonce',35,'change_nonce'),(107,'Can delete nonce',35,'delete_nonce'),(108,'Can add user social auth',36,'add_usersocialauth'),(109,'Can change user social auth',36,'change_usersocialauth'),(110,'Can delete user social auth',36,'delete_usersocialauth'),(111,'Can add partial',37,'add_partial'),(112,'Can change partial',37,'change_partial'),(113,'Can delete partial',37,'delete_partial'),(114,'Can add feedback',38,'add_feedback'),(115,'Can change feedback',38,'change_feedback'),(116,'Can delete feedback',38,'delete_feedback'),(117,'Can add faq',39,'add_faq'),(118,'Can change faq',39,'change_faq'),(119,'Can delete faq',39,'delete_faq'),(120,'Can add faq category',40,'add_faqcategory'),(121,'Can change faq category',40,'change_faqcategory'),(122,'Can delete faq category',40,'delete_faqcategory'),(123,'Can add course',41,'add_course'),(124,'Can change course',41,'change_course'),(125,'Can delete course',41,'delete_course'),(126,'Can add links',42,'add_links'),(127,'Can change links',42,'change_links'),(128,'Can delete links',42,'delete_links'),(129,'Can add topic article',43,'add_topicarticle'),(130,'Can change topic article',43,'change_topicarticle'),(131,'Can delete topic article',43,'delete_topicarticle'),(132,'Can add topics',44,'add_topics'),(133,'Can change topics',44,'change_topics'),(134,'Can delete topics',44,'delete_topics'),(135,'Can add videos',45,'add_videos'),(136,'Can change videos',45,'change_videos'),(137,'Can delete videos',45,'delete_videos'),(138,'Can add notification',46,'add_notification'),(139,'Can change notification',46,'change_notification'),(140,'Can delete notification',46,'delete_notification'),(141,'Can add action',47,'add_action'),(142,'Can change action',47,'change_action'),(143,'Can delete action',47,'delete_action'),(144,'Can add follow',48,'add_follow'),(145,'Can change follow',48,'change_follow'),(146,'Can delete follow',48,'delete_follow'),(147,'Can add type',49,'add_notificationtype'),(148,'Can change type',49,'change_notificationtype'),(149,'Can delete type',49,'delete_notificationtype'),(150,'Can add settings',50,'add_settings'),(151,'Can change settings',50,'change_settings'),(152,'Can delete settings',50,'delete_settings'),(153,'Can add notification',51,'add_notification'),(154,'Can change notification',51,'change_notification'),(155,'Can delete notification',51,'delete_notification'),(156,'Can add subscription',52,'add_subscription'),(157,'Can change subscription',52,'change_subscription'),(158,'Can delete subscription',52,'delete_subscription'),(159,'Can add kv store',53,'add_kvstore'),(160,'Can change kv store',53,'change_kvstore'),(161,'Can delete kv store',53,'delete_kvstore'),(162,'Can add article',54,'add_article'),(163,'Can change article',54,'change_article'),(164,'Can delete article',54,'delete_article'),(165,'Can edit all articles and lock/unlock/restore',54,'moderate'),(166,'Can change ownership of any article',54,'assign'),(167,'Can assign permissions to other users',54,'grant'),(168,'Can add Article for object',55,'add_articleforobject'),(169,'Can change Article for object',55,'change_articleforobject'),(170,'Can delete Article for object',55,'delete_articleforobject'),(171,'Can add article plugin',56,'add_articleplugin'),(172,'Can change article plugin',56,'change_articleplugin'),(173,'Can delete article plugin',56,'delete_articleplugin'),(174,'Can add article revision',57,'add_articlerevision'),(175,'Can change article revision',57,'change_articlerevision'),(176,'Can delete article revision',57,'delete_articlerevision'),(177,'Can add reusable plugin',58,'add_reusableplugin'),(178,'Can change reusable plugin',58,'change_reusableplugin'),(179,'Can delete reusable plugin',58,'delete_reusableplugin'),(180,'Can add revision plugin',59,'add_revisionplugin'),(181,'Can change revision plugin',59,'change_revisionplugin'),(182,'Can delete revision plugin',59,'delete_revisionplugin'),(183,'Can add revision plugin revision',60,'add_revisionpluginrevision'),(184,'Can change revision plugin revision',60,'change_revisionpluginrevision'),(185,'Can delete revision plugin revision',60,'delete_revisionpluginrevision'),(186,'Can add simple plugin',61,'add_simpleplugin'),(187,'Can change simple plugin',61,'change_simpleplugin'),(188,'Can delete simple plugin',61,'delete_simpleplugin'),(189,'Can add URL path',62,'add_urlpath'),(190,'Can change URL path',62,'change_urlpath'),(191,'Can delete URL path',62,'delete_urlpath'),(192,'Can add attachment',63,'add_attachment'),(193,'Can change attachment',63,'change_attachment'),(194,'Can delete attachment',63,'delete_attachment'),(195,'Can add attachment revision',64,'add_attachmentrevision'),(196,'Can change attachment revision',64,'change_attachmentrevision'),(197,'Can delete attachment revision',64,'delete_attachmentrevision'),(198,'Can add article subscription',65,'add_articlesubscription'),(199,'Can change article subscription',65,'change_articlesubscription'),(200,'Can delete article subscription',65,'delete_articlesubscription'),(201,'Can add image',66,'add_image'),(202,'Can change image',66,'change_image'),(203,'Can delete image',66,'delete_image'),(204,'Can add image revision',67,'add_imagerevision'),(205,'Can change image revision',67,'change_imagerevision'),(206,'Can delete image revision',67,'delete_imagerevision'),(207,'Can add article flag logs',68,'add_articleflaglogs'),(208,'Can change article flag logs',68,'change_articleflaglogs'),(209,'Can delete article flag logs',68,'delete_articleflaglogs'),(210,'Can add article score log',69,'add_articlescorelog'),(211,'Can change article score log',69,'change_articlescorelog'),(212,'Can delete article score log',69,'delete_articlescorelog'),(213,'Can add article user score logs',70,'add_articleuserscorelogs'),(214,'Can change article user score logs',70,'change_articleuserscorelogs'),(215,'Can delete article user score logs',70,'delete_articleuserscorelogs'),(216,'Can add community reputaion',71,'add_communityreputaion'),(217,'Can change community reputaion',71,'change_communityreputaion'),(218,'Can delete community reputaion',71,'delete_communityreputaion'),(219,'Can add flag reason',72,'add_flagreason'),(220,'Can change flag reason',72,'change_flagreason'),(221,'Can delete flag reason',72,'delete_flagreason'),(222,'Can add media flag logs',73,'add_mediaflaglogs'),(223,'Can change media flag logs',73,'change_mediaflaglogs'),(224,'Can delete media flag logs',73,'delete_mediaflaglogs'),(225,'Can add media score log',74,'add_mediascorelog'),(226,'Can change media score log',74,'change_mediascorelog'),(227,'Can delete media score log',74,'delete_mediascorelog'),(228,'Can add media user score logs',75,'add_mediauserscorelogs'),(229,'Can change media user score logs',75,'change_mediauserscorelogs'),(230,'Can delete media user score logs',75,'delete_mediauserscorelogs'),(231,'Can add resource score',76,'add_resourcescore'),(232,'Can change resource score',76,'change_resourcescore'),(233,'Can delete resource score',76,'delete_resourcescore'),(234,'Can add user score',77,'add_userscore'),(235,'Can change user score',77,'change_userscore'),(236,'Can delete user score',77,'delete_userscore'),(237,'Can add ether article',78,'add_etherarticle'),(238,'Can change ether article',78,'change_etherarticle'),(239,'Can delete ether article',78,'delete_etherarticle'),(240,'Can add ether community',79,'add_ethercommunity'),(241,'Can change ether community',79,'change_ethercommunity'),(242,'Can delete ether community',79,'delete_ethercommunity'),(243,'Can add ether group',80,'add_ethergroup'),(244,'Can change ether group',80,'change_ethergroup'),(245,'Can delete ether group',80,'delete_ethergroup'),(246,'Can add ether user',81,'add_etheruser'),(247,'Can change ether user',81,'change_etheruser'),(248,'Can delete ether user',81,'delete_etheruser'),(249,'Can add media',82,'add_media'),(250,'Can change media',82,'change_media'),(251,'Can delete media',82,'delete_media'),(252,'Can add metadata',83,'add_metadata'),(253,'Can change metadata',83,'change_metadata'),(254,'Can delete metadata',83,'delete_metadata'),(255,'Can add task',84,'add_task'),(256,'Can change task',84,'change_task'),(257,'Can delete task',84,'delete_task'),(258,'Can add badge',85,'add_badge'),(259,'Can change badge',85,'change_badge'),(260,'Can delete badge',85,'delete_badge'),(261,'Can add badge to user',86,'add_badgetouser'),(262,'Can change badge to user',86,'change_badgetouser'),(263,'Can delete badge to user',86,'delete_badgetouser'),(264,'Can add category',87,'add_category'),(265,'Can change category',87,'change_category'),(266,'Can delete category',87,'delete_category'),(267,'Can add Tag',88,'add_tag'),(268,'Can change Tag',88,'change_tag'),(269,'Can delete Tag',88,'delete_tag'),(270,'Can add Tagged Item',89,'add_taggeditem'),(271,'Can change Tagged Item',89,'change_taggeditem'),(272,'Can delete Tagged Item',89,'delete_taggeditem'),(273,'Can add Forum',90,'add_forum'),(274,'Can change Forum',90,'change_forum'),(275,'Can delete Forum',90,'delete_forum'),(276,'Can add Post',91,'add_post'),(277,'Can change Post',91,'change_post'),(278,'Can delete Post',91,'delete_post'),(279,'Can add Topic',92,'add_topic'),(280,'Can change Topic',92,'change_topic'),(281,'Can delete Topic',92,'delete_topic'),(282,'Can add Attachment',93,'add_attachment'),(283,'Can change Attachment',93,'change_attachment'),(284,'Can delete Attachment',93,'delete_attachment'),(285,'Can add Topic poll',94,'add_topicpoll'),(286,'Can change Topic poll',94,'change_topicpoll'),(287,'Can delete Topic poll',94,'delete_topicpoll'),(288,'Can add Topic poll option',95,'add_topicpolloption'),(289,'Can change Topic poll option',95,'change_topicpolloption'),(290,'Can delete Topic poll option',95,'delete_topicpolloption'),(291,'Can add Topic poll vote',96,'add_topicpollvote'),(292,'Can change Topic poll vote',96,'change_topicpollvote'),(293,'Can delete Topic poll vote',96,'delete_topicpollvote'),(294,'Can add Forum track',97,'add_forumreadtrack'),(295,'Can change Forum track',97,'change_forumreadtrack'),(296,'Can delete Forum track',97,'delete_forumreadtrack'),(297,'Can add Topic track',98,'add_topicreadtrack'),(298,'Can change Topic track',98,'change_topicreadtrack'),(299,'Can delete Topic track',98,'delete_topicreadtrack'),(300,'Can add Forum profile',99,'add_forumprofile'),(301,'Can change Forum profile',99,'change_forumprofile'),(302,'Can delete Forum profile',99,'delete_forumprofile'),(303,'Can add Forum permission',100,'add_forumpermission'),(304,'Can change Forum permission',100,'change_forumpermission'),(305,'Can delete Forum permission',100,'delete_forumpermission'),(306,'Can add Group forum permission',101,'add_groupforumpermission'),(307,'Can change Group forum permission',101,'change_groupforumpermission'),(308,'Can delete Group forum permission',101,'delete_groupforumpermission'),(309,'Can add User forum permission',102,'add_userforumpermission'),(310,'Can change User forum permission',102,'change_userforumpermission'),(311,'Can delete User forum permission',102,'delete_userforumpermission'),(312,'Can add badge score',103,'add_badgescore'),(313,'Can change badge score',103,'change_badgescore'),(314,'Can delete badge score',103,'delete_badgescore');
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
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$36000$r8CujTIffhma$jnmVmCO1tuc18NIMsZrwfrdyNnxCNmIAXB+9LdVkPsE=','2019-03-26 14:16:28.754819',1,'admin','','','admin@mail.com',1,1,'2019-02-26 07:47:48.227174');
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
-- Table structure for table `badges_badge`
--

DROP TABLE IF EXISTS `badges_badge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_badge` (
  `id` varchar(255) NOT NULL,
  `level` varchar(1) NOT NULL,
  `icon` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_badge`
--

LOCK TABLES `badges_badge` WRITE;
/*!40000 ALTER TABLE `badges_badge` DISABLE KEYS */;
INSERT INTO `badges_badge` VALUES ('ac-level-1','1',''),('ac-level-2','2',''),('ac-level-3','3',''),('ac-level-4','4',''),('ac-level-5','5',''),('ap-level-1','1',''),('ap-level-2','2',''),('ap-level-3','3',''),('ap-level-4','4',''),('ap-level-5','5',''),('pa-level-1','1',''),('pa-level-2','2',''),('pa-level-3','3',''),('pa-level-4','4',''),('pa-level-5','5','');
/*!40000 ALTER TABLE `badges_badge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges_badgetouser`
--

DROP TABLE IF EXISTS `badges_badgetouser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges_badgetouser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `badge_id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `community_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `badges_badgetouser_badge_id_0e3cd6bb_fk_badges_badge_id` (`badge_id`),
  KEY `badges_badgetouser_user_id_7928b431_fk_auth_user_id` (`user_id`),
  KEY `badges_badgetouser_community_id_01e9a7f7_fk_Community` (`community_id`),
  CONSTRAINT `badges_badgetouser_badge_id_0e3cd6bb_fk_badges_badge_id` FOREIGN KEY (`badge_id`) REFERENCES `badges_badge` (`id`),
  CONSTRAINT `badges_badgetouser_community_id_01e9a7f7_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `badges_badgetouser_user_id_7928b431_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges_badgetouser`
--

LOCK TABLES `badges_badgetouser` WRITE;
/*!40000 ALTER TABLE `badges_badgetouser` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges_badgetouser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BasicArticle_articles`
--

DROP TABLE IF EXISTS `BasicArticle_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BasicArticle_articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `body` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `published_on` datetime(6) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `published_by_id` int(11) DEFAULT NULL,
  `state_id` int(11),
  PRIMARY KEY (`id`),
  KEY `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` (`created_by_id`),
  KEY `BasicArticle_articles_published_by_id_81e5e785_fk_auth_user_id` (`published_by_id`),
  KEY `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` (`state_id`),
  CONSTRAINT `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `BasicArticle_articles_published_by_id_81e5e785_fk_auth_user_id` FOREIGN KEY (`published_by_id`) REFERENCES `auth_user` (`id`),
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
  CONSTRAINT `BasicArticle_article_article_id_164e59b4_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `basicarticle_articles` (`id`)
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
-- Table structure for table `Categories_category`
--

DROP TABLE IF EXISTS `Categories_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Categories_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `lft` int(10) unsigned NOT NULL,
  `rght` int(10) unsigned NOT NULL,
  `tree_id` int(10) unsigned NOT NULL,
  `level` int(10) unsigned NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Categories_category_lft_ec4145b1` (`lft`),
  KEY `Categories_category_rght_63642186` (`rght`),
  KEY `Categories_category_tree_id_1d8ca4e7` (`tree_id`),
  KEY `Categories_category_level_593703f5` (`level`),
  KEY `Categories_category_parent_id_eee850a6` (`parent_id`),
  CONSTRAINT `Categories_category_parent_id_eee850a6_fk_Categories_category_id` FOREIGN KEY (`parent_id`) REFERENCES `categories_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories_category`
--

LOCK TABLES `Categories_category` WRITE;
/*!40000 ALTER TABLE `Categories_category` DISABLE KEYS */;
INSERT INTO `Categories_category` VALUES (1,'CS','category/bf1d0420-ae80-4e53-b4bc-9a6efabd1652.PNG','2019-03-26 14:17:02.349656',1,2,1,0,NULL);
/*!40000 ALTER TABLE `Categories_category` ENABLE KEYS */;
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
  `category_id` int(11) DEFAULT NULL,
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
  `image_thumbnail` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_community_lft_d7f05a9b` (`lft`),
  KEY `Community_community_rght_6dfec445` (`rght`),
  KEY `Community_community_tree_id_bd4e2595` (`tree_id`),
  KEY `Community_community_level_db58ba5f` (`level`),
  KEY `Community_community_created_by_id_1080464d_fk_auth_user_id` (`created_by_id`),
  KEY `Community_community_parent_id_47d0e58d` (`parent_id`),
  KEY `Community_community_category_id_87e260b2` (`category_id`),
  CONSTRAINT `Community_community_category_id_87e260b2_fk_Categorie` FOREIGN KEY (`category_id`) REFERENCES `categories_category` (`id`),
  CONSTRAINT `Community_community_created_by_id_1080464d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Community_community_parent_id_47d0e58d_fk_Community_community_id` FOREIGN KEY (`parent_id`) REFERENCES `community_community` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_community`
--

LOCK TABLES `Community_community` WRITE;
/*!40000 ALTER TABLE `Community_community` DISABLE KEYS */;
INSERT INTO `Community_community` VALUES (3,'q','<p>q</p>','',1,'q','2019-03-26 14:52:57.276683','q-4',4,1,2,1,0,1,NULL,'');
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
  CONSTRAINT `Community_communitya_article_id_c9af3fed_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `basicarticle_articles` (`id`),
  CONSTRAINT `Community_communitya_community_id_39b5841f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
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
  KEY `Community_communityc_community_id_db58cc7f_fk_Community` (`community_id`),
  KEY `Community_communityc_course_id_1b9cc41b_fk_Course_co` (`course_id`),
  KEY `Community_communitycourses_user_id_d3572caf_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Community_communityc_community_id_db58cc7f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `Community_communityc_course_id_1b9cc41b_fk_Course_co` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`),
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
  CONSTRAINT `Community_communityg_community_id_3e76934c_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `Community_communitygroups_group_id_a2ce7b35_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_group` (`id`),
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
  CONSTRAINT `Community_communitym_community_id_3ff46a01_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `Community_communitymedia_media_id_e160518e_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `media_media` (`id`),
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
  CONSTRAINT `Community_communitym_community_id_8a39991d_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `Community_communitymembership_role_id_9c581fd0_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `Community_communitymembership_user_id_5dd1c26b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Community_communitymembership`
--

LOCK TABLES `Community_communitymembership` WRITE;
/*!40000 ALTER TABLE `Community_communitymembership` DISABLE KEYS */;
INSERT INTO `Community_communitymembership` VALUES (1,3,3,1);
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
  `category_id` int(11) DEFAULT NULL,
  `tag_line` varchar(500) DEFAULT NULL,
  `purpose` longtext NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `requestedby_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Community_requestcom_requestedby_id_b3e83124_fk_auth_user` (`requestedby_id`),
  KEY `Community_requestcommunitycreation_category_id_874787b7` (`category_id`),
  CONSTRAINT `Community_requestcom_category_id_874787b7_fk_Categorie` FOREIGN KEY (`category_id`) REFERENCES `categories_category` (`id`),
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
  CONSTRAINT `Course_links_topics_id_096bf6bd_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `course_topics` (`id`)
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
  CONSTRAINT `Course_topicarticle_article_id_2ab7af7f_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `basicarticle_articles` (`id`),
  CONSTRAINT `Course_topicarticle_topics_id_d20b76e7_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `course_topics` (`id`)
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
  CONSTRAINT `Course_topics_course_id_9e18b74c_fk_Course_course_id` FOREIGN KEY (`course_id`) REFERENCES `course_course` (`id`),
  CONSTRAINT `Course_topics_parent_id_adff4cae_fk_Course_topics_id` FOREIGN KEY (`parent_id`) REFERENCES `course_topics` (`id`)
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
  CONSTRAINT `Course_videos_topics_id_568227cc_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `course_topics` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-02-26 07:49:42.065158','1','Collaboration System',1,'[{\"added\": {}}]',90,1),(2,'2019-02-26 11:25:17.114008','3','publish',2,'[{\"changed\": {\"fields\": [\"final\"]}}]',31,1),(3,'2019-02-26 11:27:56.205778','1','draft',2,'[{\"changed\": {\"fields\": [\"initial\"]}}]',31,1),(4,'2019-02-26 11:28:04.665605','3','publish',2,'[]',31,1),(5,'2019-03-26 14:17:02.519561','1','CS',1,'[{\"added\": {}}]',87,1),(6,'2019-03-26 15:10:04.410381','publisher','Publisher',3,'',85,1),(7,'2019-03-26 15:10:04.573761','contributor','Contributor',3,'',85,1),(8,'2019-03-26 15:13:08.566664','publisher','Publisher',3,'',85,1),(9,'2019-03-26 15:13:08.764861','contributor','Contributor',3,'',85,1),(10,'2019-03-26 15:13:08.777171','author','Author',3,'',85,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (47,'actstream','action'),(48,'actstream','follow'),(1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(30,'authtoken','token'),(85,'badges','badge'),(86,'badges','badgetouser'),(21,'BasicArticle','articles'),(22,'BasicArticle','articleviewlogs'),(87,'Categories','category'),(12,'Community','community'),(13,'Community','communityarticles'),(14,'Community','communitycourses'),(15,'Community','communitygroups'),(16,'Community','communitymedia'),(17,'Community','communitymembership'),(18,'Community','requestcommunitycreation'),(5,'contenttypes','contenttype'),(41,'Course','course'),(42,'Course','links'),(43,'Course','topicarticle'),(44,'Course','topics'),(45,'Course','videos'),(10,'django_comments','comment'),(11,'django_comments','commentflag'),(9,'django_comments_xtd','blacklisteddomain'),(8,'django_comments_xtd','xtdcomment'),(51,'django_nyt','notification'),(49,'django_nyt','notificationtype'),(50,'django_nyt','settings'),(52,'django_nyt','subscription'),(78,'etherpad','etherarticle'),(79,'etherpad','ethercommunity'),(80,'etherpad','ethergroup'),(81,'etherpad','etheruser'),(90,'forum','forum'),(93,'forum_attachments','attachment'),(91,'forum_conversation','post'),(92,'forum_conversation','topic'),(99,'forum_member','forumprofile'),(100,'forum_permission','forumpermission'),(101,'forum_permission','groupforumpermission'),(102,'forum_permission','userforumpermission'),(94,'forum_polls','topicpoll'),(95,'forum_polls','topicpolloption'),(96,'forum_polls','topicpollvote'),(97,'forum_tracking','forumreadtrack'),(98,'forum_tracking','topicreadtrack'),(23,'Group','group'),(24,'Group','grouparticles'),(25,'Group','groupinvitations'),(26,'Group','groupmedia'),(27,'Group','groupmembership'),(82,'Media','media'),(83,'metadata','metadata'),(46,'notifications','notification'),(68,'Reputation','articleflaglogs'),(69,'Reputation','articlescorelog'),(70,'Reputation','articleuserscorelogs'),(103,'Reputation','badgescore'),(71,'Reputation','communityreputaion'),(72,'Reputation','flagreason'),(73,'Reputation','mediaflaglogs'),(74,'Reputation','mediascorelog'),(75,'Reputation','mediauserscorelogs'),(76,'Reputation','resourcescore'),(77,'Reputation','userscore'),(28,'reversion','revision'),(29,'reversion','version'),(6,'sessions','session'),(7,'sites','site'),(33,'social_django','association'),(34,'social_django','code'),(35,'social_django','nonce'),(37,'social_django','partial'),(36,'social_django','usersocialauth'),(88,'taggit','tag'),(89,'taggit','taggeditem'),(84,'TaskQueue','task'),(53,'thumbnail','kvstore'),(19,'UserRolesPermission','favourite'),(20,'UserRolesPermission','profileimage'),(39,'webcontent','faq'),(40,'webcontent','faqcategory'),(38,'webcontent','feedback'),(54,'wiki','article'),(55,'wiki','articleforobject'),(56,'wiki','articleplugin'),(57,'wiki','articlerevision'),(58,'wiki','reusableplugin'),(59,'wiki','revisionplugin'),(60,'wiki','revisionpluginrevision'),(61,'wiki','simpleplugin'),(62,'wiki','urlpath'),(63,'wiki_attachments','attachment'),(64,'wiki_attachments','attachmentrevision'),(66,'wiki_images','image'),(67,'wiki_images','imagerevision'),(65,'wiki_notifications','articlesubscription'),(31,'workflow','states'),(32,'workflow','transitions');
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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-02-26 07:41:26.492337'),(2,'taggit','0001_initial','2019-02-26 07:41:29.032338'),(3,'taggit','0002_auto_20150616_2121','2019-02-26 07:41:29.450448'),(4,'workflow','0001_initial','2019-02-26 07:41:32.106100'),(5,'auth','0001_initial','2019-02-26 07:41:41.338858'),(6,'BasicArticle','0001_initial','2019-02-26 07:41:45.857438'),(7,'BasicArticle','0002_articles_tags','2019-02-26 07:41:45.926853'),(8,'Categories','0001_initial','2019-02-26 07:41:48.689139'),(9,'contenttypes','0002_remove_content_type_name','2019-02-26 07:41:49.859244'),(10,'auth','0002_alter_permission_name_max_length','2019-02-26 07:41:49.992798'),(11,'auth','0003_alter_user_email_max_length','2019-02-26 07:41:50.126212'),(12,'auth','0004_alter_user_username_opts','2019-02-26 07:41:50.182471'),(13,'auth','0005_alter_user_last_login_null','2019-02-26 07:41:50.802683'),(14,'auth','0006_require_contenttypes_0002','2019-02-26 07:41:50.852661'),(15,'auth','0007_alter_validators_add_error_messages','2019-02-26 07:41:50.905140'),(16,'auth','0008_alter_user_username_max_length','2019-02-26 07:41:51.045395'),(17,'Media','0001_initial','2019-02-26 07:41:54.052495'),(18,'Group','0001_initial','2019-02-26 07:42:09.278893'),(19,'Course','0001_initial','2019-02-26 07:42:21.130104'),(20,'Community','0001_initial','2019-02-26 07:42:32.039342'),(21,'Community','0002_auto_20181224_0729','2019-02-26 07:42:48.160860'),(22,'Community','0003_auto_20190204_1241','2019-02-26 07:42:48.353985'),(23,'Community','0004_auto_20190205_1144','2019-02-26 07:42:54.612570'),(24,'Community','0005_community_image_thumbnail','2019-02-26 07:42:55.632035'),(25,'metadata','0001_initial','2019-02-26 07:42:58.847303'),(26,'metadata','0002_auto_20190218_1005','2019-02-26 07:43:00.425941'),(27,'Media','0002_media_medialink','2019-02-26 07:43:01.270782'),(28,'Media','0003_media_metadata','2019-02-26 07:43:03.133721'),(29,'Reputation','0001_initial','2019-02-26 07:43:21.267059'),(30,'TaskQueue','0001_initial','2019-02-26 07:43:21.712524'),(31,'UserRolesPermission','0001_initial','2019-02-26 07:43:24.257755'),(32,'actstream','0001_initial','2019-02-26 07:43:32.342677'),(33,'actstream','0002_remove_action_data','2019-02-26 07:43:32.384598'),(34,'admin','0001_initial','2019-02-26 07:43:34.414618'),(35,'admin','0002_logentry_remove_auto_add','2019-02-26 07:43:34.699539'),(36,'authtoken','0001_initial','2019-02-26 07:43:35.984739'),(37,'authtoken','0002_auto_20160226_1747','2019-02-26 07:43:37.171457'),(38,'badges','0001_initial','2019-02-26 07:43:37.213251'),(39,'badges','0002_auto_20150513_0429','2019-02-26 07:43:39.910836'),(40,'badges','0003_badgetouser_community','2019-02-26 07:43:41.498222'),(41,'sites','0001_initial','2019-02-26 07:43:41.859103'),(42,'django_comments','0001_initial','2019-02-26 07:43:48.012129'),(43,'django_comments','0002_update_user_email_field_length','2019-02-26 07:43:48.189025'),(44,'django_comments','0003_add_submit_date_index','2019-02-26 07:43:48.505631'),(45,'django_comments_xtd','0001_initial','2019-02-26 07:43:50.476377'),(46,'django_comments_xtd','0002_blacklisteddomain','2019-02-26 07:43:51.236118'),(47,'django_comments_xtd','0003_auto_20170220_1333','2019-02-26 07:43:51.294082'),(48,'django_comments_xtd','0004_auto_20170221_1510','2019-02-26 07:43:51.350416'),(49,'django_comments_xtd','0005_auto_20170920_1247','2019-02-26 07:43:51.413003'),(50,'django_nyt','0001_initial','2019-02-26 07:43:52.648603'),(51,'django_nyt','0002_notification_settings','2019-02-26 07:43:54.168083'),(52,'django_nyt','0003_subscription','2019-02-26 07:43:57.343252'),(53,'django_nyt','0004_notification_subscription','2019-02-26 07:43:58.829174'),(54,'django_nyt','0005__v_0_9_2','2019-02-26 07:44:05.865184'),(55,'django_nyt','0006_auto_20141229_1630','2019-02-26 07:44:07.067140'),(56,'django_nyt','0007_add_modified_and_default_settings','2019-02-26 07:44:08.464175'),(57,'django_nyt','0008_auto_20161023_1641','2019-02-26 07:44:11.479821'),(58,'etherpad','0001_initial','2019-02-26 07:44:16.348977'),(59,'forum','0001_initial','2019-02-26 07:44:20.090416'),(60,'forum_conversation','0001_initial','2019-02-26 07:44:29.521586'),(61,'forum_conversation','0002_post_anonymous_key','2019-02-26 07:44:30.283029'),(62,'forum_conversation','0003_auto_20160228_2051','2019-02-26 07:44:30.395129'),(63,'forum_conversation','0004_auto_20160427_0502','2019-02-26 07:44:32.469261'),(64,'forum_conversation','0005_auto_20160607_0455','2019-02-26 07:44:33.163204'),(65,'forum_conversation','0006_post_enable_signature','2019-02-26 07:44:34.265613'),(66,'forum_conversation','0007_auto_20160903_0450','2019-02-26 07:44:38.033489'),(67,'forum_conversation','0008_auto_20160903_0512','2019-02-26 07:44:38.132767'),(68,'forum_conversation','0009_auto_20160925_2126','2019-02-26 07:44:38.209165'),(69,'forum_conversation','0010_auto_20170120_0224','2019-02-26 07:44:39.645125'),(70,'forum','0002_auto_20150725_0512','2019-02-26 07:44:39.703364'),(71,'forum','0003_remove_forum_is_active','2019-02-26 07:44:40.564074'),(72,'forum','0004_auto_20170504_2108','2019-02-26 07:44:42.270841'),(73,'forum','0005_auto_20170504_2113','2019-02-26 07:44:42.366941'),(74,'forum','0006_auto_20170523_2036','2019-02-26 07:44:44.081771'),(75,'forum','0007_auto_20170523_2140','2019-02-26 07:44:44.187242'),(76,'forum','0008_forum_last_post','2019-02-26 07:44:45.952930'),(77,'forum','0009_auto_20170928_2327','2019-02-26 07:44:46.052430'),(78,'forum_attachments','0001_initial','2019-02-26 07:44:47.080605'),(79,'forum_member','0001_initial','2019-02-26 07:44:48.367580'),(80,'forum_member','0002_auto_20160225_0515','2019-02-26 07:44:48.462005'),(81,'forum_member','0003_auto_20160227_2122','2019-02-26 07:44:48.541383'),(82,'forum_permission','0001_initial','2019-02-26 07:44:55.894577'),(83,'forum_permission','0002_auto_20160607_0500','2019-02-26 07:44:57.389034'),(84,'forum_permission','0003_remove_forumpermission_name','2019-02-26 07:44:58.132573'),(85,'forum_polls','0001_initial','2019-02-26 07:45:02.425912'),(86,'forum_polls','0002_auto_20151105_0029','2019-02-26 07:45:04.623388'),(87,'forum_tracking','0001_initial','2019-02-26 07:45:09.284099'),(88,'forum_tracking','0002_auto_20160607_0502','2019-02-26 07:45:10.128895'),(89,'notifications','0001_initial','2019-02-26 07:45:14.137945'),(90,'notifications','0002_auto_20150224_1134','2019-02-26 07:45:15.759730'),(91,'notifications','0003_notification_data','2019-02-26 07:45:16.577030'),(92,'notifications','0004_auto_20150826_1508','2019-02-26 07:45:16.752698'),(93,'notifications','0005_auto_20160504_1520','2019-02-26 07:45:16.888103'),(94,'notifications','0006_indexes','2019-02-26 07:45:18.254944'),(95,'reversion','0001_initial','2019-02-26 07:45:22.089041'),(96,'reversion','0002_auto_20141216_1509','2019-02-26 07:45:22.130714'),(97,'reversion','0003_auto_20160601_1600','2019-02-26 07:45:22.188958'),(98,'reversion','0004_auto_20160611_1202','2019-02-26 07:45:22.230512'),(99,'sessions','0001_initial','2019-02-26 07:45:22.823877'),(100,'sites','0002_alter_domain_unique','2019-02-26 07:45:23.108265'),(101,'default','0001_initial','2019-02-26 07:45:26.549143'),(102,'social_auth','0001_initial','2019-02-26 07:45:26.599468'),(103,'default','0002_add_related_name','2019-02-26 07:45:27.577108'),(104,'social_auth','0002_add_related_name','2019-02-26 07:45:27.610293'),(105,'default','0003_alter_email_max_length','2019-02-26 07:45:28.019857'),(106,'social_auth','0003_alter_email_max_length','2019-02-26 07:45:28.053333'),(107,'default','0004_auto_20160423_0400','2019-02-26 07:45:28.131117'),(108,'social_auth','0004_auto_20160423_0400','2019-02-26 07:45:28.169443'),(109,'social_auth','0005_auto_20160727_2333','2019-02-26 07:45:28.452965'),(110,'social_django','0006_partial','2019-02-26 07:45:29.029389'),(111,'social_django','0007_code_timestamp','2019-02-26 07:45:30.081749'),(112,'social_django','0008_partial_timestamp','2019-02-26 07:45:31.051186'),(113,'thumbnail','0001_initial','2019-02-26 07:45:31.389462'),(114,'webcontent','0001_initial','2019-02-26 07:45:32.056620'),(115,'webcontent','0002_auto_20180124_1328','2019-02-26 07:45:34.033219'),(116,'webcontent','0003_auto_20180124_1452','2019-02-26 07:45:35.486687'),(117,'webcontent','0004_delete_faq','2019-02-26 07:45:35.695460'),(118,'webcontent','0005_faq','2019-02-26 07:45:36.033789'),(119,'webcontent','0006_faqcategory','2019-02-26 07:45:36.341167'),(120,'webcontent','0007_remove_faq_category','2019-02-26 07:45:36.924524'),(121,'webcontent','0008_faq_category','2019-02-26 07:45:38.284867'),(122,'webcontent','0009_faq_order','2019-02-26 07:45:38.812470'),(123,'webcontent','0010_remove_faq_order','2019-02-26 07:45:39.371786'),(124,'webcontent','0011_faq_order','2019-02-26 07:45:40.015671'),(125,'webcontent','0012_auto_20180125_1628','2019-02-26 07:45:40.766945'),(126,'webcontent','0013_auto_20180125_1634','2019-02-26 07:45:41.760222'),(127,'webcontent','0014_auto_20180125_1636','2019-02-26 07:45:41.903136'),(128,'webcontent','0015_auto_20180125_1643','2019-02-26 07:45:42.713092'),(129,'wiki','0001_initial','2019-02-26 07:46:20.852399'),(130,'wiki','0002_urlpath_moved_to','2019-02-26 07:46:23.248390'),(131,'wiki_attachments','0001_initial','2019-02-26 07:46:29.304235'),(132,'wiki_attachments','0002_auto_20151118_1816','2019-02-26 07:46:29.373945'),(133,'wiki_images','0001_initial','2019-02-26 07:46:31.942550'),(134,'wiki_images','0002_auto_20151118_1811','2019-02-26 07:46:32.044721'),(135,'wiki_notifications','0001_initial','2019-02-26 07:46:34.491264'),(136,'wiki_notifications','0002_auto_20151118_1811','2019-02-26 07:46:34.546877'),(137,'workflow','0002_auto_20190110_1419','2019-02-26 07:46:35.795909'),(138,'reversion','0001_squashed_0004_auto_20160611_1202','2019-02-26 07:46:35.849356'),(139,'social_django','0001_initial','2019-02-26 07:46:35.894827'),(140,'social_django','0004_auto_20160423_0400','2019-02-26 07:46:35.936257'),(141,'social_django','0005_auto_20160727_2333','2019-02-26 07:46:35.994715'),(142,'social_django','0003_alter_email_max_length','2019-02-26 07:46:36.060426'),(143,'social_django','0002_add_related_name','2019-02-26 07:46:36.102235'),(144,'Reputation','0002_auto_20190306_2109','2019-03-26 14:15:54.150009'),(145,'Reputation','0003_badgescore','2019-03-26 14:15:54.193626'),(146,'Reputation','0004_communityreputaion_published_by_me_count','2019-03-26 14:15:54.269252'),(147,'Reputation','0005_auto_20190318_1041','2019-03-26 14:15:54.383579'),(148,'badges','0004_auto_20190318_0739','2019-03-26 14:15:54.445050'),(149,'workflow','0003_auto_20190318_1054','2019-03-26 14:15:54.725020'),(150,'BasicArticle','0003_auto_20190325_1120','2019-03-26 15:12:42.554039'),(151,'Media','0004_auto_20190325_1122','2019-03-26 15:12:42.809142');
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
INSERT INTO `django_session` VALUES ('9w2571ejkpm8tsta0qsvxksoyshao8gq','ZDZkN2YyZTc0YWFhMmU2MjlhZGY5N2FjNWMxYzA4NjBjZTdiYTJiMDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNGIzMDNmNjlmZjAwNDMxYWE1MTg1ODE3Mjc2Y2IwMWMiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWIzMGMxOWMxOWUyNjAwYWI0M2QxNmNjYzg5YmQ2N2JjMTI4NTcwZCJ9','2019-02-26 09:52:01.871653'),('b1yueqzk0okf3zke2j83ym9tcrdwf72u','OGY2NzBiMzlkMGNiZjVjODJjZGNmYzRkMzg1ODdiYzUzMTg1ODk2Zjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNzk4YmMxZThhNTA2NDJjZjg4MjQ4ODM2ZmI2YTJlOTgiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWIzMGMxOWMxOWUyNjAwYWI0M2QxNmNjYzg5YmQ2N2JjMTI4NTcwZCJ9','2019-02-26 13:28:32.916180'),('hek7ddvb9rg9a4eygiachdww7fqwx8cn','MmI0NzhlMWIwZmUzYzlkN2U5YmE1MDJkODhhNTFmODJkNGNhNDZhNjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNTc2MGMyYjcyMWQzNGY5OGI5MDNlMzQzMThkNmNiYTAifQ==','2019-02-26 12:34:21.300604'),('s6jbzpogbqo00m1kzfqybrdc8l3xkw6u','ZWY4NmE0NjZhNDczNWQ4ZmNkNmU3YTUyNzExOTMxMGE5NzZiY2NmYzp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiYTM3MjU0NjVjZmFkNDdjM2E3NDc3ZTIwM2NjMTM3ZGEiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWIzMGMxOWMxOWUyNjAwYWI0M2QxNmNjYzg5YmQ2N2JjMTI4NTcwZCJ9','2019-02-26 13:25:21.608345'),('yue3sfc6ebqycweh3weozwjh5pbhw6rm','YTNhMjg1N2JjNmU0ODM1OTA0OGUwY2NjMzg1YThkZDBmMThlMWMyYjp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNmVlNzU1MzY4NGJiNDZhMTk4NDJjOGRhNTNiZWRiOGMifQ==','2019-02-26 12:33:15.568030'),('zt5cmsetc8904rhgz4afyuaj4tchjpyq','NzdjNGY3YzE1M2ZkMzExZDIzMTAxNzdkNjNlNWQ4YTQ2MGM5YjZiMTp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiY2VjZmExZmViYmU1NDNkMDg2NGQ3YzA5ZmJkM2MzNGQiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWIzMGMxOWMxOWUyNjAwYWI0M2QxNmNjYzg5YmQ2N2JjMTI4NTcwZCJ9','2019-03-26 17:13:11.825347');
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
  CONSTRAINT `etherpad_etherarticl_article_id_af7a9005_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `basicarticle_articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  CONSTRAINT `etherpad_ethercommun_community_id_8610cc18_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  CONSTRAINT `etherpad_ethergroup_group_id_a1912466_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_group` (`id`)
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_forum`
--

LOCK TABLES `forum_forum` WRITE;
/*!40000 ALTER TABLE `forum_forum` DISABLE KEYS */;
INSERT INTO `forum_forum` VALUES (1,'2019-02-26 07:49:42.059228','2019-02-26 07:49:42.059279','Collaboration System','collaboration-system','','',NULL,0,0,0,NULL,1,'<p></p>',1,2,1,0,NULL,0,0,NULL),(4,'2019-03-26 20:22:57.000000','2019-03-26 20:22:57.000000','q','q','<p>q</p>',NULL,NULL,0,0,0,NULL,1,NULL,1,2,2,0,NULL,0,0,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forum_permission_groupforumpermission`
--

LOCK TABLES `forum_permission_groupforumpermission` WRITE;
/*!40000 ALTER TABLE `forum_permission_groupforumpermission` DISABLE KEYS */;
INSERT INTO `forum_permission_groupforumpermission` VALUES (1,1,NULL,1,2),(2,1,NULL,1,1),(3,1,NULL,1,7),(4,1,NULL,1,8),(5,1,NULL,1,9),(6,1,NULL,1,4),(7,1,NULL,1,3),(8,1,NULL,2,2),(9,1,NULL,2,1),(10,1,NULL,2,7),(11,1,NULL,2,8),(12,1,NULL,2,9),(13,1,NULL,2,4),(14,1,NULL,2,3),(15,1,NULL,3,2),(16,1,NULL,3,1),(17,1,NULL,3,7),(18,1,NULL,3,8),(19,1,NULL,3,5),(20,1,NULL,3,6),(21,1,NULL,3,9),(22,1,NULL,3,4),(23,1,NULL,3,3),(24,1,NULL,3,10),(25,1,NULL,3,11);
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
  CONSTRAINT `Group_grouparticles_article_id_eac38398_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `basicarticle_articles` (`id`),
  CONSTRAINT `Group_grouparticles_group_id_84ee212d_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_group` (`id`),
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
  CONSTRAINT `Group_groupinvitations_group_id_48a7f8e2_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_group` (`id`),
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
  CONSTRAINT `Group_groupmedia_group_id_73f1a47c_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_group` (`id`),
  CONSTRAINT `Group_groupmedia_media_id_bb652569_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `media_media` (`id`),
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
  CONSTRAINT `Group_groupmembership_group_id_adce78b5_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `group_group` (`id`),
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
  `state_id` int(11),
  `medialink` varchar(300) DEFAULT NULL,
  `metadata_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Media_media_created_by_id_ae93f7fb_fk_auth_user_id` (`created_by_id`),
  KEY `Media_media_published_by_id_83121da5_fk_auth_user_id` (`published_by_id`),
  KEY `Media_media_state_id_46785feb_fk_workflow_states_id` (`state_id`),
  KEY `Media_media_metadata_id_c939b240_fk_metadata_metadata_id` (`metadata_id`),
  CONSTRAINT `Media_media_created_by_id_ae93f7fb_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `Media_media_metadata_id_c939b240_fk_metadata_metadata_id` FOREIGN KEY (`metadata_id`) REFERENCES `metadata_metadata` (`id`),
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
-- Table structure for table `metadata_metadata`
--

DROP TABLE IF EXISTS `metadata_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadata_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications_notification`
--

LOCK TABLES `notifications_notification` WRITE;
/*!40000 ALTER TABLE `notifications_notification` DISABLE KEYS */;
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
  CONSTRAINT `Reputation_articlefl_reason_id_200b641a_fk_Reputatio` FOREIGN KEY (`reason_id`) REFERENCES `reputation_flagreason` (`id`),
  CONSTRAINT `Reputation_articlefl_resource_id_21412c4c_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `basicarticle_articles` (`id`),
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
  CONSTRAINT `Reputation_articlesc_resource_id_ddac6fc9_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `basicarticle_articles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  CONSTRAINT `Reputation_articleus_resource_id_2a10325b_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `basicarticle_articles` (`id`),
  CONSTRAINT `Reputation_articleuserscorelogs_user_id_77095608_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_articleuserscorelogs`
--

LOCK TABLES `Reputation_articleuserscorelogs` WRITE;
/*!40000 ALTER TABLE `Reputation_articleuserscorelogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Reputation_articleuserscorelogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_badgescore`
--

DROP TABLE IF EXISTS `Reputation_badgescore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_badgescore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articles_contributed_level_1` int(11) NOT NULL,
  `articles_contributed_level_2` int(11) NOT NULL,
  `articles_contributed_level_3` int(11) NOT NULL,
  `articles_contributed_level_4` int(11) NOT NULL,
  `articles_contributed_level_5` int(11) NOT NULL,
  `my_articles_published_level_1` int(11) NOT NULL,
  `my_articles_published_level_2` int(11) NOT NULL,
  `my_articles_published_level_3` int(11) NOT NULL,
  `my_articles_published_level_4` int(11) NOT NULL,
  `my_articles_published_level_5` int(11) NOT NULL,
  `articles_revised_by_me_level_1` int(11) NOT NULL,
  `articles_revised_by_me_level_2` int(11) NOT NULL,
  `articles_revised_by_me_level_3` int(11) NOT NULL,
  `articles_revised_by_me_level_4` int(11) NOT NULL,
  `articles_revised_by_me_level_5` int(11) NOT NULL,
  `articles_published_by_me_level_1` int(11) NOT NULL,
  `articles_published_by_me_level_2` int(11) NOT NULL,
  `articles_published_by_me_level_3` int(11) NOT NULL,
  `articles_published_by_me_level_4` int(11) NOT NULL,
  `articles_published_by_me_level_5` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_badgescore`
--

LOCK TABLES `Reputation_badgescore` WRITE;
/*!40000 ALTER TABLE `Reputation_badgescore` DISABLE KEYS */;
INSERT INTO `Reputation_badgescore` VALUES (1,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5,1,2,3,4,5);
/*!40000 ALTER TABLE `Reputation_badgescore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reputation_communityreputaion`
--

DROP TABLE IF EXISTS `Reputation_communityreputaion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Reputation_communityreputaion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `upvote_count` int(11) NOT NULL,
  `downvote_count` int(11) NOT NULL,
  `published_count` int(11) NOT NULL,
  `community_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `published_by_me_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Reputation_community_community_id_9fe0df3b_fk_Community` (`community_id`),
  KEY `Reputation_communityreputaion_user_id_fce03592_fk_auth_user_id` (`user_id`),
  CONSTRAINT `Reputation_community_community_id_9fe0df3b_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `Reputation_communityreputaion_user_id_fce03592_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_communityreputaion`
--

LOCK TABLES `Reputation_communityreputaion` WRITE;
/*!40000 ALTER TABLE `Reputation_communityreputaion` DISABLE KEYS */;
INSERT INTO `Reputation_communityreputaion` VALUES (1,0,0,0,3,1,0);
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
  CONSTRAINT `Reputation_mediaflag_reason_id_b7bf0680_fk_Reputatio` FOREIGN KEY (`reason_id`) REFERENCES `reputation_flagreason` (`id`),
  CONSTRAINT `Reputation_mediaflaglogs_resource_id_1fe0b6c8_fk_Media_media_id` FOREIGN KEY (`resource_id`) REFERENCES `media_media` (`id`),
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
  CONSTRAINT `Reputation_mediascorelog_resource_id_c3f674e3_fk_Media_media_id` FOREIGN KEY (`resource_id`) REFERENCES `media_media` (`id`)
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
  CONSTRAINT `Reputation_mediauser_resource_id_461aadb0_fk_Media_med` FOREIGN KEY (`resource_id`) REFERENCES `media_media` (`id`),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reputation_resourcescore`
--

LOCK TABLES `Reputation_resourcescore` WRITE;
/*!40000 ALTER TABLE `Reputation_resourcescore` DISABLE KEYS */;
INSERT INTO `Reputation_resourcescore` VALUES (1,1,0,0,1,0,'resource');
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
  `author` int(11) NOT NULL,
  `publisher` int(11) NOT NULL,
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
-- Table structure for table `taggit_tag`
--

DROP TABLE IF EXISTS `taggit_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggit_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggit_tag`
--

LOCK TABLES `taggit_tag` WRITE;
/*!40000 ALTER TABLE `taggit_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggit_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggit_taggeditem`
--

DROP TABLE IF EXISTS `taggit_taggeditem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggit_taggeditem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` (`tag_id`),
  KEY `taggit_taggeditem_object_id_e2d7d1df` (`object_id`),
  KEY `taggit_taggeditem_content_type_id_object_id_196cc965_idx` (`content_type_id`,`object_id`),
  CONSTRAINT `taggit_taggeditem_content_type_id_9957a03c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `taggit_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggit_taggeditem`
--

LOCK TABLES `taggit_taggeditem` WRITE;
/*!40000 ALTER TABLE `taggit_taggeditem` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggit_taggeditem` ENABLE KEYS */;
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
  `provided_at` datetime(6) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_article`
--

LOCK TABLES `wiki_article` WRITE;
/*!40000 ALTER TABLE `wiki_article` DISABLE KEYS */;
INSERT INTO `wiki_article` VALUES (1,'2019-02-26 07:51:50.401999','2019-02-26 07:51:50.698621',1,1,1,1,1,NULL,NULL),(2,'2019-03-26 20:22:58.000000','2019-03-26 20:22:58.000000',1,1,1,1,2,1,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articleforobject`
--

LOCK TABLES `wiki_articleforobject` WRITE;
/*!40000 ALTER TABLE `wiki_articleforobject` DISABLE KEYS */;
INSERT INTO `wiki_articleforobject` VALUES (1,1,1,1,62),(2,2,1,2,62);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_articlerevision`
--

LOCK TABLES `wiki_articlerevision` WRITE;
/*!40000 ALTER TABLE `wiki_articlerevision` DISABLE KEYS */;
INSERT INTO `wiki_articlerevision` VALUES (1,1,'','',NULL,'2019-02-26 07:51:50.551101','2019-02-26 07:51:50.551153',0,0,'','Collaboration System',1,NULL,1),(2,1,'Write your summary here.','','','2019-03-26 20:22:58.000000','2019-03-26 20:22:58.000000',0,0,'Write your content here','q',2,NULL,2);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wiki_urlpath`
--

LOCK TABLES `wiki_urlpath` WRITE;
/*!40000 ALTER TABLE `wiki_urlpath` DISABLE KEYS */;
INSERT INTO `wiki_urlpath` VALUES (1,NULL,1,4,1,0,1,NULL,1,NULL),(2,'q3',2,3,1,1,2,1,1,NULL);
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
  `community_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_transitions_from_state_id_5ff9ea9d_fk_workflow_` (`from_state_id`),
  KEY `workflow_transitions_to_state_id_8d6c5cc6_fk_workflow_states_id` (`to_state_id`),
  KEY `workflow_transitions_community_id_a4579b58_fk_Community` (`community_id`),
  KEY `workflow_transitions_role_id_b75429ec_fk_auth_group_id` (`role_id`),
  CONSTRAINT `workflow_transitions_community_id_a4579b58_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `community_community` (`id`),
  CONSTRAINT `workflow_transitions_from_state_id_5ff9ea9d_fk_workflow_` FOREIGN KEY (`from_state_id`) REFERENCES `workflow_states` (`id`),
  CONSTRAINT `workflow_transitions_role_id_b75429ec_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `workflow_transitions_to_state_id_8d6c5cc6_fk_workflow_states_id` FOREIGN KEY (`to_state_id`) REFERENCES `workflow_states` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workflow_transitions`
--

LOCK TABLES `workflow_transitions` WRITE;
/*!40000 ALTER TABLE `workflow_transitions` DISABLE KEYS */;
INSERT INTO `workflow_transitions` VALUES (1,'Make Visible to Group',1,4,NULL,NULL),(3,'Make Visible to Community',4,2,NULL,NULL),(4,'Ready for Publishing',2,5,NULL,NULL),(5,'Publish',5,3,NULL,NULL),(6,'Publish',5,2,NULL,NULL);
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

-- Dump completed on 2019-03-26 20:43:32
