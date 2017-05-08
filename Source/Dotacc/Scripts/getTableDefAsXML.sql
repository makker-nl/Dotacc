set server output on
declare
  l_result CLob;
begin
  dbms_output.enable(1000000);
  xxx_log.put_line('Start');
  l_result := xxx_table_definitions.getTableDefAsXML( pTableOwner => 'SOS'--'&pTableOwner'
                           , pTableName => 'SOS_EXPORTS'--'&pTableName'
                           ); 
  xxx_log.put_line(dbms_lob.substr(l_result));
end;