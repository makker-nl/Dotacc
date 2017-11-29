CREATE OR REPLACE PACKAGE BODY xxx_xslt
AS
  -- Reset the parameters on the stylesheet and then set the new
  -- parameter values based on the parameters in the paramlist.
PROCEDURE setParams(
    p_stylesheet xslprocessor.Stylesheet,
    p_params t_paramlist)
IS
BEGIN
  dbms_xslprocessor.resetParams(p_stylesheet);
  IF p_params.exists(1) THEN
    FOR i IN 1 .. p_params.COUNT
    LOOP
      IF p_params(i).name IS NOT NULL AND p_params(i).value IS NOT NULL THEN
        dbms_xslprocessor.setParam(p_stylesheet, p_params(i).name, p_params(i).value);
      END IF;
    END LOOP;
  END IF;
END setParams;
--
--
--The "stylesheet" functions create a new stylesheet object from
-- an XML source. Remember to call freeStylesheet() when you're done
-- using the stylesheet.
--
/**
* Returns a new processor instance
*/
FUNCTION new_Processor
  RETURN dbms_xslprocessor.Processor
IS
  l_Processor dbms_xslprocessor.Processor;
BEGIN
  l_Processor := dbms_xslprocessor.newprocessor;
  RETURN l_Processor;
END new_Processor;
--
--
/**
* Free XSL Processor
*/
PROCEDURE free_Processor(
    p_Processor dbms_xslprocessor.Processor)
IS
BEGIN
  dbms_xslprocessor.freeProcessor(p_Processor);
END free_Processor;
--
--
-- Return an XSLT stylesheet based on XML document with the stylesheet source
FUNCTION new_stylesheet(
    p_stylesheet dbms_xmldom.DOMDocument)
  RETURN dbms_xslprocessor.Stylesheet
IS
  l_stylesheet dbms_xslprocessor.Stylesheet;
BEGIN
  l_stylesheet := dbms_xslprocessor.newStylesheet(p_stylesheet, NULL);
  RETURN l_stylesheet ;
END new_stylesheet;
--
--
-- Return an XSLT stylesheet based on a varchar2 with the stylesheet source
FUNCTION new_stylesheet(
    p_stylesheet VARCHAR2)
  RETURN dbms_xslprocessor.Stylesheet
IS
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_new_stylesheet dbms_xslprocessor.Stylesheet;
BEGIN
  l_xmldomdoc      := xxx_xml.parse(p_stylesheet);
  l_new_stylesheet := new_Stylesheet(l_xmldomdoc);
  xxx_xml.free_Document(l_xmldomdoc);
  RETURN l_new_stylesheet;
EXCEPTION
WHEN OTHERS THEN
  xxx_xml.free_Document(l_xmldomdoc);
  RAISE;
END new_stylesheet;
--
--
-- Return an XSLT stylesheet based on a CLOB with the stylesheet source
FUNCTION new_stylesheet(
    p_stylesheet CLOB)
  RETURN dbms_xslprocessor.Stylesheet
IS
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_new_stylesheet dbms_xslprocessor.Stylesheet;
BEGIN
  l_xmldomdoc      := xxx_xml.parse(p_stylesheet);
  l_new_stylesheet := new_Stylesheet(l_xmldomdoc);
  xxx_xml.free_Document(l_xmldomdoc);
  RETURN l_new_stylesheet;
EXCEPTION
WHEN OTHERS THEN
  xxx_xml.free_Document(l_xmldomdoc);
  RAISE;
END new_stylesheet;
--
--
-- Return an XSLT stylesheet based on a BFILE with the stylesheet source
FUNCTION new_stylesheet(
    p_stylesheet BFILE)
  RETURN xslprocessor.Stylesheet
IS
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_new_stylesheet dbms_xslprocessor.Stylesheet;
BEGIN
  l_xmldomdoc      := xxx_xml.parse(p_stylesheet);
  l_new_stylesheet := new_Stylesheet(l_xmldomdoc);
  xxx_xml.free_Document(l_xmldomdoc);
  RETURN l_new_stylesheet;
EXCEPTION
WHEN OTHERS THEN
  xxx_xml.free_Document(l_xmldomdoc);
  RAISE;
END new_stylesheet;
--
--
-- Return an XSLT stylesheet based on a stylesheet source from an url.
FUNCTION new_stylesheet_From_URL(
    p_url VARCHAR2)
  RETURN xslprocessor.Stylesheet
