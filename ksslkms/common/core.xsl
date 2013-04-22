<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xc="http://goosys.sakura.ne.jp/xslcms/" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" >

<!--
	==================================================
	=== call javascript
	=== call stylesheet
	==================================================
-->
<xsl:template match="xc:Page/xc:js">
	<script type="text/javascript" src="{.}"></script>
</xsl:template>
<xsl:template match="xc:Page/xc:css">
	<link rel="stylesheet" href="{.}" type="text/css"/>
</xsl:template>


<!--
	==================================================
	=== Header
	==================================================
-->
<xsl:template name="header">
	<div id="header-content">
	<xsl:choose>
	<xsl:when test="//xc:Page/xc:file ='index'">
	    <h1 id="header-name"><a href="{//xc:Page/xc:dir}/index.{$ext}" title=""><xsl:value-of select="//xc:Site/xc:title"/></a></h1>
	    <h2 id="header-description"><xsl:value-of select="//xc:Site/xc:subtitle"/></h2>
	</xsl:when>
	<xsl:otherwise>
	    <h1 id="header-name"><xsl:if test="//xc:Page/xc:title"><xsl:value-of select="//xc:Page/xc:title"/></xsl:if></h1>
	    <h2 id="header-description"><xsl:if test="//xc:Page/xc:subs"><xsl:copy-of select="//xc:Page/xc:subs/node()"/></xsl:if></h2>
	</xsl:otherwise>
	</xsl:choose>
	</div>
</xsl:template>

<xsl:template name="header_sitename">
	<div id="header-content">
	    <h1 id="header-name"><a href="{//xc:Page/xc:dir}/index.{$ext}" title=""><xsl:value-of select="//xc:Site/xc:title"/></a></h1>
	    <h2 id="header-description"><xsl:value-of select="//xc:Site/xc:subtitle"/></h2>
	</div>
</xsl:template>
<xsl:template name="header_full">
	<div id="header-content">
	    <h1 id="header-name"><a href="{//xc:Page/xc:dir}/index.{$ext}" title=""><xsl:value-of select="//xc:Site/xc:title"/></a></h1>
	    <h2 id="header-description"><xsl:value-of select="//xc:Site/xc:subtitle"/></h2>
	    <div id="header-subtitle"><xsl:if test="//xc:Page/xc:title"><xsl:value-of select="//xc:Page/xc:title"/></xsl:if></div>
	    <div id="header-subdescription"><xsl:if test="//xc:Page/xc:subs"><xsl:copy-of select="//xc:Page/xc:subs/node()"/></xsl:if></div>
	</div>
</xsl:template>

<!--
	==================================================
	=== Header Navigation Bar
	=== Footer Information Bar
	==================================================
-->
<xsl:template match="xc:SiteMap" mode="navimenu">
    <ul class="navi_menu">
	 <xsl:apply-templates select="node()//*[(@xml or @url) and contains(@tag,'navibar')]"/>
	</ul>
</xsl:template>
<xsl:template match="xc:SiteMap" mode="footinfo">
    <ul class="footinfo">
	 <xsl:apply-templates select="node()//*[(@xml or @url) and contains(@tag,'footinfo')]"/>
	</ul>
</xsl:template>
<xsl:template match="xc:page|xc:directory">
	<li>
		<xsl:attribute name="class">
			<xsl:value-of select="concat(@xml,' ')"/>
			<xsl:if test="name()='xc:directory'"><xsl:value-of select="'dir '"/></xsl:if>
			<xsl:if test="//xc:Page/xc:file=@xml"><xsl:value-of select="'current '"/></xsl:if>
			<xsl:call-template name="oddeven"/>
		</xsl:attribute>
		<xsl:choose>
			<xsl:when test="@xml|@url"><xsl:apply-templates select="." mode="copy"/></xsl:when>
			<xsl:otherwise><span><xsl:value-of select="@title"/></span></xsl:otherwise>
		</xsl:choose>
		<xsl:if test="name()='xc:directory'">
			<ul class="{@name}"><xsl:apply-templates select="xc:page|xc:directory"/></ul>
		</xsl:if>
	</li>
