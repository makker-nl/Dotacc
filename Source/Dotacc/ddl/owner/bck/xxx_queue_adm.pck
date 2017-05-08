create or replace package xxx_queue_adm is
/*******************************************************************************************
  Administration utilities for queues.

  #Version  1.0
  #Author   Martien van den Akker
  #Usage    Recreating Log en Error queues

  <b>Change History</b>

  When Who: What
  <ul>
   <li>19-okt-2006 Martien van den Akker: Initial Creation</li>
  </ul>
********************************************************************************************/
/******************************************************************************
  Determine name of the app_queue_table according to app_name

  #Author   Martien van den Akker, Oracle Consulting
  #usage    Determine name of the app_queue_table according to app_name

  #param    p_name           name of the application
*******************************************************************************/
function queue_table_name (p_name in varchar2 )
return varchar2;
/******************************************************************************
  Determine name of the app_queue according to app_name

  #Author   Martien van den Akker, Oracle Consulting
  #usage    Determine name of the app_queue according to app_name

  #param    p_name           name of the application
*******************************************************************************/
function queue_name(p_name in varchar2 )
return varchar2;
/******************************************************************************
  Add a queue to a queue table

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Recreate a queue table.
*******************************************************************************/
procedure add_queue
 (p_queue_name in varchar2
 ,p_queue_table in varchar2
 ,p_comment in varchar2 := null
 ,p_start_queue in boolean := true
 ,p_create_table in boolean := false
 ,p_tablespace in varchar2 := null
 ,p_payload_type in varchar2 := 'RAW'
 ,p_multiple_consumers in boolean := true
 );
 /*******************************************************************************************
  Recreate queues

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Recreate queues object queue

  #param    p_name                 base name queue and the table
  #param    p_object_name          name of the object used for the payload
  #param    p_tablespace           name of the tablespace
********************************************************************************************/
procedure recreate_object_queue( p_name        in varchar2
                               , p_object_name in varchar2
                               , p_tablespace  in varchar2
                               , p_comment     in varchar2 := null);
end xxx_queue_adm;
/
create or replace package body xxx_queue_adm is

/* Default suffix for queue-names */
g_queue_sfx constant varchar2(30) := '_Q';
/* Default prefix for queue names */
g_queue_pfx constant varchar2(30) := 'xxx_';
/* Default prefix for queue-table-names */
g_queue_table_pfx constant varchar2(30) := 'xxx_';
/* Default suffix for queue-table-names */
g_queue_table_sfx constant varchar2(30) := '_QT';
/* Default prefix for subscriber-names */
g_subscriber_pfx constant varchar2(30) := 'B2B_';
/* Default suffix for subscriber-names */
g_subscriber_sfx constant varchar2(30) := '_USER';

-- Global name of the database
g_global_name global_name.global_name%type;
/******************************************************************************
  Fetch Global Database Name

  #Author   Martien van den Akker, Oracle Consulting
  #usage    Fetch Global Database Name

  #return    Global Name
*******************************************************************************/
function get_global_name
return varchar2
is
/* Return variable */
  l_return global_name.global_name%type;
cursor c_gne
 is
select global_name
from   global_name
;
begin
  open c_gne;
  fetch c_gne into l_return;
  close c_gne;
  return l_return;
exception
   when others then
      if c_gne%isopen then close c_gne; end if;
      raise;
end get_global_name;
/******************************************************************************
  Determine name of the app_queue_table according to app_name

  #Author   Martien van den Akker, Oracle Consulting
  #usage    Determine name of the app_queue_table according to app_name

  #param    p_name           name of the application
*******************************************************************************/
function queue_table_name (p_name in varchar2 )
return varchar2
is
/* Return variable */
l_return varchar2(30);
begin
  l_return := g_queue_table_pfx || p_name || g_queue_table_sfx;
  return l_return;
