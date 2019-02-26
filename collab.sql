-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 26, 2019 at 02:28 PM
-- Server version: 5.7.25-0ubuntu0.18.04.2
-- PHP Version: 7.2.15-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `temple_migration`
--

-- --------------------------------------------------------

--
-- Table structure for table `actstream_action`
--

CREATE TABLE `actstream_action` (
  `id` int(11) NOT NULL,
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
  `target_content_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `actstream_follow`
--

CREATE TABLE `actstream_follow` (
  `id` int(11) NOT NULL,
  `object_id` varchar(255) NOT NULL,
  `actor_only` tinyint(1) NOT NULL,
  `started` datetime(6) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(1, 'author'),
(3, 'community_admin'),
(4, 'group_admin'),
(2, 'publisher');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can add permission', 2, 'add_permission'),
(5, 'Can change permission', 2, 'change_permission'),
(6, 'Can delete permission', 2, 'delete_permission'),
(7, 'Can add group', 3, 'add_group'),
(8, 'Can change group', 3, 'change_group'),
(9, 'Can delete group', 3, 'delete_group'),
(10, 'Can add user', 4, 'add_user'),
(11, 'Can change user', 4, 'change_user'),
(12, 'Can delete user', 4, 'delete_user'),
(13, 'Can add content type', 5, 'add_contenttype'),
(14, 'Can change content type', 5, 'change_contenttype'),
(15, 'Can delete content type', 5, 'delete_contenttype'),
(16, 'Can add session', 6, 'add_session'),
(17, 'Can change session', 6, 'change_session'),
(18, 'Can delete session', 6, 'delete_session'),
(19, 'Can add site', 7, 'add_site'),
(20, 'Can change site', 7, 'change_site'),
(21, 'Can delete site', 7, 'delete_site'),
(22, 'Can add comment', 8, 'add_xtdcomment'),
(23, 'Can change comment', 8, 'change_xtdcomment'),
(24, 'Can delete comment', 8, 'delete_xtdcomment'),
(25, 'Can moderate comments', 8, 'can_moderate'),
(26, 'Can add black listed domain', 9, 'add_blacklisteddomain'),
(27, 'Can change black listed domain', 9, 'change_blacklisteddomain'),
(28, 'Can delete black listed domain', 9, 'delete_blacklisteddomain'),
(29, 'Can add comment', 10, 'add_comment'),
(30, 'Can change comment', 10, 'change_comment'),
(31, 'Can delete comment', 10, 'delete_comment'),
(32, 'Can moderate comments', 10, 'can_moderate'),
(33, 'Can add comment flag', 11, 'add_commentflag'),
(34, 'Can change comment flag', 11, 'change_commentflag'),
(35, 'Can delete comment flag', 11, 'delete_commentflag'),
(36, 'Can add community', 12, 'add_community'),
(37, 'Can change community', 12, 'change_community'),
(38, 'Can delete community', 12, 'delete_community'),
(39, 'Can add community articles', 13, 'add_communityarticles'),
(40, 'Can change community articles', 13, 'change_communityarticles'),
(41, 'Can delete community articles', 13, 'delete_communityarticles'),
(42, 'Can add community courses', 14, 'add_communitycourses'),
(43, 'Can change community courses', 14, 'change_communitycourses'),
(44, 'Can delete community courses', 14, 'delete_communitycourses'),
(45, 'Can add community groups', 15, 'add_communitygroups'),
(46, 'Can change community groups', 15, 'change_communitygroups'),
(47, 'Can delete community groups', 15, 'delete_communitygroups'),
(48, 'Can add community media', 16, 'add_communitymedia'),
(49, 'Can change community media', 16, 'change_communitymedia'),
(50, 'Can delete community media', 16, 'delete_communitymedia'),
(51, 'Can add community membership', 17, 'add_communitymembership'),
(52, 'Can change community membership', 17, 'change_communitymembership'),
(53, 'Can delete community membership', 17, 'delete_communitymembership'),
(54, 'Can add request community creation', 18, 'add_requestcommunitycreation'),
(55, 'Can change request community creation', 18, 'change_requestcommunitycreation'),
(56, 'Can delete request community creation', 18, 'delete_requestcommunitycreation'),
(57, 'Can add favourite', 19, 'add_favourite'),
(58, 'Can change favourite', 19, 'change_favourite'),
(59, 'Can delete favourite', 19, 'delete_favourite'),
(60, 'Can add profile image', 20, 'add_profileimage'),
(61, 'Can change profile image', 20, 'change_profileimage'),
(62, 'Can delete profile image', 20, 'delete_profileimage'),
(63, 'Can add articles', 21, 'add_articles'),
(64, 'Can change articles', 21, 'change_articles'),
(65, 'Can delete articles', 21, 'delete_articles'),
(66, 'Can add article view logs', 22, 'add_articleviewlogs'),
(67, 'Can change article view logs', 22, 'change_articleviewlogs'),
(68, 'Can delete article view logs', 22, 'delete_articleviewlogs'),
(69, 'Can add group', 23, 'add_group'),
(70, 'Can change group', 23, 'change_group'),
(71, 'Can delete group', 23, 'delete_group'),
(72, 'Can add group articles', 24, 'add_grouparticles'),
(73, 'Can change group articles', 24, 'change_grouparticles'),
(74, 'Can delete group articles', 24, 'delete_grouparticles'),
(75, 'Can add group invitations', 25, 'add_groupinvitations'),
(76, 'Can change group invitations', 25, 'change_groupinvitations'),
(77, 'Can delete group invitations', 25, 'delete_groupinvitations'),
(78, 'Can add group media', 26, 'add_groupmedia'),
(79, 'Can change group media', 26, 'change_groupmedia'),
(80, 'Can delete group media', 26, 'delete_groupmedia'),
(81, 'Can add group membership', 27, 'add_groupmembership'),
(82, 'Can change group membership', 27, 'change_groupmembership'),
(83, 'Can delete group membership', 27, 'delete_groupmembership'),
(84, 'Can add revision', 28, 'add_revision'),
(85, 'Can change revision', 28, 'change_revision'),
(86, 'Can delete revision', 28, 'delete_revision'),
(87, 'Can add version', 29, 'add_version'),
(88, 'Can change version', 29, 'change_version'),
(89, 'Can delete version', 29, 'delete_version'),
(90, 'Can add Token', 30, 'add_token'),
(91, 'Can change Token', 30, 'change_token'),
(92, 'Can delete Token', 30, 'delete_token'),
(93, 'Can add states', 31, 'add_states'),
(94, 'Can change states', 31, 'change_states'),
(95, 'Can delete states', 31, 'delete_states'),
(96, 'Can add transitions', 32, 'add_transitions'),
(97, 'Can change transitions', 32, 'change_transitions'),
(98, 'Can delete transitions', 32, 'delete_transitions'),
(99, 'Can add association', 33, 'add_association'),
(100, 'Can change association', 33, 'change_association'),
(101, 'Can delete association', 33, 'delete_association'),
(102, 'Can add code', 34, 'add_code'),
(103, 'Can change code', 34, 'change_code'),
(104, 'Can delete code', 34, 'delete_code'),
(105, 'Can add nonce', 35, 'add_nonce'),
(106, 'Can change nonce', 35, 'change_nonce'),
(107, 'Can delete nonce', 35, 'delete_nonce'),
(108, 'Can add user social auth', 36, 'add_usersocialauth'),
(109, 'Can change user social auth', 36, 'change_usersocialauth'),
(110, 'Can delete user social auth', 36, 'delete_usersocialauth'),
(111, 'Can add partial', 37, 'add_partial'),
(112, 'Can change partial', 37, 'change_partial'),
(113, 'Can delete partial', 37, 'delete_partial'),
(114, 'Can add feedback', 38, 'add_feedback'),
(115, 'Can change feedback', 38, 'change_feedback'),
(116, 'Can delete feedback', 38, 'delete_feedback'),
(117, 'Can add faq', 39, 'add_faq'),
(118, 'Can change faq', 39, 'change_faq'),
(119, 'Can delete faq', 39, 'delete_faq'),
(120, 'Can add faq category', 40, 'add_faqcategory'),
(121, 'Can change faq category', 40, 'change_faqcategory'),
(122, 'Can delete faq category', 40, 'delete_faqcategory'),
(123, 'Can add course', 41, 'add_course'),
(124, 'Can change course', 41, 'change_course'),
(125, 'Can delete course', 41, 'delete_course'),
(126, 'Can add links', 42, 'add_links'),
(127, 'Can change links', 42, 'change_links'),
(128, 'Can delete links', 42, 'delete_links'),
(129, 'Can add topic article', 43, 'add_topicarticle'),
(130, 'Can change topic article', 43, 'change_topicarticle'),
(131, 'Can delete topic article', 43, 'delete_topicarticle'),
(132, 'Can add topics', 44, 'add_topics'),
(133, 'Can change topics', 44, 'change_topics'),
(134, 'Can delete topics', 44, 'delete_topics'),
(135, 'Can add videos', 45, 'add_videos'),
(136, 'Can change videos', 45, 'change_videos'),
(137, 'Can delete videos', 45, 'delete_videos'),
(138, 'Can add notification', 46, 'add_notification'),
(139, 'Can change notification', 46, 'change_notification'),
(140, 'Can delete notification', 46, 'delete_notification'),
(141, 'Can add action', 47, 'add_action'),
(142, 'Can change action', 47, 'change_action'),
(143, 'Can delete action', 47, 'delete_action'),
(144, 'Can add follow', 48, 'add_follow'),
(145, 'Can change follow', 48, 'change_follow'),
(146, 'Can delete follow', 48, 'delete_follow'),
(147, 'Can add type', 49, 'add_notificationtype'),
(148, 'Can change type', 49, 'change_notificationtype'),
(149, 'Can delete type', 49, 'delete_notificationtype'),
(150, 'Can add settings', 50, 'add_settings'),
(151, 'Can change settings', 50, 'change_settings'),
(152, 'Can delete settings', 50, 'delete_settings'),
(153, 'Can add notification', 51, 'add_notification'),
(154, 'Can change notification', 51, 'change_notification'),
(155, 'Can delete notification', 51, 'delete_notification'),
(156, 'Can add subscription', 52, 'add_subscription'),
(157, 'Can change subscription', 52, 'change_subscription'),
(158, 'Can delete subscription', 52, 'delete_subscription'),
(159, 'Can add kv store', 53, 'add_kvstore'),
(160, 'Can change kv store', 53, 'change_kvstore'),
(161, 'Can delete kv store', 53, 'delete_kvstore'),
(162, 'Can add article', 54, 'add_article'),
(163, 'Can change article', 54, 'change_article'),
(164, 'Can delete article', 54, 'delete_article'),
(165, 'Can edit all articles and lock/unlock/restore', 54, 'moderate'),
(166, 'Can change ownership of any article', 54, 'assign'),
(167, 'Can assign permissions to other users', 54, 'grant'),
(168, 'Can add Article for object', 55, 'add_articleforobject'),
(169, 'Can change Article for object', 55, 'change_articleforobject'),
(170, 'Can delete Article for object', 55, 'delete_articleforobject'),
(171, 'Can add article plugin', 56, 'add_articleplugin'),
(172, 'Can change article plugin', 56, 'change_articleplugin'),
(173, 'Can delete article plugin', 56, 'delete_articleplugin'),
(174, 'Can add article revision', 57, 'add_articlerevision'),
(175, 'Can change article revision', 57, 'change_articlerevision'),
(176, 'Can delete article revision', 57, 'delete_articlerevision'),
(177, 'Can add reusable plugin', 58, 'add_reusableplugin'),
(178, 'Can change reusable plugin', 58, 'change_reusableplugin'),
(179, 'Can delete reusable plugin', 58, 'delete_reusableplugin'),
(180, 'Can add revision plugin', 59, 'add_revisionplugin'),
(181, 'Can change revision plugin', 59, 'change_revisionplugin'),
(182, 'Can delete revision plugin', 59, 'delete_revisionplugin'),
(183, 'Can add revision plugin revision', 60, 'add_revisionpluginrevision'),
(184, 'Can change revision plugin revision', 60, 'change_revisionpluginrevision'),
(185, 'Can delete revision plugin revision', 60, 'delete_revisionpluginrevision'),
(186, 'Can add simple plugin', 61, 'add_simpleplugin'),
(187, 'Can change simple plugin', 61, 'change_simpleplugin'),
(188, 'Can delete simple plugin', 61, 'delete_simpleplugin'),
(189, 'Can add URL path', 62, 'add_urlpath'),
(190, 'Can change URL path', 62, 'change_urlpath'),
(191, 'Can delete URL path', 62, 'delete_urlpath'),
(192, 'Can add attachment', 63, 'add_attachment'),
(193, 'Can change attachment', 63, 'change_attachment'),
(194, 'Can delete attachment', 63, 'delete_attachment'),
(195, 'Can add attachment revision', 64, 'add_attachmentrevision'),
(196, 'Can change attachment revision', 64, 'change_attachmentrevision'),
(197, 'Can delete attachment revision', 64, 'delete_attachmentrevision'),
(198, 'Can add article subscription', 65, 'add_articlesubscription'),
(199, 'Can change article subscription', 65, 'change_articlesubscription'),
(200, 'Can delete article subscription', 65, 'delete_articlesubscription'),
(201, 'Can add image', 66, 'add_image'),
(202, 'Can change image', 66, 'change_image'),
(203, 'Can delete image', 66, 'delete_image'),
(204, 'Can add image revision', 67, 'add_imagerevision'),
(205, 'Can change image revision', 67, 'change_imagerevision'),
(206, 'Can delete image revision', 67, 'delete_imagerevision'),
(207, 'Can add article flag logs', 68, 'add_articleflaglogs'),
(208, 'Can change article flag logs', 68, 'change_articleflaglogs'),
(209, 'Can delete article flag logs', 68, 'delete_articleflaglogs'),
(210, 'Can add article score log', 69, 'add_articlescorelog'),
(211, 'Can change article score log', 69, 'change_articlescorelog'),
(212, 'Can delete article score log', 69, 'delete_articlescorelog'),
(213, 'Can add article user score logs', 70, 'add_articleuserscorelogs'),
(214, 'Can change article user score logs', 70, 'change_articleuserscorelogs'),
(215, 'Can delete article user score logs', 70, 'delete_articleuserscorelogs'),
(216, 'Can add community reputaion', 71, 'add_communityreputaion'),
(217, 'Can change community reputaion', 71, 'change_communityreputaion'),
(218, 'Can delete community reputaion', 71, 'delete_communityreputaion'),
(219, 'Can add flag reason', 72, 'add_flagreason'),
(220, 'Can change flag reason', 72, 'change_flagreason'),
(221, 'Can delete flag reason', 72, 'delete_flagreason'),
(222, 'Can add media flag logs', 73, 'add_mediaflaglogs'),
(223, 'Can change media flag logs', 73, 'change_mediaflaglogs'),
(224, 'Can delete media flag logs', 73, 'delete_mediaflaglogs'),
(225, 'Can add media score log', 74, 'add_mediascorelog'),
(226, 'Can change media score log', 74, 'change_mediascorelog'),
(227, 'Can delete media score log', 74, 'delete_mediascorelog'),
(228, 'Can add media user score logs', 75, 'add_mediauserscorelogs'),
(229, 'Can change media user score logs', 75, 'change_mediauserscorelogs'),
(230, 'Can delete media user score logs', 75, 'delete_mediauserscorelogs'),
(231, 'Can add resource score', 76, 'add_resourcescore'),
(232, 'Can change resource score', 76, 'change_resourcescore'),
(233, 'Can delete resource score', 76, 'delete_resourcescore'),
(234, 'Can add user score', 77, 'add_userscore'),
(235, 'Can change user score', 77, 'change_userscore'),
(236, 'Can delete user score', 77, 'delete_userscore'),
(237, 'Can add ether article', 78, 'add_etherarticle'),
(238, 'Can change ether article', 78, 'change_etherarticle'),
(239, 'Can delete ether article', 78, 'delete_etherarticle'),
(240, 'Can add ether community', 79, 'add_ethercommunity'),
(241, 'Can change ether community', 79, 'change_ethercommunity'),
(242, 'Can delete ether community', 79, 'delete_ethercommunity'),
(243, 'Can add ether group', 80, 'add_ethergroup'),
(244, 'Can change ether group', 80, 'change_ethergroup'),
(245, 'Can delete ether group', 80, 'delete_ethergroup'),
(246, 'Can add ether user', 81, 'add_etheruser'),
(247, 'Can change ether user', 81, 'change_etheruser'),
(248, 'Can delete ether user', 81, 'delete_etheruser'),
(249, 'Can add media', 82, 'add_media'),
(250, 'Can change media', 82, 'change_media'),
(251, 'Can delete media', 82, 'delete_media'),
(252, 'Can add metadata', 83, 'add_metadata'),
(253, 'Can change metadata', 83, 'change_metadata'),
(254, 'Can delete metadata', 83, 'delete_metadata'),
(255, 'Can add task', 84, 'add_task'),
(256, 'Can change task', 84, 'change_task'),
(257, 'Can delete task', 84, 'delete_task'),
(258, 'Can add badge', 85, 'add_badge'),
(259, 'Can change badge', 85, 'change_badge'),
(260, 'Can delete badge', 85, 'delete_badge'),
(261, 'Can add badge to user', 86, 'add_badgetouser'),
(262, 'Can change badge to user', 86, 'change_badgetouser'),
(263, 'Can delete badge to user', 86, 'delete_badgetouser'),
(264, 'Can add category', 87, 'add_category'),
(265, 'Can change category', 87, 'change_category'),
(266, 'Can delete category', 87, 'delete_category'),
(267, 'Can add Tag', 88, 'add_tag'),
(268, 'Can change Tag', 88, 'change_tag'),
(269, 'Can delete Tag', 88, 'delete_tag'),
(270, 'Can add Tagged Item', 89, 'add_taggeditem'),
(271, 'Can change Tagged Item', 89, 'change_taggeditem'),
(272, 'Can delete Tagged Item', 89, 'delete_taggeditem'),
(273, 'Can add Forum', 90, 'add_forum'),
(274, 'Can change Forum', 90, 'change_forum'),
(275, 'Can delete Forum', 90, 'delete_forum'),
(276, 'Can add Post', 91, 'add_post'),
(277, 'Can change Post', 91, 'change_post'),
(278, 'Can delete Post', 91, 'delete_post'),
(279, 'Can add Topic', 92, 'add_topic'),
(280, 'Can change Topic', 92, 'change_topic'),
(281, 'Can delete Topic', 92, 'delete_topic'),
(282, 'Can add Attachment', 93, 'add_attachment'),
(283, 'Can change Attachment', 93, 'change_attachment'),
(284, 'Can delete Attachment', 93, 'delete_attachment'),
(285, 'Can add Topic poll', 94, 'add_topicpoll'),
(286, 'Can change Topic poll', 94, 'change_topicpoll'),
(287, 'Can delete Topic poll', 94, 'delete_topicpoll'),
(288, 'Can add Topic poll option', 95, 'add_topicpolloption'),
(289, 'Can change Topic poll option', 95, 'change_topicpolloption'),
(290, 'Can delete Topic poll option', 95, 'delete_topicpolloption'),
(291, 'Can add Topic poll vote', 96, 'add_topicpollvote'),
(292, 'Can change Topic poll vote', 96, 'change_topicpollvote'),
(293, 'Can delete Topic poll vote', 96, 'delete_topicpollvote'),
(294, 'Can add Forum track', 97, 'add_forumreadtrack'),
(295, 'Can change Forum track', 97, 'change_forumreadtrack'),
(296, 'Can delete Forum track', 97, 'delete_forumreadtrack'),
(297, 'Can add Topic track', 98, 'add_topicreadtrack'),
(298, 'Can change Topic track', 98, 'change_topicreadtrack'),
(299, 'Can delete Topic track', 98, 'delete_topicreadtrack'),
(300, 'Can add Forum profile', 99, 'add_forumprofile'),
(301, 'Can change Forum profile', 99, 'change_forumprofile'),
(302, 'Can delete Forum profile', 99, 'delete_forumprofile'),
(303, 'Can add Forum permission', 100, 'add_forumpermission'),
(304, 'Can change Forum permission', 100, 'change_forumpermission'),
(305, 'Can delete Forum permission', 100, 'delete_forumpermission'),
(306, 'Can add Group forum permission', 101, 'add_groupforumpermission'),
(307, 'Can change Group forum permission', 101, 'change_groupforumpermission'),
(308, 'Can delete Group forum permission', 101, 'delete_groupforumpermission'),
(309, 'Can add User forum permission', 102, 'add_userforumpermission'),
(310, 'Can change User forum permission', 102, 'change_userforumpermission'),
(311, 'Can delete User forum permission', 102, 'delete_userforumpermission');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$36000$r8CujTIffhma$jnmVmCO1tuc18NIMsZrwfrdyNnxCNmIAXB+9LdVkPsE=', '2019-02-26 07:49:08.166678', 1, 'admin', '', '', 'admin@mail.com', 1, 1, '2019-02-26 07:47:48.227174');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `badges_badge`
--

CREATE TABLE `badges_badge` (
  `id` varchar(255) NOT NULL,
  `level` varchar(1) NOT NULL,
  `icon` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `badges_badge`
--

INSERT INTO `badges_badge` (`id`, `level`, `icon`) VALUES
('contributor', '1', ''),
('publisher', '3', '');

-- --------------------------------------------------------

--
-- Table structure for table `badges_badgetouser`
--

CREATE TABLE `badges_badgetouser` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `badge_id` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `community_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `BasicArticle_articles`
--

CREATE TABLE `BasicArticle_articles` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text CHARACTER SET utf8,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `published_on` datetime(6) DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `published_by_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `BasicArticle_articleviewlogs`
--

CREATE TABLE `BasicArticle_articleviewlogs` (
  `id` int(11) NOT NULL,
  `ip` varchar(40) NOT NULL,
  `session` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Categories_category`
--

CREATE TABLE `Categories_category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `lft` int(10) UNSIGNED NOT NULL,
  `rght` int(10) UNSIGNED NOT NULL,
  `tree_id` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_community`
--

CREATE TABLE `Community_community` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `tag_line` varchar(500) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `forum_link` varchar(100) DEFAULT NULL,
  `forum` int(10) UNSIGNED DEFAULT NULL,
  `lft` int(10) UNSIGNED NOT NULL,
  `rght` int(10) UNSIGNED NOT NULL,
  `tree_id` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `image_thumbnail` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_communityarticles`
--

CREATE TABLE `Community_communityarticles` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `community_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_communitycourses`
--

CREATE TABLE `Community_communitycourses` (
  `id` int(11) NOT NULL,
  `community_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_communitygroups`
--

CREATE TABLE `Community_communitygroups` (
  `id` int(11) NOT NULL,
  `community_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_communitymedia`
--

CREATE TABLE `Community_communitymedia` (
  `id` int(11) NOT NULL,
  `community_id` int(11) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_communitymembership`
--

CREATE TABLE `Community_communitymembership` (
  `id` int(11) NOT NULL,
  `community_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Community_requestcommunitycreation`
--

CREATE TABLE `Community_requestcommunitycreation` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `desc` longtext NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `tag_line` varchar(500) DEFAULT NULL,
  `purpose` longtext NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `requestedby_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Course_course`
--

CREATE TABLE `Course_course` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Course_links`
--

CREATE TABLE `Course_links` (
  `id` int(11) NOT NULL,
  `link` varchar(300) NOT NULL,
  `desc` longtext NOT NULL,
  `types` varchar(300) DEFAULT NULL,
  `topics_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Course_topicarticle`
--

CREATE TABLE `Course_topicarticle` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `topics_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Course_topics`
--

CREATE TABLE `Course_topics` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `lft` int(10) UNSIGNED NOT NULL,
  `rght` int(10) UNSIGNED NOT NULL,
  `tree_id` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `course_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Course_videos`
--

CREATE TABLE `Course_videos` (
  `id` int(11) NOT NULL,
  `video` varchar(300) NOT NULL,
  `desc` longtext NOT NULL,
  `topics_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2019-02-26 07:49:42.065158', '1', 'Collaboration System', 1, '[{\"added\": {}}]', 90, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_comments`
--

CREATE TABLE `django_comments` (
  `id` int(11) NOT NULL,
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
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_comments_xtd_blacklisteddomain`
--

CREATE TABLE `django_comments_xtd_blacklisteddomain` (
  `id` int(11) NOT NULL,
  `domain` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_comments_xtd_xtdcomment`
--

CREATE TABLE `django_comments_xtd_xtdcomment` (
  `comment_ptr_id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `level` smallint(6) NOT NULL,
  `order` int(11) NOT NULL,
  `followup` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_comment_flags`
--

CREATE TABLE `django_comment_flags` (
  `id` int(11) NOT NULL,
  `flag` varchar(30) NOT NULL,
  `flag_date` datetime(6) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(47, 'actstream', 'action'),
(48, 'actstream', 'follow'),
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(30, 'authtoken', 'token'),
(85, 'badges', 'badge'),
(86, 'badges', 'badgetouser'),
(21, 'BasicArticle', 'articles'),
(22, 'BasicArticle', 'articleviewlogs'),
(87, 'Categories', 'category'),
(12, 'Community', 'community'),
(13, 'Community', 'communityarticles'),
(14, 'Community', 'communitycourses'),
(15, 'Community', 'communitygroups'),
(16, 'Community', 'communitymedia'),
(17, 'Community', 'communitymembership'),
(18, 'Community', 'requestcommunitycreation'),
(5, 'contenttypes', 'contenttype'),
(41, 'Course', 'course'),
(42, 'Course', 'links'),
(43, 'Course', 'topicarticle'),
(44, 'Course', 'topics'),
(45, 'Course', 'videos'),
(10, 'django_comments', 'comment'),
(11, 'django_comments', 'commentflag'),
(9, 'django_comments_xtd', 'blacklisteddomain'),
(8, 'django_comments_xtd', 'xtdcomment'),
(51, 'django_nyt', 'notification'),
(49, 'django_nyt', 'notificationtype'),
(50, 'django_nyt', 'settings'),
(52, 'django_nyt', 'subscription'),
(78, 'etherpad', 'etherarticle'),
(79, 'etherpad', 'ethercommunity'),
(80, 'etherpad', 'ethergroup'),
(81, 'etherpad', 'etheruser'),
(90, 'forum', 'forum'),
(93, 'forum_attachments', 'attachment'),
(91, 'forum_conversation', 'post'),
(92, 'forum_conversation', 'topic'),
(99, 'forum_member', 'forumprofile'),
(100, 'forum_permission', 'forumpermission'),
(101, 'forum_permission', 'groupforumpermission'),
(102, 'forum_permission', 'userforumpermission'),
(94, 'forum_polls', 'topicpoll'),
(95, 'forum_polls', 'topicpolloption'),
(96, 'forum_polls', 'topicpollvote'),
(97, 'forum_tracking', 'forumreadtrack'),
(98, 'forum_tracking', 'topicreadtrack'),
(23, 'Group', 'group'),
(24, 'Group', 'grouparticles'),
(25, 'Group', 'groupinvitations'),
(26, 'Group', 'groupmedia'),
(27, 'Group', 'groupmembership'),
(82, 'Media', 'media'),
(83, 'metadata', 'metadata'),
(46, 'notifications', 'notification'),
(68, 'Reputation', 'articleflaglogs'),
(69, 'Reputation', 'articlescorelog'),
(70, 'Reputation', 'articleuserscorelogs'),
(71, 'Reputation', 'communityreputaion'),
(72, 'Reputation', 'flagreason'),
(73, 'Reputation', 'mediaflaglogs'),
(74, 'Reputation', 'mediascorelog'),
(75, 'Reputation', 'mediauserscorelogs'),
(76, 'Reputation', 'resourcescore'),
(77, 'Reputation', 'userscore'),
(28, 'reversion', 'revision'),
(29, 'reversion', 'version'),
(6, 'sessions', 'session'),
(7, 'sites', 'site'),
(33, 'social_django', 'association'),
(34, 'social_django', 'code'),
(35, 'social_django', 'nonce'),
(37, 'social_django', 'partial'),
(36, 'social_django', 'usersocialauth'),
(88, 'taggit', 'tag'),
(89, 'taggit', 'taggeditem'),
(84, 'TaskQueue', 'task'),
(53, 'thumbnail', 'kvstore'),
(19, 'UserRolesPermission', 'favourite'),
(20, 'UserRolesPermission', 'profileimage'),
(39, 'webcontent', 'faq'),
(40, 'webcontent', 'faqcategory'),
(38, 'webcontent', 'feedback'),
(54, 'wiki', 'article'),
(55, 'wiki', 'articleforobject'),
(56, 'wiki', 'articleplugin'),
(57, 'wiki', 'articlerevision'),
(58, 'wiki', 'reusableplugin'),
(59, 'wiki', 'revisionplugin'),
(60, 'wiki', 'revisionpluginrevision'),
(61, 'wiki', 'simpleplugin'),
(62, 'wiki', 'urlpath'),
(63, 'wiki_attachments', 'attachment'),
(64, 'wiki_attachments', 'attachmentrevision'),
(66, 'wiki_images', 'image'),
(67, 'wiki_images', 'imagerevision'),
(65, 'wiki_notifications', 'articlesubscription'),
(31, 'workflow', 'states'),
(32, 'workflow', 'transitions');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2019-02-26 07:41:26.492337'),
(2, 'taggit', '0001_initial', '2019-02-26 07:41:29.032338'),
(3, 'taggit', '0002_auto_20150616_2121', '2019-02-26 07:41:29.450448'),
(4, 'workflow', '0001_initial', '2019-02-26 07:41:32.106100'),
(5, 'auth', '0001_initial', '2019-02-26 07:41:41.338858'),
(6, 'BasicArticle', '0001_initial', '2019-02-26 07:41:45.857438'),
(7, 'BasicArticle', '0002_articles_tags', '2019-02-26 07:41:45.926853'),
(8, 'Categories', '0001_initial', '2019-02-26 07:41:48.689139'),
(9, 'contenttypes', '0002_remove_content_type_name', '2019-02-26 07:41:49.859244'),
(10, 'auth', '0002_alter_permission_name_max_length', '2019-02-26 07:41:49.992798'),
(11, 'auth', '0003_alter_user_email_max_length', '2019-02-26 07:41:50.126212'),
(12, 'auth', '0004_alter_user_username_opts', '2019-02-26 07:41:50.182471'),
(13, 'auth', '0005_alter_user_last_login_null', '2019-02-26 07:41:50.802683'),
(14, 'auth', '0006_require_contenttypes_0002', '2019-02-26 07:41:50.852661'),
(15, 'auth', '0007_alter_validators_add_error_messages', '2019-02-26 07:41:50.905140'),
(16, 'auth', '0008_alter_user_username_max_length', '2019-02-26 07:41:51.045395'),
(17, 'Media', '0001_initial', '2019-02-26 07:41:54.052495'),
(18, 'Group', '0001_initial', '2019-02-26 07:42:09.278893'),
(19, 'Course', '0001_initial', '2019-02-26 07:42:21.130104'),
(20, 'Community', '0001_initial', '2019-02-26 07:42:32.039342'),
(21, 'Community', '0002_auto_20181224_0729', '2019-02-26 07:42:48.160860'),
(22, 'Community', '0003_auto_20190204_1241', '2019-02-26 07:42:48.353985'),
(23, 'Community', '0004_auto_20190205_1144', '2019-02-26 07:42:54.612570'),
(24, 'Community', '0005_community_image_thumbnail', '2019-02-26 07:42:55.632035'),
(25, 'metadata', '0001_initial', '2019-02-26 07:42:58.847303'),
(26, 'metadata', '0002_auto_20190218_1005', '2019-02-26 07:43:00.425941'),
(27, 'Media', '0002_media_medialink', '2019-02-26 07:43:01.270782'),
(28, 'Media', '0003_media_metadata', '2019-02-26 07:43:03.133721'),
(29, 'Reputation', '0001_initial', '2019-02-26 07:43:21.267059'),
(30, 'TaskQueue', '0001_initial', '2019-02-26 07:43:21.712524'),
(31, 'UserRolesPermission', '0001_initial', '2019-02-26 07:43:24.257755'),
(32, 'actstream', '0001_initial', '2019-02-26 07:43:32.342677'),
(33, 'actstream', '0002_remove_action_data', '2019-02-26 07:43:32.384598'),
(34, 'admin', '0001_initial', '2019-02-26 07:43:34.414618'),
(35, 'admin', '0002_logentry_remove_auto_add', '2019-02-26 07:43:34.699539'),
(36, 'authtoken', '0001_initial', '2019-02-26 07:43:35.984739'),
(37, 'authtoken', '0002_auto_20160226_1747', '2019-02-26 07:43:37.171457'),
(38, 'badges', '0001_initial', '2019-02-26 07:43:37.213251'),
(39, 'badges', '0002_auto_20150513_0429', '2019-02-26 07:43:39.910836'),
(40, 'badges', '0003_badgetouser_community', '2019-02-26 07:43:41.498222'),
(41, 'sites', '0001_initial', '2019-02-26 07:43:41.859103'),
(42, 'django_comments', '0001_initial', '2019-02-26 07:43:48.012129'),
(43, 'django_comments', '0002_update_user_email_field_length', '2019-02-26 07:43:48.189025'),
(44, 'django_comments', '0003_add_submit_date_index', '2019-02-26 07:43:48.505631'),
(45, 'django_comments_xtd', '0001_initial', '2019-02-26 07:43:50.476377'),
(46, 'django_comments_xtd', '0002_blacklisteddomain', '2019-02-26 07:43:51.236118'),
(47, 'django_comments_xtd', '0003_auto_20170220_1333', '2019-02-26 07:43:51.294082'),
(48, 'django_comments_xtd', '0004_auto_20170221_1510', '2019-02-26 07:43:51.350416'),
(49, 'django_comments_xtd', '0005_auto_20170920_1247', '2019-02-26 07:43:51.413003'),
(50, 'django_nyt', '0001_initial', '2019-02-26 07:43:52.648603'),
(51, 'django_nyt', '0002_notification_settings', '2019-02-26 07:43:54.168083'),
(52, 'django_nyt', '0003_subscription', '2019-02-26 07:43:57.343252'),
(53, 'django_nyt', '0004_notification_subscription', '2019-02-26 07:43:58.829174'),
(54, 'django_nyt', '0005__v_0_9_2', '2019-02-26 07:44:05.865184'),
(55, 'django_nyt', '0006_auto_20141229_1630', '2019-02-26 07:44:07.067140'),
(56, 'django_nyt', '0007_add_modified_and_default_settings', '2019-02-26 07:44:08.464175'),
(57, 'django_nyt', '0008_auto_20161023_1641', '2019-02-26 07:44:11.479821'),
(58, 'etherpad', '0001_initial', '2019-02-26 07:44:16.348977'),
(59, 'forum', '0001_initial', '2019-02-26 07:44:20.090416'),
(60, 'forum_conversation', '0001_initial', '2019-02-26 07:44:29.521586'),
(61, 'forum_conversation', '0002_post_anonymous_key', '2019-02-26 07:44:30.283029'),
(62, 'forum_conversation', '0003_auto_20160228_2051', '2019-02-26 07:44:30.395129'),
(63, 'forum_conversation', '0004_auto_20160427_0502', '2019-02-26 07:44:32.469261'),
(64, 'forum_conversation', '0005_auto_20160607_0455', '2019-02-26 07:44:33.163204'),
(65, 'forum_conversation', '0006_post_enable_signature', '2019-02-26 07:44:34.265613'),
(66, 'forum_conversation', '0007_auto_20160903_0450', '2019-02-26 07:44:38.033489'),
(67, 'forum_conversation', '0008_auto_20160903_0512', '2019-02-26 07:44:38.132767'),
(68, 'forum_conversation', '0009_auto_20160925_2126', '2019-02-26 07:44:38.209165'),
(69, 'forum_conversation', '0010_auto_20170120_0224', '2019-02-26 07:44:39.645125'),
(70, 'forum', '0002_auto_20150725_0512', '2019-02-26 07:44:39.703364'),
(71, 'forum', '0003_remove_forum_is_active', '2019-02-26 07:44:40.564074'),
(72, 'forum', '0004_auto_20170504_2108', '2019-02-26 07:44:42.270841'),
(73, 'forum', '0005_auto_20170504_2113', '2019-02-26 07:44:42.366941'),
(74, 'forum', '0006_auto_20170523_2036', '2019-02-26 07:44:44.081771'),
(75, 'forum', '0007_auto_20170523_2140', '2019-02-26 07:44:44.187242'),
(76, 'forum', '0008_forum_last_post', '2019-02-26 07:44:45.952930'),
(77, 'forum', '0009_auto_20170928_2327', '2019-02-26 07:44:46.052430'),
(78, 'forum_attachments', '0001_initial', '2019-02-26 07:44:47.080605'),
(79, 'forum_member', '0001_initial', '2019-02-26 07:44:48.367580'),
(80, 'forum_member', '0002_auto_20160225_0515', '2019-02-26 07:44:48.462005'),
(81, 'forum_member', '0003_auto_20160227_2122', '2019-02-26 07:44:48.541383'),
(82, 'forum_permission', '0001_initial', '2019-02-26 07:44:55.894577'),
(83, 'forum_permission', '0002_auto_20160607_0500', '2019-02-26 07:44:57.389034'),
(84, 'forum_permission', '0003_remove_forumpermission_name', '2019-02-26 07:44:58.132573'),
(85, 'forum_polls', '0001_initial', '2019-02-26 07:45:02.425912'),
(86, 'forum_polls', '0002_auto_20151105_0029', '2019-02-26 07:45:04.623388'),
(87, 'forum_tracking', '0001_initial', '2019-02-26 07:45:09.284099'),
(88, 'forum_tracking', '0002_auto_20160607_0502', '2019-02-26 07:45:10.128895'),
(89, 'notifications', '0001_initial', '2019-02-26 07:45:14.137945'),
(90, 'notifications', '0002_auto_20150224_1134', '2019-02-26 07:45:15.759730'),
(91, 'notifications', '0003_notification_data', '2019-02-26 07:45:16.577030'),
(92, 'notifications', '0004_auto_20150826_1508', '2019-02-26 07:45:16.752698'),
(93, 'notifications', '0005_auto_20160504_1520', '2019-02-26 07:45:16.888103'),
(94, 'notifications', '0006_indexes', '2019-02-26 07:45:18.254944'),
(95, 'reversion', '0001_initial', '2019-02-26 07:45:22.089041'),
(96, 'reversion', '0002_auto_20141216_1509', '2019-02-26 07:45:22.130714'),
(97, 'reversion', '0003_auto_20160601_1600', '2019-02-26 07:45:22.188958'),
(98, 'reversion', '0004_auto_20160611_1202', '2019-02-26 07:45:22.230512'),
(99, 'sessions', '0001_initial', '2019-02-26 07:45:22.823877'),
(100, 'sites', '0002_alter_domain_unique', '2019-02-26 07:45:23.108265'),
(101, 'default', '0001_initial', '2019-02-26 07:45:26.549143'),
(102, 'social_auth', '0001_initial', '2019-02-26 07:45:26.599468'),
(103, 'default', '0002_add_related_name', '2019-02-26 07:45:27.577108'),
(104, 'social_auth', '0002_add_related_name', '2019-02-26 07:45:27.610293'),
(105, 'default', '0003_alter_email_max_length', '2019-02-26 07:45:28.019857'),
(106, 'social_auth', '0003_alter_email_max_length', '2019-02-26 07:45:28.053333'),
(107, 'default', '0004_auto_20160423_0400', '2019-02-26 07:45:28.131117'),
(108, 'social_auth', '0004_auto_20160423_0400', '2019-02-26 07:45:28.169443'),
(109, 'social_auth', '0005_auto_20160727_2333', '2019-02-26 07:45:28.452965'),
(110, 'social_django', '0006_partial', '2019-02-26 07:45:29.029389'),
(111, 'social_django', '0007_code_timestamp', '2019-02-26 07:45:30.081749'),
(112, 'social_django', '0008_partial_timestamp', '2019-02-26 07:45:31.051186'),
(113, 'thumbnail', '0001_initial', '2019-02-26 07:45:31.389462'),
(114, 'webcontent', '0001_initial', '2019-02-26 07:45:32.056620'),
(115, 'webcontent', '0002_auto_20180124_1328', '2019-02-26 07:45:34.033219'),
(116, 'webcontent', '0003_auto_20180124_1452', '2019-02-26 07:45:35.486687'),
(117, 'webcontent', '0004_delete_faq', '2019-02-26 07:45:35.695460'),
(118, 'webcontent', '0005_faq', '2019-02-26 07:45:36.033789'),
(119, 'webcontent', '0006_faqcategory', '2019-02-26 07:45:36.341167'),
(120, 'webcontent', '0007_remove_faq_category', '2019-02-26 07:45:36.924524'),
(121, 'webcontent', '0008_faq_category', '2019-02-26 07:45:38.284867'),
(122, 'webcontent', '0009_faq_order', '2019-02-26 07:45:38.812470'),
(123, 'webcontent', '0010_remove_faq_order', '2019-02-26 07:45:39.371786'),
(124, 'webcontent', '0011_faq_order', '2019-02-26 07:45:40.015671'),
(125, 'webcontent', '0012_auto_20180125_1628', '2019-02-26 07:45:40.766945'),
(126, 'webcontent', '0013_auto_20180125_1634', '2019-02-26 07:45:41.760222'),
(127, 'webcontent', '0014_auto_20180125_1636', '2019-02-26 07:45:41.903136'),
(128, 'webcontent', '0015_auto_20180125_1643', '2019-02-26 07:45:42.713092'),
(129, 'wiki', '0001_initial', '2019-02-26 07:46:20.852399'),
(130, 'wiki', '0002_urlpath_moved_to', '2019-02-26 07:46:23.248390'),
(131, 'wiki_attachments', '0001_initial', '2019-02-26 07:46:29.304235'),
(132, 'wiki_attachments', '0002_auto_20151118_1816', '2019-02-26 07:46:29.373945'),
(133, 'wiki_images', '0001_initial', '2019-02-26 07:46:31.942550'),
(134, 'wiki_images', '0002_auto_20151118_1811', '2019-02-26 07:46:32.044721'),
(135, 'wiki_notifications', '0001_initial', '2019-02-26 07:46:34.491264'),
(136, 'wiki_notifications', '0002_auto_20151118_1811', '2019-02-26 07:46:34.546877'),
(137, 'workflow', '0002_auto_20190110_1419', '2019-02-26 07:46:35.795909'),
(138, 'reversion', '0001_squashed_0004_auto_20160611_1202', '2019-02-26 07:46:35.849356'),
(139, 'social_django', '0001_initial', '2019-02-26 07:46:35.894827'),
(140, 'social_django', '0004_auto_20160423_0400', '2019-02-26 07:46:35.936257'),
(141, 'social_django', '0005_auto_20160727_2333', '2019-02-26 07:46:35.994715'),
(142, 'social_django', '0003_alter_email_max_length', '2019-02-26 07:46:36.060426'),
(143, 'social_django', '0002_add_related_name', '2019-02-26 07:46:36.102235');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('9w2571ejkpm8tsta0qsvxksoyshao8gq', 'ZDZkN2YyZTc0YWFhMmU2MjlhZGY5N2FjNWMxYzA4NjBjZTdiYTJiMDp7Il9hbm9ueW1vdXNfZm9ydW1fa2V5IjoiNGIzMDNmNjlmZjAwNDMxYWE1MTg1ODE3Mjc2Y2IwMWMiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZWIzMGMxOWMxOWUyNjAwYWI0M2QxNmNjYzg5YmQ2N2JjMTI4NTcwZCJ9', '2019-02-26 09:52:01.871653');

-- --------------------------------------------------------

--
-- Table structure for table `django_site`
--

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `django_site`
--

INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES
(1, 'example.com', 'example.com');

-- --------------------------------------------------------

--
-- Table structure for table `etherpad_etherarticle`
--

CREATE TABLE `etherpad_etherarticle` (
  `id` int(11) NOT NULL,
  `article_ether_id` longtext NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `etherpad_ethercommunity`
--

CREATE TABLE `etherpad_ethercommunity` (
  `id` int(11) NOT NULL,
  `community_ether_id` longtext NOT NULL,
  `community_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `etherpad_ethergroup`
--

CREATE TABLE `etherpad_ethergroup` (
  `id` int(11) NOT NULL,
  `group_ether_id` longtext NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `etherpad_etheruser`
--

CREATE TABLE `etherpad_etheruser` (
  `id` int(11) NOT NULL,
  `user_ether_id` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_attachments_attachment`
--

CREATE TABLE `forum_attachments_attachment` (
  `id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `post_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_conversation_post`
--

CREATE TABLE `forum_conversation_post` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `poster_ip` char(39) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `username` varchar(155) DEFAULT NULL,
  `approved` tinyint(1) NOT NULL,
  `update_reason` varchar(255) DEFAULT NULL,
  `updates_count` int(10) UNSIGNED NOT NULL,
  `_content_rendered` longtext,
  `poster_id` int(11) DEFAULT NULL,
  `topic_id` int(11) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `anonymous_key` varchar(100) DEFAULT NULL,
  `enable_signature` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_conversation_topic`
--

CREATE TABLE `forum_conversation_topic` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL,
  `status` int(10) UNSIGNED NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `posts_count` int(10) UNSIGNED NOT NULL,
  `views_count` int(10) UNSIGNED NOT NULL,
  `last_post_on` datetime(6) DEFAULT NULL,
  `forum_id` int(11) NOT NULL,
  `poster_id` int(11) DEFAULT NULL,
  `first_post_id` int(11) DEFAULT NULL,
  `last_post_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_conversation_topic_subscribers`
--

CREATE TABLE `forum_conversation_topic_subscribers` (
  `id` int(11) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_forum`
--

CREATE TABLE `forum_forum` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext,
  `image` varchar(100) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `link_redirects` tinyint(1) NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL,
  `link_redirects_count` int(10) UNSIGNED NOT NULL,
  `last_post_on` datetime(6) DEFAULT NULL,
  `display_sub_forum_list` tinyint(1) NOT NULL,
  `_description_rendered` longtext,
  `lft` int(10) UNSIGNED NOT NULL,
  `rght` int(10) UNSIGNED NOT NULL,
  `tree_id` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `direct_posts_count` int(10) UNSIGNED NOT NULL,
  `direct_topics_count` int(10) UNSIGNED NOT NULL,
  `last_post_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forum_forum`
--

INSERT INTO `forum_forum` (`id`, `created`, `updated`, `name`, `slug`, `description`, `image`, `link`, `link_redirects`, `type`, `link_redirects_count`, `last_post_on`, `display_sub_forum_list`, `_description_rendered`, `lft`, `rght`, `tree_id`, `level`, `parent_id`, `direct_posts_count`, `direct_topics_count`, `last_post_id`) VALUES
(1, '2019-02-26 07:49:42.059228', '2019-02-26 07:49:42.059279', 'Collaboration System', 'collaboration-system', '', '', NULL, 0, 0, 0, NULL, 1, '<p></p>', 1, 2, 1, 0, NULL, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `forum_member_forumprofile`
--

CREATE TABLE `forum_member_forumprofile` (
  `id` int(11) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `signature` longtext,
  `posts_count` int(10) UNSIGNED NOT NULL,
  `_signature_rendered` longtext,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_permission_forumpermission`
--

CREATE TABLE `forum_permission_forumpermission` (
  `id` int(11) NOT NULL,
  `codename` varchar(150) NOT NULL,
  `is_global` tinyint(1) NOT NULL,
  `is_local` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forum_permission_forumpermission`
--

INSERT INTO `forum_permission_forumpermission` (`id`, `codename`, `is_global`, `is_local`) VALUES
(1, 'can_see_forum', 1, 1),
(2, 'can_read_forum', 1, 1),
(3, 'can_start_new_topics', 1, 1),
(4, 'can_reply_to_topics', 1, 1),
(5, 'can_post_announcements', 1, 1),
(6, 'can_post_stickies', 1, 1),
(7, 'can_delete_own_posts', 1, 1),
(8, 'can_edit_own_posts', 1, 1),
(9, 'can_post_without_approval', 1, 1),
(10, 'can_create_polls', 1, 1),
(11, 'can_vote_in_polls', 1, 1),
(12, 'can_attach_file', 1, 1),
(13, 'can_download_file', 1, 1),
(14, 'can_lock_topics', 0, 1),
(15, 'can_move_topics', 0, 1),
(16, 'can_edit_posts', 0, 1),
(17, 'can_delete_posts', 0, 1),
(18, 'can_approve_posts', 0, 1),
(19, 'can_reply_to_locked_topics', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `forum_permission_groupforumpermission`
--

CREATE TABLE `forum_permission_groupforumpermission` (
  `id` int(11) NOT NULL,
  `has_perm` tinyint(1) NOT NULL,
  `forum_id` int(11) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forum_permission_groupforumpermission`
--

INSERT INTO `forum_permission_groupforumpermission` (`id`, `has_perm`, `forum_id`, `group_id`, `permission_id`) VALUES
(1, 1, NULL, 1, 2),
(2, 1, NULL, 1, 1),
(3, 1, NULL, 1, 7),
(4, 1, NULL, 1, 8),
(5, 1, NULL, 1, 9),
(6, 1, NULL, 1, 4),
(7, 1, NULL, 1, 3),
(8, 1, NULL, 2, 2),
(9, 1, NULL, 2, 1),
(10, 1, NULL, 2, 7),
(11, 1, NULL, 2, 8),
(12, 1, NULL, 2, 9),
(13, 1, NULL, 2, 4),
(14, 1, NULL, 2, 3),
(15, 1, NULL, 3, 2),
(16, 1, NULL, 3, 1),
(17, 1, NULL, 3, 7),
(18, 1, NULL, 3, 8),
(19, 1, NULL, 3, 5),
(20, 1, NULL, 3, 6),
(21, 1, NULL, 3, 9),
(22, 1, NULL, 3, 4),
(23, 1, NULL, 3, 3),
(24, 1, NULL, 3, 10),
(25, 1, NULL, 3, 11);

-- --------------------------------------------------------

--
-- Table structure for table `forum_permission_userforumpermission`
--

CREATE TABLE `forum_permission_userforumpermission` (
  `id` int(11) NOT NULL,
  `has_perm` tinyint(1) NOT NULL,
  `anonymous_user` tinyint(1) NOT NULL,
  `forum_id` int(11) DEFAULT NULL,
  `permission_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `forum_permission_userforumpermission`
--

INSERT INTO `forum_permission_userforumpermission` (`id`, `has_perm`, `anonymous_user`, `forum_id`, `permission_id`, `user_id`) VALUES
(1, 1, 1, NULL, 2, NULL),
(2, 1, 1, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `forum_polls_topicpoll`
--

CREATE TABLE `forum_polls_topicpoll` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `question` varchar(255) NOT NULL,
  `duration` int(10) UNSIGNED DEFAULT NULL,
  `max_options` smallint(5) UNSIGNED NOT NULL,
  `user_changes` tinyint(1) NOT NULL,
  `topic_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_polls_topicpolloption`
--

CREATE TABLE `forum_polls_topicpolloption` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `poll_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_polls_topicpollvote`
--

CREATE TABLE `forum_polls_topicpollvote` (
  `id` int(11) NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  `poll_option_id` int(11) NOT NULL,
  `voter_id` int(11) DEFAULT NULL,
  `anonymous_key` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_tracking_forumreadtrack`
--

CREATE TABLE `forum_tracking_forumreadtrack` (
  `id` int(11) NOT NULL,
  `mark_time` datetime(6) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `forum_tracking_topicreadtrack`
--

CREATE TABLE `forum_tracking_topicreadtrack` (
  `id` int(11) NOT NULL,
  `mark_time` datetime(6) NOT NULL,
  `topic_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Group_group`
--

CREATE TABLE `Group_group` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `desc` longtext NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `visibility` tinyint(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Group_grouparticles`
--

CREATE TABLE `Group_grouparticles` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Group_groupinvitations`
--

CREATE TABLE `Group_groupinvitations` (
  `id` int(11) NOT NULL,
  `invitedat` datetime(6) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  `invitedby_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Group_groupmedia`
--

CREATE TABLE `Group_groupmedia` (
  `id` int(11) NOT NULL,
  `group_id` int(11) DEFAULT NULL,
  `media_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Group_groupmembership`
--

CREATE TABLE `Group_groupmembership` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Media_media`
--

CREATE TABLE `Media_media` (
  `id` int(11) NOT NULL,
  `mediatype` varchar(10) NOT NULL,
  `title` varchar(100) NOT NULL,
  `mediafile` varchar(100) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `published_on` datetime(6) DEFAULT NULL,
  `views` int(10) UNSIGNED NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `published_by_id` int(11) DEFAULT NULL,
  `state_id` int(11) DEFAULT NULL,
  `medialink` varchar(300) DEFAULT NULL,
  `metadata_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `metadata_metadata`
--

CREATE TABLE `metadata_metadata` (
  `id` int(11) NOT NULL,
  `description` text CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notifications_notification`
--

CREATE TABLE `notifications_notification` (
  `id` int(11) NOT NULL,
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
  `data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nyt_notification`
--

CREATE TABLE `nyt_notification` (
  `id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  `url` varchar(200) DEFAULT NULL,
  `is_viewed` tinyint(1) NOT NULL,
  `is_emailed` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `occurrences` int(10) UNSIGNED NOT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `modified` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nyt_notificationtype`
--

CREATE TABLE `nyt_notificationtype` (
  `key` varchar(128) NOT NULL,
  `label` varchar(128) DEFAULT NULL,
  `content_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nyt_settings`
--

CREATE TABLE `nyt_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `interval` smallint(6) NOT NULL,
  `is_default` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `nyt_subscription`
--

CREATE TABLE `nyt_subscription` (
  `id` int(11) NOT NULL,
  `settings_id` int(11) NOT NULL,
  `notification_type_id` varchar(128) NOT NULL,
  `object_id` varchar(64) DEFAULT NULL,
  `send_emails` tinyint(1) NOT NULL,
  `latest_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_articleflaglogs`
--

CREATE TABLE `Reputation_articleflaglogs` (
  `id` int(11) NOT NULL,
  `reason_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_articlescorelog`
--

CREATE TABLE `Reputation_articlescorelog` (
  `id` int(11) NOT NULL,
  `upvote` int(11) DEFAULT NULL,
  `downvote` int(11) DEFAULT NULL,
  `reported` int(11) DEFAULT NULL,
  `publish` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_articleuserscorelogs`
--

CREATE TABLE `Reputation_articleuserscorelogs` (
  `id` int(11) NOT NULL,
  `upvoted` tinyint(1) NOT NULL,
  `downvoted` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_communityreputaion`
--

CREATE TABLE `Reputation_communityreputaion` (
  `id` int(11) NOT NULL,
  `upvote_count` int(11) NOT NULL,
  `downvote_count` int(11) NOT NULL,
  `published_count` int(11) NOT NULL,
  `community_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_flagreason`
--

CREATE TABLE `Reputation_flagreason` (
  `id` int(11) NOT NULL,
  `reason` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_mediaflaglogs`
--

CREATE TABLE `Reputation_mediaflaglogs` (
  `id` int(11) NOT NULL,
  `reason_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_mediascorelog`
--

CREATE TABLE `Reputation_mediascorelog` (
  `id` int(11) NOT NULL,
  `upvote` int(11) DEFAULT NULL,
  `downvote` int(11) DEFAULT NULL,
  `reported` int(11) DEFAULT NULL,
  `publish` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_mediauserscorelogs`
--

CREATE TABLE `Reputation_mediauserscorelogs` (
  `id` int(11) NOT NULL,
  `upvoted` tinyint(1) NOT NULL,
  `downvoted` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `resource_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_resourcescore`
--

CREATE TABLE `Reputation_resourcescore` (
  `id` int(11) NOT NULL,
  `can_vote_unpublished` tinyint(1) NOT NULL,
  `upvote_value` int(11) DEFAULT NULL,
  `downvote_value` int(11) DEFAULT NULL,
  `can_report` tinyint(1) NOT NULL,
  `publish_value` int(11) DEFAULT NULL,
  `resource_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Reputation_userscore`
--

CREATE TABLE `Reputation_userscore` (
  `id` int(11) NOT NULL,
  `author` int(11) DEFAULT NULL,
  `publisher` int(11) DEFAULT NULL,
  `role_score` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reversion_revision`
--

CREATE TABLE `reversion_revision` (
  `id` int(11) NOT NULL,
  `date_created` datetime(6) NOT NULL,
  `comment` longtext NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reversion_version`
--

CREATE TABLE `reversion_version` (
  `id` int(11) NOT NULL,
  `object_id` varchar(191) NOT NULL,
  `format` varchar(255) NOT NULL,
  `serialized_data` longtext NOT NULL,
  `object_repr` longtext NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `db` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_association`
--

CREATE TABLE `social_auth_association` (
  `id` int(11) NOT NULL,
  `server_url` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `secret` varchar(255) NOT NULL,
  `issued` int(11) NOT NULL,
  `lifetime` int(11) NOT NULL,
  `assoc_type` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_code`
--

CREATE TABLE `social_auth_code` (
  `id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `code` varchar(32) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `timestamp` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_nonce`
--

CREATE TABLE `social_auth_nonce` (
  `id` int(11) NOT NULL,
  `server_url` varchar(255) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `salt` varchar(65) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_partial`
--

CREATE TABLE `social_auth_partial` (
  `id` int(11) NOT NULL,
  `token` varchar(32) NOT NULL,
  `next_step` smallint(5) UNSIGNED NOT NULL,
  `backend` varchar(32) NOT NULL,
  `data` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `social_auth_usersocialauth`
--

CREATE TABLE `social_auth_usersocialauth` (
  `id` int(11) NOT NULL,
  `provider` varchar(32) NOT NULL,
  `uid` varchar(255) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `taggit_tag`
--

CREATE TABLE `taggit_tag` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `taggit_taggeditem`
--

CREATE TABLE `taggit_taggeditem` (
  `id` int(11) NOT NULL,
  `object_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `TaskQueue_task`
--

CREATE TABLE `TaskQueue_task` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `tfile` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `thumbnail_kvstore`
--

CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `UserRolesPermission_favourite`
--

CREATE TABLE `UserRolesPermission_favourite` (
  `id` int(11) NOT NULL,
  `resource` int(10) UNSIGNED NOT NULL,
  `category` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `UserRolesPermission_profileimage`
--

CREATE TABLE `UserRolesPermission_profileimage` (
  `id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `webcontent_faq`
--

CREATE TABLE `webcontent_faq` (
  `id` int(11) NOT NULL,
  `question` varchar(200) NOT NULL,
  `answer` longtext NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `flow` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `webcontent_faq`
--

INSERT INTO `webcontent_faq` (`id`, `question`, `answer`, `category_id`, `flow`) VALUES
(1, 'What are collaborative communities?', 'The portal for ‘Collaborative Communities’ will allow individual users to form communities, participate in various activities defined within the community, and thus, enhance its value for the society in terms of education.', 1, 1),
(2, 'Why do we need collaborative communities?', '‘Collaborative Communities’ helps us to know what other communities can offer and share resources  to achieve a common goal.', 1, 2),
(3, 'What type of collaborative communities will you find?', 'You will find communities from various education fields which come together and contribute to it.', 1, 3),
(4, 'What are the key features of collaborative communities?', 'Collaborative Communities allow a particular community to share resources and idea. It also increases the community awareness.', 1, 4),
(5, 'How to register on this website?', 'Click on \'Sign-Up\' button on the top right corner, and fill the required details as prompted.\r\n', 1, 5),
(6, 'I have forgotten my password. What should I do?', 'Click on forgot password message and enter your email id. You will receive a link to your email for resetting your password.', 1, 6),
(7, 'What is a community?', 'Set of people coming together to achieve a common goal by sharing ideas and information by performing various activities within it.', 2, 0.5),
(8, 'What is a group?', 'A group is nothing but a sub-community which is formed by a group of people of a particular community.', 3, 0.5),
(9, 'How to join a community? ', ' Navigate to \'Collaborative Communities\' homepage. Assuming that you have logged in, click ‘Communities’ and then click on any desired community. Click ‘Join us’\r\nYou will now be an \'Author\' in the community.\r\n', 2, 1),
(10, 'How to leave a community? ', 'Navigate to the desired community and click ‘Unsubscribe\' and follow the steps given on the screen. \r\n', 2, 2),
(11, 'How do I know which communities I am subscribed to? ', 'Assuming that you have logged in, click on your username > ‘Dashboard’. You will be able to see your subscribed communities under ‘My Communities’\r\n', 2, 3),
(12, 'Can I create a community?', 'No, you cannot create a community. In case you feel the need of a community and it does not make sense in creating a group under a community, only then you may request for creation of a community. You may do so by clicking your username and ‘Request community creation’. Fill the details and follow the instructions.', 2, 4),
(13, 'What are the different roles?', 'Roles are associated with a community and group. A community has (a) author, (b) publisher, and (c) community admin; while a group has (a) author, (b) publisher, and (c) group admin, i.e. a person can be an author in one community/group, a publisher in other, and admin in other. Each of these roles have some set of privileges.', 5, 1),
(14, 'Who is an author and what are the privileges?', 'An author is a member of a community or group who can contribute by creating resources like basic articles and groups in a community.', 5, 2),
(15, 'Who is a publisher and what are the privileges?', 'A publisher is a member of a community or group who has all the privileges as that of an author but is also responsible for publishing articles contributed by other authors in that community/group.', 5, 3),
(16, 'Who is an admin of community/group and what are the privileges?', 'An admin of a community or group has all the privileges as that of a publisher but is also responsible for maintaining the decorum of the community or group. He/she can edit the community/group information, change role of a member, and add or remove a member to/from community/group. <br /><br />\r\n\r\n<b>Note:</b> The person requesting for a community becomes the community admin of that community. The person who creates a group in the community becomes the group admin of that group.', 5, 4),
(17, 'Who can create a resource and how?', 'A resource is created in a community/group. Any member belonging to the community/group can create it. Go to the desired community/group and click \'Create Article\'. Fill up the ‘title’, ‘body’, and ‘image (optional)’, and click \'Create\'. Every resource created follows a workflow from its initial state to final (Publish) state. For more details, please refer to the questions in the \'Workflow\' category.', 5, 5),
(18, 'Who will publish my resource and when?', 'The publisher of the community/group publishes the resource. It will be published based on the states given in the workflow category.', 5, 6),
(19, 'I am a publisher of a community/group, can I publish a resource created by me?', 'No, a publisher cannot publish the resource created by him/her. Other publishers belonging to that community/group can publish it.', 5, 7),
(20, 'What is a workflow?', 'A workflow follows certain steps from initial state to the final state for a resource created by a member of community/group.', 6, 1),
(21, 'What workflow is followed in a community/group?', 'The workflow goes from \'Draft\' state to \'Visible, \'Publishable\', and finally \'Publish\' state in a community; while \'Draft\' to \'Private\', and finally \'Visible\' state in a group. To know more about the states, refer respective questions given below.', 6, 2),
(22, 'What is draft state?', 'When a resource is created, it is initially in this state. At this time only the person who has created it can view. This is true for community as well as group.', 6, 3),
(23, 'What is visible state?', 'This state belongs to community as well as group.\r\nIf a resource in the community is changed to \'Visible\' state, the resource can be viewed and edited by all members of the community. Whereas if the resource in a group is changed to \'Visible\' state, then all the members of the community can view it but cannot edit it.', 6, 4),
(24, 'What is publishable state?', 'This state only belongs to the resource created in the community. In this state the resource is only visible to the community members. The publisher of the community will publish it or reject it.', 6, 5),
(25, 'What is publish state?', 'In this state the resource is published and is visible to anonymous and authenticated users of the system as well. Once it is published then the resource cannot be edited by anyone.', 6, 6),
(26, 'What is the flow of the state and who is authorised for changing the states.', '', 6, 7),
(27, 'How do I know which groups I am subscribed to?', 'Assuming that you have logged in, click on your username > ‘Dashboard’. You will be able to see your subscribed communities under ‘My Groups’', 3, 2),
(29, 'What workflow is followed by a group? ', 'The workflow goes from \'Draft\' state to visible state in a group. To know about the states, refer respective questions given below. ', 3, 3),
(30, 'What is a draft state? ', 'When a resource is created, it is initially in this state. At this time only the person who has created it can view.', 3, 4),
(31, 'What is visible state? ', 'Content is visible to all members of the community.  Members can comment and edit it.', 3, 5),
(32, 'What are the responsibilities of group admin? ', 'Any community member who creates a group in that particular community becomes a group admin of that particular group. He/she has the right to add/remove people to and from the group and change roles of the group members. He/she can make article visible.', 3, 6),
(33, 'Information about a public group in a community and a private group in a community?', 'Community is always public and available for the authenticated user to join.  Public Group: There can be 0 to N public groups in a community. Any member of the community can create a public group and any member of the community can join it.  Private Group: There can be 0 to N private groups in a community. Any member of the community can create a private group but only invited members can join it.', 3, 7),
(37, 'What type of resource tools are available for use?', 'As of now, our portal has \'Basic Article\' as a tool to offer. We plan to offer other tools like video, audio, etc. as well, in our next release.', 4, 1),
(38, 'How to join a group?', 'Navigate to \'Collaborative Communities\' homepage. Assuming that you have logged in, click ‘Communities’ and then click on any desired community. You will see a list of groups in that community. Click on the desired group and click ‘Join us’ You will now be an \'Author\' in the group.', 3, 1),
(39, 'How to leave a group?', 'Navigate to the desired group and click ‘Unsubscribe\' and follow the steps given on the screen.', 3, 1.5),
(40, 'Can I create a group and how?', 'Yes, you can create a group under a community. Go to the desired community and check whether a similar group exists. Only if it does not exist, then you may create a group by clicking \'Create Group\'. Fill in the details and follow the instructions on the screen.', 3, 2.5),
(41, 'Can I edit a resource created by someone else', 'Yes, as name \'Collaborative Communities\' suggests you can edit and collaborate resources created by other members of your community/group.', 5, 8),
(42, 'Can I delete a resource', 'No, you cannot delete any resource, except the one which is created by you and is in its initial state (draft) only.', 5, 9),
(43, 'What is private state?', 'This state only belongs to a group. When a resource from \'Draft\' state is changed to \'Private\' state, it can be viewed by all members of the group.', 6, 3.5);

-- --------------------------------------------------------

--
-- Table structure for table `webcontent_faqcategory`
--

CREATE TABLE `webcontent_faqcategory` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `desc` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `webcontent_faqcategory`
--

INSERT INTO `webcontent_faqcategory` (`id`, `name`, `desc`) VALUES
(1, 'General', 'General faq question'),
(2, 'Community', 'Category for community faqs.'),
(3, 'Group', 'category for groups faq'),
(4, 'Resource', 'category for resource faqs'),
(5, 'Roles and Permissions', 'categories for roles'),
(6, 'Workflow', 'category for workflow');

-- --------------------------------------------------------

--
-- Table structure for table `webcontent_feedback`
--

CREATE TABLE `webcontent_feedback` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` longtext NOT NULL,
  `provided_at` datetime(6) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_article`
--

CREATE TABLE `wiki_article` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `modified` datetime(6) NOT NULL,
  `group_read` tinyint(1) NOT NULL,
  `group_write` tinyint(1) NOT NULL,
  `other_read` tinyint(1) NOT NULL,
  `other_write` tinyint(1) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wiki_article`
--

INSERT INTO `wiki_article` (`id`, `created`, `modified`, `group_read`, `group_write`, `other_read`, `other_write`, `current_revision_id`, `group_id`, `owner_id`) VALUES
(1, '2019-02-26 07:51:50.401999', '2019-02-26 07:51:50.698621', 1, 1, 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `wiki_articleforobject`
--

CREATE TABLE `wiki_articleforobject` (
  `id` int(11) NOT NULL,
  `object_id` int(10) UNSIGNED NOT NULL,
  `is_mptt` tinyint(1) NOT NULL,
  `article_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wiki_articleforobject`
--

INSERT INTO `wiki_articleforobject` (`id`, `object_id`, `is_mptt`, `article_id`, `content_type_id`) VALUES
(1, 1, 1, 1, 62);

-- --------------------------------------------------------

--
-- Table structure for table `wiki_articleplugin`
--

CREATE TABLE `wiki_articleplugin` (
  `id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_articlerevision`
--

CREATE TABLE `wiki_articlerevision` (
  `id` int(11) NOT NULL,
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
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wiki_articlerevision`
--

INSERT INTO `wiki_articlerevision` (`id`, `revision_number`, `user_message`, `automatic_log`, `ip_address`, `modified`, `created`, `deleted`, `locked`, `content`, `title`, `article_id`, `previous_revision_id`, `user_id`) VALUES
(1, 1, '', '', NULL, '2019-02-26 07:51:50.551101', '2019-02-26 07:51:50.551153', 0, 0, '', 'Collaboration System', 1, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `wiki_attachments_attachment`
--

CREATE TABLE `wiki_attachments_attachment` (
  `reusableplugin_ptr_id` int(11) NOT NULL,
  `original_filename` varchar(256) DEFAULT NULL,
  `current_revision_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_attachments_attachmentrevision`
--

CREATE TABLE `wiki_attachments_attachmentrevision` (
  `id` int(11) NOT NULL,
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
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_images_image`
--

CREATE TABLE `wiki_images_image` (
  `revisionplugin_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_images_imagerevision`
--

CREATE TABLE `wiki_images_imagerevision` (
  `revisionpluginrevision_ptr_id` int(11) NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `width` smallint(6) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_notifications_articlesubscription`
--

CREATE TABLE `wiki_notifications_articlesubscription` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_reusableplugin`
--

CREATE TABLE `wiki_reusableplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_reusableplugin_articles`
--

CREATE TABLE `wiki_reusableplugin_articles` (
  `id` int(11) NOT NULL,
  `reusableplugin_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_revisionplugin`
--

CREATE TABLE `wiki_revisionplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `current_revision_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_revisionpluginrevision`
--

CREATE TABLE `wiki_revisionpluginrevision` (
  `id` int(11) NOT NULL,
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
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_simpleplugin`
--

CREATE TABLE `wiki_simpleplugin` (
  `articleplugin_ptr_id` int(11) NOT NULL,
  `article_revision_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wiki_urlpath`
--

CREATE TABLE `wiki_urlpath` (
  `id` int(11) NOT NULL,
  `slug` varchar(50) DEFAULT NULL,
  `lft` int(10) UNSIGNED NOT NULL,
  `rght` int(10) UNSIGNED NOT NULL,
  `tree_id` int(10) UNSIGNED NOT NULL,
  `level` int(10) UNSIGNED NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `site_id` int(11) NOT NULL,
  `moved_to_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wiki_urlpath`
--

INSERT INTO `wiki_urlpath` (`id`, `slug`, `lft`, `rght`, `tree_id`, `level`, `article_id`, `parent_id`, `site_id`, `moved_to_id`) VALUES
(1, NULL, 1, 2, 1, 0, 1, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `workflow_states`
--

CREATE TABLE `workflow_states` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `desc` longtext,
  `final` tinyint(1) NOT NULL,
  `initial` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workflow_states`
--

INSERT INTO `workflow_states` (`id`, `name`, `desc`, `final`, `initial`) VALUES
(1, 'draft', 'save as draft state', 0, 0),
(2, 'visible', 'this state make the content visible to community', 0, 0),
(3, 'publish', 'save as visible state', 0, 0),
(4, 'private', 'this state make the content visible to group', 0, 0),
(5, 'publishable', 'this content makes the content ready for publishing', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `workflow_transitions`
--

CREATE TABLE `workflow_transitions` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `from_state_id` int(11) DEFAULT NULL,
  `to_state_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `workflow_transitions`
--

INSERT INTO `workflow_transitions` (`id`, `name`, `from_state_id`, `to_state_id`) VALUES
(1, 'Make Visible to Group', 1, 4),
(3, 'Make Visible to Community', 4, 2),
(4, 'Ready for Publishing', 2, 5),
(5, 'Publish', 5, 3),
(6, 'Publish', 5, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actstream_action`
--
ALTER TABLE `actstream_action`
  ADD PRIMARY KEY (`id`),
  ADD KEY `actstream_action_action_object_conten_ee623c15_fk_django_co` (`action_object_content_type_id`),
  ADD KEY `actstream_action_actor_content_type_i_d5e5ec2a_fk_django_co` (`actor_content_type_id`),
  ADD KEY `actstream_action_target_content_type__187fa164_fk_django_co` (`target_content_type_id`),
  ADD KEY `actstream_action_actor_object_id_72ef0cfa` (`actor_object_id`),
  ADD KEY `actstream_action_verb_83f768b7` (`verb`),
  ADD KEY `actstream_action_target_object_id_e080d801` (`target_object_id`),
  ADD KEY `actstream_action_action_object_object_id_6433bdf7` (`action_object_object_id`),
  ADD KEY `actstream_action_timestamp_a23fe3ae` (`timestamp`),
  ADD KEY `actstream_action_public_ac0653e9` (`public`);

--
-- Indexes for table `actstream_follow`
--
ALTER TABLE `actstream_follow`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `actstream_follow_user_id_content_type_id_object_id_63ca7c27_uniq` (`user_id`,`content_type_id`,`object_id`),
  ADD KEY `actstream_follow_content_type_id_ba287eb9_fk_django_co` (`content_type_id`),
  ADD KEY `actstream_follow_object_id_d790e00d` (`object_id`),
  ADD KEY `actstream_follow_started_254c63bd` (`started`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `badges_badge`
--
ALTER TABLE `badges_badge`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `badges_badgetouser`
--
ALTER TABLE `badges_badgetouser`
  ADD PRIMARY KEY (`id`),
  ADD KEY `badges_badgetouser_badge_id_0e3cd6bb_fk_badges_badge_id` (`badge_id`),
  ADD KEY `badges_badgetouser_user_id_7928b431_fk_auth_user_id` (`user_id`),
  ADD KEY `badges_badgetouser_community_id_01e9a7f7_fk_Community` (`community_id`);

--
-- Indexes for table `BasicArticle_articles`
--
ALTER TABLE `BasicArticle_articles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` (`created_by_id`),
  ADD KEY `BasicArticle_articles_published_by_id_81e5e785_fk_auth_user_id` (`published_by_id`),
  ADD KEY `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` (`state_id`);

--
-- Indexes for table `BasicArticle_articleviewlogs`
--
ALTER TABLE `BasicArticle_articleviewlogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `BasicArticle_article_article_id_164e59b4_fk_BasicArti` (`article_id`);

--
-- Indexes for table `Categories_category`
--
ALTER TABLE `Categories_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Categories_category_lft_ec4145b1` (`lft`),
  ADD KEY `Categories_category_rght_63642186` (`rght`),
  ADD KEY `Categories_category_tree_id_1d8ca4e7` (`tree_id`),
  ADD KEY `Categories_category_level_593703f5` (`level`),
  ADD KEY `Categories_category_parent_id_eee850a6` (`parent_id`);

--
-- Indexes for table `Community_community`
--
ALTER TABLE `Community_community`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_community_lft_d7f05a9b` (`lft`),
  ADD KEY `Community_community_rght_6dfec445` (`rght`),
  ADD KEY `Community_community_tree_id_bd4e2595` (`tree_id`),
  ADD KEY `Community_community_level_db58ba5f` (`level`),
  ADD KEY `Community_community_created_by_id_1080464d_fk_auth_user_id` (`created_by_id`),
  ADD KEY `Community_community_parent_id_47d0e58d` (`parent_id`),
  ADD KEY `Community_community_category_id_87e260b2` (`category_id`);

--
-- Indexes for table `Community_communityarticles`
--
ALTER TABLE `Community_communityarticles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_communitya_article_id_c9af3fed_fk_BasicArti` (`article_id`),
  ADD KEY `Community_communitya_community_id_39b5841f_fk_Community` (`community_id`),
  ADD KEY `Community_communityarticles_user_id_04d18793_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Community_communitycourses`
--
ALTER TABLE `Community_communitycourses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_communityc_community_id_db58cc7f_fk_Community` (`community_id`),
  ADD KEY `Community_communityc_course_id_1b9cc41b_fk_Course_co` (`course_id`),
  ADD KEY `Community_communitycourses_user_id_d3572caf_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Community_communitygroups`
--
ALTER TABLE `Community_communitygroups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_communityg_community_id_3e76934c_fk_Community` (`community_id`),
  ADD KEY `Community_communitygroups_group_id_a2ce7b35_fk_Group_group_id` (`group_id`),
  ADD KEY `Community_communitygroups_user_id_eaead89d_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Community_communitymedia`
--
ALTER TABLE `Community_communitymedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_communitym_community_id_3ff46a01_fk_Community` (`community_id`),
  ADD KEY `Community_communitymedia_media_id_e160518e_fk_Media_media_id` (`media_id`),
  ADD KEY `Community_communitymedia_user_id_97a38254_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Community_communitymembership`
--
ALTER TABLE `Community_communitymembership`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_communitym_community_id_8a39991d_fk_Community` (`community_id`),
  ADD KEY `Community_communitymembership_role_id_9c581fd0_fk_auth_group_id` (`role_id`),
  ADD KEY `Community_communitymembership_user_id_5dd1c26b_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Community_requestcommunitycreation`
--
ALTER TABLE `Community_requestcommunitycreation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Community_requestcom_requestedby_id_b3e83124_fk_auth_user` (`requestedby_id`),
  ADD KEY `Community_requestcommunitycreation_category_id_874787b7` (`category_id`);

--
-- Indexes for table `Course_course`
--
ALTER TABLE `Course_course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Course_course_created_by_id_696e3a4e_fk_auth_user_id` (`created_by_id`),
  ADD KEY `Course_course_state_id_77c858e0_fk_workflow_states_id` (`state_id`);

--
-- Indexes for table `Course_links`
--
ALTER TABLE `Course_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Course_links_topics_id_096bf6bd_fk_Course_topics_id` (`topics_id`);

--
-- Indexes for table `Course_topicarticle`
--
ALTER TABLE `Course_topicarticle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Course_topicarticle_article_id_2ab7af7f_fk_BasicArti` (`article_id`),
  ADD KEY `Course_topicarticle_topics_id_d20b76e7_fk_Course_topics_id` (`topics_id`);

--
-- Indexes for table `Course_topics`
--
ALTER TABLE `Course_topics`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Course_topics_course_id_9e18b74c_fk_Course_course_id` (`course_id`),
  ADD KEY `Course_topics_lft_90a2e5bc` (`lft`),
  ADD KEY `Course_topics_rght_01583e2c` (`rght`),
  ADD KEY `Course_topics_tree_id_b199de91` (`tree_id`),
  ADD KEY `Course_topics_level_a7ab2ea8` (`level`),
  ADD KEY `Course_topics_parent_id_adff4cae` (`parent_id`);

--
-- Indexes for table `Course_videos`
--
ALTER TABLE `Course_videos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Course_videos_topics_id_568227cc_fk_Course_topics_id` (`topics_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_comments`
--
ALTER TABLE `django_comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_comments_content_type_id_c4afe962_fk_django_co` (`content_type_id`),
  ADD KEY `django_comments_site_id_9dcf666e_fk_django_site_id` (`site_id`),
  ADD KEY `django_comments_user_id_a0a440a1_fk_auth_user_id` (`user_id`),
  ADD KEY `django_comments_submit_date_514ed2d9` (`submit_date`);

--
-- Indexes for table `django_comments_xtd_blacklisteddomain`
--
ALTER TABLE `django_comments_xtd_blacklisteddomain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_comments_xtd_blacklisteddomain_domain_43b81328` (`domain`);

--
-- Indexes for table `django_comments_xtd_xtdcomment`
--
ALTER TABLE `django_comments_xtd_xtdcomment`
  ADD PRIMARY KEY (`comment_ptr_id`),
  ADD KEY `django_comments_xtd_xtdcomment_thread_id_e192a27a` (`thread_id`),
  ADD KEY `django_comments_xtd_xtdcomment_order_36db562d` (`order`);

--
-- Indexes for table `django_comment_flags`
--
ALTER TABLE `django_comment_flags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_comment_flags_user_id_comment_id_flag_537f77a7_uniq` (`user_id`,`comment_id`,`flag`),
  ADD KEY `django_comment_flags_comment_id_d8054933_fk_django_comments_id` (`comment_id`),
  ADD KEY `django_comment_flags_flag_8b141fcb` (`flag`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `django_site`
--
ALTER TABLE `django_site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`);

--
-- Indexes for table `etherpad_etherarticle`
--
ALTER TABLE `etherpad_etherarticle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `etherpad_etherarticl_article_id_af7a9005_fk_BasicArti` (`article_id`);

--
-- Indexes for table `etherpad_ethercommunity`
--
ALTER TABLE `etherpad_ethercommunity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `etherpad_ethercommun_community_id_8610cc18_fk_Community` (`community_id`);

--
-- Indexes for table `etherpad_ethergroup`
--
ALTER TABLE `etherpad_ethergroup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `etherpad_ethergroup_group_id_a1912466_fk_Group_group_id` (`group_id`);

--
-- Indexes for table `etherpad_etheruser`
--
ALTER TABLE `etherpad_etheruser`
  ADD PRIMARY KEY (`id`),
  ADD KEY `etherpad_etheruser_user_id_1c71c453_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `forum_attachments_attachment`
--
ALTER TABLE `forum_attachments_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_attachments_at_post_id_0476a843_fk_forum_con` (`post_id`);

--
-- Indexes for table `forum_conversation_post`
--
ALTER TABLE `forum_conversation_post`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_conversation_post_poster_id_19c4e995_fk_auth_user_id` (`poster_id`),
  ADD KEY `forum_conversation_p_topic_id_f6aaa418_fk_forum_con` (`topic_id`),
  ADD KEY `forum_conversation_post_updated_by_id_86093355_fk_auth_user_id` (`updated_by_id`),
  ADD KEY `forum_conversation_post_approved_a1090910` (`approved`),
  ADD KEY `forum_conversation_post_enable_signature_b1ce8b55` (`enable_signature`);

--
-- Indexes for table `forum_conversation_topic`
--
ALTER TABLE `forum_conversation_topic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_conversation_topic_forum_id_e9cfe592_fk_forum_forum_id` (`forum_id`),
  ADD KEY `forum_conversation_topic_poster_id_0dd4fa07_fk_auth_user_id` (`poster_id`),
  ADD KEY `forum_conversation_topic_slug_c74ce2cc` (`slug`),
  ADD KEY `forum_conversation_topic_type_92971eb5` (`type`),
  ADD KEY `forum_conversation_topic_status_e78d0ae4` (`status`),
  ADD KEY `forum_conversation_topic_approved_ad3fcbf9` (`approved`),
  ADD KEY `forum_conversation_t_last_post_id_e14396a2_fk_forum_con` (`last_post_id`),
  ADD KEY `forum_conversation_t_first_post_id_ca473bd1_fk_forum_con` (`first_post_id`);

--
-- Indexes for table `forum_conversation_topic_subscribers`
--
ALTER TABLE `forum_conversation_topic_subscribers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forum_conversation_topic_topic_id_user_id_b2c961d5_uniq` (`topic_id`,`user_id`),
  ADD KEY `forum_conversation_t_user_id_7e386a79_fk_auth_user` (`user_id`);

--
-- Indexes for table `forum_forum`
--
ALTER TABLE `forum_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_forum_slug_b9acc50d` (`slug`),
  ADD KEY `forum_forum_type_30239563` (`type`),
  ADD KEY `forum_forum_lft_ad1dea6a` (`lft`),
  ADD KEY `forum_forum_rght_72abf953` (`rght`),
  ADD KEY `forum_forum_tree_id_84a9227d` (`tree_id`),
  ADD KEY `forum_forum_level_8a349c84` (`level`),
  ADD KEY `forum_forum_parent_id_22edea05` (`parent_id`),
  ADD KEY `forum_forum_last_post_id_81b59e37_fk_forum_conversation_post_id` (`last_post_id`);

--
-- Indexes for table `forum_member_forumprofile`
--
ALTER TABLE `forum_member_forumprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `forum_permission_forumpermission`
--
ALTER TABLE `forum_permission_forumpermission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codename` (`codename`),
  ADD KEY `forum_permission_forumpermission_is_global_5772ce17` (`is_global`),
  ADD KEY `forum_permission_forumpermission_is_local_92cef3ca` (`is_local`);

--
-- Indexes for table `forum_permission_groupforumpermission`
--
ALTER TABLE `forum_permission_groupforumpermission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forum_permission_groupfo_permission_id_forum_id_g_a1e477c8_uniq` (`permission_id`,`forum_id`,`group_id`),
  ADD KEY `forum_permission_gro_forum_id_d59d5cac_fk_forum_for` (`forum_id`),
  ADD KEY `forum_permission_gro_group_id_b515635b_fk_auth_grou` (`group_id`),
  ADD KEY `forum_permission_groupforumpermission_has_perm_48cae01d` (`has_perm`);

--
-- Indexes for table `forum_permission_userforumpermission`
--
ALTER TABLE `forum_permission_userforumpermission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forum_permission_userfor_permission_id_forum_id_u_024a3693_uniq` (`permission_id`,`forum_id`,`user_id`),
  ADD KEY `forum_permission_use_forum_id_f781f4d6_fk_forum_for` (`forum_id`),
  ADD KEY `forum_permission_use_user_id_8106d02d_fk_auth_user` (`user_id`),
  ADD KEY `forum_permission_userforumpermission_anonymous_user_8aabbd9d` (`anonymous_user`),
  ADD KEY `forum_permission_userforumpermission_has_perm_1b5ee7ac` (`has_perm`);

--
-- Indexes for table `forum_polls_topicpoll`
--
ALTER TABLE `forum_polls_topicpoll`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `topic_id` (`topic_id`);

--
-- Indexes for table `forum_polls_topicpolloption`
--
ALTER TABLE `forum_polls_topicpolloption`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_polls_topicpol_poll_id_a54cbd58_fk_forum_pol` (`poll_id`);

--
-- Indexes for table `forum_polls_topicpollvote`
--
ALTER TABLE `forum_polls_topicpollvote`
  ADD PRIMARY KEY (`id`),
  ADD KEY `forum_polls_topicpol_poll_option_id_a075b665_fk_forum_pol` (`poll_option_id`),
  ADD KEY `forum_polls_topicpollvote_voter_id_0a287559_fk_auth_user_id` (`voter_id`);

--
-- Indexes for table `forum_tracking_forumreadtrack`
--
ALTER TABLE `forum_tracking_forumreadtrack`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forum_tracking_forumreadtrack_user_id_forum_id_3e64777a_uniq` (`user_id`,`forum_id`),
  ADD KEY `forum_tracking_forum_forum_id_bbd3fb47_fk_forum_for` (`forum_id`),
  ADD KEY `forum_tracking_forumreadtrack_mark_time_72eec39e` (`mark_time`);

--
-- Indexes for table `forum_tracking_topicreadtrack`
--
ALTER TABLE `forum_tracking_topicreadtrack`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `forum_tracking_topicreadtrack_user_id_topic_id_6fe3e105_uniq` (`user_id`,`topic_id`),
  ADD KEY `forum_tracking_topic_topic_id_9a53bd45_fk_forum_con` (`topic_id`),
  ADD KEY `forum_tracking_topicreadtrack_mark_time_7dafc483` (`mark_time`);

--
-- Indexes for table `Group_group`
--
ALTER TABLE `Group_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_group_created_by_id_b1ee0c6d_fk_auth_user_id` (`created_by_id`);

--
-- Indexes for table `Group_grouparticles`
--
ALTER TABLE `Group_grouparticles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_grouparticles_article_id_eac38398_fk_BasicArti` (`article_id`),
  ADD KEY `Group_grouparticles_group_id_84ee212d_fk_Group_group_id` (`group_id`),
  ADD KEY `Group_grouparticles_user_id_12983c5c_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Group_groupinvitations`
--
ALTER TABLE `Group_groupinvitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_groupinvitations_group_id_48a7f8e2_fk_Group_group_id` (`group_id`),
  ADD KEY `Group_groupinvitations_invitedby_id_f7a8ea5c_fk_auth_user_id` (`invitedby_id`),
  ADD KEY `Group_groupinvitations_role_id_20c49c7f_fk_auth_group_id` (`role_id`),
  ADD KEY `Group_groupinvitations_user_id_a4a046d3_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Group_groupmedia`
--
ALTER TABLE `Group_groupmedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_groupmedia_group_id_73f1a47c_fk_Group_group_id` (`group_id`),
  ADD KEY `Group_groupmedia_media_id_bb652569_fk_Media_media_id` (`media_id`),
  ADD KEY `Group_groupmedia_user_id_e6917c04_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Group_groupmembership`
--
ALTER TABLE `Group_groupmembership`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Group_groupmembership_group_id_adce78b5_fk_Group_group_id` (`group_id`),
  ADD KEY `Group_groupmembership_role_id_bb865ffb_fk_auth_group_id` (`role_id`),
  ADD KEY `Group_groupmembership_user_id_e4f5757f_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Media_media`
--
ALTER TABLE `Media_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Media_media_created_by_id_ae93f7fb_fk_auth_user_id` (`created_by_id`),
  ADD KEY `Media_media_published_by_id_83121da5_fk_auth_user_id` (`published_by_id`),
  ADD KEY `Media_media_state_id_46785feb_fk_workflow_states_id` (`state_id`),
  ADD KEY `Media_media_metadata_id_c939b240_fk_metadata_metadata_id` (`metadata_id`);

--
-- Indexes for table `metadata_metadata`
--
ALTER TABLE `metadata_metadata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications_notification`
--
ALTER TABLE `notifications_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co` (`action_object_content_type_id`),
  ADD KEY `notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co` (`actor_content_type_id`),
  ADD KEY `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` (`recipient_id`),
  ADD KEY `notifications_notifi_target_content_type__ccb24d88_fk_django_co` (`target_content_type_id`),
  ADD KEY `notifications_notification_deleted_b32b69e6` (`deleted`),
  ADD KEY `notifications_notification_emailed_23a5ad81` (`emailed`),
  ADD KEY `notifications_notification_public_1bc30b1c` (`public`),
  ADD KEY `notifications_notification_unread_cce4be30` (`unread`);

--
-- Indexes for table `nyt_notification`
--
ALTER TABLE `nyt_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nyt_notification_subscription_id_5a132ae1_fk_nyt_subscription_id` (`subscription_id`),
  ADD KEY `nyt_notification_user_id_acbb5c10_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `nyt_notificationtype`
--
ALTER TABLE `nyt_notificationtype`
  ADD PRIMARY KEY (`key`),
  ADD KEY `nyt_notificationtype_content_type_id_18800dea_fk_django_co` (`content_type_id`);

--
-- Indexes for table `nyt_settings`
--
ALTER TABLE `nyt_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nyt_settings_user_id_1fad6d98_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `nyt_subscription`
--
ALTER TABLE `nyt_subscription`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nyt_subscription_settings_id_761bae06_fk_nyt_settings_id` (`settings_id`),
  ADD KEY `nyt_subscription_notification_type_id_ca8af379_fk_nyt_notif` (`notification_type_id`),
  ADD KEY `nyt_subscription_latest_id_bbb7d98b_fk_nyt_notification_id` (`latest_id`);

--
-- Indexes for table `Reputation_articleflaglogs`
--
ALTER TABLE `Reputation_articleflaglogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reputation_articlefl_reason_id_200b641a_fk_Reputatio` (`reason_id`),
  ADD KEY `Reputation_articlefl_resource_id_21412c4c_fk_BasicArti` (`resource_id`),
  ADD KEY `Reputation_articleflaglogs_user_id_4bce74ef_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Reputation_articlescorelog`
--
ALTER TABLE `Reputation_articlescorelog`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `resource_id` (`resource_id`);

--
-- Indexes for table `Reputation_articleuserscorelogs`
--
ALTER TABLE `Reputation_articleuserscorelogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reputation_articleus_resource_id_2a10325b_fk_BasicArti` (`resource_id`),
  ADD KEY `Reputation_articleuserscorelogs_user_id_77095608_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Reputation_communityreputaion`
--
ALTER TABLE `Reputation_communityreputaion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reputation_community_community_id_9fe0df3b_fk_Community` (`community_id`),
  ADD KEY `Reputation_communityreputaion_user_id_fce03592_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Reputation_flagreason`
--
ALTER TABLE `Reputation_flagreason`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Reputation_mediaflaglogs`
--
ALTER TABLE `Reputation_mediaflaglogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reputation_mediaflag_reason_id_b7bf0680_fk_Reputatio` (`reason_id`),
  ADD KEY `Reputation_mediaflaglogs_resource_id_1fe0b6c8_fk_Media_media_id` (`resource_id`),
  ADD KEY `Reputation_mediaflaglogs_user_id_6d095f7f_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Reputation_mediascorelog`
--
ALTER TABLE `Reputation_mediascorelog`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `resource_id` (`resource_id`);

--
-- Indexes for table `Reputation_mediauserscorelogs`
--
ALTER TABLE `Reputation_mediauserscorelogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reputation_mediauser_resource_id_461aadb0_fk_Media_med` (`resource_id`),
  ADD KEY `Reputation_mediauserscorelogs_user_id_ef68208e_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `Reputation_resourcescore`
--
ALTER TABLE `Reputation_resourcescore`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Reputation_userscore`
--
ALTER TABLE `Reputation_userscore`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reversion_revision`
--
ALTER TABLE `reversion_revision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reversion_revision_user_id_17095f45_fk_auth_user_id` (`user_id`),
  ADD KEY `reversion_revision_date_created_96f7c20c` (`date_created`);

--
-- Indexes for table `reversion_version`
--
ALTER TABLE `reversion_version`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reversion_version_db_content_type_id_objec_b2c54f65_uniq` (`db`,`content_type_id`,`object_id`,`revision_id`),
  ADD KEY `reversion_version_content_type_id_7d0ff25c_fk_django_co` (`content_type_id`),
  ADD KEY `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` (`revision_id`);

--
-- Indexes for table `social_auth_association`
--
ALTER TABLE `social_auth_association`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_association_server_url_handle_078befa2_uniq` (`server_url`,`handle`);

--
-- Indexes for table `social_auth_code`
--
ALTER TABLE `social_auth_code`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_code_email_code_801b2d02_uniq` (`email`,`code`),
  ADD KEY `social_auth_code_code_a2393167` (`code`),
  ADD KEY `social_auth_code_timestamp_176b341f` (`timestamp`);

--
-- Indexes for table `social_auth_nonce`
--
ALTER TABLE `social_auth_nonce`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_nonce_server_url_timestamp_salt_f6284463_uniq` (`server_url`,`timestamp`,`salt`);

--
-- Indexes for table `social_auth_partial`
--
ALTER TABLE `social_auth_partial`
  ADD PRIMARY KEY (`id`),
  ADD KEY `social_auth_partial_token_3017fea3` (`token`),
  ADD KEY `social_auth_partial_timestamp_50f2119f` (`timestamp`);

--
-- Indexes for table `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_auth_usersocialauth_provider_uid_e6b5e668_uniq` (`provider`,`uid`),
  ADD KEY `social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `taggit_tag`
--
ALTER TABLE `taggit_tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` (`tag_id`),
  ADD KEY `taggit_taggeditem_object_id_e2d7d1df` (`object_id`),
  ADD KEY `taggit_taggeditem_content_type_id_object_id_196cc965_idx` (`content_type_id`,`object_id`);

--
-- Indexes for table `TaskQueue_task`
--
ALTER TABLE `TaskQueue_task`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `thumbnail_kvstore`
--
ALTER TABLE `thumbnail_kvstore`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `UserRolesPermission_favourite`
--
ALTER TABLE `UserRolesPermission_favourite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `UserRolesPermission_favourite_user_id_14680490_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `UserRolesPermission_profileimage`
--
ALTER TABLE `UserRolesPermission_profileimage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `webcontent_faq`
--
ALTER TABLE `webcontent_faq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webcontent_faq_category_id_b92f315f_fk_webcontent_faqcategory_id` (`category_id`);

--
-- Indexes for table `webcontent_faqcategory`
--
ALTER TABLE `webcontent_faqcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `webcontent_feedback`
--
ALTER TABLE `webcontent_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webcontent_feedback_user_id_943add81_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `wiki_article`
--
ALTER TABLE `wiki_article`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `current_revision_id` (`current_revision_id`),
  ADD KEY `wiki_article_group_id_bf035c83_fk_auth_group_id` (`group_id`),
  ADD KEY `wiki_article_owner_id_956bc94a_fk_auth_user_id` (`owner_id`);

--
-- Indexes for table `wiki_articleforobject`
--
ALTER TABLE `wiki_articleforobject`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_articleforobject_content_type_id_object_id_046be756_uniq` (`content_type_id`,`object_id`),
  ADD KEY `wiki_articleforobject_article_id_7d67d809_fk_wiki_article_id` (`article_id`);

--
-- Indexes for table `wiki_articleplugin`
--
ALTER TABLE `wiki_articleplugin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wiki_articleplugin_article_id_9ab0e854_fk_wiki_article_id` (`article_id`);

--
-- Indexes for table `wiki_articlerevision`
--
ALTER TABLE `wiki_articlerevision`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_articlerevision_article_id_revision_number_5bcd5334_uniq` (`article_id`,`revision_number`),
  ADD KEY `wiki_articlerevision_previous_revision_id_bcfaf4c9_fk_wiki_arti` (`previous_revision_id`),
  ADD KEY `wiki_articlerevision_user_id_c687e4de_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `wiki_attachments_attachment`
--
ALTER TABLE `wiki_attachments_attachment`
  ADD PRIMARY KEY (`reusableplugin_ptr_id`),
  ADD UNIQUE KEY `current_revision_id` (`current_revision_id`);

--
-- Indexes for table `wiki_attachments_attachmentrevision`
--
ALTER TABLE `wiki_attachments_attachmentrevision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wiki_attachments_att_attachment_id_32ffc4ea_fk_wiki_atta` (`attachment_id`),
  ADD KEY `wiki_attachments_att_previous_revision_id_e7f09093_fk_wiki_atta` (`previous_revision_id`),
  ADD KEY `wiki_attachments_att_user_id_2da908ac_fk_auth_user` (`user_id`);

--
-- Indexes for table `wiki_images_image`
--
ALTER TABLE `wiki_images_image`
  ADD PRIMARY KEY (`revisionplugin_ptr_id`);

--
-- Indexes for table `wiki_images_imagerevision`
--
ALTER TABLE `wiki_images_imagerevision`
  ADD PRIMARY KEY (`revisionpluginrevision_ptr_id`);

--
-- Indexes for table `wiki_notifications_articlesubscription`
--
ALTER TABLE `wiki_notifications_articlesubscription`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD UNIQUE KEY `subscription_id` (`subscription_id`),
  ADD UNIQUE KEY `wiki_notifications_artic_subscription_id_articlep_6898a80a_uniq` (`subscription_id`,`articleplugin_ptr_id`);

--
-- Indexes for table `wiki_reusableplugin`
--
ALTER TABLE `wiki_reusableplugin`
  ADD PRIMARY KEY (`articleplugin_ptr_id`);

--
-- Indexes for table `wiki_reusableplugin_articles`
--
ALTER TABLE `wiki_reusableplugin_articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_reusableplugin_arti_reusableplugin_id_articl_302a7a01_uniq` (`reusableplugin_id`,`article_id`),
  ADD KEY `wiki_reusableplugin__article_id_8a09d39e_fk_wiki_arti` (`article_id`);

--
-- Indexes for table `wiki_revisionplugin`
--
ALTER TABLE `wiki_revisionplugin`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD UNIQUE KEY `current_revision_id` (`current_revision_id`);

--
-- Indexes for table `wiki_revisionpluginrevision`
--
ALTER TABLE `wiki_revisionpluginrevision`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wiki_revisionpluginr_plugin_id_c8f4475b_fk_wiki_revi` (`plugin_id`),
  ADD KEY `wiki_revisionpluginr_previous_revision_id_38c877c0_fk_wiki_revi` (`previous_revision_id`),
  ADD KEY `wiki_revisionpluginrevision_user_id_ee40f729_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `wiki_simpleplugin`
--
ALTER TABLE `wiki_simpleplugin`
  ADD PRIMARY KEY (`articleplugin_ptr_id`),
  ADD KEY `wiki_simpleplugin_article_revision_id_cff7df92_fk_wiki_arti` (`article_revision_id`);

--
-- Indexes for table `wiki_urlpath`
--
ALTER TABLE `wiki_urlpath`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `wiki_urlpath_site_id_parent_id_slug_e4942e5d_uniq` (`site_id`,`parent_id`,`slug`),
  ADD KEY `wiki_urlpath_article_id_9ef0c0fb_fk_wiki_article_id` (`article_id`),
  ADD KEY `wiki_urlpath_slug_39d212eb` (`slug`),
  ADD KEY `wiki_urlpath_lft_46bfd227` (`lft`),
  ADD KEY `wiki_urlpath_rght_186fc98e` (`rght`),
  ADD KEY `wiki_urlpath_tree_id_090b475d` (`tree_id`),
  ADD KEY `wiki_urlpath_level_57f17cfd` (`level`),
  ADD KEY `wiki_urlpath_parent_id_a6e675ac` (`parent_id`),
  ADD KEY `wiki_urlpath_moved_to_id_4718abf8` (`moved_to_id`);

--
-- Indexes for table `workflow_states`
--
ALTER TABLE `workflow_states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workflow_transitions`
--
ALTER TABLE `workflow_transitions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workflow_transitions_from_state_id_5ff9ea9d_fk_workflow_` (`from_state_id`),
  ADD KEY `workflow_transitions_to_state_id_8d6c5cc6_fk_workflow_states_id` (`to_state_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actstream_action`
--
ALTER TABLE `actstream_action`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `actstream_follow`
--
ALTER TABLE `actstream_follow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=312;
--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `badges_badgetouser`
--
ALTER TABLE `badges_badgetouser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `BasicArticle_articles`
--
ALTER TABLE `BasicArticle_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `BasicArticle_articleviewlogs`
--
ALTER TABLE `BasicArticle_articleviewlogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Categories_category`
--
ALTER TABLE `Categories_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_community`
--
ALTER TABLE `Community_community`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_communityarticles`
--
ALTER TABLE `Community_communityarticles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_communitycourses`
--
ALTER TABLE `Community_communitycourses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_communitygroups`
--
ALTER TABLE `Community_communitygroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_communitymedia`
--
ALTER TABLE `Community_communitymedia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_communitymembership`
--
ALTER TABLE `Community_communitymembership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Community_requestcommunitycreation`
--
ALTER TABLE `Community_requestcommunitycreation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Course_course`
--
ALTER TABLE `Course_course`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Course_links`
--
ALTER TABLE `Course_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Course_topicarticle`
--
ALTER TABLE `Course_topicarticle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Course_topics`
--
ALTER TABLE `Course_topics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Course_videos`
--
ALTER TABLE `Course_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `django_comments`
--
ALTER TABLE `django_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_comments_xtd_blacklisteddomain`
--
ALTER TABLE `django_comments_xtd_blacklisteddomain`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_comment_flags`
--
ALTER TABLE `django_comment_flags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;
--
-- AUTO_INCREMENT for table `django_site`
--
ALTER TABLE `django_site`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `etherpad_etherarticle`
--
ALTER TABLE `etherpad_etherarticle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `etherpad_ethercommunity`
--
ALTER TABLE `etherpad_ethercommunity`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `etherpad_ethergroup`
--
ALTER TABLE `etherpad_ethergroup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `etherpad_etheruser`
--
ALTER TABLE `etherpad_etheruser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_attachments_attachment`
--
ALTER TABLE `forum_attachments_attachment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_conversation_post`
--
ALTER TABLE `forum_conversation_post`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_conversation_topic`
--
ALTER TABLE `forum_conversation_topic`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_conversation_topic_subscribers`
--
ALTER TABLE `forum_conversation_topic_subscribers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_forum`
--
ALTER TABLE `forum_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `forum_member_forumprofile`
--
ALTER TABLE `forum_member_forumprofile`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_permission_forumpermission`
--
ALTER TABLE `forum_permission_forumpermission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `forum_permission_groupforumpermission`
--
ALTER TABLE `forum_permission_groupforumpermission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `forum_permission_userforumpermission`
--
ALTER TABLE `forum_permission_userforumpermission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `forum_polls_topicpoll`
--
ALTER TABLE `forum_polls_topicpoll`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_polls_topicpolloption`
--
ALTER TABLE `forum_polls_topicpolloption`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_polls_topicpollvote`
--
ALTER TABLE `forum_polls_topicpollvote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_tracking_forumreadtrack`
--
ALTER TABLE `forum_tracking_forumreadtrack`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `forum_tracking_topicreadtrack`
--
ALTER TABLE `forum_tracking_topicreadtrack`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Group_group`
--
ALTER TABLE `Group_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Group_grouparticles`
--
ALTER TABLE `Group_grouparticles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Group_groupinvitations`
--
ALTER TABLE `Group_groupinvitations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Group_groupmedia`
--
ALTER TABLE `Group_groupmedia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Group_groupmembership`
--
ALTER TABLE `Group_groupmembership`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Media_media`
--
ALTER TABLE `Media_media`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `metadata_metadata`
--
ALTER TABLE `metadata_metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `notifications_notification`
--
ALTER TABLE `notifications_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nyt_notification`
--
ALTER TABLE `nyt_notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nyt_settings`
--
ALTER TABLE `nyt_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `nyt_subscription`
--
ALTER TABLE `nyt_subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_articleflaglogs`
--
ALTER TABLE `Reputation_articleflaglogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_articlescorelog`
--
ALTER TABLE `Reputation_articlescorelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_articleuserscorelogs`
--
ALTER TABLE `Reputation_articleuserscorelogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_communityreputaion`
--
ALTER TABLE `Reputation_communityreputaion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_flagreason`
--
ALTER TABLE `Reputation_flagreason`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_mediaflaglogs`
--
ALTER TABLE `Reputation_mediaflaglogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_mediascorelog`
--
ALTER TABLE `Reputation_mediascorelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_mediauserscorelogs`
--
ALTER TABLE `Reputation_mediauserscorelogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_resourcescore`
--
ALTER TABLE `Reputation_resourcescore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Reputation_userscore`
--
ALTER TABLE `Reputation_userscore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reversion_revision`
--
ALTER TABLE `reversion_revision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `reversion_version`
--
ALTER TABLE `reversion_version`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `social_auth_association`
--
ALTER TABLE `social_auth_association`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `social_auth_code`
--
ALTER TABLE `social_auth_code`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `social_auth_nonce`
--
ALTER TABLE `social_auth_nonce`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `social_auth_partial`
--
ALTER TABLE `social_auth_partial`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `taggit_tag`
--
ALTER TABLE `taggit_tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `TaskQueue_task`
--
ALTER TABLE `TaskQueue_task`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserRolesPermission_favourite`
--
ALTER TABLE `UserRolesPermission_favourite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `UserRolesPermission_profileimage`
--
ALTER TABLE `UserRolesPermission_profileimage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `webcontent_faq`
--
ALTER TABLE `webcontent_faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT for table `webcontent_faqcategory`
--
ALTER TABLE `webcontent_faqcategory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `webcontent_feedback`
--
ALTER TABLE `webcontent_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wiki_article`
--
ALTER TABLE `wiki_article`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `wiki_articleforobject`
--
ALTER TABLE `wiki_articleforobject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `wiki_articleplugin`
--
ALTER TABLE `wiki_articleplugin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wiki_articlerevision`
--
ALTER TABLE `wiki_articlerevision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `wiki_attachments_attachmentrevision`
--
ALTER TABLE `wiki_attachments_attachmentrevision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wiki_reusableplugin_articles`
--
ALTER TABLE `wiki_reusableplugin_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wiki_revisionpluginrevision`
--
ALTER TABLE `wiki_revisionpluginrevision`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wiki_urlpath`
--
ALTER TABLE `wiki_urlpath`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `workflow_states`
--
ALTER TABLE `workflow_states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `workflow_transitions`
--
ALTER TABLE `workflow_transitions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `actstream_action`
--
ALTER TABLE `actstream_action`
  ADD CONSTRAINT `actstream_action_action_object_conten_ee623c15_fk_django_co` FOREIGN KEY (`action_object_content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `actstream_action_actor_content_type_i_d5e5ec2a_fk_django_co` FOREIGN KEY (`actor_content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `actstream_action_target_content_type__187fa164_fk_django_co` FOREIGN KEY (`target_content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `actstream_follow`
--
ALTER TABLE `actstream_follow`
  ADD CONSTRAINT `actstream_follow_content_type_id_ba287eb9_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `actstream_follow_user_id_e9d4e1ff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `badges_badgetouser`
--
ALTER TABLE `badges_badgetouser`
  ADD CONSTRAINT `badges_badgetouser_badge_id_0e3cd6bb_fk_badges_badge_id` FOREIGN KEY (`badge_id`) REFERENCES `badges_badge` (`id`),
  ADD CONSTRAINT `badges_badgetouser_community_id_01e9a7f7_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `badges_badgetouser_user_id_7928b431_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `BasicArticle_articles`
--
ALTER TABLE `BasicArticle_articles`
  ADD CONSTRAINT `BasicArticle_articles_created_by_id_8b76d84d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `BasicArticle_articles_published_by_id_81e5e785_fk_auth_user_id` FOREIGN KEY (`published_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `BasicArticle_articles_state_id_1a38551e_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`);

--
-- Constraints for table `BasicArticle_articleviewlogs`
--
ALTER TABLE `BasicArticle_articleviewlogs`
  ADD CONSTRAINT `BasicArticle_article_article_id_164e59b4_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`);

--
-- Constraints for table `Categories_category`
--
ALTER TABLE `Categories_category`
  ADD CONSTRAINT `Categories_category_parent_id_eee850a6_fk_Categories_category_id` FOREIGN KEY (`parent_id`) REFERENCES `Categories_category` (`id`);

--
-- Constraints for table `Community_community`
--
ALTER TABLE `Community_community`
  ADD CONSTRAINT `Community_community_category_id_87e260b2_fk_Categorie` FOREIGN KEY (`category_id`) REFERENCES `Categories_category` (`id`),
  ADD CONSTRAINT `Community_community_created_by_id_1080464d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `Community_community_parent_id_47d0e58d_fk_Community_community_id` FOREIGN KEY (`parent_id`) REFERENCES `Community_community` (`id`);

--
-- Constraints for table `Community_communityarticles`
--
ALTER TABLE `Community_communityarticles`
  ADD CONSTRAINT `Community_communitya_article_id_c9af3fed_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`),
  ADD CONSTRAINT `Community_communitya_community_id_39b5841f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `Community_communityarticles_user_id_04d18793_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Community_communitycourses`
--
ALTER TABLE `Community_communitycourses`
  ADD CONSTRAINT `Community_communityc_community_id_db58cc7f_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `Community_communityc_course_id_1b9cc41b_fk_Course_co` FOREIGN KEY (`course_id`) REFERENCES `Course_course` (`id`),
  ADD CONSTRAINT `Community_communitycourses_user_id_d3572caf_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Community_communitygroups`
--
ALTER TABLE `Community_communitygroups`
  ADD CONSTRAINT `Community_communityg_community_id_3e76934c_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `Community_communitygroups_group_id_a2ce7b35_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  ADD CONSTRAINT `Community_communitygroups_user_id_eaead89d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Community_communitymedia`
--
ALTER TABLE `Community_communitymedia`
  ADD CONSTRAINT `Community_communitym_community_id_3ff46a01_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `Community_communitymedia_media_id_e160518e_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `Media_media` (`id`),
  ADD CONSTRAINT `Community_communitymedia_user_id_97a38254_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Community_communitymembership`
--
ALTER TABLE `Community_communitymembership`
  ADD CONSTRAINT `Community_communitym_community_id_8a39991d_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `Community_communitymembership_role_id_9c581fd0_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `Community_communitymembership_user_id_5dd1c26b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Community_requestcommunitycreation`
--
ALTER TABLE `Community_requestcommunitycreation`
  ADD CONSTRAINT `Community_requestcom_category_id_874787b7_fk_Categorie` FOREIGN KEY (`category_id`) REFERENCES `Categories_category` (`id`),
  ADD CONSTRAINT `Community_requestcom_requestedby_id_b3e83124_fk_auth_user` FOREIGN KEY (`requestedby_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Course_course`
--
ALTER TABLE `Course_course`
  ADD CONSTRAINT `Course_course_created_by_id_696e3a4e_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `Course_course_state_id_77c858e0_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`);

--
-- Constraints for table `Course_links`
--
ALTER TABLE `Course_links`
  ADD CONSTRAINT `Course_links_topics_id_096bf6bd_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `Course_topics` (`id`);

--
-- Constraints for table `Course_topicarticle`
--
ALTER TABLE `Course_topicarticle`
  ADD CONSTRAINT `Course_topicarticle_article_id_2ab7af7f_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`),
  ADD CONSTRAINT `Course_topicarticle_topics_id_d20b76e7_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `Course_topics` (`id`);

--
-- Constraints for table `Course_topics`
--
ALTER TABLE `Course_topics`
  ADD CONSTRAINT `Course_topics_course_id_9e18b74c_fk_Course_course_id` FOREIGN KEY (`course_id`) REFERENCES `Course_course` (`id`),
  ADD CONSTRAINT `Course_topics_parent_id_adff4cae_fk_Course_topics_id` FOREIGN KEY (`parent_id`) REFERENCES `Course_topics` (`id`);

--
-- Constraints for table `Course_videos`
--
ALTER TABLE `Course_videos`
  ADD CONSTRAINT `Course_videos_topics_id_568227cc_fk_Course_topics_id` FOREIGN KEY (`topics_id`) REFERENCES `Course_topics` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_comments`
--
ALTER TABLE `django_comments`
  ADD CONSTRAINT `django_comments_content_type_id_c4afe962_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_comments_site_id_9dcf666e_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  ADD CONSTRAINT `django_comments_user_id_a0a440a1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_comments_xtd_xtdcomment`
--
ALTER TABLE `django_comments_xtd_xtdcomment`
  ADD CONSTRAINT `django_comments_xtd__comment_ptr_id_01d47130_fk_django_co` FOREIGN KEY (`comment_ptr_id`) REFERENCES `django_comments` (`id`);

--
-- Constraints for table `django_comment_flags`
--
ALTER TABLE `django_comment_flags`
  ADD CONSTRAINT `django_comment_flags_comment_id_d8054933_fk_django_comments_id` FOREIGN KEY (`comment_id`) REFERENCES `django_comments` (`id`),
  ADD CONSTRAINT `django_comment_flags_user_id_f3f81f0a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `etherpad_etherarticle`
--
ALTER TABLE `etherpad_etherarticle`
  ADD CONSTRAINT `etherpad_etherarticl_article_id_af7a9005_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`);

--
-- Constraints for table `etherpad_ethercommunity`
--
ALTER TABLE `etherpad_ethercommunity`
  ADD CONSTRAINT `etherpad_ethercommun_community_id_8610cc18_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`);

--
-- Constraints for table `etherpad_ethergroup`
--
ALTER TABLE `etherpad_ethergroup`
  ADD CONSTRAINT `etherpad_ethergroup_group_id_a1912466_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`);

--
-- Constraints for table `etherpad_etheruser`
--
ALTER TABLE `etherpad_etheruser`
  ADD CONSTRAINT `etherpad_etheruser_user_id_1c71c453_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_attachments_attachment`
--
ALTER TABLE `forum_attachments_attachment`
  ADD CONSTRAINT `forum_attachments_at_post_id_0476a843_fk_forum_con` FOREIGN KEY (`post_id`) REFERENCES `forum_conversation_post` (`id`);

--
-- Constraints for table `forum_conversation_post`
--
ALTER TABLE `forum_conversation_post`
  ADD CONSTRAINT `forum_conversation_p_topic_id_f6aaa418_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`),
  ADD CONSTRAINT `forum_conversation_post_poster_id_19c4e995_fk_auth_user_id` FOREIGN KEY (`poster_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `forum_conversation_post_updated_by_id_86093355_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_conversation_topic`
--
ALTER TABLE `forum_conversation_topic`
  ADD CONSTRAINT `forum_conversation_t_first_post_id_ca473bd1_fk_forum_con` FOREIGN KEY (`first_post_id`) REFERENCES `forum_conversation_post` (`id`),
  ADD CONSTRAINT `forum_conversation_t_last_post_id_e14396a2_fk_forum_con` FOREIGN KEY (`last_post_id`) REFERENCES `forum_conversation_post` (`id`),
  ADD CONSTRAINT `forum_conversation_topic_forum_id_e9cfe592_fk_forum_forum_id` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  ADD CONSTRAINT `forum_conversation_topic_poster_id_0dd4fa07_fk_auth_user_id` FOREIGN KEY (`poster_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_conversation_topic_subscribers`
--
ALTER TABLE `forum_conversation_topic_subscribers`
  ADD CONSTRAINT `forum_conversation_t_topic_id_34ebca87_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`),
  ADD CONSTRAINT `forum_conversation_t_user_id_7e386a79_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_forum`
--
ALTER TABLE `forum_forum`
  ADD CONSTRAINT `forum_forum_last_post_id_81b59e37_fk_forum_conversation_post_id` FOREIGN KEY (`last_post_id`) REFERENCES `forum_conversation_post` (`id`),
  ADD CONSTRAINT `forum_forum_parent_id_22edea05_fk_forum_forum_id` FOREIGN KEY (`parent_id`) REFERENCES `forum_forum` (`id`);

--
-- Constraints for table `forum_member_forumprofile`
--
ALTER TABLE `forum_member_forumprofile`
  ADD CONSTRAINT `forum_member_forumprofile_user_id_9d6b9b6b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_permission_groupforumpermission`
--
ALTER TABLE `forum_permission_groupforumpermission`
  ADD CONSTRAINT `forum_permission_gro_forum_id_d59d5cac_fk_forum_for` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  ADD CONSTRAINT `forum_permission_gro_group_id_b515635b_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `forum_permission_gro_permission_id_2475fe70_fk_forum_per` FOREIGN KEY (`permission_id`) REFERENCES `forum_permission_forumpermission` (`id`);

--
-- Constraints for table `forum_permission_userforumpermission`
--
ALTER TABLE `forum_permission_userforumpermission`
  ADD CONSTRAINT `forum_permission_use_forum_id_f781f4d6_fk_forum_for` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  ADD CONSTRAINT `forum_permission_use_permission_id_9090e930_fk_forum_per` FOREIGN KEY (`permission_id`) REFERENCES `forum_permission_forumpermission` (`id`),
  ADD CONSTRAINT `forum_permission_use_user_id_8106d02d_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_polls_topicpoll`
--
ALTER TABLE `forum_polls_topicpoll`
  ADD CONSTRAINT `forum_polls_topicpol_topic_id_1b827b83_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`);

--
-- Constraints for table `forum_polls_topicpolloption`
--
ALTER TABLE `forum_polls_topicpolloption`
  ADD CONSTRAINT `forum_polls_topicpol_poll_id_a54cbd58_fk_forum_pol` FOREIGN KEY (`poll_id`) REFERENCES `forum_polls_topicpoll` (`id`);

--
-- Constraints for table `forum_polls_topicpollvote`
--
ALTER TABLE `forum_polls_topicpollvote`
  ADD CONSTRAINT `forum_polls_topicpol_poll_option_id_a075b665_fk_forum_pol` FOREIGN KEY (`poll_option_id`) REFERENCES `forum_polls_topicpolloption` (`id`),
  ADD CONSTRAINT `forum_polls_topicpollvote_voter_id_0a287559_fk_auth_user_id` FOREIGN KEY (`voter_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_tracking_forumreadtrack`
--
ALTER TABLE `forum_tracking_forumreadtrack`
  ADD CONSTRAINT `forum_tracking_forum_forum_id_bbd3fb47_fk_forum_for` FOREIGN KEY (`forum_id`) REFERENCES `forum_forum` (`id`),
  ADD CONSTRAINT `forum_tracking_forumreadtrack_user_id_932d4605_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `forum_tracking_topicreadtrack`
--
ALTER TABLE `forum_tracking_topicreadtrack`
  ADD CONSTRAINT `forum_tracking_topic_topic_id_9a53bd45_fk_forum_con` FOREIGN KEY (`topic_id`) REFERENCES `forum_conversation_topic` (`id`),
  ADD CONSTRAINT `forum_tracking_topicreadtrack_user_id_2762562b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Group_group`
--
ALTER TABLE `Group_group`
  ADD CONSTRAINT `Group_group_created_by_id_b1ee0c6d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Group_grouparticles`
--
ALTER TABLE `Group_grouparticles`
  ADD CONSTRAINT `Group_grouparticles_article_id_eac38398_fk_BasicArti` FOREIGN KEY (`article_id`) REFERENCES `BasicArticle_articles` (`id`),
  ADD CONSTRAINT `Group_grouparticles_group_id_84ee212d_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  ADD CONSTRAINT `Group_grouparticles_user_id_12983c5c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Group_groupinvitations`
--
ALTER TABLE `Group_groupinvitations`
  ADD CONSTRAINT `Group_groupinvitations_group_id_48a7f8e2_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  ADD CONSTRAINT `Group_groupinvitations_invitedby_id_f7a8ea5c_fk_auth_user_id` FOREIGN KEY (`invitedby_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `Group_groupinvitations_role_id_20c49c7f_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `Group_groupinvitations_user_id_a4a046d3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Group_groupmedia`
--
ALTER TABLE `Group_groupmedia`
  ADD CONSTRAINT `Group_groupmedia_group_id_73f1a47c_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  ADD CONSTRAINT `Group_groupmedia_media_id_bb652569_fk_Media_media_id` FOREIGN KEY (`media_id`) REFERENCES `Media_media` (`id`),
  ADD CONSTRAINT `Group_groupmedia_user_id_e6917c04_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Group_groupmembership`
--
ALTER TABLE `Group_groupmembership`
  ADD CONSTRAINT `Group_groupmembership_group_id_adce78b5_fk_Group_group_id` FOREIGN KEY (`group_id`) REFERENCES `Group_group` (`id`),
  ADD CONSTRAINT `Group_groupmembership_role_id_bb865ffb_fk_auth_group_id` FOREIGN KEY (`role_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `Group_groupmembership_user_id_e4f5757f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Media_media`
--
ALTER TABLE `Media_media`
  ADD CONSTRAINT `Media_media_created_by_id_ae93f7fb_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `Media_media_metadata_id_c939b240_fk_metadata_metadata_id` FOREIGN KEY (`metadata_id`) REFERENCES `metadata_metadata` (`id`),
  ADD CONSTRAINT `Media_media_published_by_id_83121da5_fk_auth_user_id` FOREIGN KEY (`published_by_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `Media_media_state_id_46785feb_fk_workflow_states_id` FOREIGN KEY (`state_id`) REFERENCES `workflow_states` (`id`);

--
-- Constraints for table `notifications_notification`
--
ALTER TABLE `notifications_notification`
  ADD CONSTRAINT `notifications_notifi_action_object_conten_7d2b8ee9_fk_django_co` FOREIGN KEY (`action_object_content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `notifications_notifi_actor_content_type_i_0c69d7b7_fk_django_co` FOREIGN KEY (`actor_content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `notifications_notifi_target_content_type__ccb24d88_fk_django_co` FOREIGN KEY (`target_content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `notifications_notification_recipient_id_d055f3f0_fk_auth_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `nyt_notification`
--
ALTER TABLE `nyt_notification`
  ADD CONSTRAINT `nyt_notification_subscription_id_5a132ae1_fk_nyt_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `nyt_subscription` (`id`),
  ADD CONSTRAINT `nyt_notification_user_id_acbb5c10_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `nyt_notificationtype`
--
ALTER TABLE `nyt_notificationtype`
  ADD CONSTRAINT `nyt_notificationtype_content_type_id_18800dea_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `nyt_settings`
--
ALTER TABLE `nyt_settings`
  ADD CONSTRAINT `nyt_settings_user_id_1fad6d98_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `nyt_subscription`
--
ALTER TABLE `nyt_subscription`
  ADD CONSTRAINT `nyt_subscription_latest_id_bbb7d98b_fk_nyt_notification_id` FOREIGN KEY (`latest_id`) REFERENCES `nyt_notification` (`id`),
  ADD CONSTRAINT `nyt_subscription_notification_type_id_ca8af379_fk_nyt_notif` FOREIGN KEY (`notification_type_id`) REFERENCES `nyt_notificationtype` (`key`),
  ADD CONSTRAINT `nyt_subscription_settings_id_761bae06_fk_nyt_settings_id` FOREIGN KEY (`settings_id`) REFERENCES `nyt_settings` (`id`);

--
-- Constraints for table `Reputation_articleflaglogs`
--
ALTER TABLE `Reputation_articleflaglogs`
  ADD CONSTRAINT `Reputation_articlefl_reason_id_200b641a_fk_Reputatio` FOREIGN KEY (`reason_id`) REFERENCES `Reputation_flagreason` (`id`),
  ADD CONSTRAINT `Reputation_articlefl_resource_id_21412c4c_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `BasicArticle_articles` (`id`),
  ADD CONSTRAINT `Reputation_articleflaglogs_user_id_4bce74ef_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Reputation_articlescorelog`
--
ALTER TABLE `Reputation_articlescorelog`
  ADD CONSTRAINT `Reputation_articlesc_resource_id_ddac6fc9_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `BasicArticle_articles` (`id`);

--
-- Constraints for table `Reputation_articleuserscorelogs`
--
ALTER TABLE `Reputation_articleuserscorelogs`
  ADD CONSTRAINT `Reputation_articleus_resource_id_2a10325b_fk_BasicArti` FOREIGN KEY (`resource_id`) REFERENCES `BasicArticle_articles` (`id`),
  ADD CONSTRAINT `Reputation_articleuserscorelogs_user_id_77095608_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Reputation_communityreputaion`
--
ALTER TABLE `Reputation_communityreputaion`
  ADD CONSTRAINT `Reputation_community_community_id_9fe0df3b_fk_Community` FOREIGN KEY (`community_id`) REFERENCES `Community_community` (`id`),
  ADD CONSTRAINT `Reputation_communityreputaion_user_id_fce03592_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Reputation_mediaflaglogs`
--
ALTER TABLE `Reputation_mediaflaglogs`
  ADD CONSTRAINT `Reputation_mediaflag_reason_id_b7bf0680_fk_Reputatio` FOREIGN KEY (`reason_id`) REFERENCES `Reputation_flagreason` (`id`),
  ADD CONSTRAINT `Reputation_mediaflaglogs_resource_id_1fe0b6c8_fk_Media_media_id` FOREIGN KEY (`resource_id`) REFERENCES `Media_media` (`id`),
  ADD CONSTRAINT `Reputation_mediaflaglogs_user_id_6d095f7f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `Reputation_mediascorelog`
--
ALTER TABLE `Reputation_mediascorelog`
  ADD CONSTRAINT `Reputation_mediascorelog_resource_id_c3f674e3_fk_Media_media_id` FOREIGN KEY (`resource_id`) REFERENCES `Media_media` (`id`);

--
-- Constraints for table `Reputation_mediauserscorelogs`
--
ALTER TABLE `Reputation_mediauserscorelogs`
  ADD CONSTRAINT `Reputation_mediauser_resource_id_461aadb0_fk_Media_med` FOREIGN KEY (`resource_id`) REFERENCES `Media_media` (`id`),
  ADD CONSTRAINT `Reputation_mediauserscorelogs_user_id_ef68208e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `reversion_revision`
--
ALTER TABLE `reversion_revision`
  ADD CONSTRAINT `reversion_revision_user_id_17095f45_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `reversion_version`
--
ALTER TABLE `reversion_version`
  ADD CONSTRAINT `reversion_version_content_type_id_7d0ff25c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `reversion_version_revision_id_af9f6a9d_fk_reversion_revision_id` FOREIGN KEY (`revision_id`) REFERENCES `reversion_revision` (`id`);

--
-- Constraints for table `social_auth_usersocialauth`
--
ALTER TABLE `social_auth_usersocialauth`
  ADD CONSTRAINT `social_auth_usersocialauth_user_id_17d28448_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `taggit_taggeditem`
--
ALTER TABLE `taggit_taggeditem`
  ADD CONSTRAINT `taggit_taggeditem_content_type_id_9957a03c_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `taggit_taggeditem_tag_id_f4f5b767_fk_taggit_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `taggit_tag` (`id`);

--
-- Constraints for table `UserRolesPermission_favourite`
--
ALTER TABLE `UserRolesPermission_favourite`
  ADD CONSTRAINT `UserRolesPermission_favourite_user_id_14680490_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `UserRolesPermission_profileimage`
--
ALTER TABLE `UserRolesPermission_profileimage`
  ADD CONSTRAINT `UserRolesPermission__user_id_2e95d164_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `webcontent_faq`
--
ALTER TABLE `webcontent_faq`
  ADD CONSTRAINT `webcontent_faq_category_id_b92f315f_fk_webcontent_faqcategory_id` FOREIGN KEY (`category_id`) REFERENCES `webcontent_faqcategory` (`id`);

--
-- Constraints for table `webcontent_feedback`
--
ALTER TABLE `webcontent_feedback`
  ADD CONSTRAINT `webcontent_feedback_user_id_943add81_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `wiki_article`
--
ALTER TABLE `wiki_article`
  ADD CONSTRAINT `wiki_article_current_revision_id_fc83ea0a_fk_wiki_arti` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  ADD CONSTRAINT `wiki_article_group_id_bf035c83_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `wiki_article_owner_id_956bc94a_fk_auth_user_id` FOREIGN KEY (`owner_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `wiki_articleforobject`
--
ALTER TABLE `wiki_articleforobject`
  ADD CONSTRAINT `wiki_articleforobjec_content_type_id_ba569059_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `wiki_articleforobject_article_id_7d67d809_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`);

--
-- Constraints for table `wiki_articleplugin`
--
ALTER TABLE `wiki_articleplugin`
  ADD CONSTRAINT `wiki_articleplugin_article_id_9ab0e854_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`);

--
-- Constraints for table `wiki_articlerevision`
--
ALTER TABLE `wiki_articlerevision`
  ADD CONSTRAINT `wiki_articlerevision_article_id_e0fb2474_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `wiki_articlerevision_previous_revision_id_bcfaf4c9_fk_wiki_arti` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  ADD CONSTRAINT `wiki_articlerevision_user_id_c687e4de_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `wiki_attachments_attachment`
--
ALTER TABLE `wiki_attachments_attachment`
  ADD CONSTRAINT `wiki_attachments_att_current_revision_id_d30f6b77_fk_wiki_atta` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_attachments_attachmentrevision` (`id`),
  ADD CONSTRAINT `wiki_attachments_att_reusableplugin_ptr_i_856ba17c_fk_wiki_reus` FOREIGN KEY (`reusableplugin_ptr_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`);

--
-- Constraints for table `wiki_attachments_attachmentrevision`
--
ALTER TABLE `wiki_attachments_attachmentrevision`
  ADD CONSTRAINT `wiki_attachments_att_attachment_id_32ffc4ea_fk_wiki_atta` FOREIGN KEY (`attachment_id`) REFERENCES `wiki_attachments_attachment` (`reusableplugin_ptr_id`),
  ADD CONSTRAINT `wiki_attachments_att_previous_revision_id_e7f09093_fk_wiki_atta` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_attachments_attachmentrevision` (`id`),
  ADD CONSTRAINT `wiki_attachments_att_user_id_2da908ac_fk_auth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `wiki_images_image`
--
ALTER TABLE `wiki_images_image`
  ADD CONSTRAINT `wiki_images_image_revisionplugin_ptr_i_d230f69d_fk_wiki_revi` FOREIGN KEY (`revisionplugin_ptr_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`);

--
-- Constraints for table `wiki_images_imagerevision`
--
ALTER TABLE `wiki_images_imagerevision`
  ADD CONSTRAINT `wiki_images_imagerev_revisionpluginrevisi_ecb726e8_fk_wiki_revi` FOREIGN KEY (`revisionpluginrevision_ptr_id`) REFERENCES `wiki_revisionpluginrevision` (`id`);

--
-- Constraints for table `wiki_notifications_articlesubscription`
--
ALTER TABLE `wiki_notifications_articlesubscription`
  ADD CONSTRAINT `wiki_notifications_a_articleplugin_ptr_id_c9190941_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  ADD CONSTRAINT `wiki_notifications_a_subscription_id_bd1f8af5_fk_nyt_subsc` FOREIGN KEY (`subscription_id`) REFERENCES `nyt_subscription` (`id`);

--
-- Constraints for table `wiki_reusableplugin`
--
ALTER TABLE `wiki_reusableplugin`
  ADD CONSTRAINT `wiki_reusableplugin_articleplugin_ptr_id_c1737239_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`);

--
-- Constraints for table `wiki_reusableplugin_articles`
--
ALTER TABLE `wiki_reusableplugin_articles`
  ADD CONSTRAINT `wiki_reusableplugin__article_id_8a09d39e_fk_wiki_arti` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `wiki_reusableplugin__reusableplugin_id_52618a1c_fk_wiki_reus` FOREIGN KEY (`reusableplugin_id`) REFERENCES `wiki_reusableplugin` (`articleplugin_ptr_id`);

--
-- Constraints for table `wiki_revisionplugin`
--
ALTER TABLE `wiki_revisionplugin`
  ADD CONSTRAINT `wiki_revisionplugin_articleplugin_ptr_id_95c295f2_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`),
  ADD CONSTRAINT `wiki_revisionplugin_current_revision_id_46514536_fk_wiki_revi` FOREIGN KEY (`current_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`);

--
-- Constraints for table `wiki_revisionpluginrevision`
--
ALTER TABLE `wiki_revisionpluginrevision`
  ADD CONSTRAINT `wiki_revisionpluginr_plugin_id_c8f4475b_fk_wiki_revi` FOREIGN KEY (`plugin_id`) REFERENCES `wiki_revisionplugin` (`articleplugin_ptr_id`),
  ADD CONSTRAINT `wiki_revisionpluginr_previous_revision_id_38c877c0_fk_wiki_revi` FOREIGN KEY (`previous_revision_id`) REFERENCES `wiki_revisionpluginrevision` (`id`),
  ADD CONSTRAINT `wiki_revisionpluginrevision_user_id_ee40f729_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `wiki_simpleplugin`
--
ALTER TABLE `wiki_simpleplugin`
  ADD CONSTRAINT `wiki_simpleplugin_article_revision_id_cff7df92_fk_wiki_arti` FOREIGN KEY (`article_revision_id`) REFERENCES `wiki_articlerevision` (`id`),
  ADD CONSTRAINT `wiki_simpleplugin_articleplugin_ptr_id_2b99b828_fk_wiki_arti` FOREIGN KEY (`articleplugin_ptr_id`) REFERENCES `wiki_articleplugin` (`id`);

--
-- Constraints for table `wiki_urlpath`
--
ALTER TABLE `wiki_urlpath`
  ADD CONSTRAINT `wiki_urlpath_article_id_9ef0c0fb_fk_wiki_article_id` FOREIGN KEY (`article_id`) REFERENCES `wiki_article` (`id`),
  ADD CONSTRAINT `wiki_urlpath_moved_to_id_4718abf8_fk_wiki_urlpath_id` FOREIGN KEY (`moved_to_id`) REFERENCES `wiki_urlpath` (`id`),
  ADD CONSTRAINT `wiki_urlpath_parent_id_a6e675ac_fk_wiki_urlpath_id` FOREIGN KEY (`parent_id`) REFERENCES `wiki_urlpath` (`id`),
  ADD CONSTRAINT `wiki_urlpath_site_id_319be912_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`);

--
-- Constraints for table `workflow_transitions`
--
ALTER TABLE `workflow_transitions`
  ADD CONSTRAINT `workflow_transitions_from_state_id_5ff9ea9d_fk_workflow_` FOREIGN KEY (`from_state_id`) REFERENCES `workflow_states` (`id`),
  ADD CONSTRAINT `workflow_transitions_to_state_id_8d6c5cc6_fk_workflow_states_id` FOREIGN KEY (`to_state_id`) REFERENCES `workflow_states` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
