<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- updates the cache options of the exist config files -->

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@collectionCache" > 
    <xsl:attribute name="collectionCache">100M</xsl:attribute>
  </xsl:template>

  <xsl:template match="@cacheSize" > 
    <xsl:attribute name="cacheSize">1000M</xsl:attribute>
  </xsl:template>

  
</xsl:stylesheet>