</xsl:template>

<!--
	==================================================
	=== Breadcrumb list Navigation Bar
	==================================================
-->
<xsl:template match="xc:SiteMap" mode="navi_breadcrumb">
	<div class="navi_breadcrumb_wrap">
    <xsl:apply-templates select="//xc:SiteMap//*[//xc:Page/xc:file=@xml]" mode="navi_breadcrumb"/>
	</div>
</xsl:template>
<xsl:template match="xc:page|xc:directory" mode="navi_breadcrumb">
	<xsl:choose>
	<xsl:when test="parent::xc:directory and not(ancestor::*[position()=2 and name()='xc:SiteMap'])">
    	<xsl:apply-templates select="parent::xc:directory" mode="navi_breadcrumb"/>
    	<span class="bread_split">&gt;</span>
    </xsl:when>
	<xsl:when test="@xml='index'"></xsl:when>
    <xsl:otherwise>
		<xsl:apply-templates select="//xc:SiteMap//*[@xml='index']" mode="copy"/>
		<span class="bread_split">&gt;</span>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="@xml|@url"><xsl:apply-templates select="." mode="copy"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="@title"/></xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!--
	==================================================
	=== Next/Prev Navigation Bar
	==================================================
-->
<xsl:template match="xc:SiteMap" mode="navi_nextprev">
	<xsl:param name="prev"><xsl:call-template name="prev_page"/></xsl:param>
	<xsl:param name="next"><xsl:call-template name="next_page"/></xsl:param>
	<xsl:param name="parent"><xsl:call-template name="parent_page"/></xsl:param>
	
	<div class="navi_nextprev_wrap">
    <ul class="navi_nextprev">
    <xsl:if test="$prev!='' and $prev!=$parent"><li class="prev"><xsl:apply-templates select="//xc:SiteMap//*[@xml=$prev]" mode="copy"/></li></xsl:if>
    <xsl:if test="$parent!=''"><li class="parent"><xsl:apply-templates select="//xc:SiteMap//*[@xml=$parent]" mode="copy"/></li></xsl:if>
    <li><xsl:apply-templates select="//xc:SiteMap//*[//xc:Page/xc:file=@xml]" mode="copy"/></li>
    <xsl:if test="$next!=''"><li class="next"><xsl:apply-templates select="//xc:SiteMap//*[@xml=$next]" mode="copy"/></li></xsl:if>
	</ul>
	</div>
</xsl:template>
<!--
	==================================================
	=== Next/Prev Page
	==================================================
-->
<xsl:template name="currentpos">
	<xsl:for-each select="//xc:SiteMap/xc:directory[@name!='hidden']//*[@xml]">
    	<xsl:if test="//xc:Page/xc:file=@xml"><xsl:value-of select="position()"/></xsl:if>
    </xsl:for-each>
</xsl:template>
<xsl:template name="parent_page">
	<xsl:apply-templates select="//xc:SiteMap//*[//xc:Page/xc:file=@xml]" mode="parent_page"/>
</xsl:template>
<xsl:template match="*" mode="parent_page">
	<xsl:if test="parent::xc:directory[@xml]"><xsl:value-of select="parent::xc:directory/@xml"/></xsl:if>
</xsl:template>
<xsl:template name="prev_page">
	<xsl:param name="currentpos"><xsl:call-template name="currentpos"/></xsl:param>
    <xsl:for-each select="//xc:SiteMap/xc:directory[@name!='hidden']//*[@xml]">
		<xsl:if test="position()=$currentpos - 1">
	    	<xsl:value-of select="@xml"/>
	    </xsl:if>
    </xsl:for-each>
</xsl:template>
<xsl:template name="next_page">
	<xsl:param name="currentpos"><xsl:call-template name="currentpos"/></xsl:param>
    <xsl:for-each select="//xc:SiteMap/xc:directory[@name!='hidden']//*[@xml]">
		<xsl:if test="position()=$currentpos + 1">
	    	<xsl:value-of select="@xml"/>
	    </xsl:if>
    </xsl:for-each>
</xsl:template>



