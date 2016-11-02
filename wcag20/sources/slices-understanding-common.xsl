<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="2.0">
  <xsl:import href="diffspec-howto.xsl"/>
	<xsl:param name="output.dir" select="'.'"/>
	<xsl:param name="slices" select="1"/>
  <xsl:param name="show.diff.markup" select="0"/>
  <xsl:template name="href.target">
    <xsl:param name="target" select="."/>
    <xsl:variable name="slice" select="($target/ancestor-or-self::div1 | $target/ancestor-or-self::inform-div1  | $target/ancestor-or-self::div2   | $target/ancestor-or-self::div3 | $target/ancestor-or-self::spec)[last()]"/>
  	<!-- MC: this is a terrible hack, get a proper URL for the Conformance criterion cross reference. We should have a way of handling specrefs in content imported from guidelines, but I'm in a hurry and need to special case this. -->
  	<xsl:choose>
  		<xsl:when test="$target/@id = 'cc4' or $target/@id = 'cc5'"><xsl:value-of select="concat($glthisversion, '#', $target/@id)"/></xsl:when>
  		<xsl:otherwise>
  			<xsl:apply-templates select="$slice" mode="slice-understanding-filename"/>
  			<xsl:if test="$target != $slice">
  				<xsl:text>#</xsl:text>
  				<xsl:choose>
  					<xsl:when test="$target/@id">
  						<xsl:value-of select="$target/@id"/>
  					</xsl:when>
  					<xsl:otherwise>
  						<xsl:message terminate="yes">Generating ID for <xsl:value-of select="$target"/></xsl:message>
  						<xsl:value-of select="generate-id($target)"/>
  					</xsl:otherwise>
  				</xsl:choose>
  			</xsl:if>
  		</xsl:otherwise>
  	</xsl:choose>
  </xsl:template>
  <!-- Note: slice filename templates moved to xmlspec-wcag.xsl, so they can be used to create cross reference links. Also mode name changed to "slice-understanding-filename" in anticipation of also slicing up the techniques docs -->
  <!-- create a separate page for the introduction -->
  <xsl:template match="front/div1">
    <xsl:variable name="prev" select="(preceding::div1)[last()]"/>
    <xsl:variable name="next" select="(following::div1|following::inform-div1)[1]"/>
  	<xsl:variable name="filename"><xsl:apply-templates select="." mode="slice-understanding-filename"/></xsl:variable>
  	<xsl:result-document method="xml" href="file:///{$output.dir}/{$filename}" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no">
  		<html>
  			<xsl:if test="/spec/header/langusage/language">
  				<xsl:attribute name="lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  				<xsl:attribute name="xml:lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  			</xsl:if>
  			<head>
  				<title>
  					<xsl:apply-templates select="head" mode="text"/>  | WCAG 2.0解説書
  				</title>
  				<xsl:call-template name="canonical-link"/>
  				<xsl:call-template name="css"/>
  				<link rel="stylesheet" type="text/css" href="slicenav.css"/>
  				<xsl:if test="$show.diff.markup != 0">
  					<script type="text/javascript" src="diffmarks.js"><xsl:text> </xsl:text></script>
  					<link rel="stylesheet" type="text/css" href="diffs.css" />
  				</xsl:if>
  			</head>
  			<body class="slices">
  				<xsl:if test="$show.diff.markup != 0">
  					<xsl:attribute name="onload">jscheck()</xsl:attribute>
  				</xsl:if>
  				<xsl:call-template name="skipnav"></xsl:call-template>
  				<xsl:call-template name="navigation.top">
  					<xsl:with-param name="prev" select="$prev"/>
  					<xsl:with-param name="next" select="$next"/>
  				</xsl:call-template>
  				<div class="mainbody">
  					<div class="navtoc">
  						<p>このページの内容:</p>    
  						<ul id="navbar">
  							<xsl:for-each select="descendant::div3">
  							  <xsl:variable name="prefix">
  							    <xsl:choose>
  							      <xsl:when test="ancestor::div1/@id = 'intro'">イントロダクション</xsl:when>
  							      <xsl:when test="ancestor::div1/@id = 'understanding-techniques'">ut</xsl:when>
  							      <xsl:otherwise><xsl:message terminate="yes">Unhandled ID prefix in frontmatter TOC</xsl:message></xsl:otherwise>
  							    </xsl:choose>
  							  </xsl:variable>
  								<li><a href="#{$prefix}-{@id}-head"><xsl:value-of select="head"></xsl:value-of></a></li>
  							</xsl:for-each></ul>            
  					</div>            
  					<div class="div1">
  						<xsl:apply-templates/>
  					</div>
  					<xsl:call-template name="navigation.bottom">
  						<xsl:with-param name="prev" select="$prev"/>
  						<xsl:with-param name="next" select="$next"/>
  					</xsl:call-template>
  				</div>
  				<xsl:call-template name="footer"></xsl:call-template>
  			</body>
  		</html>
  	</xsl:result-document>
  </xsl:template>
  <!-- create Understanding Guidelines Pages -->
  <xsl:template match="body/div1">
    <xsl:variable name="prev" select="(preceding::div2[@role='extsrc']|preceding::div1[@id!='placeholders']|preceding::inform-div1)[last()]"/>
    <xsl:variable name="next" select="(div2[@role='extsrc']|following::div1|following::inform-div1)[1]"/>
  	<xsl:variable name="filename"><xsl:apply-templates select="." mode="slice-understanding-filename"/></xsl:variable>
  	<xsl:result-document method="xml" href="file:///{$output.dir}/{$filename}" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no">
  		<html>
  			<xsl:if test="/spec/header/langusage/language">
  				<xsl:attribute name="lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  				<xsl:attribute name="xml:lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  			</xsl:if>
  			<head>
  				<title>
  					<xsl:if test="@id!='conformance'">ガイドライン<xsl:text> </xsl:text>
  					</xsl:if>
  					<xsl:apply-templates select="head" mode="text"/> を理解する | WCAG 2.0解説書
  				</title>
  				<xsl:call-template name="canonical-link"/>
  				<xsl:call-template name="css"/>
  				<link rel="stylesheet" type="text/css" href="slicenav.css"/>
  				<xsl:if test="@id='conformance'">
  					<style type="text/css">
  						blockquote.scquote {margin: 0 1em 1em 1em;}
  					</style><xsl:text> </xsl:text>
  				</xsl:if>
  				
  				<xsl:if test="$show.diff.markup != 0">
  					<script type="text/javascript" src="diffmarks.js"><xsl:text> </xsl:text></script>
  					<link rel="stylesheet" type="text/css" href="diffs.css" />
  				</xsl:if>
  			</head>
  			<body class="slices">
  				<xsl:if test="$show.diff.markup != 0">
  					<xsl:attribute name="onload">jscheck()</xsl:attribute>
  				</xsl:if>
  				<xsl:call-template name="skipnav"></xsl:call-template>
  				
  				<xsl:call-template name="navigation.top">
  					<xsl:with-param name="prev" select="$prev"/>
  					<xsl:with-param name="next" select="$next"/>
  				</xsl:call-template>
  				<div class="mainbody">
  					<xsl:choose>
  						<xsl:when test="@id='conformance'">
  							<div class="navtoc">
  								<p>このページの内容:</p>    
  								<ul id="navbar">
  									<xsl:for-each select="descendant::div3">
  										<li><a href="#uc-{@id}-head"><xsl:value-of select="head"></xsl:value-of></a></li>
  									</xsl:for-each></ul>            
  							</div>                      
  						</xsl:when>
  						<xsl:otherwise>
  							
  							<div class="navtoc">
  								<p>このページの内容:</p>    
  								<xsl:apply-templates mode="gltoc" select=".">
  									<xsl:with-param name="just.filename" select="'1'"/>
  								</xsl:apply-templates>
  							</div>
  							
  						</xsl:otherwise>
  					</xsl:choose>    
  					
  					
  					
  					<div class="div1">
  						<xsl:choose>
  							<xsl:when test="@id='conformance'">
  								<xsl:apply-templates/>
  							</xsl:when>
  							<xsl:otherwise>
  								<xsl:apply-templates select="head"/>
  								<xsl:apply-templates select="div2[@role='glintent'] | div2[@role='gladvisory']"/>
  								<!-- List all Success Criterion for this guideline -->
  								<hr/>
  								<h2 id="{@id}-sc" class="section">このガイドラインの達成基準:</h2>
  								<ul>
  									<xsl:apply-templates mode="guidelinetoc" select="div2[@role='extsrc']">
  										<xsl:with-param name="just.filename" select="'1'"/>
  									</xsl:apply-templates>
  								</ul>
  							</xsl:otherwise>
  						</xsl:choose>
  					</div>
  					
  					<xsl:call-template name="navigation.bottom">
  						<xsl:with-param name="prev" select="(preceding::div2[@role='extsrc']|preceding::div1[@id!='placeholders']|preceding::inform-div1)[last()]"/>
  						<xsl:with-param name="next" select="(div2[@role='extsrc']|following::div1|following::inform-div1)[1]"/>
  					</xsl:call-template>
  				</div>
  				<xsl:call-template name="footer"></xsl:call-template>
  			</body>
  		</html>
  	</xsl:result-document>
