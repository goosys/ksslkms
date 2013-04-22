<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xc="http://goosys.sakura.ne.jp/xslcms/" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" >


<!--
	==================================================
	=== Override:
	=== Next/Prev Navigation Bar
	==================================================
-->
<xsl:template match="xc:SiteMap" mode="navi_nextprev">
	<xsl:param name="prev"><xsl:call-template name="prev_page"/></xsl:param>
	<xsl:param name="next"><xsl:call-template name="next_page"/></xsl:param>
	<xsl:param name="parent"><xsl:call-template name="parent_page"/></xsl:param>
	
	<div class="navi_nextprev_wrap">
    <ul class="navi_nextprev">
    
    <xsl:if test="$prev!='' and $prev!=$parent">
    <li class="prev">
	<a title="前のページ">
		<xsl:attribute name="href">
			<xsl:apply-templates select="//xc:SiteMap//*[@xml=$prev]" mode="file-format"/>
		</xsl:attribute>
		<!--
		<xsl:value-of select="'&lt;&lt;前のページ'"/>
		-->
		<xsl:value-of select="'&lt;&lt;'"/><xsl:apply-templates select="//xc:SiteMap//*[@xml=$prev]" mode="pagetitle"/>
	</a>
	</li>
	</xsl:if>
	
    <xsl:if test="$parent!=''">
    <li class="parent">
	<a title="上のページ">
		<xsl:attribute name="href">
			<xsl:apply-templates select="//xc:SiteMap//*[@xml=$parent]" mode="file-format"/>
		</xsl:attribute>
		<!--
		<xsl:value-of select="'上のページ'"/>
		-->
		<xsl:value-of select="'△'"/><xsl:apply-templates select="//xc:SiteMap//*[@xml=$parent]" mode="pagetitle"/>
	</a>
	</li>
	</xsl:if>
	
    <li class="current">
	<a title="ページの先頭">
		<xsl:attribute name="href">
			<xsl:apply-templates select="//xc:SiteMap//*[@xml=//xc:Page/xc:file]" mode="file-format"/>
		</xsl:attribute>
		<!--
		<xsl:value-of select="'ページの先頭'"/>
		-->
		<xsl:apply-templates select="//xc:SiteMap//*[@xml=//xc:Page/xc:file]" mode="pagetitle"/>
	</a>
	</li>
	
    <xsl:if test="$next!=''">
    <li class="next">
	<a title="次のページ">
		<xsl:attribute name="href">
			<xsl:apply-templates select="//xc:SiteMap//*[@xml=$next]" mode="file-format"/>
		</xsl:attribute>
		<!--
		<xsl:value-of select="'次のページ&gt;&gt;'"/>
		-->
		<xsl:apply-templates select="//xc:SiteMap//*[@xml=$next]" mode="pagetitle"/><xsl:value-of select="'&gt;&gt;'"/>
	</a>
	</li>
	</xsl:if>
	
	</ul>
	</div>
</xsl:template>
<xsl:template match="xc:page" mode="pagetitle">
	<xsl:value-of select="node()"/>
</xsl:template>
<xsl:template match="xc:directory" mode="pagetitle">
	<xsl:value-of select="@title"/>
</xsl:template>


</xsl:stylesheet>
