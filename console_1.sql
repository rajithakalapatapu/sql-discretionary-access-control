
-- First transaction
-- a new user is added to user_account with uid:212 which is the primary key of this table and unique.
insert into security_database.user_account(user_account_id, fname, lname, area_code, state_code, number)
values(212,'rinku','pane',123,345,5678);

-- Second transaction
-- a new role is added to user_role with role_id:700 which is the primary kry of this table and unique.
-- uid:212 is the foreign key which refers to the user_account_id of user_account table.
insert into security_database.user_role(role_id, role_name, description, uid)
values(700,'dbread','can read the tables','212');

-- third transaction
-- a new entry table_name:table1 is added into table.
-- table_uid:141 determines the owner of this new table1 , which is also the foreign key referring to user_account_id of user_account table.
insert into security_database.table(table_name,table_uid,table_role_id,table_rp_name) VALUE
("table1",141,400,"R3");

-- fourth transaction
-- to insert a new tuple into account_privilege if the privilege type is account privilege.
insert into security_database.account_privilege(acc_priv_name, ap_uid, ap_role_id)
values('A6',212,700);

-- fifth transaction
-- to relate user account to user role m:n relationship is maintained in new table assigned_with.
-- to relate a new user to new role can be achieved by making entry in this table.
insert into security_database.assigned_with(aw_role_id, aw_uid)
values(700,212);
insert into security_database.assigned_with(aw_role_id, aw_uid)
values(600,212);
insert into security_database.assigned_with(aw_role_id, aw_uid)
values(600,141);
select * from security_database.assigned_with where aw_role_id=200;

-- sixth transaction
-- to relate account_privilege to user_role,
-- example we are selecting acc_priv_name which is primary key in account_privilege table
-- which is assigned with ap_uid foreign key referring to user_account_id of user_account table.
select * from security_database.account_privilege where account_privilege.acc_priv_name='A6';

-- seventh transaction
-- to relate relation privilege, role and table,
-- we have a ternary relationship part_of
select * from security_database.part_of where po_rp_name='R4'and po_table_name ='record' and role_id=500




