<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:nzetc="http://www.nzetc.org/structure"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- convert lots of random tei tags to either tei:div or tei:p -->

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="tei:table  |tei:cell |tei:front|tei:back|tei:body|tei:figure|tei:list">
    <tei:div>
      <xsl:apply-templates select="@*|node()"/>
    </tei:div>
 </xsl:template>

  <xsl:template match="tei:cell| tei:figure|tei:item| tei:label|
		       tei:opener| tei:closer| tei:head">
    <tei:p>
      <xsl:apply-templates select="@*|node()"/>
    </tei:p>
 </xsl:template>
</xsl:stylesheet>

