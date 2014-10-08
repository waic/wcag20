<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2006 sp2 U (http://www.altova.com) by Ben Caldwell (W3C) -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:variable name="docs" select="/*/doc"/>
    <xsl:variable name="techsthisversion">http://www.w3.org/TR/2008/NOTE-WCAG20-TECHS-20081211/</xsl:variable>
  <xsl:template match="mergedocs">
    <xsl:apply-templates select="doc[1]"/>
  </xsl:template>
  <!--Match the first doc to create the top most element -->
  <xsl:template match="doc">
      <spec status="int-review" w3c-doctype="review" role="editors-copy">
      <header>
          <title>Techniques for WCAG 2.0 </title>
		<subtitle>Techniques and Failures for Web Content Accessibility Guidelines 2.0</subtitle>
        <w3c-designation>WD-WCAG20-TECHS</w3c-designation>
        <w3c-doctype>W3C Working Group Note</w3c-doctype>
      	<pubdate>
              <day></day>
              <month>January</month>
              <year>2010</year>
      	</pubdate>
    <publoc>
        <loc href="http://www.w3.org/WAI/GL/WCAG20/NOTE-WCAG20-TECHS-20090105/">http://www.w3.org/WAI/GL/WCAG20/NOTE-WCAG20-TECHS-20090105/</loc>
    </publoc>
    <altlocs>
    <loc href="complete.html">Single file version</loc>
        <!--loc href="complete-diff.html">Single file diff-marked version showing revisions since 03 November 2008</loc-->
        <loc href="/WAI/WCAG20/versions/techniques/">Alternate Versions of Techniques for WCAG 2.0</loc>
    </altlocs>
        <latestloc>
            <loc href="http://www.w3.org/TR/WCAG20-TECHS/">http://www.w3.org/TR/WCAG20-TECHS/</loc>
        </latestloc>
        <prevlocs>
            <loc href="http://www.w3.org/TR/2008/NOTE-WCAG20-TECHS-20081211/">http://www.w3.org/TR/2008/NOTE-WCAG20-TECHS-20081211/</loc>
        </prevlocs>
        <authlist>
          <author role="current">
            <name>Ben Caldwell</name>
            <affiliation>Trace R&amp;D Center, University of
Wisconsin-Madison</affiliation>
          </author>
          <author role="current">
            <name>Michael Cooper</name>
            <affiliation>W3C</affiliation>
          </author>
          <author role="current">
            <name>Loretta Guarino Reid</name>
            <affiliation>Google, Inc.</affiliation>
          </author>
          <author role="current">
            <name>Gregg Vanderheiden</name>
            <affiliation>Trace R&amp;D Center, University of
Wisconsin-Madison</affiliation>
          </author>
          <author role="past">
            <name>Wendy Chisholm</name>
            <affiliation>(until July 2006 while at W3C)</affiliation>
          </author>
          <author role="past">
            <name>John Slatin</name>
            <affiliation>(until June 2006 while at Accessibility Institute, University of Texas at
Austin)</affiliation>
          </author>
        </authlist>
        <status>
        	<p><emph>This section describes the status of this document at the time of its
        		publication. Other documents may supersede this document. A list of current
        		W3C publications and the latest revision of this technical report can be
        		found in the <loc href="http://www.w3.org/TR/">W3C technical reports index</loc> at <loc href="http://www.w3.org/TR/">http://www.w3.org/TR/</loc>.</emph></p>
        	<p>This is a Working Group Note &quot;Techniques for WCAG 2.0&quot;. These
        		techniques are produced by the <loc href="http://www.w3.org/WAI/GL/">Web
        			Content Accessibility Guidelines Working Group</loc> to provide guidance about
        		how to conform to the <loc
        			href="http://www.w3.org/TR/2008/REC-WCAG20-20081211/">Web Content
        			Accessibility Guidelines (WCAG) 2.0  Recommendation</loc>.
        		Techniques are referenced from <loc
        			href="http://www.w3.org/TR/2008/NOTE-UNDERSTANDING-WCAG20-20081211/">Understanding
        			WCAG 2.0</loc> and <loc
        				href="http://www.w3.org/WAI/WCAG20/quickref/20081211/">How to Meet WCAG
        				2.0</loc>. Please note that the contents of this document are informative (they
        		provide guidance), and not normative (they do not set requirements for
        		conforming to WCAG 2.0).</p>
        	<p>The Working Group requests that any comments be made using the provided <loc
        		href="http://www.w3.org/WAI/WCAG20/comments/">online comment
        		form</loc>. If this is not possible, comments can also be sent to <loc
        			href="mailto:public-comments-wcag20@w3.org">public-comments-wcag20@w3.org</loc>.
        		The <loc
        			href="http://lists.w3.org/Archives/Public/public-comments-wcag20/">archives
        			for the public comments list</loc> are publicly available. Comments received on this document may be addressed in future versions of this document, or in another manner. The Working Group does not plan to make formal responses to comments. Archives of the <loc
        				href="http://lists.w3.org/Archives/Public/w3c-wai-gl/">WCAG WG mailing list
        				discussions</loc> are  publicly available, and future work undertaken by the Working Group may address comments received on this document.</p>
        	<p>Materials from the public to assist in documenting 
        		techniques are particularly welcomed. Please use the <loc
        			href="http://www.w3.org/WAI/WCAG1-Conformance">Techniques Submission
        			Form</loc> to submit techniques. </p>
        	<p>This document has been produced as part of the W3C <loc
        		href="http://www.w3.org/WAI/">Web Accessibility Initiative</loc> (WAI). The
        		goals of the WCAG Working Group are discussed in the <loc
        			href="http://www.w3.org/WAI/GL/new-charter-2000.html">WCAG Working Group
        			charter</loc>. The WCAG Working Group is part of the <loc
        				href="http://www.w3.org/WAI/Technical/Activity">WAI Technical
        				Activity</loc>.</p>
        	<p> Publication as a Working Group Note does not imply endorsement by the            W3C Membership.  This is a draft document and may be updated, replaced            or obsoleted by other documents at any time. It is inappropriate to cite            this document as other than work in progress. </p>
        	<p>This document was produced by a group operating under the <loc
        		href="http://www.w3.org/Consortium/Patent-Policy-20040205/">5 February 2004
        		W3C Patent Policy</loc>. W3C maintains a <loc
        			role="disclosures" href="http://www.w3.org/2004/01/pp-impl/35422/status">public
        			list of any patent disclosures</loc> made in connection with the deliverables
        		of the group; that page also includes instructions for disclosing a patent.
        		An individual who has actual knowledge of a patent which the individual
        		believes contains <loc
        			href="http://www.w3.org/Consortium/Patent-Policy-20040205/#def-essential">Essential
        			Claim(s)</loc> must disclose the information in accordance with <loc
        				href="http://www.w3.org/Consortium/Patent-Policy-20040205/#sec-Disclosure">section
        				6 of the W3C Patent Policy</loc>. </p>
        </status>
        <abstract>
        	<p>&quot;Techniques for WCAG 2.0&quot;  provides information to Web content developers who wish to  satisfy the success criteria of <loc href="http://www.w3.org/TR/WCAG20/">Web Content Accessibility Guidelines (WCAG) 2.0</loc> <bibref ref="WCAG20"/>. Techniques are specific authoring practices that may be used in support of the WCAG 2.0 success criteria. This document provides &quot;General Techniques&quot; that describe basic practices that are applicable to any technology, and technology-specific techniques that provide information applicable to specific technologies. The World Wide Web Consortium  only documents techniques for non-proprietary technologies; the WCAG Working Group hopes vendors of other technologies will provide similar techniques to describe how to conform to WCAG 2.0 using those technologies. Use of the techniques provided in this document makes it easier for Web  content to demonstrate conformance to WCAG 2.0 success criteria than if  these techniques are not used.</p>
<p>Besides the techniques provided in this document, there may be other techniques that  can be used to  implement conformance to WCAG 2.0. The WCAG WG encourages submission of such techniques so they can be considered for  inclusion in this document, in order to make the set of techniques maintained by the  WCAG WG as comprehensive as possible.  Please submit techniques for  consideration using the &quot;<loc href="http://www.w3.org/WAI/GL/WCAG20/TECHS-SUBMIT/">Techniques Submission Form</loc>.&quot;</p>
        	<p>This document is part of a series of documents published by the W3C Web  Accessibility Initiative (WAI) to support WCAG 2.0. This document was published as a Working Group Note at the same time WCAG 2.0 was published as a W3C Recommendation. Unlike WCAG 2.0, is expected that the information in Understanding WCAG 2.0 will be updated from time to time. See <loc href="http://www.w3.org/WAI/intro/wcag.php">Web Content Accessibility Guidelines (WCAG) Overview</loc> for an introduction to WCAG, supporting technical documents, and educational material.</p> 
        </abstract>
        <langusage>
          <language id="en-US"/>
        </langusage>
<revisiondesc>
  <p>
    <loc href="/WAI/GL/WCAG20/change-history.html">History of Changes to WCAG 2.0 Working Drafts</loc>
  </p>
</revisiondesc>
      </header>
      <front>
  <div1 id="intro">
      <head>Introduction to Techniques for WCAG 2.0</head>
      <div2 id="suff-adv-techs" role="normal">
      <p>This document is part of a series of documents published by the W3C Web Accessibility Initiative (WAI) to support WCAG 2.0 <bibref ref="WCAG20"></bibref>. It includes a variety of techniques which include specific authoring practices and examples for developing more accessible Web content. As well, it lists failures, which describe common mistakes that are considered failures of WCAG 2.0 Success Criteria.</p>
          <p>This is not an introductory document. It is a detailed technical description of techniques that can be used to address the requirements in WCAG 2.0. See <loc href="http://www.w3.org/WAI/intro/wcag.php">Web Content Accessibility Guidelines (WCAG) Overview</loc> for an introduction to WCAG, supporting  technical documents, and educational material.</p>
      <p>In order to make the set of techniques maintained by the WCAG WG as comprehensive as possible, the WCAG WG encourages submission of new techniques so they can be considered for inclusion in this document. Please submit techniques for consideration using the "<loc href="/WAI/GL/WCAG20/TECHS-SUBMIT/">Techniques Submission Form</loc>."</p>
      
  <head>Sufficient and Advisory Techniques</head>
  <p>Rather than having technology specific techniques in WCAG 2.0, the guidelines and success criteria themselves have been written in a technology neutral fashion. In order to provide guidance and examples for meeting the guidelines using specific technologies (for example HTML) the working group has identified <emph role="bolditalic">sufficient techniques</emph> for each Success Criterion that are sufficient to meet that Success Criterion. The list of sufficient techniques is maintained in the "Understanding WCAG 2.0" (and mirrored in How to Meet WCAG 2.0). In this way it is possible to update the list as new techniques are discovered, and as Web Technologies and Assistive Technologies progress.</p>
  <p>Note that all techniques are <loc href="informativedef" linktype="glossary">informative</loc>. The "sufficient techniques" are
considered sufficient by the WCAG Working Group to meet the success criteria. However, it is not necessary to use these particular techniques. If techniques are used other than those listed by the Working Group, then some other method for establishing the technique's ability to meet the success criteria would be needed</p>
  <p>Most success criteria have multiple sufficient techniques listed. Any of the listed sufficient techniques can be used to meet the Success Criterion. There may be other techniques which are not documented by the working group that could also meet the Success Criterion. As new sufficient techniques are identified they will be added to the listing.</p>
  <p>In addition to the sufficient techniques, there are a number of <emph role="bolditalic">advisory techniques</emph> that can enhance accessibility, but did not qualify as sufficient techniques because are not sufficient to meet the full requirements of the success criteria, they are not testable, and/or are good and effective techniques in some circumstances but not effective or helpful in others. These are listed as advisory techniques and are right below the sufficient techniques. Authors are encouraged to use these techniques wherever appropriate to increase accessibility of their Web pages.</p>

</div2>
<div2 id="intro-tech-types" role="normal">
  <head>Technique Collections</head>
  <p>The following list includes links to a series of techniques document collections. </p>
  <ul>
      <li><a href="{$techsthisversion}complete.html">Techniques for WCAG 2.0 (includes all techniques and failures as a single file)</a></li>
     <xsl:for-each select="$docs[position() > 0]">
         <li><p><a href="{$techsthisversion}{document(@path)//body/div1/@id}.html"><xsl:value-of select="document(@path)//body/div1/head"/></a></p></li>
  </xsl:for-each>  </ul>
  </div2>
  </div1>
</front>
      <body><xsl:variable name="path" select="@path"/>
        <xsl:for-each select="document($path)">
          <xsl:copy>
            <!-- Merge children of doc 1 -->
            <xsl:copy-of select="//body/div1"/>
            <!--Loop over remaining docs to merge their children -->
            <xsl:for-each select="$docs[position() > 1]">
              <xsl:copy-of select="document(@path)//body/div1"/>
            </xsl:for-each>
          </xsl:copy>
        </xsl:for-each>
      </body>
      <back>
        <!-- BBC - This is the master list. Some of these refs also appear in the Understanding Doc. -->
        <inform-div1 id="references">
          <head>References</head>
          <blist>
            <bibl id="CSS1" key="CSS1">"Cascading Style Sheets, level 1," B. Bos, H. Wium Lie, eds., W3C Recommendation 17 Dec 1996, revised 11 Jan 1999. Available at <loc href="http://www.w3.org/TR/REC-CSS1/">http://www.w3.org/TR/REC-CSS1/</loc>.</bibl>
          	<bibl id="CSS2" key="CSS2">"Cascading Style Sheets, level 2," B. Bos, H. Wium Lie, C. Lilley, and I. Jacobs, eds., W3C Recommendation 12 May 1998. Available at <loc href="http://www.w3.org/TR/CSS2/">http://www.w3.org/TR/CSS2/</loc>.</bibl>
            <bibl id="CSS21" key="CSS21">"Cascading Style Sheets, level 2 revision 1,"  B. Bos, T. Çelik,  I. Hickson,   H. Wium Lie, eds., W3C Candidate Recommendation 25 February 2004.  Available at:  <loc href="http://www.w3.org/TR/CSS21/">http://www.w3.org/TR/CSS21/</loc>
            </bibl>
            <bibl id="CSS3" key="CSS3">
              <titleref href="http://www.w3.org/Style/CSS/current-work">[CSS 2.1 and CSS 3] Roadmap</titleref>, CSS WG's table of modules and publication dates.</bibl>
            <bibl id="HTML4" key="HTML4">"HTML 4.01 Specification," D. Raggett, A. Le Hors, I. Jacobs, eds.,  W3C Recommendation 24 December 1999. Available at <loc href="http://www.w3.org/TR/html401/">http://www.w3.org/TR/html401/</loc>
            </bibl>
              <bibl id="WCAG20" key="WCAG20">"Web Content Accessibility Guidelines 2.0,"  B. Caldwell, M Cooper, L Guarino Reid, and G. Vanderheiden, eds., W3 Recommendation 12 December 2008, <loc href="http://www.w3.org/TR/2008/REC-WCAG20-20081211/">http://www.w3.org/TR/2008/REC-WCAG20-20081211</loc>.  The latest version of WCAG 2.0 is available at <loc href="http://www.w3.org/TR/WCAG20/">http://www.w3.org/TR/WCAG20/</loc>.
              </bibl>
            <bibl id="XHTML1" key="XHTML1">"XHTML 1.0 The Extensible HyperText Markup Language (Second Edition)," S. Pemberton, et al.,  W3C Recommendation 26 January 2000, revised 1 August 2002. Available at:  <loc href="http://www.w3.org/TR/xhtml1/">http://www.w3.org/TR/xhtml1/</loc>.</bibl>
          </blist>
        </inform-div1>
      </back>
    </spec>
  </xsl:template>
</xsl:stylesheet>
