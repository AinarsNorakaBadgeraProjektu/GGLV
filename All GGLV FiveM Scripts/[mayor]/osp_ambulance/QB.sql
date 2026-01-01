ALTER TABLE `players`
ADD `woundData` text DEFAULT NULL;


CREATE TABLE IF NOT EXISTS `ecg` (
  `ActiveECG` int(11) DEFAULT NULL,
  `handle` varchar(50) DEFAULT NULL,
  `prop` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
