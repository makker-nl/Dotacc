CREATE OR REPLACE PACKAGE       "XXX_LOG" as
/*******************************************************************************
  Package for handling errors and do logging

  #version   0.3
  #Author    Martien van den Akker
  #Usage     For testing purposes at KPN

  <b>Change History</b>

  When Who: What
  <ul>
    <li>06-nov-2008 Martien van den Akker:  Initial Creation </li>
  </ul>
*******************************************************************************/
--
--  
  subtype max_varchar2   is varchar2(32767);
  subtype ident_type     is varchar2(30);
  subtype dbl_ident_type is varchar2(61);
--
--
  /*******************************************************************************
  Put Line

  #Version   0.1
  #Author    Martien van den Akker
  #Usage     To output large teksts
*******************************************************************************/
  procedure put_line(p_text in varchar2);
--
--
/*******************************************************************************
  Put Line

  #Version   0.1
  #Author    Martien van den Akker
  #Usage     To output large teksts
*******************************************************************************/
  procedure put_line(p_text in clob);
--
--
/*******************************************************************************
Log
#Version   0.1
#Author    Martien van den Akker
#Usage     log text to the database
*******************************************************************************/
PROCEDURE log(
    p_package        IN VARCHAR2 ,
    p_module         IN VARCHAR2 ,
    p_text           IN VARCHAR2 ,
    p_parameter_1    IN VARCHAR2 DEFAULT NULL ,
    p_parameter_2    IN VARCHAR2 DEFAULT NULL ,
    p_parameter_3    IN VARCHAR2 DEFAULT NULL ,
    p_parameter_4    IN VARCHAR2 DEFAULT NULL ,
    p_parameter_5    IN VARCHAR2 DEFAULT NULL ,
    p_parameter_clob IN CLOB DEFAULT NULL );
--
--
/*******************************************************************************
  Handle Exception

  #Version   0.1
  #Author    Martien van den Akker
  #Usage     To handle exceptions
*******************************************************************************/
  procedure handle_exception( p_package      in VARCHAR2
                            , p_module       in varchar2
                            , p_error_text   in varchar2
                            , p_raise        in boolean default true
                            , p_parameter_1  in varchar2 default null
                            , p_parameter_2  in varchar2 default null
                            , p_parameter_3  in varchar2 default null
                            , p_parameter_4  in varchar2 default null
                            , p_parameter_5  in varchar2 default null);
--
--
/*******************************************************************************
  Fetch the local global_name

  #Version   0.1
  #Author    Martien van den Akker
  #Usage     Fetch the local global_name
*******************************************************************************/
 function get_global_name
 return varchar2;
--
--
end xxx_log;