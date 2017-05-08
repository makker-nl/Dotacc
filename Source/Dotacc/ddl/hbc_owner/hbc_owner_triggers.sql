------------------------------------------------
-- Export file for user DOE_OWNER             --
-- Created by makker on 9/19/2008, 4:33:08 PM --
------------------------------------------------

spool hbc_owner_triggers.log

prompt
prompt Creating trigger HBC_CMR_BRI
prompt ============================
prompt
create or replace trigger hbc_OWNER.HBC_CMR_BRI
  before insert or update on HBC_customers  
  for each row
declare
  -- local variables here
begin
  if :new.birth_date<sysdate then
    raise_application_error(-20000,'Birthdate should be in the past');
  end if;
end HBC_CMR_BRI;
/
