<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:nzetc="http://www.nzetc.org/structure"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- put URLs to to the NZETC website into 'n' attributes of
       documents so we can preserve deep linking back to the source -->

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="*[@nzetc:id][@nzetc:has-text='true']">
    <xsl:variable name='lang' select="ancestor-or-self::*[normalize-space(@xml:lang)][1]/@xml:lang"/>
    <xsl:copy>
      <xsl:attribute name="n">http://www.nzetc.org/tm/scholarly/<xsl:value-of select="@nzetc:id"/>.html</xsl:attribute>
      <xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
  </xsl:template>

<!--
  <xsl:template match="*">
    <xsl:variable name='lang' select="ancestor-or-self::*[normalize-space(@xml:lang)][1]/@xml:lang"/>
    <xsl:copy>
      <xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
      <xsl:apply-templates select="@*|node()"/>
     </xsl:copy>
  </xsl:template>
-->

  <!--swallow the any original n attributes -->
  <xsl:template match="@n"/>

</xsl:stylesheet>

