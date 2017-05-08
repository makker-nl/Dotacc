------------------------------------------------
-- Export file for user HBC_OWNER             --
-- Created by makker on 9/19/2008, 3:49:10 PM --
------------------------------------------------

spool hbc_owner_sequences.log

prompt
prompt Creating sequence HBC_ADS_SEQ
prompt =============================
prompt
create sequence HBC_OWNER.HBC_ADS_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence HBC_AMN_SEQ
prompt =============================
prompt
create sequence HBC_OWNER.HBC_AMN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence HBC_PAY_SEQ
prompt =============================
prompt
create sequence HBC_OWNER.HBC_PAY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 261
increment by 1
cache 20;

prompt
prompt Creating sequence HBC_PLC_SEQ
prompt =============================
prompt
create sequence HBC_OWNER.HBC_PLC_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 381
increment by 1
cache 20;


spool off
