<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="tei html teidocx xs"
    version="2.0">
    
    <xsl:import href="to.xsl"/>
    
    <xsl:param name="outputDir">omp/</xsl:param>
    
    <xsl:param name="topNavigation">false</xsl:param>
    <xsl:param name="sideNavigation">false</xsl:param>
    
    <xsl:param name="splitLevel">-1</xsl:param>
    
    <xsl:param name="cssFile">stylesheet.css</xsl:param>
    <xsl:param name="cssSecondaryFile"/>
    <xsl:template name="cssHook"/>
    
    <xsl:template name="javascriptHook"/>
    <xsl:template name="bodyJavascriptHook">
        <xsl:param name="thisLanguage"/>
    </xsl:template>
    <xsl:template name="bodyEndHook"/>
    
    <xsl:template match="tei:divGen[@xml:id = ('teiHeader','titleType','search')]">
        <!-- ne procesiram -->
    </xsl:template>
    
    <!-- dodam procesiranje TOC takoj za front/titlePage -->
    <xsl:template match="tei:titlePage">
        <!-- avtor -->
        <p  class="naslovnicaAvtor">
            <xsl:for-each select="tei:docAuthor">
                <xsl:choose>
                    <xsl:when test="tei:forename or tei:surname">
                        <xsl:for-each select="tei:forename">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() ne last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                        <xsl:if test="tei:surname">
                            <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:for-each select="tei:surname">
                            <xsl:value-of select="."/>
                            <xsl:if test="position() ne last()">
                                <xsl:text> </xsl:text>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="position() ne last()">
                    <br/>
                </xsl:if>
            </xsl:for-each>
        </p>
        <!-- naslov -->
        <xsl:for-each select="tei:docTitle/tei:titlePart[1]">
            <h1 class="text-center"><xsl:value-of select="."/></h1>
            <xsl:for-each select="following-sibling::tei:titlePart">
                <h1 class="subheader podnaslov"><xsl:value-of select="."/></h1>
            </xsl:for-each>
        </xsl:for-each>
        <br/>
        <xsl:if test="tei:figure">
            <div class="text-center">
                <p>
                    <img src="{tei:figure/tei:graphic/@url}" alt="naslovna slika"/>
                </p>
            </div>
        </xsl:if>
        <xsl:if test="tei:graphic">
            <div class="text-center">
                <p>
                    <img src="{tei:graphic/@url}" alt="naslovna slika"/>
                </p>
            </div>
        </xsl:if>
        <br/>
        <p class="text-center">
            <!-- založnik -->
            <xsl:for-each select="tei:docImprint/tei:publisher">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <!-- kraj izdaje -->
            <xsl:for-each select="tei:docImprint/tei:pubPlace">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
            <!-- leto izdaje -->
            <xsl:for-each select="tei:docImprint/tei:docDate">
                <xsl:value-of select="."/>
                <br/>
            </xsl:for-each>
        </p>
        <!-- dodam TOC -->
        <h2>
            <xsl:sequence select="tei:i18n('tocWords')"/>
        </h2>
        <xsl:call-template name="mainTOC"/>
        
    </xsl:template>
    
</xsl:stylesheet>