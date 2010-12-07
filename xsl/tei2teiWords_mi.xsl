<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
		xmlns="http://www.tei-c.org/ns/1.0"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output indent="yes"/>

  <!-- This is a simple stylesheet that inserts word tags around words
  (and implicitly defines what those words are) -->

  <xsl:variable name="lowernormal" select="'qwertyuiopasdfghjklzxcvbnmaeiouaeiou'"/>
  <xsl:variable name="upper"       select="'QWERTYUIOPASDFGHJKLZXCVBNMĀĒĪŌŪāēīōū'"/>
  
  <xsl:variable name="drop" select="'{}()*'"/>
  <xsl:variable name="punctuation" select="'.:;,!?'"/>
  <xsl:variable name="regexp" select="('.:;,!?')*()"/>


  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="text()[normalize-space()]">
    <xsl:variable name='orig' select="."/>
    <xsl:variable name='lang' select="$orig/ancestor::*[normalize-space(@xml:lang)][1]/@xml:lang"/>

    <xsl:analyze-string select="." regex="[\p{{L}}\p{{N}}]+">
      <xsl:matching-substring>

	<xsl:variable name="normalised">
	  <xsl:call-template name="normal">
	    <xsl:with-param name="string" select="translate(.,$upper,$lowernormal)"/>
	  </xsl:call-template>
	</xsl:variable>
	
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

  <xsl:template name="normal">
    <xsl:param name="string"/>
    
    <xsl:if test="string-length($string) &gt; 0">
      <xsl:if test="not(compare(substring($string,1,1),substring($string,2,1))=0)">
	<xsl:value-of select="substring($string,1,1)"/>
      </xsl:if>
      <xsl:call-template name="normal">
	<xsl:with-param name="string" select="substring($string,2)"/>
	</xsl:call-template>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>