IS
  l_new_stylesheet dbms_xslprocessor.Stylesheet;
BEGIN
  l_new_stylesheet := dbms_xslprocessor.newStylesheet(p_url, NULL);
  RETURN l_new_stylesheet;
END new_stylesheet_From_URL;
--
--
-- Methods to transform an XML Document with an XSLT stylesheet, returning a varchar2
--
-- Transform  the XML document source  using the XSLT stylesheet.
-- The resulting target document is returned as a varchar2.
FUNCTION transform(
    p_xml dbms_xmldom.DOMDocument,
    p_stylesheet dbms_xslprocessor.Stylesheet,
    p_params t_paramlist := none)
  RETURN VARCHAR2
IS
  l_processor dbms_xslprocessor.Processor;
  l_result VARCHAR2(32767);
BEGIN
  l_processor := new_Processor();
  setParams(p_stylesheet, p_params);
  dbms_xslprocessor.processXSL(p => l_processor, ss =>p_stylesheet, xmldoc =>p_xml, buffer => l_result);
  free_Processor(l_processor);
  RETURN l_result;
EXCEPTION
WHEN OTHERS THEN
  free_Processor(l_processor);
  RAISE;
END transform;
--
--
-- Transform  the XML document source in varchar2  using the XSLT stylesheet.
-- The resulting target document is returned as a varchar2.
FUNCTION transform(
    p_xml VARCHAR2,
    p_stylesheet dbms_xslprocessor.Stylesheet,
    p_params t_paramlist := none)
  RETURN VARCHAR2
IS
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_return VARCHAR2(32767);
BEGIN
  l_xmldomdoc := xxx_xml.parse(p_xml);
  l_return    := transform( p_xml => l_xmldomdoc, p_stylesheet => p_stylesheet , p_params => p_params );
  xxx_xml.free_document(l_xmldomdoc);
  RETURN l_return;
END transform;
--
--
-- Transform  the XML document source in CLOB  using the XSLT stylesheet as CLOB.
-- The resulting target document is returned as a varchar2.
FUNCTION transform(
    p_xml CLOB,
    p_stylesheet CLOB,
    p_params t_paramlist := none)
  RETURN VARCHAR2
IS
  l_stylesheet dbms_xslprocessor.Stylesheet;
  l_xmldomdoc dbms_xmldom.DOMDocument;
  l_return VARCHAR2(32767);
BEGIN
  l_stylesheet := new_stylesheet(p_stylesheet);
  l_xmldomdoc  := xxx_xml.parse(p_xml);
  l_return     := transform( p_xml => l_xmldomdoc, p_stylesheet => l_stylesheet , p_params => p_params );
  free_stylesheet(l_stylesheet);
  xxx_xml.free_document(l_xmldomdoc);
  RETURN l_return;
END transform;
--
--
-- Methods to transform an XML Document with an XSLT stylesheet, returning a CLOB
--
-- Transform  the XML document source  using the XSLT stylesheet.
-- The resulting target document is returned as a CLOB.
FUNCTION transformToCLOB(
    p_xml dbms_xmldom.DOMDocument,
    p_stylesheet dbms_xslprocessor.Stylesheet,
    p_params t_paramlist := none)
  RETURN CLOB
IS
  l_result CLOB;
  l_processor dbms_xslprocessor.Processor;
  l_domdocfrag dbms_xmldom.DOMDocumentFragment;
  l_domnode dbms_xmldom.DOMNode;
BEGIN
  l_processor := new_Processor();
  setParams(p_stylesheet, p_params);
  dbms_lob.createTemporary(l_result,true,DBMS_LOB.SESSION);
  dbms_xslprocessor.processXSL(p => l_processor, ss =>p_stylesheet, xmldoc =>p_xml, cl => l_result);
  free_Processor(l_processor);
  RETURN l_result;
EXCEPTION
WHEN OTHERS THEN
  free_Processor(l_processor);
  RAISE;
END transformToCLOB;
--
--
-- Transform  the CLOB source  using the XSLT stylesheet in CLOB.
-- The resulting target document is returned as a CLOB.
FUNCTION transformToCLOB(
    p_xml CLOB,
    p_stylesheet CLOB,
    p_params t_paramlist := none)
  RETURN CLOB
IS
  l_xml dbms_xmldom.DOMDocument;
  l_stylesheet dbms_xslprocessor.Stylesheet;
  l_result CLOB;
