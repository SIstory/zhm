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
    
    <xsl:param name="outputDir">omp-split/</xsl:param>
    
    <xsl:param name="topNavigation">false</xsl:param>
    <xsl:param name="sideNavigation">false</xsl:param>
    
    <xsl:param name="splitLevel">0</xsl:param>
    
    <xsl:param name="cssFile">stylesheet.css</xsl:param>
    <xsl:param name="cssSecondaryFile"/>
    <xsl:template name="cssHook"/>
    
    <xsl:template name="javascriptHook"/>
    <xsl:template name="bodyJavascriptHook">
        <xsl:param name="thisLanguage"/>
    </xsl:template>
    <xsl:template name="bodyEndHook"/>
    
    <xsl:template match="tei:divGen[@xml:id = ('titleType','search')]">
        <!-- ne procesiram -->
    </xsl:template>
    
    <xsl:template match="tei:div[@xml:id='epigraph']">
        <!-- ne procesiram -->
    </xsl:template>
    
    <!-- moram odstraniti povezave iz bibl/ref, saj v ločenih poglavjih znotraj OMP ne bodo delale -->
    <xsl:template match="tei:ref[parent::tei:bibl]">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- zunanje povezave se odpirajo v novem oknu: target="_blank" -->
    <xsl:template name="makeExternalLink">
        <xsl:param name="ptr" as="xs:boolean"  select="false()"/>
        <xsl:param name="dest"/>
        <xsl:param name="title"/>
        <xsl:param name="class">link_<xsl:value-of select="local-name(.)"/>
        </xsl:param>
        <xsl:element name="{$linkElement}" namespace="{$linkElementNamespace}">
            <!-- dodam atribut target _blank -->
            <xsl:attribute name="target">_blank</xsl:attribute>
            <xsl:if test="(self::tei:ptr or self::tei:ref) and @xml:id">
                <xsl:attribute name="id" select="@xml:id"/>
            </xsl:if>
            <xsl:if test="$title">
                <xsl:attribute name="title" select="$title"/>
            </xsl:if>
            <xsl:call-template name="makeRendition">
                <xsl:with-param name="default" select="$class"/>
            </xsl:call-template>
            <xsl:if test="@type and not($outputTarget=('epub3', 'html', 'html5'))">
                <xsl:attribute name="type">
                    <xsl:value-of select="@type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="{$linkAttribute}" namespace="{$linkAttributeNamespace}">
                <xsl:sequence select="$dest"/>
                <xsl:if test="contains(@from,'id (')">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="substring(@from,5,string-length(normalize-space(@from))-1)"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="@n">
                    <xsl:attribute name="title"  namespace="{$linkAttributeNamespace}">
                        <xsl:value-of select="@n"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="xrefHook"/>
            <xsl:choose>
                <xsl:when test="$dest=''">??</xsl:when>
                <xsl:when test="$ptr">
                    <xsl:element name="{$urlMarkup}" namespace="{$linkElementNamespace}">
                        <xsl:choose>
                            <xsl:when test="starts-with($dest,'mailto:')">
                                <xsl:value-of select="substring-after($dest,'mailto:')"/>
                            </xsl:when>
                            <xsl:when test="starts-with($dest,'file:')">
                                <xsl:value-of select="substring-after($dest,'file:')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$dest"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    
</xsl:stylesheet>