-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.28-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- Volcando estructura para tabla esxlegacy_44b028.dispatch_callsigns
CREATE TABLE IF NOT EXISTS `dispatch_callsigns` (
  `identifier` varchar(46) NOT NULL,
  `callsign` varchar(50) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_cameras
CREATE TABLE IF NOT EXISTS `dispatch_cameras` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `model` varchar(50) NOT NULL,
  `coords` varchar(255) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_jail_database
CREATE TABLE IF NOT EXISTS `dispatch_jail_database` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_identifier` varchar(255) NOT NULL,
  `jail_reason` varchar(255) NOT NULL,
  `jail_time` int(11) NOT NULL,
  `jail_start` timestamp NOT NULL DEFAULT current_timestamp(),
  `jail_end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_mdt_bolos
CREATE TABLE IF NOT EXISTS `dispatch_mdt_bolos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CreatorName` varchar(50) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  `title` varchar(50) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `officers_involved` text DEFAULT NULL,
  `createdAt` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_mdt_convictions
CREATE TABLE IF NOT EXISTS `dispatch_mdt_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `charges` text DEFAULT NULL,
  `warrant` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_mdt_data
CREATE TABLE IF NOT EXISTS `dispatch_mdt_data` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`identifier` VARCHAR(46) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`tags` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`jobtype` VARCHAR(25) NULL DEFAULT 'police' COLLATE 'utf8mb4_general_ci',
	`pfp` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`notes` MEDIUMTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	INDEX `id` (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=7
;


-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_mdt_incidents
CREATE TABLE IF NOT EXISTS `dispatch_mdt_incidents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `CreatorName` varchar(50) DEFAULT NULL,
  `jobtype` varchar(25) DEFAULT 'police',
  `title` varchar(50) DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `citizens_involved` text DEFAULT NULL,
  `criminals_involved` text DEFAULT NULL,
  `officers_involved` text DEFAULT NULL,
  `createdAt` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_players_database
CREATE TABLE IF NOT EXISTS `dispatch_players_database` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext NOT NULL,
  `datatype` varchar(1200) NOT NULL DEFAULT 'undefinedData',
  `dataobj` longtext NOT NULL,
  `createdAt` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla esxlegacy_44b028.dispatch_vehicle_database
CREATE TABLE IF NOT EXISTS `dispatch_vehicle_database` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datatype` varchar(50) DEFAULT NULL,
  `by` varchar(50) DEFAULT NULL,
  `plate` varchar(50) NOT NULL,
  `data` longtext DEFAULT NULL,
  `createdAt` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;


ALTER TABLE `dispatch_mdt_data` CHANGE `tags` `tags` TEXT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci';