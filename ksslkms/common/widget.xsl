<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xc="http://goosys.sakura.ne.jp/xslcms/" xmlns="http://www.w3.org/1999/xhtml" >

<!--
	==================================================
	=== Widget's Base
	==================================================
-->
<xsl:template match="//xc:Widgets//xc:widget" mode="widget-outer">
	<xsl:if test="not(@visible) or contains(@visible,//xc:Page/xc:file)">
	<xsl:if test="not(@hidden)  or not(contains(@hidden ,//xc:Page/xc:file))">
	<xsl:variable name="test"><xsl:apply-templates select="." mode="test"/></xsl:variable>
	<xsl:if test="$test=1">
	
	<div class="widget-{@name} widget">
		<xsl:if test="./node()"><h3 class="widget-header"><xsl:copy-of select="./node()"/></h3></xsl:if>
		<div class="widget-content"><xsl:apply-templates select="."/></div>
		<div class="widget-footer"></div>
	</div>
	
	</xsl:if>
	</xsl:if>
	</xsl:if>
</xsl:template>
<xsl:template match="xc:widget" mode="test">1</xsl:template>

<!--
	==================================================
	=== dummy 
	==================================================
-->
<xsl:template match="xc:widget[@name='index']">
</xsl:template>

<!--
	==================================================
	=== Admonistrater Profile
	==================================================
-->
<xsl:template match="xc:widget[@name='profile']">
	<xsl:apply-templates select="//xc:Admin" mode="widget"/>
</xsl:template>
<xsl:template match="//xc:Admin" mode="widget">
    <dl class="profile-{xc:name}">
		<xsl:if test="xc:image"><xsl:apply-templates select="xc:image" mode="dl"/></xsl:if>
		<xsl:apply-templates select="node()[not(name()='xc:id' or name()='xc:name' or name()='xc:image') and node()]" mode="dl"/>
	</dl>
</xsl:template>
<xsl:template match="xc:Admin/*" mode="dl">
	<xsl:if test="node()">
	<dt>
		<xsl:attribute name="class"><xsl:call-template name="oddeven"/></xsl:attribute>
		<xsl:if test="not(@title)"><xsl:value-of select="substring-after(name(),':')"/></xsl:if>
		<xsl:if test="@title"><xsl:value-of select="@title"/></xsl:if>
	</dt>
	<dd>
		<xsl:attribute name="class"><xsl:call-template name="oddeven"/></xsl:attribute>
		<xsl:choose>
		<xsl:when test="name()='xc:area'"><xsl:apply-templates select="." mode="city"/></xsl:when>
		<xsl:when test="@xml or @url"><xsl:apply-templates select="." mode="link-format" /></xsl:when>
		<xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
		</xsl:choose>
	</dd>
	</xsl:if>
</xsl:template>
<xsl:template match="xc:Admin/xc:image" mode="dl">
	 <dt class="icon"><img class="user-pic" src="{//xc:Page/xc:dir}/{@src}" alt="{@title}" width="{@width}" height="{@height}"/></dt>
</xsl:template>
<xsl:template match="xc:area" mode="city">
	<xsl:value-of select="//xc:city/@title"/>
</xsl:template>

<!--
	==================================================
	=== Contents Map
	==================================================
-->
<xsl:template match="xc:widget[@name='pages']">
<xsl:variable name="dir"><xsl:value-of select="@dir"/></xsl:variable>
	<xsl:apply-templates select="//xc:SiteMap/xc:directory[@name=$dir]" mode="widget"/>
</xsl:template>
<xsl:template match="//xc:SiteMap//xc:directory" mode="widget">
    <ul class="sitemap-{@name} sitemap">
	 <xsl:apply-templates select="xc:page|xc:directory"/>
	</ul>
</xsl:template>


<!--
	==================================================
	=== Anchers
	==================================================
-->
<xsl:template match="xc:widget[@name='anchers']">
	<xsl:apply-templates select="//xc:Contents" mode="anchers"/>
</xsl:template>
<xsl:template match="xc:widget[@name='anchers']" mode="test">
	<xsl:if test="count(//xc:Contents/xc:block)&gt;1">1</xsl:if>
</xsl:template>

<!--
	==================================================
	=== Bookmarks
	==================================================
-->
<xsl:template match="xc:widget[@name='bookmarks']">
<xsl:variable name="dir"><xsl:value-of select="@dir"/></xsl:variable>
	<xsl:apply-templates select="//xc:Bookmark/xc:directory[@name=$dir]" mode="ul"/>
</xsl:template>
<xsl:template match="//xc:Bookmark/xc:directory" mode="ul">
    <ul class="bookmark-{@name}">
	 <xsl:apply-templates select="./xc:page"/>
	</ul>
</xsl:template>


<!--
	==================================================
	=== Latest Updates
	==================================================
-->
<xsl:template match="xc:widget[@name='updates']">
	<xsl:apply-templates select="//xc:Updates" mode="widget"/>
</xsl:template>
<xsl:template match="//xc:Updates" mode="widget">
	<ul class="dir">
	 <xsl:apply-templates select="xc:item[position()&lt;6]"/>
	</ul>