<!--
	==================================================
	=== Contents
	==================================================
-->
<xsl:template match="xc:Contents" mode="anchers">
	<xsl:call-template name="titles"/>
</xsl:template>
<xsl:template match="xc:Contents">
	<xsl:if test="@index and @index='-1'"><xsl:call-template name="titles"/></xsl:if>
	<xsl:apply-templates select="xc:block" mode="block-outer" />
</xsl:template>
<xsl:template match="xc:Contents/xc:block" mode="block-outer">
	<h2><xsl:attribute name="id"><xsl:value-of select="translate(xc:title,' ','')"/></xsl:attribute><xsl:value-of select="xc:title"/></h2>
	<xsl:apply-templates select="." />
	<xsl:if test="../@index and ../@index=position()"><xsl:apply-templates  select="parent::node()" mode="anchers"/></xsl:if>
</xsl:template>
<xsl:template match="xc:Widgets/xc:block" mode="column-header">
	<h2 id="{@pos}-header"><xsl:value-of select="@title"/></h2>
</xsl:template>

<!--
	==================================================
	=== Anchers
	==================================================
-->
<xsl:template name="titles">
	<div class="page_guid">
		<ul class="indexof">
		<xsl:for-each select="xc:block/xc:title">
			<li><xsl:attribute name="class"><xsl:call-template name="oddeven"/></xsl:attribute>
				<a href="#{translate(.,' ','')}" title="{.}"><xsl:value-of select="."/></a>
			</li>
		</xsl:for-each>
		</ul>
	</div>
</xsl:template>

<!--
	==================================================
	=== document
	==================================================
-->
<xsl:template match="xc:Contents/xc:block[@layout='document']">
	<div class="indent"><xsl:apply-templates select="xc:description"/></div>
</xsl:template>
<xsl:template match="xc:description">
	<xsl:apply-templates select="@*|node()" mode="copy"/>
</xsl:template>

<xsl:template match="xc:Contents/xc:block[@layout='latestupdate']">
	<div class="subs"><xsl:copy-of select="xc:subs/node()"/></div>
	<div class="indent"><ul><xsl:apply-templates select="//xc:Updates/xc:item" /></ul></div>
</xsl:template>

<xsl:template match="xc:Updates/xc:item">
	<li>
		<xsl:attribute name="class"><xsl:call-template name="oddeven"/></xsl:attribute>
		<span class="date"><xsl:value-of select="substring(@date,6)"/></span>
	<xsl:choose>
		<xsl:when test="@xml"><xsl:apply-templates select="." mode="link-format" /></xsl:when>
		<xsl:otherwise><xsl:value-of select="node()"/></xsl:otherwise>
	</xsl:choose>
	</li>
</xsl:template>

<xsl:template match="xc:Contents/xc:block[@layout='raws']">
	 <dl class="rawlist">
		<xsl:for-each select="item/key|item/value|item/subs">
		<xsl:if test="name()='key'"><dt><xsl:value-of select="./node()"/></dt></xsl:if>
		<xsl:if test="name()='value'"><dd><xsl:copy-of select="./node()"/></dd></xsl:if>
		<xsl:if test="name()='subs'"><dd class="subs">※<xsl:copy-of select="./node()"/></dd></xsl:if>
		</xsl:for-each>
	 </dl>
</xsl:template>

<xsl:template match="xc:Contents/xc:block[@layout='widget']">
<xsl:variable name="name"><xsl:value-of select="@name"/></xsl:variable>
<xsl:variable name="dir"><xsl:value-of select="@dir"/></xsl:variable>
	<xsl:apply-templates select="//xc:Widgets//xc:widget[@name=$name and (not(@dir) or @dir=$dir)]" mode="widget-outer"/>
</xsl:template>


<xsl:template match="xc:Contents/xc:block[@layout='profile' and @data='Company']">
	<table class="profile">
		<caption><xsl:value-of select="//xc:Company/xc:title"/></caption>
		<thead><tr><th><br/></th><th><br/></th></tr></thead>
		<tbody><xsl:apply-templates select="//xc:Company/node()[not(name()='xc:id' or name()='xc:name') and name()!='']" mode="table"/></tbody>
	</table>
