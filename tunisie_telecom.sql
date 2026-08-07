-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 23 août 2024 à 08:47
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tunisie_telecom`
--

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add objectif', 7, 'add_objectif'),
(26, 'Can change objectif', 7, 'change_objectif'),
(27, 'Can delete objectif', 7, 'delete_objectif'),
(28, 'Can view objectif', 7, 'view_objectif'),
(29, 'Can add vente', 8, 'add_vente'),
(30, 'Can change vente', 8, 'change_vente'),
(31, 'Can delete vente', 8, 'delete_vente'),
(32, 'Can view vente', 8, 'view_vente'),
(33, 'Can add resultat', 9, 'add_resultat'),
(34, 'Can change resultat', 9, 'change_resultat'),
(35, 'Can delete resultat', 9, 'delete_resultat'),
(36, 'Can view resultat', 9, 'view_resultat'),
(37, 'Can add user', 10, 'add_customuser'),
(38, 'Can change user', 10, 'change_customuser'),
(39, 'Can delete user', 10, 'delete_customuser'),
(40, 'Can view user', 10, 'view_customuser'),
(41, 'Can add user', 11, 'add_customuser'),
(42, 'Can change user', 11, 'change_customuser'),
(43, 'Can delete user', 11, 'delete_customuser'),
(44, 'Can view user', 11, 'view_customuser');

-- --------------------------------------------------------

--
-- Structure de la table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'myapp', 'objectif'),
(8, 'myapp', 'vente'),
(9, 'myapp', 'resultat'),
(11, 'myapp', 'customuser');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-07-08 01:15:25.021687'),
(2, 'auth', '0001_initial', '2024-07-08 01:15:25.633609'),
(3, 'admin', '0001_initial', '2024-07-08 01:15:25.989212'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-07-08 01:15:25.989212'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-07-08 01:15:26.011013'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-07-08 01:15:26.083254'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-07-08 01:15:26.116595'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-07-08 01:15:26.154005'),
(9, 'auth', '0004_alter_user_username_opts', '2024-07-08 01:15:26.166477'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-07-08 01:15:26.203597'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-07-08 01:15:26.203597'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-07-08 01:15:26.217085'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-07-08 01:15:26.253584'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-07-08 01:15:26.299062'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-07-08 01:15:26.350163'),
(16, 'auth', '0011_update_proxy_permissions', '2024-07-08 01:15:26.365238'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-07-08 01:15:26.400870'),
(18, 'myapp', '0001_initial', '2024-07-08 01:15:26.414995'),
(19, 'myapp', '0002_alter_objectif_table', '2024-07-08 01:15:26.422885'),
(20, 'myapp', '0003_vente_alter_objectif_table', '2024-07-08 01:15:26.448319'),
(21, 'myapp', '0004_alter_objectif_table', '2024-07-08 01:15:26.458400'),
(22, 'myapp', '0005_resultat_alter_vente_produit_alter_vente_table', '2024-07-08 01:15:26.503881'),
(23, 'myapp', '0006_auto_20240708_0301', '2024-07-08 01:15:26.503881'),
(24, 'sessions', '0001_initial', '2024-07-08 01:15:26.554318'),
(25, 'myapp', '0002_alter_customuser_options_alter_customuser_groups_and_more', '2024-07-24 14:21:52.023402'),
(26, 'myapp', '0003_alter_customuser_options_alter_customuser_groups_and_more', '2024-07-24 14:21:52.099891');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('piwjtxk1i4ogmxvo60ty700yl4cw4qqf', 'e30:1sW3qk:toOpHW37h4fpsSQa2ZlE21sJpzAGQrMC7IopzWOUEok', '2024-08-06 00:57:54.612301'),
('aeqzun4aqz17xva9f2ejjslefnt5zt2t', '.eJxVjMsOwiAQRf-FtSGAMIBL9_0GMgMztmrapI-V8d-1SRe6veec-1IFt7Uv28JzGZq6KMjq9DsS1gePO2l3HG-TrtO4zgPpXdEHXXQ3NX5eD_fvoMel_9aJ2QffDNfEvsKZSEJGqhXEpWwoGOesiBhpQhJj9GwNeEEESB6sen8AONM42Q:1shPdv:Md6iHTS8AD8vBwx7a1FtwRht1eKOXTHIqa0PYWQ1m_k', '2024-09-06 08:27:35.226064'),
('xe7t4qcxwia3kn4yr8x7mz3yjl9e5mxy', '.eJxVjMsOwiAQRf-FtSEMr4JL934DYWCQqoGktCvjv2uTLnR7zzn3xULc1hq2QUuYMzszx06_G8b0oLaDfI_t1nnqbV1m5LvCDzr4tWd6Xg7376DGUb-18lIrkC5KZ0ACFCwawUzCEFgUNgNZUzR5nVBNSSAZ9M466TRFnwt7fwC1uTdK:1sWJz6:0c1naptlDC0oFyAe9Kwf2Me5Mz--9hZ3H44jvutiTxw', '2024-08-06 18:11:36.943102'),
('027th1rw838lxhvyo7cmng1rq5qps215', 'e30:1sWLcM:GHa-j_lvXYUkea12w-DfYVc_QXUTetHyZNX6eIDtyQ0', '2024-08-06 19:56:14.255556');

-- --------------------------------------------------------

--
-- Structure de la table `myapp_admin`
--

DROP TABLE IF EXISTS `myapp_admin`;
CREATE TABLE IF NOT EXISTS `myapp_admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_staff` tinyint(1) NOT NULL DEFAULT '0',
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  `last_login` datetime DEFAULT NULL,
  `date_joined` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_username` (`username`(100)),
  UNIQUE KEY `unique_email` (`email`(100))
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `myapp_admin_groups`
--

DROP TABLE IF EXISTS `myapp_admin_groups`;
CREATE TABLE IF NOT EXISTS `myapp_admin_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customuser_id` (`admin_id`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `myapp_admin_user_permissions`
--

DROP TABLE IF EXISTS `myapp_admin_user_permissions`;
CREATE TABLE IF NOT EXISTS `myapp_admin_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customuser_id` (`admin_id`),
  KEY `permission_id` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `objectif`
--

DROP TABLE IF EXISTS `objectif`;
CREATE TABLE IF NOT EXISTS `objectif` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `categorie` varchar(100) NOT NULL,
  `objectif_quantite` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `objectif`
--

INSERT INTO `objectif` (`id`, `date`, `categorie`, `objectif_quantite`) VALUES
(187, '2024-01-31', 'offres_mobiles_prépayées', 112);

-- --------------------------------------------------------

--
-- Structure de la table `resultat`
--

DROP TABLE IF EXISTS `resultat`;
CREATE TABLE IF NOT EXISTS `resultat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date_mensuel` date NOT NULL,
  `categorie` varchar(100) NOT NULL,
  `somme_quantite_vendue` int NOT NULL,
  `objectif_quantite` int NOT NULL,
  `taux` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `resultat`
--

INSERT INTO `resultat` (`id`, `date_mensuel`, `categorie`, `somme_quantite_vendue`, `objectif_quantite`, `taux`) VALUES
(259, '2024-01-31', 'offres_mobiles_prépayées', 1355, 112, 1209.8);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