</xsl:template>

<!--
	==================================================
	=== Free text widget
	==================================================
-->
<xsl:template match="xc:widget[@name='user']">
<xsl:variable name="text"><xsl:value-of select="@text"/></xsl:variable>
	<xsl:apply-templates select="//xc:Freetext/xc:setvar[@name=$text]" mode="copy"/>
</xsl:template>



<!--
	==================================================
	=== Value Commerce 
	=== AdSense by Google
	==================================================
-->
<xsl:template match="xc:widget[@name='commercial']">
<xsl:variable name="dir"><xsl:value-of select="@dir"/></xsl:variable>
	<xsl:apply-templates select="//xc:Commercial/xc:directory[@name=$dir]" mode="ul"/>
</xsl:template>
<xsl:template match="xc:Commercial/xc:directory" mode="ul">
	<ul class=""><xsl:apply-templates select="xc:page"/></ul>
</xsl:template>
<!--
	==================================================
	=== Value Commerce 
	==================================================
-->
<xsl:template match="xc:page[@type='vc']">
	<xsl:variable name="vcurl">http://ad.jp.ap.valuecommerce.com/servlet</xsl:variable>
	<xsl:variable name="vcid">sid=<xsl:value-of select="@sid"/>&amp;pid=<xsl:value-of select="@pid"/></xsl:variable>
	<li>
	<iframe frameborder="0" allowtransparency="true" height="{@height}" width="{@width}" marginheight="0" scrolling="no" src="{$vcurl}/htmlbanner?{$vcid}" marginwidth="0">
		<script language="javascript" src="{$vcurl}/jsbanner?{$vcid}"></script>
		<noscript><a href="{$vcurl}/referral?{$vcid}" target="_blank" ><img src="{$vcurl}/gifbanner?{$vcid}" height="{@wdith}" width="{@height}" border="0"/></a></noscript>
	</iframe>
	</li>
</xsl:template>

<!--
	==================================================
	=== AdSense by Google
	==================================================
-->

<xsl:template match="xc:page[@type='ads']">
	<li><xsl:apply-templates select="." mode="script"/></li>
</xsl:template>

<xsl:template match="xc:page[@type='ads']" mode="script">
<script type="text/javascript"><xsl:comment>
google_ad_client = "<xsl:value-of select="@client"/>";
google_ad_slot = "<xsl:value-of select="@slot"/>";
google_ad_width = <xsl:value-of select="@width"/>;
google_ad_height = <xsl:value-of select="@height"/>;
//</xsl:comment>
</script>
<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
</xsl:template>

<!-- === append === -->
<xsl:template match="xc:page[@type='ads']">
	<li id="ads-{@slot}" style="width:{@width}; height:{@height};"></li>
</xsl:template>
<xsl:template match="xc:page[@type='ads']" mode="ads-hidden">
	<div id="adsref-{@slot}" style="dislpay:none;"><xsl:apply-templates select="." mode="script"/></div>
</xsl:template>
<xsl:template match="xc:widget" mode="ads-hidden-outer">
<xsl:variable name="dir"><xsl:value-of select="@dir"/></xsl:variable>
	<xsl:apply-templates select="//xc:Commercial/xc:directory[@name=$dir]/xc:page[@type='ads']" mode="ads-hidden"/>
</xsl:template>
<!--
	==================================================
	=== Google Search
	==================================================
-->
<xsl:template match="xc:page[@type='gg-search']">
	<div class="cse-branding-bottom">
		<div class="cse-branding-form">
			<form action="http://www.google.co.jp/cse" id="cse-search-box">
			<div>
				<input type="hidden" name="cx" value="{@client}" />
				<input type="hidden" name="ie" value="UTF-8" />
				<input type="text" name="q" size="20" />
				<input type="submit" name="sa" value="&#x691c;&#x7d22;" />
			</div>
			</form>
		</div>
		<div class="cse-branding-logo">
			<img src="http://www.google.com/images/poweredby_transparent/poweredby_FFFFFF.gif" alt="Google" />
		</div>
		<div class="cse-branding-text">&#12459;&#12473;&#12479;&#12512;&#26908;&#32034;</div>
	</div>
</xsl:template>



<!--
	==================================================
	=== Passed W3C Markup Validator, v1.2.
	==================================================
-->
<xsl:template match="xc:widget[@name='w3c']">
	<ul class="">
	 <li><a href="http://validator.w3.org/check?uri=referer"><img src="{//xc:Page/xc:dir}/css/icon/valid-xhtml10.gif" alt="Valid XHTML 1.0 Transitional" height="31" width="88" /></a></li>
	</ul>
</xsl:template>

<!--
	==================================================
	=== Footer
	==================================================
-->
<xsl:template match="xc:widget[@name='copyright']">
	<xsl:apply-templates select="//xc:Site" mode="widget"/>
</xsl:template>
<xsl:template match="//xc:Site" mode="widget">
	<p>powered by <xsl:value-of select="xc:copyright"/></p>
	<p>copyright(c) All Rights Reserved</p>
</xsl:template>



</xsl:stylesheet>