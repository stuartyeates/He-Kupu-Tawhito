<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
		xmlns:html="http://www.w3.org/1999/xhtml"
		xmlns:tei="http://www.tei-c.org/ns/1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output indent="yes"/>

    <xsl:variable name="title"><xsl:value-of select="//tei:titleStmt/text()"/></xsl:variable>
    <xsl:variable name="lang"><xsl:value-of select="//tei:entry/@xml:lang"/></xsl:variable>

  <xsl:template match="@*|node()" priority="-1">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="/">
    <html:html xml:lang="{$lang}" >
      <html:head>
        <html:title><xsl:value-of select="$title"/></html:title>
        <html:meta property="dc:subject" xml:lang="en" content="Dictionary Concordance word te Reo Māori he kupu tawhito"/>
        <html:meta property="dc:subject" xml:lang="mi" content="papakupu tikinare he_kupu_tawhito "/>
        <html:meta property="dc:title" xml:lang="{$lang}" content="{$title}"/>
        <html:meta property="dc:creator" xml:lang="en" content="Stuart Yeates"/>
      </html:head>
      <html:body xml:lang="{$lang}" >
        <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:div/tei:entry"/>
      </html:body>
    </html:html>
  </xsl:template>

  <xsl:template match="@xml:id" />

  <xsl:template match="tei:entry">
    <html:h2 xml:lang="mi">He Kupu Tawhito</html:h2>
    <html:h1 xml:lang="mi">Kupu matua: <html:span class="hit-word" style="font-style:  bold" xml:lang="{$lang}"><xsl:value-of select="$title"/></html:span></html:h1>
    <html:div>
      <xsl:apply-templates select="tei:cit"/>
    </html:div>
    <xsl:variable name="url"><xsl:value-of select="concat('kupu.xql?reo=', @xml:lang, '&amp;kupu=', tei:form/tei:orth/text(), '&amp;kotahi=', @n)"/></xsl:variable>

    <html:div> <html:p> <html:a href="{$url}" style="font-style: italic">Panuku</html:a> </html:p> </html:div>
  </xsl:template>
  

  <xsl:template match="tei:cit" >
    <html:div>
      <xsl:apply-templates select="node()"/>
    </html:div>
    <html:hr/>
  </xsl:template>

  <xsl:template match="tei:p">
    <html:p>
      <xsl:apply-templates select="node()"/>
      <html:a href="{@n}" alt="ko te tohutoro"  style="font-style: italic">↗</html:a>
    </html:p>
  </xsl:template>

  <xsl:template match="tei:w">
    <xsl:variable name="url"><xsl:value-of select="concat('kupu.xql?reo=', @xml:lang, '&amp;kupu=', @lemma)"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="contains(../../@corresp,@xml:id)">
        <html:span class="hit-word" style="font-style: italic;font-weight:bold"><html:a href="{$url}" alt="">
          <xsl:apply-templates select="node()"/>
        </html:a></html:span>
      </xsl:when>
      <xsl:otherwise>
        <html:a href="{$url}">
          <xsl:apply-templates select="node()"/>
        </html:a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