<xsl:apply-templates select="div2[@role='extsrc']"/>
  </xsl:template>
   <!-- Create pages for the Understanding SC chunks-->
      <!--BBC: There is a xalan error that occurs only when generating a non diff-markup version (with show.diff-markup=0) that requires the variables $prev and $next to include the xpath expression from below in the calls to navigation.bottom -->   
   
    <xsl:template match="div2[@role='extsrc']">
      <xsl:variable name="prev" select="(preceding::div2[@role='extsrc']|parent::div1[@id!='placeholders'])[last()]"/>
      <xsl:variable name="next" select="(following::div2[@role='extsrc']|following::div1)[1]"/>
    	<xsl:variable name="filename"><xsl:apply-templates select="." mode="slice-understanding-filename"/></xsl:variable>
    	<xsl:result-document method="xml" href="file:///{$output.dir}/{$filename}" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no">
    	    <html>
    	    	<xsl:if test="/spec/header/langusage/language">
    	    		<xsl:attribute name="lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
    	    		<xsl:attribute name="xml:lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
    	    	</xsl:if>
    	    	<head>
    				<title>
    					達成基準 <xsl:call-template name="sc-number"><xsl:with-param name="id" select="@id"/></xsl:call-template> を理解する | WCAG 2.0解説書
    				</title>
    	    		<xsl:call-template name="canonical-link"/>
    				<xsl:call-template name="css"/>
    				<link rel="stylesheet" type="text/css" href="slicenav.css"/>
    				<xsl:if test="$show.diff.markup != 0">
    					<script type="text/javascript" src="diffmarks.js"><xsl:text> </xsl:text></script>
    					<link rel="stylesheet" type="text/css" href="diffs.css" />
    				</xsl:if>
    			</head>
    			<body class="slices">
    				<xsl:if test="$show.diff.markup != 0">
    					<xsl:attribute name="onload">jscheck()</xsl:attribute>
    				</xsl:if>
    				<xsl:call-template name="skipnav"></xsl:call-template>
    				<div class="mainbody">
    					<xsl:call-template name="navigation.top">
    						<xsl:with-param name="prev" select="$prev"/>
    						<xsl:with-param name="next" select="$next"/>
    					</xsl:call-template>
    					<!-- Quick TOC for Understanding SC -->
    					<div class="navtoc">
    						<p>このページの内容:</p>    
    						<xsl:apply-templates mode="criteriontoc" select=".">
    							<xsl:with-param name="just.filename" select="'1'"/>
    						</xsl:apply-templates>
    					</div>
    					<xsl:apply-templates/>
    					<xsl:if test="@role='extsrc'">
    						<xsl:variable name="gl" select="$gl-src//*[@id = current()/@id]"/>
    						<xsl:if test="$gl/descendant::termref">
    							<div class="div3">
    								<h2 id="key-terms" class="terms">重要な用語</h2>
    								<dl class="keyterms">
    									<xsl:for-each select="$gl/descendant::termref">
    										<xsl:sort data-type="text" select="$gl-src//*[@id = current()/@def]/label"/>
    										<xsl:apply-templates select="$gl-src//*[@id = current()/@def]"/>
    									</xsl:for-each>
    								</dl></div>
    						</xsl:if>
    					</xsl:if>
    					
    					<xsl:call-template name="navigation.bottom">
    						<xsl:with-param name="prev" select="(preceding::div2[@role='extsrc']|parent::div1[@id!='placeholders'])[last()]"/>
    						<xsl:with-param name="next" select="(following::div2[@role='extsrc']|following::div1)[1]"/>
    					</xsl:call-template>
    				</div>
    				<xsl:call-template name="footer"></xsl:call-template>
    			</body>
    		</html>
    	</xsl:result-document>
    </xsl:template>
    
