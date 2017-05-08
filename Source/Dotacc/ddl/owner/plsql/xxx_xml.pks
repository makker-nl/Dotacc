CREATE OR REPLACE PACKAGE xxx_xml
AS
  /******************************************************************************
  Purpose         : Functionality to parse XML documents.
  Usage           : From scripts or packages.
  (c) 2008-2014 Darwin-IT Professionals, Martien van den Akker
  Change History
  When        Who            What
  12-06-2014  MAkker         Initial Creation
  *******************************************************************************/
  --
  --
  -- Parse an XML document in a varchar2 and return a handle to the in-memory
  -- DOM Document representation of the parsed XML.
  -- Call freeDocument() when you're done using the document returned by the function.
  FUNCTION parse(
      p_xml VARCHAR2)
    RETURN DBMS_XMLDOM.DOMDocument;
  --
  --
  -- Parse an XML document in a CLOB and return a handle to the in-memory
  -- DOM Document representation of the parsed XML.
  -- Call freeDocument() when you're done using the document returned by the function.
  FUNCTION parse(
      p_xml CLOB)
    RETURN DBMS_XMLDOM.DOMDocument;
  --
  --
  -- Parse an XML document from a BFILE and return a handle to the in-memory DOM Document
  -- representation of the parsed XML.
  -- Call freeDocument() when you're done using the document returned by the function.
  FUNCTION parse(
      p_xmlfile BFILE)
    RETURN xmldom.DOMDocument;
  --
  --
  -- Parse an XML document using the default parser from an URL and return a handle
  -- to the in-memory roM Document representation of the parsed XML.
  -- Set a proxy when needed.
  -- Call freeDocument() when you're done using the document returned by the function.
  FUNCTION parseURL(
      p_url VARCHAR2)
    RETURN xmldom.DOMDocument;
  --
  --
  -- Transforms an XML Dom Document Fragment to a DomDocument
  FUNCTION make_document(
      p_xmldomdocfrag dbms_xmldom.DOMDocumentFragment)
    RETURN dbms_xmldom.DOMDocument;
  --
  --
  -- Free the Java objects associated with an in-memory DOM tree
  PROCEDURE free_document(
      p_xmldomdoc DBMS_XMLDOM.DOMDocument);
  --
  -- Free the Java objects associated with an in-memory DOM tree
  PROCEDURE free_documentfragment(
      p_xmldomdocfrag dbms_xmldom.DOMDocumentFragment);
--
--
END xxx_xml;