</xsl:template>
<xsl:template match="xc:Company/*" mode="table">
	<tr>
		<xsl:attribute name="class"><xsl:call-template name="oddeven"/></xsl:attribute>
	<th>
		<xsl:if test="not(@title)"><xsl:value-of select="substring-after(name(),':')"/></xsl:if>
		<xsl:if test="@title"><xsl:value-of select="@title"/></xsl:if>
	</th>
	<td>
		<xsl:choose>
		<xsl:when test="name()='xc:area'"><xsl:apply-templates select="." mode="city"/></xsl:when>
		<xsl:when test="@xml or @url"><xsl:apply-templates select="." mode="link-format" /></xsl:when>
		<xsl:otherwise><xsl:apply-templates select="." mode="copy"/></xsl:otherwise>
		</xsl:choose>
	</td>
	</tr>
</xsl:template>


<!--
	==================================================
	=== format
	==================================================
-->
<xsl:template match="*" mode="link-format">
<xsl:param name="class"/>
<xsl:param name="nonchild"/>
	<a>
		<xsl:attribute name="href">
			<xsl:choose>
			<xsl:when test="@xml"><xsl:apply-templates select="." mode="file-format"/></xsl:when>
			<xsl:otherwise>
				<xsl:if test="not(contains(@url,'http'))"><xsl:value-of select="//xc:Page/xc:dir"/>/</xsl:if>
				<xsl:value-of select="@url"/><xsl:value-of select="@param"/>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<xsl:attribute name="title">
			<xsl:if test="@title"><xsl:value-of select="@title"/>-<xsl:value-of select="."/></xsl:if>
			<xsl:if test="not(@title)"><xsl:value-of select="."/></xsl:if>
		</xsl:attribute>
		<xsl:if test="$class!=''"><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute></xsl:if>
		<xsl:apply-templates select="@id|@class|@title|@href" mode="copy"/>
		
		<xsl:choose>
		<xsl:when test="$nonchild=1"><xsl:value-of select="@title"/></xsl:when>
		<xsl:otherwise><xsl:apply-templates select="node()" mode="copy"/></xsl:otherwise>
		</xsl:choose>
	</a>
</xsl:template>

<xsl:template match="*" mode="file-format">
	<xsl:variable name="path"><xsl:value-of select="//xc:Page/xc:dir"/>/</xsl:variable>
	<xsl:variable name="filename">
		<xsl:choose>
		<xsl:when test="$ext='xml' or not(contains(@xml,'index'))"><xsl:value-of select="concat(@xml,'.',$ext)"/></xsl:when>
		<xsl:otherwise><xsl:value-of select="substring-before(@xml,'index')"/></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:value-of select="concat($path,$filename,@param)"/>
</xsl:template>

<xsl:template match="/|@*|node()" mode="copy">
	<xsl:copy><xsl:apply-templates select="@*|node()" mode="copy"/></xsl:copy>
</xsl:template>
<xsl:template match="xc:page" mode="copy">
	<xsl:apply-templates select="." mode="link-format">
		<xsl:with-param name="class"><xsl:if test="//xc:Page/xc:file=@xml">current</xsl:if></xsl:with-param>
	</xsl:apply-templates>
</xsl:template>
<xsl:template match="xc:directory" mode="copy">
	<xsl:apply-templates select="." mode="link-format">
		<xsl:with-param name="class"><xsl:if test="//xc:Page/xc:file=@xml">current</xsl:if></xsl:with-param>
		<xsl:with-param name="nonchild">1</xsl:with-param>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="xc:getvar" mode="copy">
<xsl:variable name="text"><xsl:value-of select="@text"/></xsl:variable>
	<xsl:apply-templates select="//xc:Freetext/xc:setvar[@name=$text]" mode="copy"/>
</xsl:template>

<xsl:template name="oddeven">
	<xsl:if test="position() mod 2 =0">even</xsl:if>
	<xsl:if test="position() mod 2 =1">odd</xsl:if>
</xsl:template>

</xsl:stylesheet>
