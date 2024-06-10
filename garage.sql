
CREATE TABLE IF NOT EXISTS `bp_garages` (
  `garageid` int(11) NOT NULL AUTO_INCREMENT,
  `garagetype` longtext DEFAULT NULL,
  `garageowner` longtext DEFAULT NULL,
  `garagemeta` longtext DEFAULT NULL,
  `garageimg` longtext DEFAULT NULL,
  `garagename` longtext DEFAULT NULL,
  `garageownername` longtext DEFAULT NULL,
  PRIMARY KEY (`garageid`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb4;

