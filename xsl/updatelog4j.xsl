<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes" doctype-public="log4j:configuration" doctype-system="log4j.dtd" />

  <!-- updates the cache options of the exist config files -->

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="root" > 
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <appender-ref ref="exist.profiling"/>
      <appender-ref ref="exist.xmldb"/>
     </xsl:copy>
  </xsl:template>

  
</xsl:stylesheet>
