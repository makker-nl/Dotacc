CREATE OR REPLACE PACKAGE BODY xxx_xml
AS
  parse_error EXCEPTION;
  PRAGMA EXCEPTION_INIT(parse_error, -20100);
--
--
-- Example code for using a proxy server.
--  http_proxy_host VARCHAR2(200);
--  http_proxy_port VARCHAR2(5) := '80';
/*  PROCEDURE setHttpProxy(machinename VARCHAR2, port VARCHAR2 := '80') IS
BEGIN
  http_proxy_host := machinename;
  http_proxy_port := port;
END;
--
-- Set HTTP Proxy for Java programs in the current session.
PROCEDURE setProxy IS
BEGIN
  IF http_proxy_host IS Not NULL THEN
    http_util.setProxy(http_proxy_host, http_proxy_port);
  END IF;
END;*/
--
--
-- Get a new xmlparser.
FUNCTION new_parser
  RETURN dbms_xmlparser.Parser
IS
  l_parser dbms_xmlparser.Parser;
BEGIN
  l_parser := dbms_xmlparser.newparser;
  RETURN l_parser;
END new_parser;
--
--
-- free the xml parser.
PROCEDURE free_parser(
    p_parser dbms_xmlparser.Parser)
IS
BEGIN
  dbms_xmlparser.freeparser(p_parser);
END free_parser;
--
--
-- Parse an XML document in a varchar2 and return a handle to the in-memory
-- DOM Document representation of the parsed XML.
-- Call freeDocument() when you're done using the document returned by the function.
FUNCTION parse(
    p_xml VARCHAR2)
  RETURN DBMS_XMLDOM.DOMDocument
IS
  l_xmldomdoc DBMS_XMLDOM.DOMDocument;
  l_parser dbms_xmlparser.Parser;
BEGIN
  IF p_xml   IS NOT NULL THEN
    l_parser := new_parser;
    dbms_xmlparser.parseBuffer(l_parser, p_xml);
    l_xmldomdoc := dbms_xmlparser.GETDOCUMENT(l_parser);
    free_Parser(l_parser);
  END IF;
  RETURN l_xmldomdoc;
EXCEPTION
WHEN parse_error THEN
  free_Parser(l_parser);
  RETURN l_xmldomdoc;
WHEN OTHERS THEN
  free_Parser(l_parser);
  raise;
END parse;
--
--
-- Parse an XML document in a CLOB and return a handle to the in-memory
-- DOM Document representation of the parsed XML.
-- Call freeDocument() when you're done using the document returned by the function.
FUNCTION parse(
    p_xml CLOB)
  RETURN DBMS_XMLDOM.DOMDocument
IS
  l_xmldomdoc DBMS_XMLDOM.DOMDocument;
  l_parser dbms_xmlparser.Parser;
BEGIN
  IF p_xml   IS NOT NULL THEN
    l_parser := new_parser;
    dbms_xmlparser.parseCLOB(l_parser, p_xml);
    l_xmldomdoc := dbms_xmlparser.GETDOCUMENT(l_parser);
    free_Parser(l_parser);
  END IF;
  RETURN l_xmldomdoc;
EXCEPTION
WHEN parse_error THEN
  free_Parser(l_parser);
  RETURN l_xmldomdoc;
WHEN OTHERS THEN
  free_Parser(l_parser);
  raise;
END parse;
--
--
-- Parse an XML document from a BFILE and return a handle to the in-memory DOM Document
-- representation of the parsed XML.
-- Call freeDocument() when you're done using the document returned by the function.
FUNCTION parse(
    p_xmlfile BFILE)
  RETURN xmldom.DOMDocument
IS
  l_xmldomdoc DBMS_XMLDOM.DOMDocument;
  l_bfile BFILE := p_xmlfile;
  l_xmlClob CLOB;
BEGIN
  IF p_xmlfile IS NOT NULL THEN
    dbms_lob.createtemporary(l_xmlClob, cache => FALSE);
    dbms_lob.fileOpen(l_bfile);
    dbms_lob.loadFromFile(dest_lob => l_xmlClob, src_lob => l_bfile, amount => dbms_lob.getLength(l_bfile));
    dbms_lob.fileClose(l_bfile);
    l_xmldomdoc := parse(l_xmlclob);
    dbms_lob.freetemporary(l_xmlClob);
  END IF;
  RETURN l_xmldomdoc;
END parse;
--
--
-- Parse an XML document using the default parser from an URL and return a handle
-- to the in-memory roM Document representation of the parsed XML.
-- Set a proxy when needed.
-- Call freeDocument() when you're done using the document returned by the function.
FUNCTION parseURL(
    p_url VARCHAR2)
  RETURN xmldom.DOMDocument
IS
  l_xmldomdoc DBMS_XMLDOM.DOMDocument;
BEGIN
  IF p_url IS NOT NULL THEN
    --setproxy;
    l_xmldomdoc:=dbms_xmlparser.parse( url => p_url);
  END IF;
  RETURN l_xmldomdoc;
END;
--
--
-- Transforms an XML Dom Document Fragment to a DomDocument
FUNCTION make_document(
    p_xmldomdocfrag dbms_xmldom.DOMDocumentFragment)
  RETURN dbms_xmldom.DOMDocument
IS
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_xmldomnode dbms_xmldom.DOMNode;
BEGIN
  l_xmldomnode := dbms_xmldom.makenode(df=>p_xmldomdocfrag);
  l_xmldomdoc  := dbms_xmldom.makedocument(n=>l_xmldomnode);
  RETURN l_xmldomdoc;
END make_document;
--
--
-- Free the Java objects associated with an in-memory DOM tree
PROCEDURE free_document(
    p_xmldomdoc DBMS_XMLDOM.DOMDocument)
IS
BEGIN
  dbms_xmldom.freedocument(p_xmldomdoc);
END free_document;
--
--
-- Free the Java objects associated with an in-memory DOM tree
PROCEDURE free_documentfragment(
    p_xmldomdocfrag dbms_xmldom.DOMDocumentFragment)
IS
BEGIN
  dbms_xmldom.freeDocFrag(df => p_xmldomdocfrag);
END free_documentfragment;
--
--
END xxx_xml;
/
