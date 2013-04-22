<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xc="http://goosys.sakura.ne.jp/xslcms/" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" >

<!--
	==================================================
	=== HTML Cntents
	==================================================
-->
<xsl:template match="html:tbody" mode="copy">
	<xsl:copy><xsl:apply-templates select="html:tr"/></xsl:copy>
</xsl:template>
<xsl:template match="html:ul|html:ol" mode="copy">
	<xsl:copy><xsl:apply-templates select="html:li"/></xsl:copy>
</xsl:template>
<xsl:template match="html:tr|html:li">
	<xsl:copy>
		<xsl:attribute name="class">
		<xsl:if test="@class"><xsl:value-of select="concat(@class,' ')"/></xsl:if><xsl:call-template name="oddeven"/>
		</xsl:attribute>
		<xsl:apply-templates select="@*[name()!='class']|node()" mode="copy"/>
	</xsl:copy><xsl:text>
</xsl:text>
</xsl:template>

</xsl:stylesheet>
