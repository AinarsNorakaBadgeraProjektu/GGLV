ALTER TABLE `users`
ADD `woundData` text DEFAULT NULL;


CREATE TABLE IF NOT EXISTS `ecg` (
  `ActiveECG` int(11) DEFAULT NULL,
  `handle` varchar(50) DEFAULT NULL,
  `prop` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('ecg', 'Ecg', 1, 0, 1),
	('pager', 'Pager', 1, 0, 1),
	('tourniquet', 'Tourniquet', 1, 0, 1),
	('field_dressing', 'Field Dressing', 1, 0, 1),
	('elastic_bandage', 'Elastic Bandage', 1, 0, 1),
	('quick_clot', 'Quick Clot', 1, 0, 1),
	('packing_bandage', 'Packing Bandage', 1, 0, 1),
	('sewing_kit', 'Sewing Kit', 1, 0, 1),
	('epinephrine', 'Epinephrine', 1, 0, 1),
	('morphine', 'Morphine', 1, 0, 1),
	('blood250ml', 'Blood Pack 250ml', 1, 0, 1),
	('blood500ml', 'Blood Pack 500ml', 1, 0, 1),
	('saline250ml', 'Saline Pack 250ml', 1, 0, 1),
	('saline500ml', 'Saline Pack 500ml', 1, 0, 1),
	('revivekit', 'Emergency Revive Kit', 1, 0, 1),
	('wheelchair', 'Wheelchair', 1, 0, 1),
	('crutch', 'Crutch', 1, 0, 1),
	('stretcher', 'Stretcher', 1, 0, 1),
	('bodybag', 'Bodybag', 1, 0, 1),
	('bandage', 'Bandage', 1, 0, 1),
	('ifak', 'IFAK', 1, 0, 1),
	('painkillers', 'Painkillers', 1, 0, 1),
	('temporary_tourniquet', 'Temporary Tourniquet', 1, 0, 1);