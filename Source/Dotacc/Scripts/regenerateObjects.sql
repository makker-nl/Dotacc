prompt setupTables
prompt ___________
@@..\ddl\owner\setupTables.sql
prompt setupPlSql
prompt ___________
@@..\ddl\owner\setupPlsql.sql
-- prompt insert EN XSL styltesheets
-- prompt __________________________
--@@..\ddl\owner\insertXslEN2.0.sql
prompt insert NL XSL styltesheets
prompt __________________________
@@..\ddl\owner\insertXslNL2.0.sql
prompt insert Table defninitions
prompt __________________________
@@..\Config\Insert_tables.sql
prompt insert FK defninitions
prompt __________________________
@@..\Config\Insert_fk_definitions.sql
prompt insert Custom methods
prompt __________________________
@@..\Config\Insert_custom_methods.sql
prompt insert Derived columns
prompt __________________________
@@..\Config\Insert_Derived_columns.sql
prompt regenerate the objects.
prompt __________________________
BEGIN
  xxx_gen_objects.recreate_objects;
END;
/

@@..\ddl\owner\dropPlsql.sql
@@..\ddl\owner\dropTables.sql