end queue_table_name;
/******************************************************************************
  Determine name of the app_queue according to app_name

  #Author   Martien van den Akker, Oracle Consulting
  #usage    Determine name of the app_queue according to app_name

  #param    p_name           name of the application
*******************************************************************************/
function queue_name(p_name in varchar2 )
return varchar2
is
/* Return variable */
l_return varchar2(30);
begin
   l_return := g_queue_pfx || p_name || g_queue_sfx;
   return l_return;
end queue_name;
/******************************************************************************
  Determine name of the app_queue according to app_name

  #Author   Martien van den Akker, Oracle Consulting
  #usage    Determine name of the app_queue according to app_name

  #param    p_name           name of the application
*******************************************************************************/
function subscriber_name(p_name in varchar2 )
return varchar2
is
/* Return variable */
l_return varchar2(30);
begin
   l_return := g_subscriber_pfx || p_name || g_subscriber_Sfx;
   return l_return;
end subscriber_name;
/*******************************************************************************************
  Stop and drop a queue.

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Drop a queue table.

  #param    p_queue_name           name of the queueu tables to drop
********************************************************************************************/
procedure drop_queue
 (p_queue_name in varchar2
 )
 is
begin
   dbms_aqadm.stop_queue(queue_name => p_queue_name);
   dbms_aqadm.drop_queue(queue_name => p_queue_name);
exception -- ignore errors
  when others then null;
end drop_queue;
/*******************************************************************************************
  Stop and drop all queues in queue table

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Drop a queue table.

  #param    p_queue_table           name of the queueu tables to drop
********************************************************************************************/
procedure drop_all_queues
 (p_queue_table in user_queue_tables.queue_table%type
 )
 is
cursor c_uqe
 (b_queue_table in user_queue_tables.queue_table%type
 )
 is
select name
from   user_queues uqe
where  uqe.queue_table = b_queue_table
;
begin
   for r_uqe in c_uqe(b_queue_table => p_queue_table)
   loop
      drop_queue(p_queue_name => r_uqe.name);
   end loop;
exception -- ignore errors
  when others then raise;-- null;
end drop_all_queues;
procedure drop_queue_table
 (p_name in varchar2
 ,p_force in boolean := true
 ,p_auto_commit in boolean := true
 )
 is
begin
   dbms_aqadm.drop_queue_table( queue_table => p_name
                              , force => p_force
                              , auto_commit => p_auto_commit);
exception -- ignore errors
  when others then null;
end drop_queue_table;
/*******************************************************************************************
  Drop all queue tables like p_name%

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Drop all queue tables like p_name%

  #param    p_name           name of the queueu tables to drop
********************************************************************************************/
procedure drop_all_queue_tables(p_name in varchar2 := null)
 is
cursor c_qte
 (b_queue_table in user_queue_tables.queue_table%type
 )
 is
select qte.queue_table
from user_queue_tables qte
where qte.queue_table like b_queue_table||'%'
or    b_queue_table is null
;
begin
   for r_qte in c_qte(b_queue_table => p_name)
   loop
      drop_all_queues(p_queue_table => r_qte.queue_table);
      drop_queue_table(p_name => r_qte.queue_table);
   end loop;
exception -- ignore errors
  when others then null;
end drop_all_queue_tables;
/******************************************************************************
  Recreate a queue table.

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Recreate a queue table.
 *******************************************************************************/
procedure recreate_queue_table
 (p_name in varchar2
 ,p_tablespace in varchar2
 ,p_payload_type in varchar2 := 'RAW'
 ,p_multiple_consumers in boolean := true
 ,p_storage in varchar2 := null
 ,p_sort_list in varchar2 := 'priority,enq_time'
 ,p_compatible in varchar2 := '8.1'
 )
 is
