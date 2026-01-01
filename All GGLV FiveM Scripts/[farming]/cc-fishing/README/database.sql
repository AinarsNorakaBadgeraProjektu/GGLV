CREATE TABLE IF NOT EXISTS `fishing_tournaments` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `fish_type` VARCHAR(50) NOT NULL,
    `start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` ENUM('active', 'completed') NOT NULL DEFAULT 'active',
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `fishing_tournament_catches` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`player_id` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`fish_type` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`fish_length` FLOAT(10,2) NOT NULL,
	`catch_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`tournament_id` INT(11) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `tournament_id` (`tournament_id`) USING BTREE,
	CONSTRAINT `fishing_tournament_catches_ibfk_1` FOREIGN KEY (`tournament_id`) REFERENCES `fishing_tournaments` (`id`) ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS `fishing_challenges` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`player_id` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`challenge_id` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`progress` INT(11) NOT NULL DEFAULT '0',
	`completed` TINYINT(1) NOT NULL DEFAULT '0',
	`rewarded` TINYINT(1) NOT NULL DEFAULT '0',
	`date` DATE NOT NULL,
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `player_challenge_date` (`player_id`, `challenge_id`, `date`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `fishing_leaderboard` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`player_id` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`fish_type` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`fish_length` FLOAT(10,2) NOT NULL,
	`catch_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`) USING BTREE
);

CREATE TABLE IF NOT EXISTS `fishing_nets` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`owner` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`location_x` FLOAT NOT NULL,
	`location_y` FLOAT NOT NULL,
	`location_z` FLOAT NOT NULL,
	`placement_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`durability` INT(11) NOT NULL DEFAULT '100',
	`rotation_x` FLOAT NULL DEFAULT '0',
	`rotation_y` FLOAT NULL DEFAULT '0',
	`rotation_z` FLOAT NULL DEFAULT '0',
	`bait` LONGTEXT NULL DEFAULT '{}' COLLATE 'utf8mb4_bin',
	`catches` LONGTEXT NULL DEFAULT '[]' COLLATE 'utf8mb4_bin',
	`zone_info` TEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	CONSTRAINT `bait` CHECK (json_valid(`bait`)),
	CONSTRAINT `catches` CHECK (json_valid(`catches`))
);

CREATE TABLE IF NOT EXISTS `fishing_stats` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `player_id` VARCHAR(50) NOT NULL,
    `skill_level` INT(11) NOT NULL DEFAULT 1,
    `experience` INT(11) NOT NULL DEFAULT 0,
    `logbook` JSON NOT NULL,
    `last_updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `player_id` (`player_id`)
);

CREATE TABLE IF NOT EXISTS `fishing_supply` (
    `fish_type` VARCHAR(50) NOT NULL,
    `supply` INT NOT NULL DEFAULT 100,
    `demand` INT NOT NULL DEFAULT 100,
    `current_multiplier` FLOAT NOT NULL DEFAULT 1.0,
    `last_update` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`fish_type`)
);
