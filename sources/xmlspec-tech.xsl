<?xml version="1.0" encoding="utf-8"?>
<!-- Based on xmlspec-wcag.xsl  -->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://icl.com/saxon" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="saxon" version="1.0">
  <xsl:import href="xmlspec-wcag.xsl"/>
	<xsl:preserve-space elements="p item"/>
	<!--xsl:key name="bibls" match="document('refs.xml')/spec/body/div1/blist/bibl" use="@id"/-->
	<xsl:variable name="biblItems">
		<xsl:for-each select="document('refs.xml')//bibl">
			<xsl:copy-of select="."/>
		</xsl:for-each>
	</xsl:variable>
	<!-- create a variable for the wcag2.0 source document since we will pull  and success criterion text from that doc -->
	<xsl:variable name="wcag-src" select="document('wcag2-src.xml')"/>
	<!--xsl:param name="additional.title">(Editors' copy)</xsl:param-->
	<!-- if this =0, ednotes won't show -->
	<xsl:param name="show.ednotes">1</xsl:param>
		<xsl:param name="slices" select="0"/>
	<xsl:variable name="output.mode" select="'xhtml'"/>
	<xsl:param name="toc.level" select="3"/>

    
	<xsl:template match="bdo">
		<bdo>
			<xsl:if test="@xml:lang">
				<xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
				<xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="dir"><xsl:value-of select="@dir"/></xsl:attribute>
			<xsl:apply-templates/>
		</bdo>
	</xsl:template>
	<!-- copy-common-atts: copies across xml:lang and dir attributes.  The preferred way of doing  this is the template immediately following, but I can't copy the id across because of the way  xmlspec handles anchors. -->
	<xsl:template name="copy-common-atts">
		<xsl:for-each select="@*">
			<xsl:if test="name()='dir'">
				<xsl:copy/>
			</xsl:if>
			<xsl:if test="name()='xml:lang'">
				<xsl:copy/>
				<xsl:attribute name="lang"><xsl:value-of select="."/></xsl:attribute>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- copy-common-atts: does what it says (see comments for previous template). -->
	<xsl:template name="preferred-copy-common-atts">
		<xsl:for-each select="@*">
			<xsl:copy/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="description"><xsl:apply-templates/></xsl:template>
	<!-- Technique description -->
	<xsl:template match="technique/description">

		<xsl:call-template name="heading">
			<xsl:with-param name="level">
				<xsl:choose>
          <xsl:when test="$slices='1'">2</xsl:when>
		<xsl:when test="$bytech='1'">3</xsl:when>
          <xsl:otherwise>4</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
			<xsl:with-param name="id"><xsl:value-of select="../@id"/>-description</xsl:with-param>
			<xsl:with-param name="text">Description</xsl:with-param>
		</xsl:call-template>
		<div class="textbody"><xsl:apply-templates/></div>
	</xsl:template>
	<!-- don't copy the placeholders -->
	<xsl:template match="div1[@id='placeholders']"/>

   <xsl:template match="examples">
      <xsl:choose>
        <xsl:when test="$slices= '1'"> <h2 class="small-head" id="{../@id}-examples">Examples</h2></xsl:when>
        <xsl:when test="$bytech= '1'"> <h3 class="small-head" id="{../@id}-examples">Examples</h3></xsl:when>
        <xsl:otherwise> <h4 class="small-head" id="{../@id}-examples">Examples</h4></xsl:otherwise>
      </xsl:choose>
		  
						<xsl:apply-templates/>
   </xsl:template>
<xsl:template match="exsubhead">
    <xsl:variable name="exsubheadnum"><xsl:value-of select="count(preceding::exsubhead)"/></xsl:variable>
<xsl:choose>
  <xsl:when test="$slices= '1'"><h4 id="{../../../../@id}-subhead-{$exsubheadnum}"><xsl:apply-templates></xsl:apply-templates></h4></xsl:when>
  <xsl:when test="$bytech= '1'"><h5 id="{../../../../@id}-subhead-{$exsubheadnum}"><xsl:apply-templates></xsl:apply-templates></h5></xsl:when>
  <xsl:otherwise><h6 id="{../../../../@id}-subhead-{$exsubheadnum}"><xsl:apply-templates></xsl:apply-templates></h6></xsl:otherwise>
</xsl:choose>

</xsl:template>
	<xsl:template match="eg-group">
		<xsl:variable name="exnumber"><xsl:number level="multiple" count="eg-group" format="1"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="@role='failure'">
				<div class="failure">
					<xsl:call-template name="copy-common-atts"/>
					<xsl:choose>
          <xsl:when test="$slices='1'"><h3 class="small-head" id="{../../@id}-failex{$exnumber}">
					Failure Example <xsl:value-of select="$exnumber"></xsl:value-of><xsl:if test="head"><xsl:text>: </xsl:text></xsl:if><xsl:value-of select="head"></xsl:value-of></h3></xsl:when>
					  <xsl:when test="$bytech='1'"><h4 class="small-head" id="{../../@id}-failex{$exnumber}">
					    Failure Example <xsl:value-of select="$exnumber"></xsl:value-of><xsl:if test="head"><xsl:text>: </xsl:text></xsl:if><xsl:value-of select="head"></xsl:value-of></h4></xsl:when>
          <xsl:otherwise><h5 class="small-head" id="{../../@id}-failex{$exnumber}">
					Failure Example <xsl:value-of select="$exnumber"></xsl:value-of><xsl:if test="head"><xsl:text>: </xsl:text></xsl:if><xsl:value-of select="head"></xsl:value-of></h5></xsl:otherwise>
        </xsl:choose>
					
							<div class="example">
<xsl:apply-templates></xsl:apply-templates>
				</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
			<xsl:choose>
    <xsl:when test="$slices='1'"><h3 class="small-head" id="{../../@id}-ex{$exnumber}">Example <xsl:value-of select="$exnumber"></xsl:value-of><xsl:if test="head[@role='fail']"><xsl:text> (failure)</xsl:text></xsl:if><xsl:if test="head"><xsl:text>: </xsl:text></xsl:if> <xsl:value-of select="head"></xsl:value-of></h3></xsl:when>
			  <xsl:when test="$bytech='1'"><h4 class="small-head" id="{../../@id}-ex{$exnumber}">Example <xsl:value-of select="$exnumber"></xsl:value-of><xsl:if test="head[@role='fail']"><xsl:text> (failure)</xsl:text></xsl:if><xsl:if test="head"><xsl:text>: </xsl:text></xsl:if> <xsl:value-of select="head"></xsl:value-of></h4></xsl:when>
    <xsl:otherwise><h5 class="small-head" id="{../../@id}-ex{$exnumber}">Example <xsl:value-of select="$exnumber"></xsl:value-of><xsl:if test="head[@role='fail']"><xsl:text> (failure)</xsl:text></xsl:if><xsl:if test="head"><xsl:text>: </xsl:text></xsl:if> <xsl:value-of select="head"></xsl:value-of></h5></xsl:otherwise>
  </xsl:choose>
				
		<div class="example">
<xsl:apply-templates></xsl:apply-templates>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="eg-group/head"></xsl:template>
    
	<xsl:template match="eg-group/description">
<div class="textbody">
<xsl:apply-templates></xsl:apply-templates>
</div>	
	</xsl:template>
	
	<xsl:template match="procedure">
					<xsl:call-template name="copy-common-atts"/>
					<xsl:choose>
      <xsl:when test="$slices='1'"><h3 class="small-head" id="{../../@id}-procedure">Procedure</h3></xsl:when>
	<xsl:when test="$bytech='1'"><h4 class="small-head" id="{../../@id}-procedure">Procedure</h4></xsl:when>
      <xsl:otherwise><h5 class="small-head" id="{../../@id}-procedure">Procedure</h5></xsl:otherwise>
    </xsl:choose>
					
					<xsl:apply-templates/>
	</xsl:template>
		<xsl:template match="related-techs">
					<xsl:call-template name="copy-common-atts"/>
					<xsl:choose>
      <xsl:when test="$slices='1'"><h3 class="small-head" id="{../../@id}-related-techs">Related Techniques</h3></xsl:when>
	<xsl:when test="$bytech='1'"><h3 class="small-head" id="{../../@id}-related-techs">Related Techniques</h3></xsl:when>
      <xsl:otherwise><h5 class="small-head" id="{../../@id}-related-techs">Related Techniques</h5></xsl:otherwise>
    </xsl:choose>
					
					<xsl:apply-templates/>
	</xsl:template>
	
		<xsl:template match="expected-results">
					<xsl:call-template name="copy-common-atts"/>
					<xsl:choose>
      <xsl:when test="$slices='1'"><h3 class="small-head" id="{../../@id}-results">Expected Results</h3></xsl:when>
	<xsl:when test="$bytech='1'"><h4 class="small-head" id="{../../@id}-results">Expected Results</h4></xsl:when>
      <xsl:otherwise><h5 class="small-head" id="{../../@id}-results">Expected Results</h5></xsl:otherwise></xsl:choose>
					<xsl:apply-templates/>
	</xsl:template>	
	
	<xsl:template match="figure">
		<div class="figure" align="center">
			<xsl:call-template name="copy-common-atts"/>
			<xsl:if test="image">
				<xsl:apply-templates select="image"/>
			</xsl:if>
			<xsl:if test="table">
				<xsl:apply-templates select="table"/>
			</xsl:if>
			<xsl:if test="caption">
				<div class="caption">
					<!--xsl:text>Figure&#xA0;</xsl:text>           <xsl:number count="figure" level="any" />           <xsl:text>:&#xA0;</xsl:text-->
					<xsl:value-of select="caption"/>
				</div>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- graphic: external illustration DEPRECATED FOR CM & TECHNIQUES -->
	<!-- reference external graphic file with alt text -->
	<xsl:template match="graphic">
	    <img src="{@source}">
			<xsl:if test="@alt">
				<xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@width">
				<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@height">
				<xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
			</xsl:if>
		</img>
	</xsl:template>
	<!-- head in div2 -->
	<xsl:template match="div2/head">
		<xsl:text> </xsl:text>
		<h3>
			<xsl:call-template name="anchor">
				<xsl:with-param name="conditional" select="0"/>
				<xsl:with-param name="node" select=".."/>
			</xsl:call-template>
			<xsl:apply-templates select=".." mode="divnum"/>
			<!--BBC Added a test to replace guideline headings with value from current source-->
			<xsl:choose>
				<xsl:when test="../@role='extsrc'">
				   Guideline 
				<xsl:number level="multiple" count="div1 | div2" format="1.1 "/>
					<xsl:value-of select="$wcag-src//div2[@id=current()/../@id]/head"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</h3>
	</xsl:template>
	<!-- image -->
	<xsl:template match="image">
		<img align="middle">
			<xsl:call-template name="copy-common-atts"/>
			<xsl:attribute name="src"><xsl:value-of select="img/@source"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="alt"/></xsl:attribute>
			<xsl:if test="img/@height">
				<xsl:attribute name="height"><xsl:value-of select="img/@height"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="img/@width">
				<xsl:attribute name="width"><xsl:value-of select="img/@width"/></xsl:attribute>
			</xsl:if>
		</img>
	</xsl:template>
	<!-- img: external illustration -->
	<!-- reference external graphic file with alt text -->
	<xsl:template match="img">
		<img src="{@source}">
			<xsl:call-template name="copy-common-atts"/>
			<xsl:if test="@width">
				<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="@height">
				<xsl:attribute name="height"><xsl:value-of select="@height"/></xsl:attribute>
			</xsl:if>
		</img>
	</xsl:template>
	<!--  include: pulls in content from another file -->
	<xsl:template match="include[@mode='technique']">
		<xsl:variable name="idref">
			<xsl:value-of select="@idref"/>
		</xsl:variable>
		<xsl:for-each select="document(@doc)//*[@id=$idref]">
			<xsl:apply-templates select="task"/>
			<xsl:apply-templates select="applicability"/>
			<xsl:apply-templates select="testable-statement"/>
			<xsl:apply-templates select="ua-applicability"/>
			<xsl:apply-templates select="ua-issues"/>
			<xsl:apply-templates select="description"/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="include[@mode='link']">
		<xsl:variable name="idref">
			<xsl:value-of select="@idref"/>
		</xsl:variable>
		<xsl:for-each select="document(@doc)//*[@id=$idref]">
			<xsl:apply-templates/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="resources">
		<!--<div class="resources">
			<xsl:call-template name="copy-common-atts"/>-->
				
			<xsl:call-template name="heading">
				<xsl:with-param name="level">
				<xsl:choose>
          <xsl:when test="$slices='1'">2</xsl:when>
				  <xsl:when test="$bytech='1'">3</xsl:when>
          <xsl:otherwise>4</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
				<xsl:with-param name="id"><xsl:value-of select="../@id"/>-resources</xsl:with-param>
				<xsl:with-param name="text">Resources</xsl:with-param>
			</xsl:call-template>
			<div class="textbody">
			<xsl:choose>
			<xsl:when test="child::node()">
			<p>Resources are for information purposes only, no endorsement implied.</p>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise><p>No resources available for this technique.</p></xsl:otherwise>
			</xsl:choose>
			</div>
		<!--</div>-->
	</xsl:template>
	
	
	<xsl:template match="related-techniques">
		<!--<div class="resources">
			<xsl:call-template name="copy-common-atts"/>-->
				
			<xsl:call-template name="heading">
				<xsl:with-param name="level">
				<xsl:choose>
          <xsl:when test="$slices='1'">2</xsl:when>
	<xsl:when test="$bytech='1'">3</xsl:when>
          <xsl:otherwise>4</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
				<xsl:with-param name="id"><xsl:value-of select="../@id"/>-related-techs</xsl:with-param>
				<xsl:with-param name="text">Related Techniques</xsl:with-param>
			</xsl:call-template>
		<div class="textbody">
			<xsl:choose>
			<xsl:when test="relatedtech">
			<ul>
				<xsl:apply-templates/>
			</ul>
			</xsl:when>
			<xsl:otherwise><p>(none currently listed)</p></xsl:otherwise>
			</xsl:choose>
			</div>
		<!--</div>-->
	</xsl:template>
	
	<xsl:template match="relatedtech">
	<xsl:variable name="id" select="@idref"/>
	<xsl:for-each select="$techs-src//technique[@id=current()/@idref]">
			<li>
				<a href="{$techsthisversion}{$id}">
					<xsl:value-of select="$id"></xsl:value-of>: <xsl:apply-templates select="short-name" mode="text"></xsl:apply-templates>
				</a>
			</li>
			</xsl:for-each>
	</xsl:template>

	<xsl:template match="tests">
		<!--<div class="resources">
			<xsl:call-template name="copy-common-atts"/>-->
				
			<xsl:call-template name="heading">
				<xsl:with-param name="level">
				<xsl:choose>
          <xsl:when test="$slices='1'">2</xsl:when>
	    <xsl:when test="$bytech='1'">3</xsl:when>
          <xsl:otherwise>4</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
				<xsl:with-param name="id"><xsl:value-of select="../@id"/>-tests</xsl:with-param>
				<xsl:with-param name="text">Tests</xsl:with-param>
			</xsl:call-template>
			<div class="textbody">
			  <xsl:choose>
			    <xsl:when test="child::node()">
			      <xsl:apply-templates/>
			    </xsl:when>
			    <xsl:otherwise><p>No tests available for this technique.</p></xsl:otherwise>
			  </xsl:choose>
			</div>
		<!--</div>-->
	</xsl:template>

	<!-- applicability condition: the true-false statement for the technique -->
	<xsl:template match="applicability">
		<div class="applicability">
			<xsl:call-template name="copy-common-atts"/>
				
			<xsl:call-template name="heading">
        <xsl:with-param name="level">
				<xsl:choose>
          <xsl:when test="$slices='1'">2</xsl:when>
	     <xsl:when test="$bytech='1'">3</xsl:when>
          <xsl:otherwise>4</xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
				<xsl:with-param name="id"><xsl:value-of select="../@id"/>-applicability</xsl:with-param>
				<xsl:with-param name="text">Applicability</xsl:with-param>
			</xsl:call-template>
			<div class="textbody">
				<xsl:apply-templates/>
			</div>
		</div>
	</xsl:template>
	<!-- see-also: an item in a resource list for a technique -->
	<xsl:template match="see-also">
	    <xsl:if test="head">
	    <xsl:choose>
	        <xsl:when test="$slices='1'"><h3 class="small-head" id="{../../@id}-sa{count(preceding-sibling::see-also)}"><xsl:value-of select="head"></xsl:value-of></h3></xsl:when>
	        <xsl:when test="$bytech='1'"><h4 class="small-head" id="{../../@id}-sa{count(preceding-sibling::see-also)}"><xsl:value-of select="head"></xsl:value-of></h4></xsl:when>
	        <xsl:otherwise><h5 class="small-head" id="{../../@id}-sa{count(preceding-sibling::see-also)}"><xsl:value-of select="head"></xsl:value-of></h5></xsl:otherwise>
	    </xsl:choose></xsl:if>
	    <xsl:apply-templates/>
	</xsl:template>
    
    <xsl:template match="see-also/head"></xsl:template>
   

	<xsl:template match="short-name">
	  <xsl:choose>
	    <xsl:when test="$bytech='1'">
	      <h2><a name="{../@id}" id="{../@id}"><xsl:text> </xsl:text></a>
	        <xsl:call-template name="copy-common-atts"/>
	        <xsl:value-of select="../@id"/><xsl:text>: </xsl:text><xsl:apply-templates/>
	      </h2>
	    </xsl:when>
	    <xsl:otherwise>
	      <h3><a name="{../@id}" id="{../@id}"><xsl:text> </xsl:text></a>
	        <xsl:call-template name="copy-common-atts"/>
	        <xsl:value-of select="../@id"/><xsl:text>: </xsl:text><xsl:apply-templates/>
	      </h3>
	    </xsl:otherwise>
	  </xsl:choose>
	  
	 
	</xsl:template>
	<!-- spec: the specification itself -->
	
	<!-- technique -->
	<xsl:template match="technique">
		<div class="technique">
			<hr class="divider" title="Beginning of new technique"/>
			<xsl:call-template name="copy-common-atts"/>
			<!-- xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute  			20031021 WAC per pubrules, id should be on heading, not div. thus  			the template for 'short-name' handles the id now-->
<xsl:apply-templates select="issue"/>			
			<xsl:apply-templates select="short-name"/>
			<xsl:apply-templates select="applicability"/>
			<xsl:apply-templates select="applies-to"/>
			<xsl:apply-templates select="ua-issues"/>
			<xsl:apply-templates select="description"/>
			<xsl:apply-templates select="examples"/>
			<xsl:apply-templates select="resources"/>
			<xsl:apply-templates select="related-techniques"/>
			<xsl:apply-templates select="tests"/>
			<xsl:if test="position() = last()"><hr class="divider" title="End of techniques"/></xsl:if>
		</div>
	</xsl:template>
	<!-- ua-applicability: applicability of a technique to user agents -->
	<xsl:template match="ua-applicability">
		<div class="applicability">
			<xsl:text>&#xa0;</xsl:text>
			<!-- hack to prevent <div/> for empty elements -->
			<xsl:if test="ie">
				<xsl:choose>
					<xsl:when test="ie/@version = 'Y'">IE(Win)&#xa0; </xsl:when>
					<xsl:when test="ie/@version = '-'">
						<span class="not-supported">IE(Win)&#xa0; </span>
					</xsl:when>
					<xsl:otherwise>IE(Win)<span class="ver">
							<xsl:value-of select="ie/@version"/>
						</span>
						<xsl:text>&#xa0; </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="nn">
				<xsl:choose>
					<xsl:when test="nn/@version = 'Y'">NNav&#xa0; </xsl:when>
					<xsl:when test="nn/@version = '-'">
						<span class="not-supported">NNav&#xa0; </span>
					</xsl:when>
					<xsl:otherwise>NNav<span class="ver">
							<xsl:value-of select="nn/@version"/>
						</span>
						<xsl:text>&#xa0; </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="op">
				<xsl:choose>
					<xsl:when test="op/@version = 'Y'">Opera&#xa0; </xsl:when>
					<xsl:when test="op/@version = '-'">
						<span title="Not supported" class="not-supported">Opera&#xa0; </span>
					</xsl:when>
					<xsl:otherwise>Opera<span class="ver">
							<xsl:value-of select="op/@version"/>
						</span>
						<xsl:text>&#xa0; </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</div>
	</xsl:template>
	<xsl:template match="ua-issues">
		<xsl:variable name="uanumber">ua<xsl:number level="multiple" count="div1 | technique | ua-issues" format="1.1.1"/>
		</xsl:variable>
		<div class="ua-issues">
			<xsl:call-template name="copy-common-atts"/>
			<xsl:choose>
    <xsl:when test="$slices= '1'"><h2 class="small-head" id="{$uanumber}"> User Agent and Assistive Technology Support Notes</h2></xsl:when>
    <xsl:when test="$bytech= '1'"><h3 class="small-head" id="{$uanumber}"> User Agent and Assistive Technology Support Notes</h3></xsl:when>
    <xsl:otherwise><h4 class="small-head" id="{$uanumber}"> User Agent and Assistive Technology Support Notes</h4></xsl:otherwise>
  </xsl:choose>
			
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="ua-issue">
		<div class="ua-issue">
			<xsl:call-template name="copy-common-atts"/>
			<xsl:apply-templates/>
			<!--BBC: commented out. May be useful someday, but not enough data yet. table>
				<tr>
					<td class="ua-type">
						<xsl:value-of select="@name"/>
						<xsl:value-of select="@version"/>
					</td>
					<td>
						
					</td>
				</tr>
			</table-->
		</div>
	</xsl:template>
	
	<xsl:template name="css">
	    <xsl:if test="$show.diff.markup != '0'">
	        <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css" href="diffs.css" />
	    </xsl:if>
	    <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css">
	        <xsl:attribute name="href"><xsl:text>http://www.w3.org/StyleSheets/TR/</xsl:text>
	            <xsl:choose>
	                <!-- Editor's review drafts are a special case. -->
	            	<xsl:when test="/spec/@role='editors-copy'">W3C-ED</xsl:when>
	            	<xsl:when test="$show.diff.markup != 0">W3C-ED</xsl:when>
	                <xsl:otherwise>
	                    <xsl:choose>
	                    	<xsl:when test="/spec/@w3c-doctype='review' or contains(/spec/header/w3c-doctype, 'Editor')">W3C-ED</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='wd'">W3C-WD</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='rec'">W3C-REC</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='pr'">W3C-PR</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='per'">W3C-PER</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='cr'">W3C-CR</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='note'">W3C-NOTE</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='wgnote'">W3C-WG-NOTE</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='memsub'">W3C-Member-SUBM</xsl:when>
	                        <xsl:when test="/spec/@w3c-doctype='teamsub'">W3C-Team-SUBM</xsl:when>
	                        <xsl:otherwise>base</xsl:otherwise>
	                    </xsl:choose>
	                </xsl:otherwise>
	            </xsl:choose>
	            <xsl:text>.css</xsl:text>
	        </xsl:attribute>
	    </link>
	    <link xmlns="http://www.w3.org/1999/xhtml" rel="stylesheet" type="text/css" href="additional.css" />
	    <xsl:if test="$bytech='1'">
	        <link rel="stylesheet" type="text/css" href="bytech.css"/>
	    </xsl:if>
	</xsl:template>
	<xsl:template match="eg-group/code">
	    <div class="code">
	        <p><strong>Example Code:</strong></p>
		        <pre><code>
				<xsl:apply-templates/>
		        </code></pre>
		    
		</div>
	</xsl:template>
	<xsl:template match="applies-to">
			<xsl:variable name="this-h4-id">
				<xsl:choose>
					<xsl:when test="../@id">
						<xsl:value-of select="../@id"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="generate-id(.)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:element name="p">
				<!--BBC changed id="referenced" to class to avoid duplicate ID problem w/ validation -->
				<xsl:attribute name="class">referenced</xsl:attribute>This <xsl:choose>
      <xsl:when test="ancestor::div1[@role='failures']">failure</xsl:when>
      <xsl:otherwise>technique</xsl:otherwise>
    </xsl:choose> relates to:</xsl:element>
			<ul>
				<xsl:apply-templates select="guideline" mode="relates"/>
				<xsl:apply-templates select="success-criterion" mode="screlates"/>
				<xsl:apply-templates select="conformance-criterion" mode="ccrelates"/>
							</ul>
	</xsl:template>
	<xsl:template match="guideline" mode="relates">
		<xsl:variable name="id" select="@idref"/>
		<li>
			<!-- 20031031 BBC: included some code to get the guideline numbers and links to them into the output-->
			<xsl:for-each select="$wcag-src//div3[@id=current()/@idref]">
				<xsl:variable name="filename"><xsl:apply-templates select="$guide-src//*[@id = $id]" mode="slice-understanding-filename"/></xsl:variable>
				<xsl:variable name="fragment"><xsl:if test="$id != substring-before($filename, '.')">#<xsl:value-of select="$id"/></xsl:if></xsl:variable>
			    <a href="{$guide-src//publoc/loc[@href]}{$filename}{fragment}">
					Understanding Guideline <xsl:number level="multiple" count="div2 | div3" format="1.1 "/> (<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="@id"/></xsl:call-template>)
				</a>
			</xsl:for-each>
		</li>
	</xsl:template>
	<xsl:template match="success-criterion" mode="screlates">
		<xsl:variable name="id" select="@idref"/>
		<xsl:variable name="filename"><xsl:apply-templates select="$guide-src//*[@id = $id]" mode="slice-understanding-filename"/></xsl:variable>
		<xsl:variable name="fragment"><xsl:if test="$id != substring-before($filename, '.')">#<xsl:value-of select="$id"/></xsl:if></xsl:variable>
		<li>
			<a href="{$gl-src//publoc/loc[@href]}#{$id}">
				Success Criterion<xsl:text> </xsl:text><xsl:call-template name="sc-number"><xsl:with-param name="id" select="$id"/></xsl:call-template> (<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="$id"/></xsl:call-template>)</a> 
			<ul>
				<li>
				    <a href="{$quickref-src//publoc/loc[@href]}#{$id}">
						How to Meet <xsl:call-template name="sc-number"><xsl:with-param name="id" select="$id"/></xsl:call-template> (<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="$id"/></xsl:call-template>)
					</a>
				</li>
				<li>
				    <a href="{$guide-src//publoc/loc[@href]}{$filename}{fragment}">
						Understanding Success Criterion <xsl:call-template name="sc-number"><xsl:with-param name="id" select="$id"/></xsl:call-template> (<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="$id"/></xsl:call-template>)
					</a>
				</li>
			</ul>
		</li>
	</xsl:template>
	<xsl:template match="conformance-criterion" mode="ccrelates">
	<xsl:choose>
  <xsl:when test="@idref='UNKNOWN'">
<li>@@ Error! This technique is not associated with any guidelines, Success Criterion or conformance requirement.</li>  
  </xsl:when>
  <xsl:otherwise>
  <xsl:variable name="id" select="@idref"/>
		<xsl:for-each select="$wcag-src//div3[@id=current()/@idref]">
			<li>
				<a href="{$gl-src//publoc/loc[@href]}#{$id}">
					Conformance Requirement<xsl:text> </xsl:text><xsl:call-template name="cc-number"/> (<xsl:call-template name="sc-handle"><xsl:with-param name="handleid" select="@id"/></xsl:call-template>)
				</a> 
			</li>
			<!--BBC Add a similar template below for htmrelates-->
		</xsl:for-each>
		</xsl:otherwise>
</xsl:choose>
		
	</xsl:template>
	<!-- This overrides the specref template in wcag2gl.xsl, which doesn't permit references to elements beyond the types it already knows about 
	<xsl:template match="specref">
		<xsl:variable name="target" select="key('ids', @ref)[1]"/>
		<xsl:apply-templates select="$target" mode="specref"/>
	</xsl:template>
	<xsl:template match="technique" mode="specref">
		<a>
			<xsl:attribute name="href"><xsl:call-template name="href.target"/></xsl:attribute>
			<em>
				<xsl:value-of select="short-name"/>
			</em>
		</a>
	</xsl:template>
		<xsl:template match="div1" mode="specref">
		<a>
			<xsl:attribute name="href"><xsl:call-template name="href.target"/></xsl:attribute>
			<em>
				<xsl:value-of select="head"/>
			</em>
		</a>
	</xsl:template>
	 This is a default template in case a more specific template doesn't exist 
	<xsl:template match="*" mode="specref">
		<xsl:variable name="target" select="key('ids', @ref)[1]"/>
		<xsl:message>
			<xsl:text>Unsupported specref to </xsl:text>
			<xsl:value-of select="local-name($target)"/>
			<xsl:text> [</xsl:text>
			<xsl:value-of select="@ref"/>
			<xsl:text>] </xsl:text>
			<xsl:text> (Contact stylesheet maintainer).</xsl:text>
		</xsl:message>
		<strong>
			<a>
				<xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="key('ids', @ref)"/></xsl:call-template></xsl:attribute>
				<xsl:text>???</xsl:text>
			</a>
		</strong>
	</xsl:template>-->
	<!-- audio-clip: audio example. alt becomes link text and content becomes transcript. -->
	<xsl:template match="audio-clip">
		<div class="audio">
			<p>
				<a href="{@source}">
					<xsl:value-of select="@alt"/>
				</a>
			</p>
			<p>Transcript:</p>
			<blockquote>
				<xsl:apply-templates/>
			</blockquote>
		</div>
	</xsl:template>
	<!-- mode: toc rewrote this section so that TOC would result in actual lists-->
	<xsl:template mode="toc" match="div1">
	<xsl:choose>
	  <xsl:when test="$bytech = '1'">
	    <xsl:for-each select="technique[not(@diff = 'del')]">
	      <li>
	        <a>
	          <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
	          <xsl:value-of select="@id"/>:<xsl:text> </xsl:text>
	          <xsl:apply-templates select="head | short-name" mode="text"/>
	        </a>
	      </li>
	    </xsl:for-each>
	    
	  </xsl:when>
	  <xsl:otherwise>
	    <li>
	      <a>
	        <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
	        <xsl:apply-templates select="." mode="divnum"/>
	        <xsl:text> </xsl:text>
	        <xsl:choose>
	          <xsl:when test="@role='extsrc'">
	            <xsl:value-of select="$wcag-src//div1[@id=current()/@id]/head"/>
	          </xsl:when>
	          <xsl:otherwise>
	            <xsl:apply-templates select="head" mode="text"/>
	          </xsl:otherwise>
	        </xsl:choose>
	      </a>
	      <xsl:if test="$toc.level &gt; 1">
	        <xsl:variable name="children1">
	          <xsl:value-of select="count(div2 | technique)"/>
	        </xsl:variable>
	        <xsl:choose>
	          <xsl:when test="$children1 = 0"/>
	          <xsl:otherwise>
	            <ul>
	              <xsl:for-each select="technique[not(@diff = 'del')]">
	                <li>
	                  <a>
	                    <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
	                    <xsl:value-of select="@id"/>:<xsl:text> </xsl:text>
	                    <xsl:apply-templates select="head | short-name" mode="text"/>
	                  </a>
	                </li>
	              </xsl:for-each>
	              <xsl:for-each select="div2">
	                <li>
	                  <a>
	                    <xsl:attribute name="href"><xsl:call-template name="href.target"><xsl:with-param name="target" select="."/></xsl:call-template></xsl:attribute>
	                    <xsl:apply-templates select="head" mode="text"/>
	                  </a>
	                </li>
	              </xsl:for-each>
	            </ul>
	          </xsl:otherwise>
	        </xsl:choose>
	      </xsl:if>
	    </li>
	  </xsl:otherwise>
	</xsl:choose>
	  
	  
	  
	</xsl:template>
	<!-- mode: divnum -->
	<xsl:template mode="divnum" match="div1">
		<xsl:number level="single" count="div1" format="1"/>.
		<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template mode="divnum" match="back/div1 | inform-div1">Appendix<xsl:text> </xsl:text><xsl:number count="div1 | inform-div1" format="A"/>:<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template mode="divnum" match="front/div1 | front//div2 | front//div3 | front//div4 | front//div5"/>
	<!-- BBC commented out b/c numbering is not needed at this level -->
	<xsl:template mode="divnum" match="technique">
		<!--xsl:number level="multiple" count="div1 | div2 | technique" format="1.1.1 "/-->
		<xsl:value-of select="@id"></xsl:value-of>:<xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template mode="divnum" match="div2">
		<!--<xsl:number level="multiple" count="div2" format="1"/>-->
	</xsl:template>
	<xsl:template mode="divnum" match="back//div2">
		<xsl:number level="multiple" count="div1 | div2 | inform-div1" format="A.1 "/>
	</xsl:template>
	<xsl:template mode="divnum" match="back//div3">
		<xsl:number level="multiple" count="div1 | div2 | div3 | inform-div1" format="A.1.1 "/>
	</xsl:template>
	<!-- BBC modified to do automatic header insertion and numbering for required and best practice SC headings-->
	<xsl:template mode="divnum" match="div3">
		<!--<xsl:number level="multiple" count="div1 | div2 | div3 | div4 " format="1.1.1.1 "/>-->
	</xsl:template>
	<xsl:template mode="divnum" match="back//div4">
		<xsl:number level="multiple" count="div1 | div2 | div3 | div4 | inform-div1" format="A.1.1.1 "/>
	</xsl:template>
	<xsl:template mode="divnum" match="div4">
		<xsl:choose>
			<xsl:when test="@role='defn'">
				<xsl:text> </xsl:text>for  			</xsl:when>
			<xsl:otherwise>
				<xsl:text> </xsl:text>of 			 			</xsl:otherwise>
		</xsl:choose>
		<xsl:text> </xsl:text>Guideline <xsl:number level="multiple" count="div1[@role='principle'] | div2" format="1.1"/>
	</xsl:template>
	<xsl:template mode="divnum" match="back//div5">
		<xsl:number level="multiple" count="div1 | div2 | div3 | div4 | div5 | inform-div1" format="A.1.1.1.1 "/>
	</xsl:template>
	
	<xsl:template name="heading">
		<xsl:param name="level"/>
		<xsl:param name="text"/>
		<xsl:param name="id"/>
		<xsl:variable name="heading-id">
			<xsl:choose>
				<xsl:when test="string-length($id) &gt; 0">
					<xsl:value-of select="$id"/>
				</xsl:when>
				<xsl:when test="@id">
					<xsl:value-of select="@id"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="generate-id(.)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:element name="h{$level}">
			<xsl:attribute name="id"><xsl:value-of select="$heading-id"/></xsl:attribute>
			<xsl:call-template name="copy-common-atts"/>
			<xsl:value-of select="$text"/>
		</xsl:element>
	</xsl:template>

<xsl:template match="body">
    <div class="body">
      <xsl:apply-templates/>
    </div>
</xsl:template>
    
    <xsl:template match="termref">
        <!--<xsl:variable name="glthisversion">
            <xsl:value-of select="$gl-src//publoc/loc[@href]"/>
        </xsl:variable>-->
        <a href="{$glthisversion}#{@def}" class="termref"  >
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
    
    <xsl:template match="blist">
        <dl xmlns="http://www.w3.org/1999/xhtml" class="slicerefs">
            <xsl:apply-templates/>
        </dl>
    </xsl:template>
</xsl:transform>
