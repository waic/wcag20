<?xml version="1.0" encoding="utf-8"?>
<!-- edited with XMLSpy v2005 rel. 3 U (http://www.altova.com) by Ben Caldwell (W3C) -->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://icl.com/saxon" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="saxon" version="1.0">
  <xsl:import href="xmlspec-wcag-howto.xsl"/>
  <!-- turn off techniques related columns -->
  <xsl:param name="show.techniques" select="1"/>
  <xsl:param name="show.diff.markup" select="0"/>
  <xsl:param name="show.issue.links" select="0"/>
  <xsl:param name="guide" select="1"/>
  <xsl:param name="quickref" select="1"/>
  <xsl:variable name="draftDate">
    <xsl:value-of select="//pubdate/day"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="//pubdate/month"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="//pubdate/year"/>
  </xsl:variable>
  <xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
  <!-- BBC: added link to guidelines -->
  <!-- BBC: pulled this in to call a variation on the "css" template with custom styles -->
  <xsl:template match="spec">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:if test="header/langusage/language">
        <xsl:attribute name="lang"><xsl:value-of select="header/langusage/language/@id"/></xsl:attribute>
      	<xsl:attribute name="xml:lang"><xsl:value-of select="header/langusage/language/@id"/></xsl:attribute>
      </xsl:if>
      <head>
        <title>
          <xsl:apply-templates select="header/title"/>
          <xsl:if test="header/version">
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="header/version"/>
          </xsl:if>
          <xsl:if test="$additional.title != ''">
            <xsl:text> -- </xsl:text>
            <xsl:value-of select="$additional.title"/>
          </xsl:if>
        </title>
        <xsl:call-template name="css2"/>
      </head>
      <body>
        <xsl:apply-templates select="header"/>
        <xsl:apply-templates select="front"/>
        <!--hr/-->
        <div id="quickref" class="quickrefcontainer">
          <xsl:apply-templates select="//div1[@id='guidelines']/head"/>
          
          <xsl:for-each select="$gl-src//div3[@role='group1'] | $gl-src//div3[@role='group2']">
            <xsl:variable name="anchor">
              <xsl:value-of select="@id"/>
            </xsl:variable>
            <xsl:variable name="gltitle">
              Guideline <xsl:number level="multiple" count="div2 | div3" format="1.1"/> - <xsl:call-template name="sc-handle">  <xsl:with-param name="handleid" select="@id"/>
              </xsl:call-template>
            </xsl:variable>
            <h3 id="{$anchor}" title="{$gltitle}">
              <xsl:call-template name="sc-handle">
          <xsl:with-param name="handleid" select="@id"/>
              </xsl:call-template><span class="screenreader">:</span></h3>
            <p class="guideline"><a href="{$glthisversion}#{$anchor}">Guideline <xsl:number level="multiple" count="div2 | div3" format="1.1"/></a>
              <xsl:text> </xsl:text><xsl:apply-templates select="head" mode="text"/>
              <a href="{$guidethisversion}{@id}.html" class="GLlink">Understanding Guideline <xsl:number level="multiple" count="div2 | div3" format="1.1"/>
              </a></p>
            <xsl:if test="count($guide-src//spec/body/div1[@id=$anchor]/div2[@role='gladvisory']/ulist) != 0">
              <xsl:processing-instruction name="php"><![CDATA[ if($bAdvisory) { ]]></xsl:processing-instruction>
            <div class="advisory">
              <h4 id="{$anchor}-advisory">Advisory Techniques for Guideline <xsl:number level="multiple" count="div2 | div3" format="1.1"/></h4>
            <xsl:apply-templates select="$guide-src//spec/body/div1[@id=$anchor]/div2[@role='gladvisory']/ulist"/>
            </div>
              <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
            </xsl:if>
                <xsl:call-template name="levels"/>
          </xsl:for-each>
        </div>
        <xsl:call-template name="confreqs" />

        <xsl:apply-templates select="back"/>
        <xsl:if test="//footnote[not(ancestor::table)]">

          <div class="endnotes">
            <xsl:text> </xsl:text>
            <h3>
              <xsl:call-template name="anchor">
                <xsl:with-param name="conditional" select="0"/>
                <xsl:with-param name="default.id" select="'endnotes'"/>
              </xsl:call-template>
              <xsl:text>End Notes</xsl:text>
            </h3>
            <dl>
              <xsl:apply-templates select="//footnote[not(ancestor::table)]" mode="notes"/>
            </dl>
          </div>
        </xsl:if>
        <div id="footer">
          <p id="editors">
            <strong>Content last updated:</strong>
            <xsl:if test="//pubdate/day">
            <xsl:text> </xsl:text>
              <xsl:apply-templates select="//pubdate/day"/>
              <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:apply-templates select="//pubdate/month"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="//pubdate/year"/>
            <br/>
 Developed by the Web Content Accessibility Guidelines Working Group (<a href="http://www.w3.org/WAI/GL/" shape="rect">WCAG WG</a>).<br/>
Editors: Gregg Vanderheiden, Loretta Guarino Reid, Ben Caldwell, Shawn Lawton Henry. Original coding by Gez Lemon.</p>
          <p>[<a href="/WAI/contacts" shape="rect">Contacting WAI</a>] Feedback welcome to <a href="mailto:public-comments-wcag20@w3.org">public-comments-wcag20@w3.org</a>.</p>
          <div class="copyright">
            <p>
              <a rel="Copyright" href="/Consortium/Legal/ipr-notice#Copyright" shape="rect">Copyright</a> &#169; 1994-2007
<a href="/" shape="rect">
                <acronym title="World Wide Web Consortium">W3C</acronym>
              </a>
              <sup>&#174;</sup> (<a href="http://www.csail.mit.edu/" shape="rect">
                <acronym title="Massachusetts Institute of Technology">MIT</acronym>
              </a>, <a href="http://www.ercim.eu/" shape="rect">
                <acronym title="European Research Consortium for Informatics and Mathematics">ERCIM</acronym>
              </a>,
<a href="http://www.keio.ac.jp/" shape="rect">Keio</a>), All Rights Reserved. W3C
<a href="/Consortium/Legal/ipr-notice#Legal_Disclaimer" shape="rect">liability</a>,

<a href="/Consortium/Legal/ipr-notice#W3C_Trademarks" shape="rect">trademark</a>,
<a rel="Copyright" href="/Consortium/Legal/copyright-documents" shape="rect">document use</a> and <a rel="Copyright" href="/Consortium/Legal/copyright-software" shape="rect">software
licensing</a> rules apply. Your interactions with this site are in
accordance with our <a href="/Consortium/Legal/privacy-statement#Public" shape="rect">public</a> and <a href="/Consortium/Legal/privacy-statement#Members" shape="rect">Member</a> privacy
statements.</p>
          </div>
          <!-- end footer -->
        </div>
      </body>
    </html>
  </xsl:template>
  <!-- variation on "css" template - adds some custom CSS without need for using additional.css file -->
  <xsl:template name="css2">
    <meta http-equiv="Content-Type" xmlns="http://www.w3.org/1999/xhtml" content="text/html; charset=utf-8"/>
    <link href="qr.css" xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css"/>
    <link href="qrprint.css" xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css" media="print"/>

<!--xsl:processing-instruction name="php"><![CDATA[  
global $userBrowser;
global $IE55, $IE5, $IE4;
$userBrowser = $_SERVER['HTTP_USER_AGENT'];
		$IE4 =  (stristr($userBrowser, "MSIE 4") || stristr($userBrowser, "Internet Explorer/4")); 
		$IE5 = (stristr($userBrowser, "MSIE 5") || stristr($userBrowser, "Explorer 5")); 
		$IE55 = (stristr($userBrowser, "MSIE 5.5") || stristr($userBrowser, "MSIE+5.5") || stristr($userBrowser, "MSIE+5+.+5"));
	
	if ($IE4 | $IE5 | $IE55) {
	// suppress javascript
	}
	else {
	]]></xsl:processing-instruction> 
script type="text/javascript" src="annotate.js" xmlns="http://www.w3.org/1999/xhtml">    
      <xsl:text> </xsl:text>
    </script
    <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> --> 
  </xsl:template>
  <!-- mode: standalone (for printing SC out of context of nearby list items-->
  <xsl:template match="termref">
    <a xmlns="http://www.w3.org/1999/xhtml" href="{$glthisversion}#{@def}" class="termref">
      <xsl:choose>
        <xsl:when test="count(child::node())=0">
          <xsl:value-of select="@def"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>
  <xsl:template name="sc-copy">
    <!-- template copies first paragraph and supporting lists/notes -->
    <xsl:for-each select="./div5">
      <xsl:variable name="anchor2">
        <xsl:value-of select="@id"/>
      </xsl:variable>
      <xsl:choose>
        <!--BBC: This test keeps deleted SC out of the quickref display.-->
        <xsl:when test="@diff='del'"/>
        <xsl:otherwise>
        <div align="right">
        <p class="showhidelink"><a href="Overview.php" class="showhideR" id="qr-{@id}" title="Go to top of page">top of page</a></p>
        <xsl:call-template name="restoresettings">
            <xsl:with-param name="anchor"><xsl:value-of select="@id"></xsl:value-of></xsl:with-param>
        </xsl:call-template></div>
          <div class="normative" xmlns="http://www.w3.org/1999/xhtml" id="{@id}">
            <xsl:apply-templates select="p[position()='1']" mode="scheader"/>
            <xsl:apply-templates select="olist | ulist | note"/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="$show.techniques != '0'">
        <!-- Sufficient Techniques -->
               <xsl:processing-instruction name="php"><![CDATA[ if($bSufficient) { ]]></xsl:processing-instruction>   
        <div class="sufficient" xmlns="http://www.w3.org/1999/xhtml" >
        <xsl:apply-templates select="$guide-src//spec/body/div1/div2[@id=$anchor2]/div3[@role='techniques']/div4[@role='sufficient']"/>
        </div>
        <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
        <xsl:apply-templates select="$guide-src//spec/body/div1/div2[@id=$anchor2]/div3[@role='techniques']/div4[@role='tech-optional']"/>
        
<xsl:processing-instruction name="php"><![CDATA[ if($bSufficient) { ]]></xsl:processing-instruction>               
                <xsl:apply-templates select="$guide-src//spec/body/div1/div2[@id=$anchor2]/div3[@role='techniques']/div4[@role='failures']"/>
                 <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <!-- mode: scheader - allows first paragraph of SC to become a header -->
  <xsl:template match="p" mode="scheader">
    <xsl:variable name="sctitle">Success Criterion <xsl:call-template name="sc-number"/>  -  <xsl:call-template name="sc-handle">
        <xsl:with-param name="handleid" select="../@id"/>
      </xsl:call-template>
    </xsl:variable>
    <h4 xmlns="http://www.w3.org/1999/xhtml" title="{$sctitle}" class="sc">
                <xsl:call-template name="sc-handle">
            <xsl:with-param name="handleid" select="../@id"/>
          </xsl:call-template><span class="screenreader">:</span></h4>
          <p class="sctxt"><xsl:call-template name="sc-number-link"/>
      <xsl:text> </xsl:text>
      <xsl:apply-templates/>
      <xsl:text> </xsl:text>
      <em>(Level <xsl:choose>
          <xsl:when test="ancestor::div4[@role='req']">A</xsl:when>
          <xsl:when test="ancestor::div4[@role='bp']">AA</xsl:when>
          <xsl:when test="ancestor::div4[@role='additional']">AAA</xsl:when>
        </xsl:choose>)</em>
      <xsl:if test="$guide='1'">
            <a href="{$guidethisversion}{../@id}.html" class="HTMlink">Understanding Success Criterion <xsl:call-template name="sc-number"/>
            </a>
      </xsl:if>
          </p>
  </xsl:template>
  <!--BBC: This controls the form at the front of the quickref -->
  <xsl:template match="div1[@id='customize']">
  <div id="customize" xmlns="http://www.w3.org/1999/xhtml">
  <h2 xmlns="http://www.w3.org/1999/xhtml">Customize this Quick Reference</h2>

  
    <form id="AsCToptions" method="post" action="Overview.php" xmlns="http://www.w3.org/1999/xhtml">
                      
      <fieldset>
        <legend>
          <strong>Technologies:</strong>
        </legend>
        <ul><li>
            <input type="checkbox" name="defaultopt" id="defaultopt" value="Y" checked="checked" disabled="disabled"/>
            <label for="defaultopt">HTML Techniques (always shown)</label>
          </li>
        
          <xsl:processing-instruction name="php"><![CDATA[ if($bCSS) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="cssopt" id="cssopt" value="Y" checked="checked"/>
            <label for="cssopt">Show <acronym title="Cascading Style Sheets (CSS)">CSS</acronym> techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="cssopt" id="cssopt" value="Y"/>
            <label for="cssopt">Show <acronym title="Cascading Style Sheets (CSS)">CSS</acronym> techniques and failures</label>
          </li>
          <!--xsl:processing-instruction name="php"><![CDATA[ } if($bCSSBase) { ]]></xsl:processing-instruction>
          <dd>
            <input type="checkbox" name="cssoptbase" id="cssoptbase" value="Y" checked="checked"/>
            <label for="cssoptbase">CSS is not relied upon.</label>
          </dd>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <dd>
            <input type="checkbox" name="cssoptbase" id="cssoptbase" value="Y"/>
            <label for="cssoptbase">CSS is not relied upon.</label>
          </dd-->
          <xsl:processing-instruction name="php"><![CDATA[ } if($bSMIL) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="smilopt" id="smilopt" value="Y" checked="checked"/>
            <label for="smilopt">Show <acronym title="Synchronized Multimedia Integration Language (SMIL)">SMIL</acronym> techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="smilopt" id="smilopt" value="Y"/>
            <label for="smilopt">Show <acronym title="Synchronized Multimedia Integration Language (SMIL)">SMIL</acronym> techniques and failures</label>
          </li>
          <!--xsl:processing-instruction name="php"><![CDATA[ } if($bSMILBase) { ]]></xsl:processing-instruction>
          <dd>
            <input type="checkbox" name="smiloptbase" id="smiloptbase" value="Y" checked="checked"/>
            <label for="smiloptbase">SMIL is not relied upon.</label>
          </dd>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <dd>
            <input type="checkbox" name="smiloptbase" id="smiloptbase" value="Y"/>
            <label for="smiloptbase">SMIL is not relied upon.</label>
          </dd-->
          <xsl:processing-instruction name="php"><![CDATA[ } if($bScript) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="scriptopt" id="scriptopt" value="Y" checked="checked"/>
            <label for="scriptopt">Show Client-side Scripting techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="scriptopt" id="scriptopt" value="Y"/>
            <label for="scriptopt">Show Client-side Scripting techniques and failures</label>
          </li>
           <xsl:processing-instruction name="php"><![CDATA[ } if($bServerSide) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="serversideopt" id="serversideopt" value="Y" checked="checked"/>
            <label for="serversideopt">Show Server-side Scripting techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="serversideopt" id="serversideopt" value="Y"/>
            <label for="serversideopt">Show Server-side Scripting techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } if($bARIA) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="ariaopt" id="ariaopt" value="Y" checked="checked"/>
            <label for="ariaopt">Show <acronym title="Web Accessibility Initiative - Accessible Rich Internet Applications">WAI-ARIA</acronym> techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="ariaopt" id="ariaopt" value="Y"/>
            <label for="ariaopt">Show <acronym title="Web Accessibility Initiative - Accessible Rich Internet Applications">WAI-ARIA</acronym> techniques and failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
          </ul>
          
          </fieldset>
      <fieldset id="qrautochange">
        <legend>
          <strong>Levels:</strong>
        </legend>
          <ul>
          <xsl:processing-instruction name="php"><![CDATA[ if($bLevel1) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="level1opt" id="level1opt" value="Y" checked="checked"/>
            <label for="level1opt">Show Level A Success Criteria</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="level1opt" id="level1opt" value="Y"/>
            <label for="level1opt">Show Level A Success Criteria</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } if($bLevel2) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="level2opt" id="level2opt" value="Y" checked="checked"/>
            <label for="level2opt">Show Level AA Success Criteria</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="level2opt" id="level2opt" value="Y"/>
            <label for="level2opt">Show Level AA Success Criteria</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } if($bLevel3) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="level3opt" id="level3opt" value="Y" checked="checked"/>
            <label for="level3opt">Show Level AAA Success Criteria</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="level3opt" id="level3opt" value="Y"/>
            <label for="level3opt">Show Level AAA Success Criteria</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
        </ul>
        </fieldset>
              <fieldset>
        <legend>
          <strong>Sections:</strong>
        </legend>
          <ul>
          <xsl:processing-instruction name="php"><![CDATA[ if($bSufficient) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="sufopt" id="sufopt" value="Y" checked="checked"/>
            <label for="sufopt">Show Sufficient Techniques and Failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="sufopt" id="sufopt" value="Y"/>
            <label for="sufopt">Show Sufficient Techniques and Failures</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
          <xsl:processing-instruction name="php"><![CDATA[ if($bAdvisory) { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="advopt" id="advopt" value="Y" checked="checked"/>
            <label for="advopt">Show Advisory Techniques</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <li>
            <input type="checkbox" name="advopt" id="advopt" value="Y"/>
            <label for="advopt">Show Advisory Techniques</label>
          </li>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
        </ul>
      </fieldset>
      <fieldset>
        <legend>
          <strong>Save Settings Option:</strong>
        </legend>
        
        <ul>
        <li>
          <xsl:processing-instruction name="php"><![CDATA[ if ($bCookies) { ]]></xsl:processing-instruction>
          <input type="checkbox" name="savesettings" id="savesettings" value="Y" checked="checked"/>
          <label for="savesettings">Save these settings (requires cookies)</label>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
          <input type="checkbox" name="savesettings" id="savesettings" value="Y"/>
          <label for="savesettings">Save these settings (requires cookies)</label>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
        </li></ul>
      </fieldset>
 
<!-- BBC: Added hidden fields here so that show/hide status of intro and conformance requirements sections would be saved -->
        <xsl:processing-instruction name="php"><![CDATA[ if($bIntroduction) { ]]></xsl:processing-instruction>
            <input type="hidden" name="introopt" value="Y"/>  
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
            <input type="hidden" name="introopt" value="N" />  
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
          
         <xsl:processing-instruction name="php"><![CDATA[ if($bConformance) { ]]></xsl:processing-instruction>
            <input type="hidden" name="confreqs" value="Y"/>  
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
            <input type="hidden" name="confreqs" value="N" />  
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
    
      
      <p id="submitAsCT">
        <input type="hidden" value="Y" name="AsCT"/>
        <input type="submit" value="Customize with Settings Above"/>
      </p>
    </form>
    
<xsl:call-template name="restoresettings">
  <xsl:with-param name="button">1</xsl:with-param>
</xsl:call-template>
    
    
    </div>
  </xsl:template>
  <xsl:template match="div4/head">
  
 
    <!--this is repeated in the xmlspec-howto -->
    <xsl:choose>
      <xsl:when test="../@role='sufficient'">
        <h5 id="{ancestor::div2/@id}-{../@role}-head" xmlns="http://www.w3.org/1999/xhtml">Sufficient Techniques for <xsl:value-of select="../../../head"/><xsl:text> </xsl:text> - <xsl:call-template name="sc-handle">
      <xsl:with-param name="handleid" select="../../../@id"/>
    </xsl:call-template>
<xsl:processing-instruction name="php"><![CDATA[ if ($bCSS && $bSMIL && $bScript && $bARIA && $bServerSide) { ]]></xsl:processing-instruction>  
<xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>        
          <xsl:text> </xsl:text>
          <span class="AsCTlist">(for the technologies you checked above)</span>
         <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
         </h5>
      </xsl:when>
      <xsl:when test="../@role='failures'">
        <!-- test to determine whether there are actually failures -->
        <xsl:choose>
          <xsl:when test="count(../ulist) = 0"/>
          <xsl:otherwise>
            <h5 id="{ancestor::div2/@id}-{../@role}-head" xmlns="http://www.w3.org/1999/xhtml">Failures for <abbr title="Success Criterion">SC</abbr><xsl:text> </xsl:text><xsl:value-of select="../../../head"/><xsl:text> </xsl:text> - <xsl:call-template name="sc-handle">
      <xsl:with-param name="handleid" select="../../../@id"/>
    </xsl:call-template>
            </h5>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="../@role='tech-optional'">
        <xsl:choose>
          <xsl:when test="count(../ulist) + count(../div5) = 0"/>
          <xsl:otherwise>
            <h5 id="{ancestor::div2/@id}-{../@role}-head" xmlns="http://www.w3.org/1999/xhtml">Advisory Techniques	for <xsl:value-of select="../../../head"/><xsl:text> </xsl:text> - <xsl:call-template name="sc-handle">
      <xsl:with-param name="handleid" select="../../../@id"/>
    </xsl:call-template>
            </h5>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!-- BBC - Note that this will need to be fixed should the intro ever include a div4. Ideally, a test for siblings to <head> would be included before the current choose statement.-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="div5/head">
    <xsl:choose>
      <xsl:when test="@role='css' or @role='script' or @role='smil' or @role='aria' or @role='server'">
        <xsl:variable name="liclass">base<xsl:value-of select="@role"/>base</xsl:variable>
        <xsl:if test="@role='css'">
          <xsl:processing-instruction name="php"><![CDATA[ if ($bCSS && !$bCSSBase) { ]]></xsl:processing-instruction>
        </xsl:if>
        <xsl:if test="@role='smil'">
          <xsl:processing-instruction name="php"><![CDATA[ if ($bSMIL && !$bSMILBase) { ]]></xsl:processing-instruction>
        </xsl:if>
        <xsl:if test="@role='script'">
          <xsl:processing-instruction name="php"><![CDATA[ if ($bScript && !$bScriptBase) { ]]></xsl:processing-instruction>
        </xsl:if>
        <xsl:if test="@role='aria'">
          <xsl:processing-instruction name="php"><![CDATA[ if ($bARIA && !$bARIABase) { ]]></xsl:processing-instruction>
        </xsl:if>
        <xsl:if test="@role='server'">
          <xsl:processing-instruction name="php"><![CDATA[ if ($bServerside && !$bServersideBase) { ]]></xsl:processing-instruction>
        </xsl:if>
        <div xmlns="http://www.w3.org/1999/xhtml">
          <xsl:attribute name="class"><xsl:value-of select="$liclass"/></xsl:attribute>
          <h6 class="situation" xmlns="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates/>
          </h6>
        </div>
        <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
      </xsl:when>
      <xsl:otherwise>
        <h6 class="situation" xmlns="http://www.w3.org/1999/xhtml">
          <xsl:apply-templates/>
        </h6>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- mode: toc rewrote this section so that TOC would result in actual lists-->
  <xsl:template mode="tocquickref" match="div1">
    <xsl:choose>
    <xsl:when test="@id='intro' or @id='customize' or @id='toc'" />
      <xsl:when test="@id='guidelines'">
        <li xmlns="http://www.w3.org/1999/xhtml">
          <a>
            <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="head" mode="text"/>
          </a>
          <ul xmlns="http://www.w3.org/1999/xhtml" class="toc">
            <xsl:for-each select="$gl-src//div3[@role='group1'] | $gl-src//div3[@role='group2']">
              <li xmlns="http://www.w3.org/1999/xhtml">
                <xsl:number level="multiple" count="div2 | div3" format="1.1"/><xsl:text> </xsl:text>
                <a href="#{@id}">
                  <strong><xsl:call-template name="sc-handle">
          <xsl:with-param name="handleid" select="@id"/>
        </xsl:call-template>:</strong><xsl:text> </xsl:text><xsl:apply-templates select="head" mode="text"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <li xmlns="http://www.w3.org/1999/xhtml">
          <a>
            <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="head" mode="text"/>
          </a>
          <xsl:if test="$toc.level &gt; 1">
            <xsl:variable name="children1">
              <xsl:value-of select="count(div2)"/>
            </xsl:variable>
          </xsl:if>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="levels">
  
    <xsl:for-each select="./div4[@role='req'] | ./div4[@role='bp'] | ./div4[@role='additional']">
      <xsl:if test="@role='req'">
        <xsl:processing-instruction name="php"><![CDATA[ if ($bLevel1) { ]]></xsl:processing-instruction>
      </xsl:if>
      <xsl:if test="@role='bp'">
        <xsl:processing-instruction name="php"><![CDATA[ if ($bLevel2) { ]]></xsl:processing-instruction>
      </xsl:if>
      <xsl:if test="@role='additional'">
        <xsl:processing-instruction name="php"><![CDATA[ if ($bLevel3) { ]]></xsl:processing-instruction>
      </xsl:if>
      <xsl:if test="count(div5) - count(div5[@diff='del']) != 0">
        <xsl:element name="div" xmlns="http://www.w3.org/1999/xhtml">
          <xsl:choose>
            <xsl:when test="@role='req'">
              <xsl:attribute name="class">level1</xsl:attribute>
            </xsl:when>
            <xsl:when test="@role='bp'">
              <xsl:attribute name="class">level2</xsl:attribute>
            </xsl:when>
            <xsl:when test="@role='additional'">
              <xsl:attribute name="class">level3</xsl:attribute>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
         
          <xsl:call-template name="sc-copy"/>
        </xsl:element>
      </xsl:if>
      <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="p[@role='i'] | p[@role='v']">
    <p  >
      <xsl:if test="@id">
        <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
      </xsl:if>
      <strong>
        <em>
          <xsl:call-template name="sc-number-link"/>
        </em>
      </strong>
      <xsl:text> </xsl:text>
      <xsl:apply-templates/>
      <xsl:text> </xsl:text>
      <xsl:if test="$guide='1'">
					[<a href="{$guidethisversion}#{../@id}">Understanding <xsl:call-template name="sc-number"/>
        </a>]
				</xsl:if>
      <xsl:if test="$guide='0'">
        <em>(Level <xsl:choose>
            <xsl:when test="ancestor::div4[@role='req']">A</xsl:when>
            <xsl:when test="ancestor::div4[@role='bp']">AA</xsl:when>
            <xsl:when test="ancestor::div4[@role='additional']">AAA</xsl:when>
          </xsl:choose>)</em>
      </xsl:if>
    </p>
  </xsl:template>
  <xsl:template name="sc-number-link">
    <a href="{$glthisversion}#{../@id}"><xsl:call-template name="sc-number"/></a>
  </xsl:template>

  <xsl:template match="header">
    <!--p xmlns="http://www.w3.org/1999/xhtml" align="center">[<a href="#contents">contents</a>]<xsl:text> </xsl:text>[<a href="#customize">customize</a>]
    </p-->
    <div xmlns="http://www.w3.org/1999/xhtml" class="head">
      <xsl:if test="not(/spec/@role='editors-copy')">
       <p id="logos"><a href="http://www.w3.org/" title="W3C Home"><img src="http://www.w3.org/Icons/w3c_home" alt="W3C logo" width="72" height="48" /></a><a href="http://www.w3.org/WAI/" title="WAI Home"><img src="http://www.w3.org/WAI/images/wai-temp" alt="Web Accessibility Initiative (WAI) logo" height="48" /></a></p>
      </xsl:if>
      <xsl:text>
</xsl:text>
      <h1>
        <xsl:call-template name="anchor">
          <xsl:with-param name="node" select="title[1]"/>
          <xsl:with-param name="conditional" select="0"/>
          <xsl:with-param name="default.id" select="'title'"/>
        </xsl:call-template>
        <xsl:apply-templates select="title"/> 
        <xsl:if test="version">
          <xsl:text> </xsl:text>
          <xsl:apply-templates select="version"/>
        </xsl:if>
      </h1>
      <xsl:if test="subtitle">
        <xsl:text>
</xsl:text>
        <h2>
          <xsl:call-template name="anchor">
            <xsl:with-param name="node" select="subtitle[1]"/>
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="default.id" select="'subtitle'"/>
          </xsl:call-template>
          <xsl:apply-templates select="subtitle"/>
        </h2>
      </xsl:if>
      <xsl:text>
      </xsl:text>
      <xsl:if test="/spec/@w3c-doctype = 'review'">
      <h2>
        <xsl:if test="/spec/@w3c-doctype='review'">
          <xsl:attribute name="class">sorethumb</xsl:attribute>
        </xsl:if>
        <xsl:call-template name="anchor">
          <xsl:with-param name="node" select="w3c-doctype[1]"/>
          <xsl:with-param name="conditional" select="0"/>
          <xsl:with-param name="default.id" select="'w3c-doctype'"/>
        </xsl:call-template>
        <xsl:choose>
          <xsl:when test="/spec/@w3c-doctype = 'review'">
            <xsl:text>Editor's Draft</xsl:text>
                   <xsl:text> </xsl:text>
        <xsl:if test="pubdate/day">
          <xsl:apply-templates select="pubdate/day"/>
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates select="pubdate/month"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="pubdate/year"/>
        <xsl:if test="$additional.title != ''">
          <xsl:text>  </xsl:text>
          <xsl:value-of select="$additional.title"/>
        </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="w3c-doctype[1]"/>
          </xsl:otherwise>
        </xsl:choose>
      </h2>
        </xsl:if>
      <!--<dl>
        <xsl:apply-templates select="publoc"/>
        <xsl:apply-templates select="latestloc"/>
        <xsl:apply-templates select="prevlocs"/>
        <xsl:apply-templates select="authlist"/>
      </dl>
       output the errataloc and altlocs >
      <xsl:apply-templates select="errataloc"/>
      <xsl:apply-templates select="preverrataloc"/>
      <xsl:apply-templates select="translationloc"/>
      <xsl:apply-templates select="altlocs"/-->
    </div>
    <xsl:apply-templates select="notice"/>
    <!--xsl:apply-templates select="abstract"/>
    <xsl:apply-templates select="status"/>
    <xsl:apply-templates select="revisiondesc"/-->
    
  </xsl:template>
  
  <xsl:template match="div2/head">
    <xsl:choose>
      <xsl:when test="../@id='conformance-reqs'"></xsl:when>
      <xsl:otherwise>
        <h2 xmlns="http://www.w3.org/1999/xhtml">
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
          <xsl:value-of select="../head"/>
        </h2>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template match="div1[@id='toc']">
<xsl:if test="$toc.level &gt; 0">
      <div xmlns="http://www.w3.org/1999/xhtml" class="toc" id="toc">
        <xsl:text>
</xsl:text>

                <h2 xmlns="http://www.w3.org/1999/xhtml">
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="default.id" select="'contents'"/>
          </xsl:call-template>
          <xsl:text>Table of Contents</xsl:text>
        </h2>
        <ul xmlns="http://www.w3.org/1999/xhtml" class="toc">
          <xsl:choose>
            <xsl:when test="$quickref='1'">
              <xsl:apply-templates select="//div1" mode="tocquickref"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates select="//div1" mode="toc"/>
            </xsl:otherwise>
          </xsl:choose>
        </ul>
        <xsl:if test="../back">
          <xsl:text>
</xsl:text>
          <h3 xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="anchor">
              <xsl:with-param name="conditional" select="0"/>
              <xsl:with-param name="default.id" select="'appendices'"/>
            </xsl:call-template>
            <xsl:text>Appendi</xsl:text>
            <xsl:choose>
              <xsl:when test="count(../back/div1 | ../back/inform-div1) &gt; 1">
                <xsl:text>ces</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>x</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </h3>
          <ul class="toc">
            <xsl:apply-templates mode="toc" select="../back/div1 | ../back/inform-div1"/>
            <xsl:call-template name="autogenerated-appendices-toc"/>
          </ul>
        </xsl:if>
        <xsl:if test="//footnote[not(ancestor::table)]">
          <ul class="toc">
            <a href="#endnotes">
              <xsl:text>End Notes</xsl:text>
            </a>
          </ul>
        </xsl:if>
      </div>
    </xsl:if>
</xsl:template>  
 <xsl:template match="div4[@role='tech-optional']">
 <xsl:if test="count(div5) + count(ulist) != 0">
     <xsl:processing-instruction name="php"><![CDATA[ if($bAdvisory) { ]]></xsl:processing-instruction>   
  <div xmlns="http://www.w3.org/1999/xhtml" class="advisory">
      <xsl:apply-templates />
 <!-- </div>
  <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>   
  <div xmlns="http://www.w3.org/1999/xhtml" class="advisory initstate">
    <xsl:apply-templates />-->
  </div>
<xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
</xsl:if>
 </xsl:template>
 <xsl:template match="div4[@role='failures']">
 <xsl:if test="count(div5) + count(ulist) != 0">
  <div xmlns="http://www.w3.org/1999/xhtml" class="failures">
    <xsl:apply-templates />
  </div>
</xsl:if>
 </xsl:template>


<xsl:template match="div1[@id='intro']/head">
                
<a id="intro" name="intro" xmlns="http://www.w3.org/1999/xhtml"><xsl:text> </xsl:text></a><h2 xmlns="http://www.w3.org/1999/xhtml"><xsl:value-of select="." />
<xsl:processing-instruction name="php"><![CDATA[ if ($bIntroduction) { ]]></xsl:processing-instruction>
<xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
<xsl:text> </xsl:text><span class="showhideR">(Hidden)</span>
<xsl:processing-instruction name="php"><![CDATA[ }]]></xsl:processing-instruction>
</h2>
        <xsl:processing-instruction name="php"><![CDATA[ if($bIntroduction) { ]]></xsl:processing-instruction>
            <p><span class="showhideinline">[<a href="Overview.php?introopt=N">Hide Introduction</a>]</span> </p>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
             <p><span class="showhideinline">[<a href="Overview.php?introopt=Y">Show Introduction</a>]</span> </p>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 

 <xsl:processing-instruction name="php"><![CDATA[ if ($bIntroduction) { ]]></xsl:processing-instruction>
 
<div id="introduction" class="introduction" xmlns="http://www.w3.org/1999/xhtml">
  <p>This document lists all of the requirements (called "success criteria") from <a href="{$gl-src//latestloc/loc[@href]}">Web Content Accessibility Guidelines (WCAG) 2.0</a>. It also lists techniques to meet the requirements, which link to more details. The "Understanding" links go to descriptions, examples, and resources. </p>
  
  <p>You can customize the list by selecting the technologies that apply to your Web project, and the <a href="{$guide-src//latestloc/loc[@href]}#uc-levels-head">levels</a> and techniques that you want included in the list. </p>

    <p>See the <a href="http://www.w3.org/WAI/intro/wcag.php">WCAG Overview</a> for an introduction to WCAG and supporting documents, including more information about this document. </p>

  <h3 id="about-techs">About the Techniques</h3>

    <p>Note that all techniques are <a href="{$gl-src//latestloc/loc[@href]}#informativedef">informative</a> - you don't have to follow them. The "sufficient techniques" listed below are considered sufficient to meet the success criteria; however, it is not necessary to use these particular techniques. Anyone can <a href="http://www.w3.org/WAI/GL/WCAG20/TECHS-SUBMIT/">submit new techniques</a> at any time. If techniques are used other than those listed by the Working Group, then some other method for establishing the technique's ability to meet the success criteria would be needed.</p>

  <p> In addition to the 'sufficient techniques', there are also advisory techniques that go beyond WCAG 2.0's requirements. Authors are encouraged to apply all techniques that they are able to, including the advisory techniques, in order to best address the needs of the widest possible range of users. </p>
  <p>Note that even content that conforms at the highest level (AAA) will not be accessible to individuals with all types, degrees, or combinations of disability, particularly in the cognitive language and learning areas. Authors are encouraged to seek relevant advice about current best practice to ensure that Web content is accessible, as far as possible, to this community.</p>
    
    <p>See also <a href="{$guide-src//publoc/loc[@href]}intro.html#introduction-layers-techs-head">Sufficient and Advisory Techniques</a>.</p>
      </div>
              <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
   </xsl:template>
   
 
 <xsl:template match="div1[@id='guidelines']/head">
 
 <!--Insert "Your customized" before heading if any settings have been modified from default. -->
 <h2 id="guidelines"><xsl:processing-instruction name="php"><![CDATA[ if ($bCSS && $bSMIL && $bScript && $bARIA && $bServerSide && $bLevel1 && $bLevel2 && $bLevel3 && $bSufficient && $bAdvisory && $bIntroduction && $bConformance ) { ]]></xsl:processing-instruction>  
<xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>        
          Your Customized<xsl:text> </xsl:text>
         <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction><xsl:apply-templates /></h2>
         
<p  class="showhideR" style="margin-bottom: 0">This Quick Reference is currently customized to include:</p>

              <xsl:processing-instruction name="php"><![CDATA[ 
              		   $technologies_array = array(
		   		"true" => array($bHTML, $bCSS, $bSMIL, $bScript, $bServerSide, $bARIA),
				"readable" => array("HTML", "CSS", "SMIL", "Client-side Scripting", "Server-side Scripting", "WAI-ARIA")
				);
		   
								for ($i = 0; $i < 6; $i++)
								{
								 	if ($technologies_array['true'][$i] == "Y")
								 	{
								 		$true[$i] = $technologies_array['readable'][$i];
									}
								}
								
								echo "<ul class=\"showhideR\"><li><strong>Techniques and Failures: </strong>";
								echo implode(", ", $true) . " ";
								
								for ($i = 0; $i < 6; $i++)
								{
								 	if ($technologies_array['true'][$i] == "Y")
								 	{
								 		
									}
									else
									{
								 		$false[$i] = $technologies_array['readable'][$i];
									}
								}
								if (isset($false)) {
									echo "(<strong>Hidden: </strong>";
									echo implode(", ", $false);
									echo ")";
									}
								echo "</li>";
								
		   $levels_array = array(
		   		"true" => array($bLevel1, $bLevel2, $bLevel3),
				"readable" => array("A", "AA", "AAA")
				);
		   
								for ($i = 0; $i < 3; $i++)
								{
								 	if ($levels_array['true'][$i] == "Y")
								 	{
								 		$levelstrue[$i] = $levels_array['readable'][$i];
									}
								}
								
								echo "<li><strong>Success Criteria Levels: </strong>";
								if (isset($levelstrue)) {
									echo implode(", ", $levelstrue) . " ";
								}
								else {
									echo "none ";
								}
								
								for ($i = 0; $i < 3; $i++)
								{
								 	if ($levels_array['true'][$i] == "Y")
								 	{
								 		
									}
									else
									{
								 		$levelsfalse[$i] = $levels_array['readable'][$i];
									}
								}
								if (isset($levelsfalse)) {
									echo "(<strong>Hidden: </strong>";
									echo implode(", ", $levelsfalse);
									echo ")";
										}
								echo "</li>";
								
				$sections_array = array(
		   		"true" => array($bIntroduction, $bSufficient, $bAdvisory, $bConformance),
				"readable" => array("Introduction", "Sufficient Techniques and Failures", "Advisory Techniques", "Conformance Requirements")
				);
		   
								for ($i = 0; $i < 4; $i++)
								{
								 	if ($sections_array['true'][$i] == "Y")
								 	{
								 		$sectionstrue[$i] = $sections_array['readable'][$i];
									}
								}
								
								echo "<li><strong>Sections: </strong>";
								if (isset($sectionstrue)) {
									echo implode(", ", $sectionstrue) . " ";
								}
								else {
									echo "none ";
								}
								
								for ($i = 0; $i < 4; $i++)
								{
								 	if ($sections_array['true'][$i] == "Y")
								 	{
								 		
									}
									else
									{
								 		$sectionsfalse[$i] = $sections_array['readable'][$i];
									}
								}
								if (isset($sectionsfalse)) {
									echo "(<strong>Hidden: </strong>";
									echo implode(", ", $sectionsfalse);
									echo ")";
										}
										echo "</li></ul>";
              
               ]]></xsl:processing-instruction>
               
 </xsl:template>   

<xsl:template name="confreqs">
                
<a id="conformance-reqs" name="conformance-reqs" xmlns="http://www.w3.org/1999/xhtml"><xsl:text> </xsl:text></a><h2 xmlns="http://www.w3.org/1999/xhtml"><xsl:value-of select="$gl-src//div2[@id='conformance-reqs']/head" />
<xsl:processing-instruction name="php"><![CDATA[ if ($bConformance) { ]]></xsl:processing-instruction>
<xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
<xsl:text> </xsl:text><span class="showhideR">(Hidden)</span>
<xsl:processing-instruction name="php"><![CDATA[ }]]></xsl:processing-instruction>
</h2>
        <xsl:processing-instruction name="php"><![CDATA[ if($bConformance) { ]]></xsl:processing-instruction>
            <p><span class="showhideinline">[<a href="Overview.php?confreqs=N#conformance-reqs">Hide Conformance Requirements</a>]</span> </p>
          <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>
             <p><span class="showhideinline">[<a href="Overview.php?confreqs=Y#conformance-reqs">Show Conformance Requirements</a>]</span> </p>
          <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 

 <xsl:processing-instruction name="php"><![CDATA[ if ($bConformance) { ]]></xsl:processing-instruction>
 
<div id="conformance" class="conformancereqscontainer" xmlns="http://www.w3.org/1999/xhtml">
    <xsl:apply-templates select="$gl-src//div2[@id='conformance-reqs']"/>
</div>
              <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
   </xsl:template>
   
   <xsl:template name="restoresettings">
   <xsl:param name="anchor" select="''"/>
   <xsl:param name="button" select="''"/>
   <form method="post" xmlns="http://www.w3.org/1999/xhtml">
<xsl:choose>
    <xsl:when test="$anchor">
        <xsl:attribute name="action">Overview.php#qr-<xsl:value-of select="$anchor"></xsl:value-of></xsl:attribute>
    </xsl:when>
    <xsl:otherwise>
        <xsl:attribute name="action">Overview.php</xsl:attribute>
    </xsl:otherwise>
  </xsl:choose>
<xsl:processing-instruction name="php"><![CDATA[ 

// only show restore settings controls if settings have been saved previously and overridden
if(stristr($uaString, "/TR/") || stristr($uaString, "WCAG20/WD-WCAG20"))	{		

// insert all of the relevant cookies as hidden fields to be submitted for restored settings

 echo "<input type=\"hidden\" name=\"introopt\" value=\"" . $HTTP_COOKIE_VARS["introopt"] . "\" />";
 echo "<input type=\"hidden\" name=\"cssopt\" value=\"" . $HTTP_COOKIE_VARS["cssopt"] . "\" />";
 echo "<input type=\"hidden\" name=\"smilopt\" value=\"" . $HTTP_COOKIE_VARS["smilopt"] . "\" />";
 echo "<input type=\"hidden\" name=\"scriptopt\" value=\"" . $HTTP_COOKIE_VARS["scriptopt"] . "\" />";
 echo "<input type=\"hidden\" name=\"serversideopt\" value=\"" . $HTTP_COOKIE_VARS["serversideopt"] . "\" />";
  echo "<input type=\"hidden\" name=\"ariaopt\" value=\"" . $HTTP_COOKIE_VARS["ariaopt"] . "\" />";
 echo "<input type=\"hidden\" name=\"level1opt\" value=\"" . $HTTP_COOKIE_VARS["level1opt"] . "\" />";
 echo "<input type=\"hidden\" name=\"level2opt\" value=\"" . $HTTP_COOKIE_VARS["level2opt"] . "\" />";
 echo "<input type=\"hidden\" name=\"level3opt\" value=\"" . $HTTP_COOKIE_VARS["level3opt"] . "\" />";
 echo "<input type=\"hidden\" name=\"sufopt\" value=\"" . $HTTP_COOKIE_VARS["sufopt"] . "\" />";
 echo "<input type=\"hidden\" name=\"confreqs\" value=\"" . $HTTP_COOKIE_VARS["confreqs"] . "\" />";
 echo "<input type=\"hidden\" name=\"savesettings\" value=\"Y\" />";
// echo "<p class=\"submitAsCT\"><input type=\"hidden\" value=\"Y\" name=\"AsCT\"/><input type=\"submit\" value=\"Customize with Previously Saved Settings\" class=\"submitLink\"/></p>";
]]></xsl:processing-instruction>

<xsl:choose>
    <xsl:when test="$button">
        <p class="submitAsCT"><input type="hidden" value="Y" name="AsCT"/><input type="submit" value="Customize with Previously Saved Settings"/></p>
    </xsl:when>
    <xsl:otherwise>
        <p class="submitAsCT"><input type="hidden" value="Y" name="AsCT"/><input type="submit" value="Customize with Previously Saved Settings"/></p>
    </xsl:otherwise>
  </xsl:choose>
<xsl:processing-instruction name="php"><![CDATA[ 

}
]]></xsl:processing-instruction>

</form>

<!--xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>   
<xsl:text> </xsl:text>
<xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction-->   
   
   </xsl:template>
    <xsl:template match="//div3[@id='cc1']">
        <xsl:apply-templates />
        <div align="right">
            <p class="showhidelink"><a href="Overview.php" class="showhideR" id="qr-{@id}" title="Go to top of page">top of page</a></p>
            <xsl:call-template name="restoresettings">
                <xsl:with-param name="anchor"><xsl:value-of select="@id"></xsl:value-of></xsl:with-param>
            </xsl:call-template></div>
        <xsl:apply-templates select="$guide-src//div4[@id='techsaltver']/div5" mode="altvertechs" />
                    
    </xsl:template>
    
    <xsl:template match="div5" mode="altvertechs" name="altvertechs">
        
        <!--this is repeated in the xmlspec-howto -->
        <xsl:choose>
            <xsl:when test="@role='sufficient'">
                <xsl:processing-instruction name="php"><![CDATA[ if($bSufficient) { ]]></xsl:processing-instruction>   
                <div class="sufficient"><div class="boxed">
                <h5 id="cc1-{@role}-head" xmlns="http://www.w3.org/1999/xhtml">Sufficient Techniques for Conformance Requirement<xsl:text> </xsl:text><xsl:call-template name="cc-number"/>  -  Conformance Level
                    <xsl:processing-instruction name="php"><![CDATA[ if ($bCSS && $bSMIL && $bScript && $bARIA && $bServerSide) { ]]></xsl:processing-instruction>  
                    <xsl:processing-instruction name="php"><![CDATA[ } else { ]]></xsl:processing-instruction>        
                    <xsl:text> </xsl:text>
                    <span class="AsCTlist">(for the technologies you checked above)</span>
                    <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction>
                </h5>
                <xsl:apply-templates select="olist" />
                </div></div>
                <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
            </xsl:when>
            <xsl:when test="@role='failures'">
                <!-- test to determine whether there are actually failures -->
                <xsl:choose>
                    <xsl:when test="count(ulist) = 0"/>
                    <xsl:otherwise>
                        <xsl:processing-instruction name="php"><![CDATA[ if($bSufficient) { ]]></xsl:processing-instruction>   
                        <div class="failures"><div class="boxed">
                        <h5 id="cc1-{@role}-head" xmlns="http://www.w3.org/1999/xhtml">Failures for Conformance Requirement<xsl:text> </xsl:text><xsl:call-template name="cc-number"/>  -  Conformance Level
                        </h5>
                        <xsl:apply-templates select="ulist" />
                        </div></div>
                        <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@role='tech-optional'">
                <xsl:choose>
                    <xsl:when test="count(ulist) = 0"/>
                    <xsl:otherwise>
                        <xsl:processing-instruction name="php"><![CDATA[ if($bAdvisory) { ]]></xsl:processing-instruction>
                        <div class="advisory"><div class="boxed">
                        <h5 id="cc1-{@role}-head" xmlns="http://www.w3.org/1999/xhtml">Advisory Techniques for Conformance Requirement<xsl:text> </xsl:text><xsl:call-template name="cc-number"/>  -  Conformance Level
                        </h5>
                        <xsl:apply-templates select="ulist" />
                        </div></div>
                        <xsl:processing-instruction name="php"><![CDATA[ } ]]></xsl:processing-instruction> 
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- BBC - Note that this will need to be fixed should the intro ever include a div4. Ideally, a test for siblings to <head> would be included before the current choose statement.-->
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
        
                
    
</xsl:transform>
