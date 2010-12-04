<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:nzetc="http://www.nzetc.org/structure"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- ensure that every xml element (tag) has an xml:id -->

  <xsl:namespace-alias  stylesheet-prefix = "tei" result-prefix = "#default" />

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:if test="not(@xml:id)">
	<xsl:attribute name="xml:id">
	  <xsl:value-of select="generate-id()"/>
	</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
