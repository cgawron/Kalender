<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ccal="http://thunder.cwru.edu/ccal/"
                version="1.0">

  <xsl:variable name="chineseNumbers">一二三四五六七八九十</xsl:variable>
  <xsl:variable name="arabicNumbers">〓〓〓〓〓〓〓〓〓〓</xsl:variable>
  <xsl:variable name="normalNumbers">1234567890</xsl:variable>

  <xsl:output method="xml" indent="yes"/>

  <!-- Titelseite -->
  <xsl:template name="titel">
    <xsl:param name="year"/>
    <fo:block width="100%" break-before="page">
      <fo:block 
        display-align="before" text-align="center" space-after="12mm" font-size="0pt" line-stacking-strategy="max-height">
        <fo:external-graphic content-height="303mm" content-width="216mm">
          <xsl:attribute name="src">url('titel.svg')</xsl:attribute>
        </fo:external-graphic>
      </fo:block>
    </fo:block>
  </xsl:template>

  <xsl:template match="/">
    <fo:root> 
      <fo:layout-master-set>
      
        <fo:simple-page-master master-name="simple"
          page-height="303mm" 
          page-width="216mm"
          margin-top="0mm" 
          margin-bottom="0mm" 
          margin-left="0mm" 
          margin-right="0mm">
          <fo:region-body margin-top="0cm" />
          <fo:region-before extent="0cm" />
          <fo:region-after extent="0cm" />
        </fo:simple-page-master>
        
      </fo:layout-master-set>

      <fo:declarations>
        <x:xmpmeta xmlns:x="adobe:ns:meta/">
          <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
            <rdf:Description rdf:about=""
              xmlns:dc="http://purl.org/dc/elements/1.1/">
              <dc:title>Kalender 2015</dc:title>
              <dc:creator>Christian Gawron</dc:creator>
            </rdf:Description>    
          </rdf:RDF>
        </x:xmpmeta>
      </fo:declarations>

      <fo:page-sequence master-reference="simple" >
        <fo:flow flow-name="xsl-region-body">
          <xsl:apply-templates/>
        </fo:flow>
      </fo:page-sequence>

    </fo:root>
  </xsl:template>


  <xsl:template match="kalender">
    <xsl:call-template name="titel">
      <xsl:with-param name="year" select="@year"/>
    </xsl:call-template>

    <xsl:for-each select="month">
      <xsl:call-template name="month"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="month">
    <fo:block font-family="Futura" break-before="page">
      <fo:block-container
        display-align="center" text-align="center" height="213mm" width="216mm" space-after.optimum="11mm" font-size="0pt" 
        line-stacking-strategy="max-height">
        <fo:block>
          <fo:external-graphic content-width="216mm" content-height="213mm">
            <xsl:attribute name="src">url('<xsl:value-of select="photo/@src"/>')</xsl:attribute>
          </fo:external-graphic>
        </fo:block>
        <fo:block margin-right="8mm" margin-top="1mm" font-family="Futura" font-size="8pt" text-align="right">
          <xsl:value-of select="photo/@description"/> - <xsl:value-of select="photo/@author"/>
        </fo:block>
      </fo:block-container>

        
      <fo:block font-size="28pt" text-align="center" 
        space-after.optimum="7mm" font-family="Futura">
        <fo:inline>
          <xsl:call-template name="monthName">
            <xsl:with-param name="month" select="position()"/>
            <xsl:with-param name="lang" select="'german'"/>
          </xsl:call-template>
        </fo:inline>
      </fo:block>
      
      <fo:block text-align="center">

        <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="proportional-column-width(1)"/>
          <fo:table-column column-width="proportional-column-width(8)"/>
          <fo:table-column column-width="proportional-column-width(1)"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell column-number="2">
                <fo:table table-layout="fixed" width="100%" text-align="center">
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <fo:table-column column-width="proportional-column-width(1)"/>
                  <xsl:call-template name="header"/>
                    
                  
                  <fo:table-body>
                    <xsl:call-template name="printHeader">
                      <xsl:with-param name="count" select="@first"/>
                    </xsl:call-template>
                    <xsl:call-template name="printDays">
                      <xsl:with-param name="month" select="position()"/>
                      <xsl:with-param name="count" select="@days"/>
                      <xsl:with-param name="offset" select="@first"/>
                      <xsl:with-param name="lang" select="@lang"/>
                    </xsl:call-template>
                  </fo:table-body>
                </fo:table>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block>

    </fo:block>
  </xsl:template>

  <xsl:template name="monthName">
    <xsl:param name="month"/>
    <xsl:param name="lang"/>
    <xsl:value-of select="document('month.xml')/months/month[position()=$month]/name[@lang=$lang]"/>
  </xsl:template>

  <xsl:template name="header">
    <!-- Chinesische Namen der Wochentage: 一二三四五六日 
         für andere Sprachen unten entsprechend anpassen
    -->
    <fo:table-header
      font-family="Futura"
      font-size="20pt"
      space-after.optimum="2mm">
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block>Mo</fo:block>
      </fo:table-cell>
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block>Di</fo:block>
      </fo:table-cell>
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block>Mi</fo:block>
      </fo:table-cell>
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block>Do</fo:block>
      </fo:table-cell>
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block>Fr</fo:block>
      </fo:table-cell>
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block>Sa</fo:block>
      </fo:table-cell>
      <fo:table-cell padding="1mm" border-bottom-color="black" border-bottom-style="solid" border-bottom-width="1pt" space-after.optimum="2mm">
        <fo:block color="red">So</fo:block>
      </fo:table-cell>
    </fo:table-header>
    
  </xsl:template>

  <xsl:template name="printNumber">
    <xsl:param name="value" select="-1"/>
    <xsl:param name="lang"/>
    
    <xsl:choose>
      <xsl:when test="$lang='arabic'">
        <fo:inline font-family="Arabic">
          <xsl:if test="$value &gt; 9">
            <xsl:value-of select="substring($arabicNumbers, floor($value div 10)+1, 1)"/>
          </xsl:if>
          <xsl:value-of select="substring($arabicNumbers, floor($value mod 10) + 1, 1)"/>
        </fo:inline>
      </xsl:when>

      <xsl:when test="$lang='chinese'">
        <fo:inline font-family="WT071">
          <xsl:choose>
            <xsl:when test="$value &gt; 19">
              <xsl:value-of select="substring($chineseNumbers, floor($value div 10), 1)"/>
              <xsl:value-of select="substring($chineseNumbers, 10, 1)"/>
            </xsl:when>
            <xsl:when test="$value &gt; 9">
              <xsl:value-of select="substring($chineseNumbers, 10, 1)"/>
            </xsl:when>
          </xsl:choose>
          <xsl:value-of select="substring($chineseNumbers, ($value mod 10), 1)"/>
        </fo:inline>
      </xsl:when>

      <xsl:otherwise>
        <xsl:number value="$value"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="printDay">
    <xsl:param name="day" select="-1"/>
    <xsl:param name="month" />
    <xsl:param name="weekDay" />
    <xsl:param name="lang" />
    
    <xsl:if test="$day &gt; 0">
      <fo:table-cell padding-top="1.5mm" padding-left="2mm">
        <xsl:if test="($weekDay mod 7) = 0">
          <xsl:attribute name="color">red</xsl:attribute>
        </xsl:if>
        <xsl:if test="($weekDay mod 7) = 0">
          <xsl:attribute name="ends-row">true</xsl:attribute>
        </xsl:if>

        <xsl:if test="//month[position()=$month]/holiday[@day=$day]">
          <xsl:attribute name="color">red</xsl:attribute>
        </xsl:if>
        <fo:block width="4cm" text-align="center">
          <xsl:value-of select="$day"/>
        </fo:block>
      </fo:table-cell>
    </xsl:if>
    <!-- <xsl:text> - </xsl:text> -->
  </xsl:template>

  <xsl:template name="printHeader">
    <xsl:param name="count"/>
    <xsl:choose>
      <xsl:when test="$count>0">
        <fo:table-cell>
          <fo:block/>
        </fo:table-cell>
        <xsl:call-template name="printHeader">
          <xsl:with-param name="count" select="number($count) - 1"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="printDays">
    <xsl:param name="lang"/>
    <xsl:param name="month"/>
    <xsl:param name="count"/>
    <xsl:param name="offset"/>
    <xsl:param name="current" select="1"/>
    <xsl:choose>
      <xsl:when test="number($current) &lt; number($count) +1">
        <xsl:call-template name="printDay">
          <xsl:with-param name="day" select="$current"/>
          <xsl:with-param name="month" select="$month"/>
          <xsl:with-param name="weekDay" select="number($current) + number($offset)"/>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>

        <xsl:call-template name="printDays">
          <xsl:with-param name="count" select="$count"/>
          <xsl:with-param name="month" select="$month"/>
          <xsl:with-param name="offset" select="$offset"/>
          <xsl:with-param name="current" select="number($current) + 1"/>
          <xsl:with-param name="lang" select="$lang"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
