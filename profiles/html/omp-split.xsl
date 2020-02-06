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
    
</xsl:stylesheet>