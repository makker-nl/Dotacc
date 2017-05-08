declare
 lResult clob;
 lResultVC varchar2(32767);
begin
  -- Call the function
  --dbms_output.enable(1000000);
  xxx_log.put_line('Start');
  lResult := xxx_xml_gen.generateontable( ptableowner => 'SOS'--'&ptableowner',
                                        , ptablename => 'SOS_EXPORTS'--'&ptablename',
                                        , ptemplatename => 'CreateObjectTypeBody'-- '&ptemplatename'
                                        );
  
  /*xxx_log.put_line(lResult);
  
  lResultVC := dbms_lob.substr(lResult);
  lResultVC := xxx_xml_gen.replaceEntities(lResultVC);
  xxx_log.put_line(lresultvc);*/
  --xxx_xml_gen.execute(lResult);
  xxx_log.put_line('Einde');
end;
