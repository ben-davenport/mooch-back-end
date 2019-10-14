# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.27)
# Database: mooch
# Generation Time: 2019-10-14 19:35:51 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cities
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cities`;

CREATE TABLE `cities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cityName` varchar(50) DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `price` int(5) DEFAULT NULL,
  `feature` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table messages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sender` int(11) unsigned NOT NULL,
  `recipient` int(11) unsigned NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  KEY `recipient` (`recipient`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `users` (`id`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`recipient`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table reservations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `reservations`;

CREATE TABLE `reservations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned DEFAULT NULL,
  `tid` int(10) unsigned DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table tools
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tools`;

CREATE TABLE `tools` (
  `tool_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) unsigned NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `details` text,
  `category` tinytext,
  `availability` varchar(50) DEFAULT NULL,
  `imageUrl` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tool_id`),
  KEY `uid` (`uid`),
  CONSTRAINT `tools_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `tools` WRITE;
/*!40000 ALTER TABLE `tools` DISABLE KEYS */;

INSERT INTO `tools` (`tool_id`, `uid`, `title`, `location`, `details`, `category`, `availability`, `imageUrl`)
VALUES
	(1,11,'#1 Hammer','','TONS OF DETAILS','housework','2','/images/1570549597112hammer.jpg'),
	(2,11,'Lawn Mower','','A lawn mower, for you!','gardening','2','/images/1570553469301hammer.jpg'),
	(3,11,'Drill','','High speed transmission delivers 2 speeds (0-600 and 0-2000 RPM) for a range of fastening and drilling applications.\n\nErgonomic handle and lightweight design deliver comfort and control.\n\nHeavy-duty 1/2 in. ratcheting chuck with carbide inserts provides superior bit gripping strength.\n\nIncludes: DCD785 hammer drill, two 1.5Ah batteries, fast charger, belt hook and on-board bit holder.\n\nCompatible with DCB200 and DCB201 batteries and DCB101 and DCB119 chargers.','construction','Every Day','/images/1570977522330drill.jpg'),
	(4,12,'Benchtop Lathe','','10 In. X 18 In. 5 Speed 1/2 HP Benchtop Wood Lathe\nFive speeds: 750, 1100, 1600, 2200 and 3200 RPM\n8 in. x 30 in. footprint\n','other','Weekends Only','/images/1571002835453lathe.jpg');

/*!40000 ALTER TABLE `tools` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first` varchar(50) NOT NULL DEFAULT '',
  `last` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `token` varchar(50) DEFAULT NULL,
  `state` varchar(2) NOT NULL DEFAULT '',
  `city` varchar(25) NOT NULL DEFAULT '',
  `street` varchar(40) NOT NULL DEFAULT '',
  `about` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `first`, `last`, `password`, `email`, `date_added`, `date_updated`, `token`, `state`, `city`, `street`, `about`)
VALUES
	(11,'A','AA','$2a$10$Xbd4Cy8WU81.9cZeaXBW/u/UKNHdg1kasRr1UZHw3SB/o7xDjpFwy','a@a.a','2019-10-08 11:06:15','2019-10-13 15:38:06','HOxZFheaECf3yHVWKwGnyd2GhN8DqI3MGidTInMdOejlPSuwII','GA','Atlanta','4th Street','AAA'),
	(12,'Ben','Malone','$2a$10$mIM8fXw9cMWFyDXsqnThJO36nMGHwxkbzzDLgppjSqF1tKgQFZEUm','b@b.b','2019-10-13 15:39:31','2019-10-14 10:54:57','vrRwjwhU0ji7axWVHFOhu2GWGqKh5J4uQD235C580Sc55JbM3P','GA','Atlanta','583 St Charles Avenue NE','I\'m living in Atlanta and I love to do carpentry and woodworking. let me know if you need anything specific.');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
