------------------------------------------------
-- Export file for user DOE_OWNER             --
-- Created by makker on 9/19/2008, 4:33:08 PM --
------------------------------------------------

spool doe_owner_triggers.log

prompt
prompt Creating trigger DOE_CMR_BRI
prompt ============================
prompt
create or replace trigger DOE_OWNER.DOE_CMR_BRI
  before insert or update on doe_customers  
  for each row
declare
  -- local variables here
begin
  if :new.birth_date<sysdate then
    raise_application_error(-20000,'Birthdate should be in the past');
  end if;
end DOE_CMR_BRI;
/

prompt
prompt Creating trigger DOE_EMP_BRI
prompt ============================
prompt
create or replace trigger DOE_OWNER.DOE_EMP_BRI
  before insert or update on doe_employees  
  for each row
declare
  -- local variables here
begin
  if :new.birth_date<sysdate then
    raise_application_error(-20000,'Birthdate should be in the past');
  end if;
end DOE_EMP_BRI;
/


spool off
