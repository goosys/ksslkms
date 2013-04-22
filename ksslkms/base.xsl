<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xc="http://goosys.sakura.ne.jp/xslcms/" xmlns:html="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" >
<xsl:output method="xml" encoding="UTF-8" indent="yes" 
    doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />
    
<xsl:preserve-space elements="codesection"/>
<xsl:variable name="ext">xml</xsl:variable>

<!-- =================================== -->
<!-- Path to common directory            -->
<!-- ex)  ../common/  coomon/            -->
<!-- =================================== -->
<xsl:include href="common/core.xsl"/>
<xsl:include href="common/widget.xsl"/>
<xsl:include href="common/contents.xsl"/>
<xsl:include href="common/navigation.xsl"/>
<xsl:variable name="commonpath">common</xsl:variable>
<!-- =================================== -->


<xsl:template match="/">
<html lang="ja">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="description" content="{//xc:Site/xc:subtitle}"/>
<title><xsl:if test="$ext='xml'">[XML] </xsl:if><xsl:if test="//xc:Page/xc:title!=''"><xsl:value-of select="//xc:Page/xc:title"/> - </xsl:if><xsl:value-of select="//xc:Site/xc:title"/></title>
<link rel="stylesheet" href="{//xc:Page/xc:dir}/styles.css" type="text/css" class="basestyle"/>
<link rel="start" href="{//xc:Site/xc:url}" title="{//xc:Site/xc:title}" />
<xsl:if test="//xc:Site/xc:rss!=''"><link rel="alternate" type="application/rss+xml" title="Recent Entries" href="{//xc:Site/xc:rss}" /></xsl:if>
<script type="text/javascript" src="{//xc:Page/xc:dir}/{$commonpath}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="{//xc:Page/xc:dir}/{$commonpath}/js/script.js"></script>
<xsl:apply-templates select="//xc:Page/xc:css"/>
<xsl:apply-templates select="//xc:Page/xc:js"/>
</head>
<body id="classic-website" class="{//xc:Layout/xc:class}">
    <div id="container">
        <div id="container-inner">

            <div id="header">
                <div id="site-navigation-top"><xsl:value-of select="//xc:Site/xc:subtitle"/></div>
                <xsl:apply-templates select="//xc:SiteMap" mode="navimenu"/>
                <div id="header-inner">
                
                     <xsl:call-template name="header_full" />
                     
                </div>
                <div id="header-side">
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='headerside']/xc:widget" mode="widget-outer"/>
                </div>
            </div>
            



            <div id="content">
                <div id="content-inner">


                    <div id="alpha">
                        <div id="alpha-inner">

<div id="topcommercial">
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='alphatop']" mode="column-header"/>
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='alphatop']/xc:widget" mode="widget-outer"/>
</div>

              
              <xsl:apply-templates select="//xc:SiteMap" mode="navi_breadcrumb"/>
<div id="documents">
            
              <xsl:apply-templates select="//xc:Contents"/>
            
</div>
              <xsl:apply-templates select="//xc:SiteMap" mode="navi_nextprev"/>



<div id="bottomcommercial">
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='alphabottom']" mode="column-header"/>
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='alphabottom']/xc:widget" mode="widget-outer"/>
</div>
                        </div>
                    </div>


              <xsl:if test="//xc:Layout/xc:column/@beta=1">
                    <div id="beta">
                        <div id="beta-inner">
                        
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='beta']" mode="column-header"/>
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='beta']/xc:widget" mode="widget-outer"/>
              
                        </div>
                    </div>
              </xsl:if>
              
              <xsl:if test="//xc:Layout/xc:column/@gamma=1">
                    <div id="gamma">
                        <div id="gamma-inner">
                        
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='gamma']" mode="column-header"/>
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='gamma']/xc:widget" mode="widget-outer"/>
              
                        </div>
                    </div>
              </xsl:if>


                </div>
            </div>

            <div id="footer">
                <div id="footer-inner">
                    <div id="footer-content">

                <xsl:apply-templates select="//xc:SiteMap" mode="footinfo"/>
              <xsl:apply-templates select="//xc:Widgets/xc:block[@pos='footer']/xc:widget" mode="widget-outer"/>

                    </div>
                </div>
            </div>



        </div>
    </div>
<xsl:apply-templates select="//xc:Widgets/xc:block[@pos!='hidden']/xc:widget[@name='commercial']" mode="ads-hidden-outer"/>
</body>
</html>
</xsl:template>

</xsl:stylesheet>