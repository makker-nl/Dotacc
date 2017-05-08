CREATE OR REPLACE PACKAGE body xxx_log
AS
  g_pck_name  CONSTANT ident_type   := 'xxx_log';
  g_insert_logs CONSTANT boolean := true;
  c_unk_error CONSTANT max_varchar2 := 'Unkown error';
--
--
/*******************************************************************************
Put Line
#Version   0.1
#Author    Martien van den Akker
#Usage     To output large teksts
*******************************************************************************/
PROCEDURE put_line(
    p_text IN VARCHAR2)
IS
  --l_text max_varchar2 := p_text;
  --l_line varchar2(255);
BEGIN
  /*while length(l_text) > 0
  loop
  l_line := substr(l_text, 1, 255);
  dbms_output.put_line (l_line);
  l_text := substr(l_text, 256);
  end loop;*/
  dbms_output.put_line (p_text);
END put_line;
--
--
/*******************************************************************************
Put Line
#Version   0.1
#Author    Martien van den Akker
#Usage     To output large teksts
*******************************************************************************/
PROCEDURE put_line(
    p_text IN CLOB)
IS
  l_text max_varchar2;
BEGIN
  --l_text := dbms_lob.substr(p_text, 1, 32767);
  put_line(p_text);
END put_line;
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
    p_parameter_clob IN CLOB DEFAULT NULL )
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
  l_module VARCHAR2(200) := p_package||'.'||p_module;
BEGIN
  IF g_insert_logs THEN
    INSERT
    INTO XXX_LOGS
      (
        MODULE,
        TEXT,
        PARAMETER1,
        PARAMETER2,
        PARAMETER3,
        PARAMETER4,
        PARAMETER5,
        PARAMETER_CLOB
      )
      VALUES
      (
        l_module,
        p_text ,
        p_parameter_1,
        p_parameter_2,
        p_parameter_3,
        p_parameter_4,
        p_parameter_5,
        p_parameter_clob
      );
    COMMIT;
  END IF;
  put_line('Module: '||l_module);
  put_line('Text: '|| p_text);
  IF p_parameter_1 IS NOT NULL THEN
    put_line('Parameter 1: '||p_parameter_1);
  END IF;
  IF p_parameter_2 IS NOT NULL THEN
    put_line('Parameter 2: '||p_parameter_2);
  END IF;
  IF p_parameter_3 IS NOT NULL THEN
    put_line('Parameter 3: '||p_parameter_3);
  END IF;
  IF p_parameter_4 IS NOT NULL THEN
    put_line('Parameter 4: '||p_parameter_4);
  END IF;
  IF p_parameter_5 IS NOT NULL THEN
    put_line('Parameter 5: '||p_parameter_5);
  END IF;
END log;
--
--
/*******************************************************************************
Handle Exception
#Version   0.1
#Author    Martien van den Akker
#Usage     To handle exceptions
*******************************************************************************/
PROCEDURE handle_exception
  (
    p_package     IN VARCHAR2 ,
    p_module      IN VARCHAR2 ,
    p_error_text  IN VARCHAR2 ,
    p_raise       IN BOOLEAN DEFAULT true ,
    p_parameter_1 IN VARCHAR2 DEFAULT NULL ,
    p_parameter_2 IN VARCHAR2 DEFAULT NULL ,
    p_parameter_3 IN VARCHAR2 DEFAULT NULL ,
    p_parameter_4 IN VARCHAR2 DEFAULT NULL ,
    p_parameter_5 IN VARCHAR2 DEFAULT NULL
  )
IS
BEGIN
  put_line('Module: '||p_package||'.'||p_module);
  log( p_package => p_package, p_module => p_module, p_text => 'Error: '||p_error_text, p_parameter_1 => p_parameter_1 , p_parameter_2 => p_parameter_2, p_parameter_3 => p_parameter_3, p_parameter_4 =>p_parameter_4, p_parameter_5 => p_parameter_5);
  IF sqlerrm IS NOT NULL THEN
    log( p_package => p_package, p_module => p_module, p_text => 'Sql error: '||sqlerrm);
  END IF;
  IF p_raise THEN
    raise_application_error( -20000 , 'Error raised in: '||p_package ||'.'||p_module || chr(10) || 'Error: ' || SUBSTR(p_error_text, 1, 200) || chr(10) || 'Sql Error: '||SUBSTR(sqlerrm, 1, 200));
  END IF;
END handle_exception;
--
--
/*******************************************************************************
Fetch the local global_name
#Version   0.1
#Author    Martien van den Akker
#Usage     Fetch the local global_name
*******************************************************************************/
FUNCTION get_global_name
  RETURN VARCHAR2
IS
  l_result max_varchar2;
BEGIN
  SELECT global_name INTO l_result FROM global_name;
  RETURN l_result;
END get_global_name;
--
--
END xxx_log;
/