BEGIN
  l_stylesheet := new_stylesheet(p_stylesheet);
  l_xml        := xxx_xml.parse(p_xml);
  l_result     := transformToClob( p_xml => l_xml, p_stylesheet =>l_stylesheet, p_params => p_params );
  free_stylesheet(l_stylesheet);
  xxx_xml.free_document(l_xml);
  RETURN l_result;
END transformToCLOB;
--
--
-- Methods to transform an XML Document with an XSLT stylesheet, returning an XML DOM Document
--
-- Transform  the XML document source  using the XSLT stylesheet.
-- The resulting target document is returned as a XML DOM Document.
FUNCTION transformToDOM(
    p_xml dbms_xmldom.DOMDocument,
    p_stylesheet dbms_xslprocessor.Stylesheet,
    p_params t_paramlist := none)
  RETURN dbms_xmldom.DOMDocument
IS
  l_domdocfrag dbms_xmldom.DOMDocumentFragment;
  l_domdoc dbms_xmldom.DOMDocument;
  l_processor dbms_xslprocessor.Processor;
BEGIN
  l_processor := new_Processor();
  setParams(p_stylesheet, p_params);
  l_domdocfrag := dbms_xslprocessor.processXSL(p => l_processor, ss =>p_stylesheet, xmldoc =>p_xml);
  free_Processor(l_processor);
  l_domdoc:= xxx_xml.make_document(p_xmldomdocfrag=> l_domdocfrag);
  xxx_xml.free_documentfragment(l_domdocfrag);
  RETURN l_domdoc;
EXCEPTION
WHEN OTHERS THEN
  free_Processor(l_processor);
  RAISE;
END transformToDOM;
--
--
-- Transform  the XML document source  using the XSLT stylesheet.
-- The resulting target document is returned as a XML DOM Document.
FUNCTION transformToDOM(
    p_xml CLOB,
    p_stylesheet CLOB,
    p_params t_paramlist := none)
  RETURN dbms_xmldom.DOMDocument
IS
  l_xml dbms_xmldom.DOMDocument;
  l_stylesheet dbms_xslprocessor.Stylesheet;
  l_domdoc dbms_xmldom.DOMDocument;
BEGIN
  l_stylesheet := new_stylesheet(p_stylesheet);
  l_xml        := xxx_xml.parse(p_xml);
  l_domdoc     := transformToDOM( p_xml => l_xml, p_stylesheet => l_stylesheet, p_params => p_params );
  free_stylesheet(l_stylesheet);
  xxx_xml.free_document(l_xml);
  RETURN l_domdoc;
END transformToDOM;
--
--
-- Construct a paramlist object based on one or more pairs of 'name', 'value' parameters.
-- Return a paramlist to be used for a transformation
FUNCTION new_paramlist(
    p_name1  VARCHAR2,
    p_value1 VARCHAR2,
    p_name2  VARCHAR2 := NULL,
    p_value2 VARCHAR2 := NULL,
    p_name3  VARCHAR2 := NULL,
    p_value3 VARCHAR2 := NULL,
    p_name4  VARCHAR2 := NULL,
    p_value4 VARCHAR2 := NULL,
    p_name5  VARCHAR2 := NULL,
    p_value5 VARCHAR2 := NULL)
  RETURN t_paramlist
IS
  p_list t_paramlist;
BEGIN
  p_list(1).name    := p_name1;
  p_list(1).value   := p_value1;
  IF p_name2        IS NOT NULL AND p_value2 IS NOT NULL THEN
    p_list(2).name  := p_name2;
    p_list(2).value := p_value2;
  END IF;
  IF p_name3        IS NOT NULL AND p_value3 IS NOT NULL THEN
    p_list(3).name  := p_name3;
    p_list(3).value := p_value3;
  END IF;
  IF p_name4        IS NOT NULL AND p_value4 IS NOT NULL THEN
    p_list(4).name  := p_name4;
    p_list(4).value := p_value4;
  END IF;
  IF p_name5        IS NOT NULL AND p_value5 IS NOT NULL THEN
    p_list(5).name  := p_name5;
    p_list(5).value := p_value5;
  END IF;
  RETURN p_list;
END;
--
--
-- Release the memory used by a stylesheet
PROCEDURE free_Stylesheet(
    p_stylesheet dbms_xslprocessor.Stylesheet)
IS
BEGIN
  dbms_xslprocessor.freeStylesheet(ss => p_stylesheet);
END;
--
--
END xxx_xslt;