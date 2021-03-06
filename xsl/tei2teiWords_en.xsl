<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
		xmlns="http://www.tei-c.org/ns/1.0"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- This is a simple stylesheet that inserts word tags around words
  (and implicitly defines what those words are) -->

  <xsl:variable name="loweren" select="'qwertyuiopasdfghjklzxcvbnm'"/>
  <xsl:variable name="upperen" select="'QWERTYUIOPASDFGHJKLZXCVBNM'"/>
  

  <xsl:template match="text()[normalize-space()][ancestor::*[normalize-space(@xml:lang)][1]/@xml:lang='en']">
    <xsl:variable name='orig' select="."/>
    <xsl:variable name='lang' select="$orig/ancestor::*[normalize-space(@xml:lang)][1]/@xml:lang"/>

    <xsl:analyze-string select="." regex="[\p{{L}}\p{{N}}]+">
      <xsl:matching-substring>

	<xsl:variable name="normalised" select="translate(.,$upperen,$loweren)"/>
	
	<xsl:element name="w" namespace="http://www.tei-c.org/ns/1.0">
	  <xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
	  <xsl:attribute name="lemma"><xsl:value-of select="$normalised"/></xsl:attribute>
	  <xsl:value-of select="."/>
	  </xsl:element>
	  
      </xsl:matching-substring>
      <xsl:non-matching-substring>
	<xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>

</xsl:stylesheet>