/* Variable to build up storage clause */
l_storage_clause varchar2(1000);
begin
  /* drop the queue-table */
  begin
     drop_queue_table( p_name  => p_name);
  exception
     when others then
        null; -- ignore errors in dropping the table;
  end;
  /* determine storage clause */
  l_storage_clause := 'tablespace '||p_tablespace;
  if p_storage is not null
  then
     l_storage_clause := l_storage_clause ||' storage ('|| p_storage ||')';
  end if;
  /* create it again */
  dbms_aqadm.create_queue_table
    ( queue_table        => p_name
    , queue_payload_type => p_Payload_type
    , multiple_consumers => p_multiple_consumers
    , storage_clause     => l_storage_clause
    , sort_list          => p_sort_list
    , compatible         => p_compatible
    );
  /* make exception queue dequeue-enabled */
  dbms_aqadm.start_queue( queue_name => 'AQ$_'||p_name||'_E'
                        , enqueue => false
                        , dequeue => true );
exception -- don't ignore errors when creating the queue table
  when others then raise;
end recreate_queue_table;
/******************************************************************************
  Add a subscriber to a queue 

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Add a subscriber to a queue
*******************************************************************************/
procedure add_subscriber( p_subscriber_name in varchar2
                        , p_queue_name in varchar2)
is
  l_subscriber sys.aq$_agent;
begin
  l_subscriber := sys.aq$_agent(p_subscriber_name, NULL, NULL);
  dbms_aqadm.add_subscriber(p_queue_name, l_subscriber, null);
END add_subscriber;
/******************************************************************************
  Add a queue to a queue table

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Recreate a queue table.
*******************************************************************************/
procedure add_queue
 (p_queue_name in varchar2
 ,p_queue_table in varchar2
 ,p_comment in varchar2 := null
 ,p_start_queue in boolean := true
 ,p_create_table in boolean := false
 ,p_tablespace in varchar2 := null
 ,p_payload_type in varchar2 := 'RAW'
 ,p_multiple_consumers in boolean := true
 )
 IS

/* Name of the queue to be added */
l_queue_name varchar2(30);
/* Name of the queue-table to be added */
l_queue_table varchar2(30);
begin
  /* Create the queue-table */
  if p_create_table
  then
     if p_tablespace is null
     then
        raise_application_error(-20000, 'Provide tablespace name');
     else
        recreate_queue_table( p_name               => p_queue_table
                            , p_tablespace         => p_tablespace
                            , p_payload_type       => p_payload_type
                            , p_multiple_consumers => p_multiple_consumers);
     end if;
  end if;
  /* Create the queue */
  dbms_aqadm.create_queue( queue_name  => p_queue_name
                         , queue_table => p_queue_table
                         , comment     => p_comment);
  /* Grant privileges to public */
  dbms_aqadm.grant_queue_privilege(privilege => 'ENQUEUE', queue_name => p_queue_name, grantee => 'PUBLIC');
  dbms_aqadm.grant_queue_privilege(privilege => 'DEQUEUE', queue_name => p_queue_name, grantee => 'PUBLIC');
  /* Start the queue */
  if p_start_queue then
     dbms_aqadm.start_queue(queue_name => p_queue_name);
  end if;
exception
  when others then
     raise;
end add_queue;
/*******************************************************************************************
  Recreate queues

  #Version  1.0
  #Author   Martien van den Akker, Martien van den Akker, Oracle Consulting
  #usage    Recreate queues object queue

  #param    p_name                 base name queue and the table
  #param    p_object_name          name of the object used for the payload
  #param    p_tablespace           name of the tablespace
********************************************************************************************/
procedure recreate_object_queue( p_name        in varchar2
                               , p_object_name in varchar2
                               , p_tablespace  in varchar2
                               , p_comment     in varchar2 := null)
is
begin
  xxx_queue_adm.add_queue( p_queue_name         => xxx_queue_adm.queue_name(p_name)
                         , p_queue_table        => xxx_queue_adm.queue_table_name(p_name)
                         , p_comment            => p_comment
                         , p_start_queue        => true
                         , p_create_table       => true
                         , p_tablespace         => p_tablespace
                         , p_payload_type       => p_object_name
                         , p_multiple_consumers => false);
end recreate_object_queue;
begin
  -- Initialization
  g_global_name := get_global_name;
end xxx_queue_adm;
/
