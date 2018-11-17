CREATE TABLE `user_account` (
  `user_account_id` int(225) NOT NULL,
  `fname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) DEFAULT NULL,
  `area_code` int(11) DEFAULT NULL,
  `state_code` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `user_role` (
  `role_id` int(225) NOT NULL,
  `role_name` varchar(225) DEFAULT NULL,
  `description` varchar(225) DEFAULT NULL,
  `uid` int(225) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  KEY `ur_ua_idx` (`uid`),
  CONSTRAINT `urfk` FOREIGN KEY (`uid`) REFERENCES `user_account` (`user_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `assigned_with` (
  `aw_role_id` int(225) NOT NULL,
  `aw_uid` int(225) NOT NULL,
  PRIMARY KEY (`aw_role_id`,`aw_uid`),
  KEY `awuafk` (`aw_uid`),
  CONSTRAINT `awuafk` FOREIGN KEY (`aw_uid`) REFERENCES `user_account` (`user_account_id`),
  CONSTRAINT `awurfk` FOREIGN KEY (`aw_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `account_privilege` (
  `acc_priv_name` varchar(225) NOT NULL,
  `ap_uid` int(225) DEFAULT NULL,
  `ap_role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`acc_priv_name`),
  KEY `apuafk` (`ap_uid`),
  KEY `apurfk` (`ap_role_id`),
  CONSTRAINT `apuafk` FOREIGN KEY (`ap_uid`) REFERENCES `user_account` (`user_account_id`),
  CONSTRAINT `apurfk` FOREIGN KEY (`ap_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `relation_privilege` (
  `rel_priv_name` varchar(225) NOT NULL,
  `rp_role_id` int(225) DEFAULT NULL,
  `rp_table_name` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`rel_priv_name`),
  KEY `rpurfk` (`rp_role_id`),
  KEY `rptfk` (`rp_table_name`),
  CONSTRAINT `rptfk` FOREIGN KEY (`rp_table_name`) REFERENCES `table` (`table_name`),
  CONSTRAINT `rpurfk` FOREIGN KEY (`rp_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `table` (
  `table_name` varchar(255) NOT NULL,
  `table_uid` int(255) DEFAULT NULL,
  `table_role_id` int(255) DEFAULT NULL,
  `table_rp_name` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`table_name`),
  KEY `turfk` (`table_role_id`),
  KEY `trpfk` (`table_rp_name`),
  CONSTRAINT `trpfk` FOREIGN KEY (`table_rp_name`) REFERENCES `relation_privilege` (`rel_priv_name`),
  CONSTRAINT `turfk` FOREIGN KEY (`table_role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `part_of` (
  `role_id` int(255) NOT NULL,
  `po_table_name` varchar(255) NOT NULL,
  `po_rp_name` varchar(225) NOT NULL,
  PRIMARY KEY (`role_id`,`po_table_name`,`po_rp_name`),
  KEY `pftfk` (`po_table_name`),
  KEY `pfrpfk` (`po_rp_name`),
  CONSTRAINT `pfrpfk` FOREIGN KEY (`po_rp_name`) REFERENCES `relation_privilege` (`rel_priv_name`),
  CONSTRAINT `pftfk` FOREIGN KEY (`po_table_name`) REFERENCES `table` (`table_name`),
  CONSTRAINT `pfurfk` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
