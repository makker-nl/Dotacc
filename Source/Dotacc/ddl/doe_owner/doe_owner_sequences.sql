------------------------------------------------
-- Export file for user DOE_OWNER             --
-- Created by makker on 9/19/2008, 4:32:49 PM --
------------------------------------------------

spool doe_owner_sequences.log

prompt
prompt Creating sequence DOE_EMP_SEQ
prompt =============================
prompt
create sequence DOE_OWNER.DOE_EMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence DOE_FNC_SEQ
prompt =============================
prompt
create sequence DOE_OWNER.DOE_FNC_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence DOE_IAY_SEQ
prompt =============================
prompt
create sequence DOE_OWNER.DOE_IAY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence DOE_MAY_SEQ
prompt =============================
prompt
create sequence DOE_OWNER.DOE_MAY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence DOE_MTL_SEQ
prompt =============================
prompt
create sequence DOE_OWNER.DOE_MTL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 61
increment by 1
cache 20;


spool off
