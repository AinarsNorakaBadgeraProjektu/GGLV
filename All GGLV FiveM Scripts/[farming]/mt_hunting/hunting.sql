CREATE TABLE `hunting_users` (
	`identifier` VARCHAR(50) NOT NULL,
	`name` LONGTEXT NULL DEFAULT NULL ,
	`xp` INT(11) NOT NULL DEFAULT '0',
	`totalanimals` INT(11) NOT NULL DEFAULT '0',
	`tournamentanimals` INT(11) NOT NULL DEFAULT '0',
	`tournamentxp` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`identifier`) USING BTREE
);

CREATE TABLE `hunting_tournaments` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`winner` VARCHAR(50) NOT NULL DEFAULT '',
	`prize` INT(11) NOT NULL DEFAULT '0',
	`starttime` INT(11) NOT NULL DEFAULT '0',
	`endtime` INT(11) NOT NULL DEFAULT '0',
	`finished` INT(11) NULL DEFAULT NULL,
	PRIMARY KEY (`id`) USING BTREE
);