-- Adding foreign keys

alter table `security_database`.`user_role`
add constraint `urfk` foreign key (`uid`)
references `security_database`.`user_account`(`user_account_id`);

alter table `security_database`.`assigned_with`
add constraint `awurfk` foreign key (`aw_role_id`)
references `security_database`.`user_role`(`role_id`);

alter table `security_database`.`assigned_with`
add constraint `awuafk` foreign key (`aw_uid`)
references `security_database`.`user_account`(`user_account_id`);

alter table `security_database`.`account_privilege`
add constraint `apuafk` foreign key (`ap_uid`)
references `security_database`.`user_account`(`user_account_id`);

alter table `security_database`.`account_privilege`
add constraint `apurfk` foreign key (`ap_role_id`)
references `security_database`.`user_role`(`role_id`);

alter table `security_database`.`relation_privilege`
add constraint `rpurfk` foreign key (`rp_role_id`)
references `security_database`.`user_role`(`role_id`);

alter table `security_database`.`relation_privilege`
add constraint `rptfk` foreign key (`rp_table_name`)
references `security_database`.`table`(`table_name`);

alter table `security_database`.`table`
add constraint `turfk` foreign key (`table_role_id`)
references `security_database`.`user_role`(`role_id`);

alter table `security_database`.`table`
add constraint `trpfk` foreign key (`table_rp_name`)
references `security_database`.`relation_privilege`(`rel_priv_name`);

alter table `security_database`.`part_of`
add constraint `pfurfk` foreign key (`role_id`)
references `security_database`.`user_role`(`role_id`);

alter table `security_database`.`part_of`
add constraint `pftfk` foreign key (`po_table_name`)
references `security_database`.`table`(`table_name`);

alter table `security_database`.`part_of`
add constraint `pfrpfk` foreign key (`po_rp_name`)
references `security_database`.`relation_privilege`(`rel_priv_name`);