<!--Generate the appendices -->   
   
  <xsl:template match="back/div1 | back/inform-div1">
    <xsl:variable name="prev" select="(preceding::div1|preceding::inform-div1)[last()]"/>
    <xsl:variable name="next" select="(following::div1|following::inform-div1)[1]"/>
  	<xsl:variable name="filename"><xsl:apply-templates select="." mode="slice-understanding-filename"/></xsl:variable>
  	<xsl:result-document method="xml" href="file:///{$output.dir}/{$filename}" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no">
  	    <html>
  	    	<xsl:if test="/spec/header/langusage/language">
  	    		<xsl:attribute name="lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  	    		<xsl:attribute name="xml:lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  	    	</xsl:if>
  	    	<head>
  				<title>
  					<xsl:apply-templates select="head" mode="text"/>  | WCAG 2.0解説書
  				</title>
  	    		<xsl:call-template name="canonical-link"/>
  				<xsl:call-template name="css"/>
  				<link rel="stylesheet" type="text/css" href="slicenav.css"/>
  				<xsl:if test="$show.diff.markup != 0">
  					<script type="text/javascript" src="diffmarks.js"><xsl:text> </xsl:text></script>
  					<link rel="stylesheet" type="text/css" href="diffs.css" />
  				</xsl:if>
  			</head>
  			<body class="slices">
  				<xsl:if test="$show.diff.markup != 0">
  					<xsl:attribute name="onload">jscheck()</xsl:attribute>
  				</xsl:if>
  				<xsl:call-template name="skipnav"></xsl:call-template>
  				<div class="mainbody">
  					<xsl:call-template name="navigation.top">
  						<xsl:with-param name="prev" select="$prev"/>
  						<xsl:with-param name="next" select="$next"/>
  					</xsl:call-template>
  					<div class="div1">
  						<xsl:apply-templates/>
  					</div>
  					<xsl:call-template name="navigation.bottom">
  						<xsl:with-param name="prev" select="(preceding::div1|preceding::inform-div1)[last()]"/>
  						<xsl:with-param name="next" select="(following::div1|following::inform-div1)[1]"/>
  					</xsl:call-template>
  					
  					
  					
  					
  				</div>
  				<xsl:call-template name="footer"></xsl:call-template>
  			</body>
  		</html>
  	</xsl:result-document>
  </xsl:template>
  
 
  <xsl:template match="spec">
  	<xsl:variable name="filename"><xsl:apply-templates select="." mode="slice-understanding-filename"/></xsl:variable>
  	<xsl:result-document method="xml" href="file:///{$output.dir}/{$filename}" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no">
  	    <html>
  	    	<xsl:if test="/spec/header/langusage/language">
  	    		<xsl:attribute name="lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  	    		<xsl:attribute name="xml:lang"><xsl:value-of select="/spec/header/langusage/language/@id"/></xsl:attribute>
  	    	</xsl:if>
  	    	<head>
  				<title>
  					<xsl:value-of select="header/title"/>
  					<xsl:if test="header/version">
  						<xsl:text> </xsl:text>
  						<xsl:apply-templates select="header/version"/>
  					</xsl:if>
  				</title>
  	    		<xsl:call-template name="canonical-link"/>
  				<xsl:call-template name="css"/>
  			</head>
  			<body class="slices">
  				<xsl:if test="$show.diff.markup != 0">
  					<xsl:attribute name="onload">jscheck()</xsl:attribute>
  				</xsl:if>
  				
  				<a name="top"><xsl:text> </xsl:text> </a>
  				<xsl:apply-templates/>
  				<xsl:if test="//footnote">
  					<hr/>
  					<div class="endnotes">
  						<h3>
  							<a name="endnotes">
  								<xsl:text>End Notes</xsl:text>
  							</a>
  						</h3>
  						<dl>
  							<xsl:apply-templates select="//footnote" mode="notes"/>
  						</dl>
  					</div>
  				</xsl:if>
  				<xsl:variable name="next" select="(descendant::div1)[1]"/>
  				<xsl:call-template name="navigation.bottom">
  					<xsl:with-param name="next" select="$next"/>
  				</xsl:call-template>
  				<!--BBC: Removed because pubrules doesn't like multiple copyright notices
  					xsl:call-template name="footer"></xsl:call-template-->
  			</body>
  		</html>
  	</xsl:result-document>
  </xsl:template>
  <!-- top navigation template-->
  <xsl:template name="navigation.top">
    <xsl:param name="prev" select="''"/>
    <xsl:param name="next" select="''"/>
    <a name="top">
      <xsl:text> </xsl:text>
    </a>
    <xsl:comment> TOP NAVIGATION BAR </xsl:comment>
    <ul id="navigation">
      <li>
        <strong><a href="Overview.html#contents" title="Table of Contents">目次</a></strong>
      </li>
      <li>
        <strong><a href="intro.html" title="Introduction to Understanding WCAG 2.0"><abbr title="Introduction">イントロダクション</abbr></a></strong>
      </li>
      <xsl:choose>
        <xsl:when test="$prev">
          <li>
            <a>
              <xsl:attribute name="title"><xsl:if test="not($prev/ancestor::front)">Understanding </xsl:if><xsl:call-template name="href.nav"><xsl:with-param name="target" select="$prev"/></xsl:call-template></xsl:attribute>
              <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="$prev"/><!--<xsl:with-param name="just.filename" select="1"/>--></xsl:call-template></xsl:attribute>
              <xsl:element name="strong">前へ:<xsl:text> </xsl:text></xsl:element>
              <xsl:call-template name="href.nav">
                <xsl:with-param name="target" select="$prev"/>
              </xsl:call-template>
            </a>
          </li>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$next">
          <li>
            <a>
            	<xsl:attribute name="title"><xsl:if test="not($next/ancestor::front)">Understanding </xsl:if><xsl:call-template name="href.nav"><xsl:with-param name="target" select="$next"/></xsl:call-template></xsl:attribute>
              <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="$next"/><!--<xsl:with-param name="just.filename" select="1"/>--></xsl:call-template></xsl:attribute>
              <xsl:element name="strong">次へ:<xsl:text> </xsl:text></xsl:element>
              <xsl:call-template name="href.nav">
                <xsl:with-param name="target" select="$next"/>
              </xsl:call-template>
            </a>
          </li>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </ul>
  </xsl:template>
  

  <!-- bottom navigation template-->
  <xsl:template name="navigation.bottom">
    <xsl:param name="prev" select="''"/>
    <xsl:param name="next" select="''"/>
    <xsl:comment> BOTTOM NAVIGATION BAR </xsl:comment>
    <ul id="navigationbottom">
      <li>
        <strong><a href="#top">ページの先頭へ</a></strong>
      </li>
      <li>
          <strong><a href="Overview.html#contents" title="Table of Contents">目次</a></strong>
      </li>
       <li>
        <strong><a href="intro.html" title="Introduction to Understanding WCAG 2.0"><abbr title="Introduction">イントロダクション</abbr></a></strong>
      </li>
      <xsl:choose>
        <xsl:when test="$prev">
          <li>
            <a>
              <xsl:attribute name="title">Understanding <xsl:call-template name="href.nav"><xsl:with-param name="target" select="$prev"/></xsl:call-template></xsl:attribute>
              <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="$prev"/><!--<xsl:with-param name="just.filename" select="1"/>--></xsl:call-template></xsl:attribute>
              <xsl:element name="strong">前へ:<xsl:text> </xsl:text></xsl:element>
              <xsl:call-template name="href.nav">
                <xsl:with-param name="target" select="$prev"/>
              </xsl:call-template>
            </a>
          </li>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$next">
          <li>
            <a>
              <xsl:attribute name="title">Understanding <xsl:call-template name="href.nav"><xsl:with-param name="target" select="$next"/></xsl:call-template></xsl:attribute>
              <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="$next"/><!--<xsl:with-param name="just.filename" select="1"/>--></xsl:call-template></xsl:attribute>
              <xsl:element name="strong">次へ:<xsl:text> </xsl:text></xsl:element>
              <xsl:call-template name="href.nav">
                <xsl:with-param name="target" select="$next"/>
              </xsl:call-template>
            </a>
          </li>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </ul>
  </xsl:template>
  <!-- BBC This template generates the TOC for the guidelines pages (points to each criterion and technique) -->
  <xsl:template mode="guidelinetoc" match="div2[@role='extsrc']">
    <li>
      <a>
        <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
        <xsl:apply-templates select="." mode="divnum"/>
        <xsl:choose>
          <xsl:when test="@role='extsrc'">
            <!--xsl:value-of select="$gl-src//div5[@id=current()/@id]/p"/-->
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="head" mode="text"/>
          </xsl:otherwise>
        </xsl:choose>
      </a>
    </li>
  </xsl:template>
  <!-- BBC This template generates the TOC for the understanding SC pages (in-page anchors) -->
  <xsl:template mode="criteriontoc" match="div2">
    <xsl:variable name="gl" select="$gl-src//*[@id = current()/@id]"/>
    <ul id="navbar">
      <xsl:if test="div3[@role='intent']">
        <li>
          <a href="#{@id}-intent-head">意図</a>
        </li>
      </xsl:if>
      <xsl:if test="div3[@role='examples']">
        <li>
          <a href="#{@id}-examples-head">事例</a>
        </li>
      </xsl:if>
      <xsl:if test="div3[@role='resources']">
        <li>
          <a href="#{@id}-resources-head">関連リソース</a>
        </li>
      </xsl:if>
      <xsl:if test="div3[@role='techniques']">
        <li>
          <a href="#{@id}-techniques-head">達成方法と不適合事例</a>
        </li>
      </xsl:if>
      <xsl:if test="div3[@role='terms'] or $gl/descendant::termref">
         <li>
          <a href="#key-terms">重要な用語</a>
        </li>
      </xsl:if>
  </ul>
  </xsl:template>
 <!-- BBC This template generates the TOC for the understanding SC pages (in-page anchors) -->
  <xsl:template mode="gltoc" match="div1">
        <ul id="navbar">
        <li>
          <a href="#{@id}">意図</a>
        </li>
        <li>
          <a href="#{@id}">参考達成方法</a>
        </li>
        <li>
          <a href="#{@id}-sc">達成基準</a>
        </li>
  </ul>
  </xsl:template>  
  
  <!-- BBC This template gives us some control over the previous/next links in the navigation -->
  <xsl:template name="href.nav">
    <xsl:param name="target" select="."/>
    <xsl:choose>
      <xsl:when test="$target/@id">
        <xsl:variable name="prefix">
          <xsl:value-of select="count($target/div2)"/>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="$target/@id='references'"> <xsl:value-of select="$target/head"/></xsl:when>
          <xsl:when test="$target/@id='conformance-referencing'"> 他の文書からのWCAG2.0の参照方法</xsl:when>
           <xsl:when test="$target/@id='accessibility-support-documenting'"> ウェブ技術の使用法のアクセシビリティ・サポーテッドを文書化する</xsl:when>
           <xsl:when test="$target/@id='understanding-metadata'"> メタデータを理解する</xsl:when>
          <xsl:when test="$prefix = 0">SC  <xsl:value-of select="$target/head"/> [<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="$target/@id"/></xsl:call-template>]</xsl:when>
          <xsl:when test="$target/@id='intro'"> <xsl:value-of select="$target/head"/></xsl:when>
        	<xsl:when test="$target/@id='understanding-techniques'"> <xsl:value-of select="$target/head"/></xsl:when>
          <xsl:when test="$target/@id='conformance'"> <xsl:value-of select="$target/head"/></xsl:when>
          <xsl:otherwise>ガイドライン  <xsl:value-of select="$target/head"/> [<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="$target/@id"/></xsl:call-template>]</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
      <xsl:text>ERROR!  No target @id defined</xsl:text>
			</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--Only differencein the templates below from xmlspec-wcag-howto is that heading level since (with slices, we need to be one heading level higher on all. Warning. Anything changed here should be changed in both locations... -->
  <xsl:template match="div1/head">
    <div class="skiptarget"><a id="maincontent">-</a></div>

    <xsl:element name="h1">
    <xsl:choose>
      <xsl:when test="../@role='extsrc'"></xsl:when>
      <xsl:otherwise><xsl:attribute name="class">normal</xsl:attribute></xsl:otherwise>
    </xsl:choose>
      <xsl:call-template name="anchor">
        <xsl:with-param name="conditional" select="0"/>
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <!--<xsl:apply-templates select=".." mode="divnum"/>
			BBC Added a test to replace guideline headings with value from current source-->
      <xsl:choose>
        <xsl:when test="../@role='extsrc'">
				   <strong><xsl:call-template name="sc-handle">
          <xsl:with-param name="handleid" select="../@id"/>
        </xsl:call-template></strong><span class="screenreader">:</span><br />Understanding Guideline <xsl:value-of select="../head"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
    
    <xsl:if test="../@role='extsrc'">
    <blockquote class="glquote">
          <div><p><strong>ガイドライン <xsl:value-of select="../head"/>: </strong><xsl:value-of select="$gl-src//div3[@id=current()/../@id]/head"/></p></div>
    </blockquote>
    </xsl:if>
  </xsl:template>
  <!-- head in div3 -->
  <xsl:template match="div2/head">
    <xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="../@role='glintent'">
        <h2 class="section">
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
			ガイドライン <xsl:value-of select="../../head"/>の意図
        </h2>
      </xsl:when>
      <xsl:when test="../@role='normal'">
        <h2 class="section">
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
          <xsl:value-of select="../head"/>
        </h2>
      </xsl:when>
      <xsl:when test="../@role='suppressed'">
      </xsl:when>
      <xsl:when test="../@role='gladvisory'">
        <h2 class="section">
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
			ガイドライン <xsl:value-of select="../../head"/> の参考にすべき達成方法(特定の達成基準に特有ではない達成方法)</h2>
        <div class="textbody">
          <p>このガイドラインにある各達成基準を満たすための達成方法は、この後に達成基準ごとに挙げられている。しかし、このガイドラインに対処するための達成方法がどの達成基準にも該当しない場合は、ここで挙げている。そういった達成方法は、どの達成基準を満たす上でも必須ではないし、十分でもないが、ウェブコンテンツの種類によってはより多くの利用者にとってよりアクセシブルにすることができるものである。</p>
          <xsl:choose>
            <xsl:when test="count(../ulist) = 0">
              <ul>
                <li>このガイドラインの参考にすべき達成方法はすべて、特定の達成基準に関係している。</li>
              </ul>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </div>
      </xsl:when>
      <xsl:otherwise>
      <div class="skiptarget"><a id="maincontent">-</a></div>
        <h1>
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="node" select=".."/>
          </xsl:call-template>
          <xsl:apply-templates select=".." mode="h1handle"/>
          <!--BBC Added a test to replace guideline headings with value from current source-->
        </h1>
      <blockquote class="scquote"><xsl:apply-templates select="$gl-src//div5[@id=current()/../@id]"/></blockquote>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="//div3/head">
    <xsl:choose>
      <xsl:when test="../@role='cc'">

			</xsl:when>
      <xsl:when test="../@role='front'">
			</xsl:when>
      <xsl:when test="../@role='normal'">
        <h2 id="{ancestor::div2/@id}-{../@id}-head" class="section">
          <xsl:apply-templates mode="text"/>
        </h2>
      </xsl:when>
      <xsl:otherwise>
        <!--BBC test to figure out if this is a success or a conformance criterion -->
        <xsl:variable name="criteriontype">
          <xsl:choose>
            <xsl:when test="../../@role='cc'">適合</xsl:when>
            <xsl:otherwise>達成</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <h2 id="{ancestor::div2/@id}-{../@role}-head" class="section">
          <!--BBC Added a test to replace guideline headings with value from current source-->
          <xsl:choose>
            <xsl:when test="../@role='intent'">
				この<xsl:value-of select="$criteriontype"/>基準の意図
			</xsl:when>
            <xsl:when test="../@role='techniques'">
				<xsl:value-of select="$criteriontype"/>基準 <xsl:call-template name="sc-number"><xsl:with-param name="id" select="../../@id"/></xsl:call-template> の達成方法及び不適合事例
              <xsl:text> </xsl:text>- <xsl:call-template name="sc-handle">
                <xsl:with-param name="handleid" select="../../@id"/>
              </xsl:call-template>
        </xsl:when>
            <xsl:when test="../@role='examples'">
				<xsl:value-of select="$criteriontype"/>基準 <xsl:call-template name="sc-number"><xsl:with-param name="id" select="../../@id"/></xsl:call-template>の事例
            </xsl:when>
            <xsl:when test="../@role='resources'">
				関連リソース
			</xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates mode="text"/>
            </xsl:otherwise>
          </xsl:choose>
        </h2>
        <xsl:choose>
          <xsl:when test="../@role='techniques'">
          	<xsl:call-template name="understanding.notrestricted.disclaimer"/>
          </xsl:when>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="../@role='resources'">
            <p>リソースは、情報提供のみを目的としており、推奨を意味するものではない。</p>
          	<xsl:if test="not(../p or ../olist or ../ulist or ../div4)">
              <p>(今のところ、文書化されていない)</p>
            </xsl:if>
          </xsl:when>
        	<xsl:when test="../@role='examples'">
        		<xsl:if test="not(../p or ../olist or ../ulist or ../div4)">
        			<p  >(今のところ、文書化されていない)</p>
        		</xsl:if>
        	</xsl:when>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template match="div4/head">
    <xsl:variable name="criteriontype">
      <xsl:choose>
        <xsl:when test="../../../@role='cc'">適合</xsl:when>
        <xsl:otherwise>達成</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="anchorinfo">
    <xsl:choose>
      <xsl:when test="../@id"><xsl:value-of select="../@id"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="count(preceding::div4)"/></xsl:otherwise>
    </xsl:choose></xsl:variable>
    <h3 id="{ancestor::div2/@id}-{$anchorinfo}-head" class="div3head" >
      <!--
			<xsl:call-template name="anchor">
				<xsl:with-param name="conditional" select="0"/>
				<xsl:with-param name="node" select=".."/>
			</xsl:call-template>
			-->
      <!--a name="{ancestor::div4/@id}-{parent::div5/@role}">
				<xsl:text> </xsl:text>
			</a-->
      <!--BBC Added a test to replace guideline headings with value from current source-->
      <xsl:choose>
        <xsl:when test="../@role='sufficient'">
				達成基準を満たすことのできる達成方法 
			</xsl:when>
        <xsl:when test="../@role='tech-specific'">
				Technology-Specific Techniques  
			</xsl:when>
        <xsl:when test="../@role='failures'">
				 <abbr title="Success Criterion">SC</abbr><xsl:text> </xsl:text><xsl:call-template name="sc-number"><xsl:with-param name="id" select="../../../@id"/></xsl:call-template>のよくある不適合事例
			</xsl:when>
        <xsl:when test="../@role='tech-optional'">
				 <xsl:call-template name="sc-number"><xsl:with-param name="id" select="../../../@id"/></xsl:call-template> でさらに対応が望まれる達成方法（参考）
        </xsl:when>
        <xsl:when test="../@role='sufficient'">
				</xsl:when>
        <xsl:when test="../@role='benefits'">
				<xsl:value-of select="$criteriontype"/>基準 <xsl:call-template name="sc-number"><xsl:with-param name="id" select="../../../@id"/></xsl:call-template>の具体的なメリット:
			</xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="text"/>
        </xsl:otherwise>
      </xsl:choose>
    </h3>
    <xsl:choose>
      <xsl:when test="../@role='failures'">
        <p>以下に挙げるものは、<acronym title="Web Content Accessibility Guidelines">WCAG</acronym> ワーキンググループが達成基準<xsl:call-template name="sc-number"><xsl:with-param name="id" select="../../../@id"/></xsl:call-template>に適合していないとみなした、よくある不適合事例である。</p>
      	<xsl:if test="not(../p or ../olist or ../ulist or ../div5)">
          <p>(今のところ、文書化された不適合事例はない)</p>
        </xsl:if>
      </xsl:when>
      <xsl:when test="../@role='tech-optional'">
        <p>適合するためには必須ではないが、コンテンツをよりアクセシブルにするためには、次の付加的な達成方法もあわせて検討するとよい。ただし、すべての状況において、すべての達成方法が使用可能、または効果的であるとは限らない。</p>
      	<xsl:if test="not(../p or ../olist or ../ulist or ../div5)">
          <p>(今のところ、文書化されていない)</p>
        </xsl:if>
      </xsl:when>
      <xsl:when test="../div5[@role='situation']">
        <p class="instructions">
          <strong>使用法：</strong> そのコンテンツに合致する状況を以下から選択すること。それぞれの状況には、WCAG ワーキンググループがその状況において十分であると判断する、番号付の達成方法（又は、達成方法の組合せ）がある。
</p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="div5/head">
    <xsl:choose>
      <xsl:when test="../@role='sc'">
		</xsl:when>
      <xsl:otherwise>
        <h4>
          <xsl:call-template name="anchor">
            <xsl:with-param name="conditional" select="0"/>
            <xsl:with-param name="node" select=".."/>
          	<xsl:with-param name="default.id">
          		<xsl:choose>
          			<xsl:when test="../@id"><xsl:value-of select="ancestor::div2/@id"/>-<xsl:value-of select="../@id"/>-head</xsl:when>
          			<xsl:otherwise><xsl:value-of select="ancestor::div2/@id"/>-<xsl:choose>
          				<xsl:when test="../@role"><xsl:value-of select="../@role"/></xsl:when>
          				<xsl:otherwise>section</xsl:otherwise>
          			</xsl:choose>-<xsl:value-of select="count(preceding::div5) +1"/>-head</xsl:otherwise>
          		</xsl:choose>
          	</xsl:with-param>
          </xsl:call-template>
          <xsl:apply-templates select=".." mode="divnum"/>
          <xsl:apply-templates/>
        </h4>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>
</xsl:text>
  </xsl:template>
  <xsl:template match="inform-div1/head">
    <xsl:text>
</xsl:text>
<div class="skiptarget"><a id="maincontent">-</a></div>
    <h1 class="normal">
      <xsl:call-template name="anchor">
        <xsl:with-param name="conditional" select="0"/>
        <xsl:with-param name="node" select=".."/>
      </xsl:call-template>
      <xsl:apply-templates select=".." mode="divnum"/>
      <xsl:apply-templates/>
    </h1>
  </xsl:template>

<!-- For slices, there's no need to suppress ids on definition lists in key terms section -->
<xsl:template match="gitem">
  <xsl:apply-templates />
</xsl:template>

<!-- the next two templates allow the termrefs within each Understanding SC slice to be in-page links to the key terms section while keeping termrefs within the definitions links to the guidelines glossary -->

<!-- BBC: Stupid hack, but make the following match something nonexistant and replublish only conformance.html to fix some bad anchor references - issue here is that there's no key terms section for conformance.-->
 <xsl:template match="termref"> 
   <a href="#{@def}" class="termref">
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
  
  <xsl:template match="gitem/def/*/termref | gitem/def/*/*/termref | gitem/def/*/*/*/termref | gitem/def/*/*/*/*/termref | gitem/def/*/*/*/*/*/termref | gitem/def/*/*/*/*/*/*/termref">
    <!--<xsl:variable name="glthisversion">
      <xsl:value-of select="$gl-src//publoc/loc[@href]"/>
    </xsl:variable>-->
   <a href="{$glthisversion}#{@def}" class="termref">
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

<!--Similar to termref above, this template makes it possible for bibrefs to function when they get copied into the understanding document-->

    <xsl:template match="gitem/def/*/bibref | gitem/def/*/*/bibref">
    <!--<xsl:variable name="glthisversion">
      <xsl:value-of select="$gl-src//publoc/loc[@href]"/>
    </xsl:variable>-->
   <a href="{$glthisversion}#{@ref}">[<xsl:choose><xsl:when test="count(child::node())=0"><xsl:value-of select="@ref"/></xsl:when><xsl:otherwise><xsl:apply-templates/></xsl:otherwise></xsl:choose>]</a>
  </xsl:template>
  
<xsl:template name="skipnav">
<div id="masthead"><p class="logo"><a href="http://www.w3.org/"><img width="72" height="48" alt="W3C" src="https://www.w3.org/StyleSheets/TR/2016/logos/W3C" /></a></p><p class="collectiontitle"><a href="Overview.html">WCAG 2.0解説書</a></p></div>

<div id="skipnav"><p class="skipnav"><a href="#maincontent">本文へジャンプ</a></p>	</div>

<xsl:if test="$show.diff.markup != 0">
              <div id="diffexp">
              <p class="screenreader">This document is a draft, and is designed to show changes from a previous version. It is presently showing <span class="diff-add">added text,</span> <span class="diff-change">changed text,</span> <span class="diff-delete">deleted text,</span><span class="difftext">[start]/[end] markers,</span> <span class="issue">and Issue Numbers</span>.</p>
                <p class="options"><a href="#" onclick="javascript:hideClass('diff-delete'); hideClass('issue'); hideClass('difftext');showClean('diff-change');showClean('diff-add')">Hide<!--Show-->&#160;All&#160;Edits</a> &#160; | &#160; <a href="#" onclick="javascript:toggleClass('diff-delete')">Toggle&#160;Deletions</a>&#160; | &#160; <a href="#"  onclick="javascript:toggleClass('issue')">Toggle&#160;Issue&#160;Numbers</a> &#160; | &#160; <a href="#" onclick="javascript:toggleClass('difftext')">Toggle<!--Hide-->&#160;[start]/[end]&#160;Markers</a> <!--&#160; | &#160; <a href="#">Show&#160;All&#160;Edits</a>-->&#160; | &#160; <a href="#" onclick="javascript:showClass('issue');showClass('diff-delete');showClass('difftext');showChange('diff-change');showAdd('diff-add')">Show&#160;All&#160;Edits</a></p><p class="state">Changes are displayed as follows:</p><ul>     <li> <span class="diff-add"><span class="difftext"> [begin add]</span> new, added text <span class="difftext">[end add] </span></span></li>     <li><span class="diff-change"><span class="difftext"> [begin change]</span> changed text <span class="difftext">[end change], </span></span></li>     <li><span class="diff-delete"><span class="difftext"> [begin delete]</span> deleted text <span class="difftext">[end delete] </span></span></li></ul>        
              </div>
            </xsl:if>
</xsl:template>

<xsl:template name="footer">
<div class="footer">
	<p class="copyright">このウェブページは、<a href="Overview.html">WCAG 2.0 解説書: WCAG 2.0 を理解して実装するためのガイド</a><xsl:call-template name="footer-latest-version-ref"/>の一部です。文書全体を<a href="complete.html">単一HTMLファイルにしたもの</a>もご利用いただけます。この文書と、ウェブ・コンテンツ・アクセシビリティ・ガイドライン (WCAG) 2.0に関連する他の文書との関係については、<a href="http://www.w3.org/WAI/intro/wcag20">The WCAG 2.0 Documents (英語)</a>をご覧ください。パブリックコメントを送るには、<a href="http://www.w3.org/WAI/WCAG20/comments/">Instructions for Commenting on WCAG 2.0 Documents（英語）</a>に従ってください。</p>
	<p class="copyright"><a href="http://www.w3.org/Consortium/Legal/ipr-notice#Copyright">Copyright</a> © <xsl:apply-templates select="//pubdate/year"/><xsl:text> </xsl:text><a href="http://www.w3.org/"><acronym title="World Wide Web Consortium">W3C</acronym></a><sup>®</sup> (<a href="http://www.csail.mit.edu/"><acronym title="Massachusetts Institute of Technology">MIT</acronym></a>, <a href="http://www.ercim.eu/"><acronym title="European Research Consortium for Informatics and Mathematics">ERCIM</acronym></a>, <a href="http://www.keio.ac.jp/">Keio</a>, <a href="http://ev.buaa.edu.cn/">Beihang</a>). W3C <a href="http://www.w3.org/Consortium/Legal/ipr-notice#Legal_Disclaimer">liability</a>, <a href="http://www.w3.org/Consortium/Legal/ipr-notice#W3C_Trademarks">trademark</a> and <a href="http://www.w3.org/Consortium/Legal/copyright-documents">document use</a> rules apply.</p>
<p>【注意】 この文書は、<a href="http://www.w3.org/TR/2016/NOTE-UNDERSTANDING-WCAG20-20160317/">W3Cワーキンググループノート「Understanding WCAG 2.0」（原文は英語）の2016年3月17日時点での最新版</a>を、「ウェブアクセシビリティ基盤委員会」が翻訳と修正をおこなって公開しているものです。（財団法人日本規格協会情報技術標準化研究センター「情報アクセシビリティ国際標準化に関する調査研究開発委員会・ウェブアクセシビリティ国際規格調査研究部会」が、「Understanding WCAG 2.0」の重要部分を翻訳して2009年1月に公開した文書が元になっています。）この文書の正式版は、あくまで W3Cのサイト内にある英語版であり、この文書には翻訳上の間違い、あるいは不適切な表現が含まれている可能性がありますのでご注意ください。また、リンク先が英語の場合、あるいはダミーのページである場合もあります。ご了承ください。</p>
<p>【重要】 原文の "Understanding WCAG 2.0"自体、WCAGワーキンググループによって今後も継続的に修正されていくものと思われます。この文書の内容は、あくまでも参考程度にご覧ください。</p>
</div>
</xsl:template>

	<xsl:template name="footer-latest-version-ref">
		<xsl:text> (see the </xsl:text>
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="ancestor::spec//latestloc/loc"/>
				<xsl:apply-templates select="." mode="slice-techniques-filename"/>
			</xsl:attribute>
			<xsl:text>latest version of this document</xsl:text>
		</a>
		<xsl:text>)</xsl:text>
	</xsl:template>
	
<xsl:template match="div3[@id='conformance-terms']">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>

</xsl:stylesheet>
