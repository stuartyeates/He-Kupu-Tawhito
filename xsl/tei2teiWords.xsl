<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
		xmlns="http://www.tei-c.org/ns/1.0"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- This is a simple stylesheet that inserts word tags around words
  (and implicitly defines what those words are) -->
  
<xsl:include  href="tei2teiWords_mi.xsl"/>
<xsl:include  href="tei2teiWords_en.xsl"/>

  <xsl:template match="@*|node()" priority="-2">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="text()[normalize-space()][not(ancestor::tei:w)]" priority="-1">
    <xsl:variable name='orig' select="."/>
    <xsl:variable name='lang' select="$orig/ancestor::*[normalize-space(@xml:lang)][1]/@xml:lang"/>

    <xsl:analyze-string select="." regex="[\p{{L}}\p{{N}}]+">
      <xsl:matching-substring>
	
	<xsl:element name="w" namespace="http://www.tei-c.org/ns/1.0">
	  <xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
	  <xsl:attribute name="lemma"><xsl:value-of select="."/></xsl:attribute>
	  <xsl:value-of select="."/>
	  </xsl:element>
	  
      </xsl:matching-substring>
      <xsl:non-matching-substring>
	<xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>

