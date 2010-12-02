<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:nzetc="http://www.nzetc.org/structure"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output indent="yes"/>

  <!-- variables -->
  <xsl:variable name="lang">
    <xsl:choose>
      <xsl:when test="//text()[contains(.,'(King James Version)')]">en</xsl:when>
      <xsl:when test="//text()[contains(.,'(Maori Bible)')]">mi</xsl:when>
      <xsl:when test="//text()[contains(.,'(Arabic Life Application Bible)')]">ar</xsl:when>
      <xsl:when test="//text()[contains(.,'(Chinese Union Version (Traditional))')]">zh</xsl:when>
      <xsl:when test="//text()[contains(.,'(Chinese Union Version (Simplified))')]">zh</xsl:when>
      <xsl:when test="//text()[contains(.,'(Darby Translation)')]">en</xsl:when>
      <xsl:when test="//text()[contains(.,'(1934 Vietnamese Bible)')]"></xsl:when>
      <xsl:when test="//text()[contains(.,'()')]"></xsl:when>
      <xsl:otherwise>!!</xsl:otherwise>
      </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="other">
    <xsl:choose>
      <xsl:when test="//text()[contains(.,'(King James Version)')]">mi</xsl:when>
	<xsl:otherwise>en</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="url"><xsl:value-of select="//html:link[@rel='canonical']/@href"/></xsl:variable>
  <xsl:variable name="id"><xsl:value-of select="translate(substring-after(substring-before($url,'&amp;'),'='),'+','X')"/></xsl:variable>

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/">
    <tei:div n="{$url}" xml:lang="{$lang}" xml:id="idX{$id}X{$lang}" corresp="#idX{$id}X{$other}">
      <xsl:apply-templates select="//html:div[@class='result-text-style-normal']/text()[normalize-space()]"/>
    </tei:div>
  </xsl:template>

  <xsl:template match="text()[normalize-space(translate(.,'&#xA0;',''))]">
    <xsl:variable name="num"><xsl:value-of select="preceding::html:sup[1]/text()"/></xsl:variable>
    
    <tei:p xml:id="idX{$id}X{$lang}X{$num}" n="{$url}" >
      <xsl:choose>
	<xsl:when test="contains($lang,'mi')"><xsl:attribute name="corresp"><xsl:value-of select="concat('#idX',$id,'XenX', $num)"/></xsl:attribute>
</xsl:when>
	<xsl:when test="contains($lang,'en')"><xsl:attribute name="corresp"><xsl:value-of select="concat('#idX',$id,'XmiX', $num)"/></xsl:attribute>
</xsl:when>
      </xsl:choose>
     <xsl:value-of select="$num"/>: <xsl:value-of select="translate(.,'&#xA0;','')"/>
    </tei:p>
  </xsl:template>

  <xsl:template match="text()"/>


</xsl:stylesheet>
