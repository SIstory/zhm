<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- Dodamo xml:id vsem prvim child elementom v div. Potrebno zaradi iskalnika. -->
    <!-- Če ima TEI element atribut xml:id, ga upoštevam pri kreiranju -->
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="*[ancestor::tei:text][parent::tei:div][self::tei:div][not(@xml:id)]">
        <xsl:variable name="position">
            <xsl:number level="any"/>
        </xsl:variable>
        <xsl:variable name="TEIid" select="ancestor::tei:TEI/@xml:id"/>
        <xsl:element name="{name(.)}">
            <xsl:apply-templates select="@*"/>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length($TEIid) gt 0">
                        <xsl:value-of select="concat($TEIid,'-',node-name(.),'-',$position)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(node-name(.),'-',$position)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
</xsl:stylesheet>