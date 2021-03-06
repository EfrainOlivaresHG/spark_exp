<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format decimal-separator="." grouping-separator=","/>
    <xsl:key name="files" match="file" use="@name"/>
    <xsl:template match="checkstyle">
        <html>
            <head>
                <title>CheckStyle Report</title>
                <style type="text/css">
                    body {
                    margin-left: 10;
                    margin-right: 10;
                    font:normal 80% arial,helvetica,sanserif;
                    background-color:#FFFFFF;
                    color:#000000;
                    }
                    .a td {
                    background: #efefef;
                    }
                    .b td {
                    background: #fbfbfb;
                    }
                    .error td {
                    background: #ff7f7f;
                    }
                    .warning td {
                    background: #fff000;
                    }
                    .info td {
                    background: #ccffff
                    }
                    th, td {
                    text-align: left;
                    vertical-align: top;
                    }
                    th {
                    font-weight:bold;
                    background: #ccc;
                    color: black;
                    }
                    table, th, td {
                    font-size:100%;
                    border: none
                    }
                    h2 {
                    font-weight:bold;
                    font-size:140%;
                    margin-bottom: 5;
                    }
                    h3 {
                    font-size:100%;
                    font-weight:bold;
                    background: #525D76;
                    color: white;
                    text-decoration: none;
                    padding: 5px;
                    margin-right: 2px;
                    margin-left: 2px;
                    margin-bottom: 0;
                    }
                </style>
            </head>
            <body>
                <a name="top"/>
                <h1>CheckStyle Report</h1>
                <hr size="1"/>

                <!-- Summary part -->
                <xsl:apply-templates select="." mode="summary"/>
                <hr size="1" width="100%" align="left"/>

                <!-- Package List part -->
                <xsl:apply-templates select="." mode="filelist"/>
                <hr size="1" width="100%" align="left"/>

                <!-- For each package create its part -->
                <xsl:apply-templates select="file[@name and generate-id(.) = generate-id(key('files', @name))]"/>

                <hr size="1" width="100%" align="left"/>

            </body>
        </html>
    </xsl:template>
    <xsl:template match="checkstyle" mode="summary">
        <h3>Summary</h3>
        <xsl:variable name="fileCount"
                      select="count(file[@name and generate-id(.) = generate-id(key('files', @name))])"/>
        <xsl:variable name="errorCount" select="count(file/error[@severity='error'])"/>
        <xsl:variable name="warningCount" select="count(file/error[@severity='warning'])"/>
        <xsl:variable name="infoCount" select="count(file/error[@severity='info'])"/>
        <table class="log" border="0" cellpadding="5" cellspacing="2" width="100%">
            <colgroup>
                <col style="width:25%"/>
                <col style="width:25%"/>
                <col style="width:25%"/>
                <col style="width:25%"/>
            </colgroup>
            <tr>
                <th>Files</th>
                <th>Errors</th>
                <th>Warnings</th>
                <th>Infos</th>
            </tr>
            <tr>
                <xsl:call-template name="alternated-row"/>
                <td>
                    <xsl:value-of select="$fileCount"/>
                </td>
                <td>
                    <xsl:value-of select="$errorCount"/>
                </td>
                <td>
                    <xsl:value-of select="$warningCount"/>
                </td>
                <td>
                    <xsl:value-of select="$infoCount"/>
                </td>
            </tr>
        </table>
    </xsl:template>
    <xsl:template match="checkstyle" mode="filelist">
        <h3>Files</h3>
        <table class="log" border="0" cellpadding="5" cellspacing="2" width="100%">
            <colgroup>
                <col style="width:75%"/>
                <col style="width:9%"/>
                <col style="width:8%"/>
                <col style="width:8%"/>
            </colgroup>
            <tr>
                <th>Name</th>
                <th>Errors</th>
                <th>Warnings</th>
                <th>Infos</th>
            </tr>
            <xsl:for-each select="file[@name and generate-id(.) = generate-id(key('files', @name))]">

                <xsl:sort data-type="number" order="descending"
                          select="count(key('files', @name)/error[@severity='error'])"/>
                <xsl:sort data-type="number" order="descending"
                          select="count(key('files', @name)/error[@severity='warning'])"/>
                <xsl:sort data-type="number" order="descending"
                          select="count(key('files', @name)/error[@severity='info'])"/>

                <xsl:variable name="errorCount" select="count(key('files', @name)/error[@severity='error'])"/>
                <xsl:variable name="warningCount" select="count(key('files', @name)/error[@severity='warning'])"/>
                <xsl:variable name="infoCount" select="count(key('files', @name)/error[@severity='info'])"/>

                <tr>
                    <xsl:call-template name="alternated-row"/>
                    <td>
                        <a href="#f-{translate(@name,'\','/')}">
                            <xsl:value-of select="@name"/>
                        </a>
                    </td>
                    <td>
                        <xsl:value-of select="$errorCount"/>
                    </td>
                    <td>
                        <xsl:value-of select="$warningCount"/>
                    </td>
                    <td>
                        <xsl:value-of select="$infoCount"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
    <xsl:template match="file">
        <a name="f-{translate(@name,'\','/')}"/>
        <h3>Class
            <xsl:value-of select="substring-after(@name, 'java/')"/>
        </h3>

        <table class="log" border="0" cellpadding="5" cellspacing="2" width="100%" style="table-layout:fixed">
            <colgroup>
                <col style="width:5%"/>
                <col style="width:70%"/>
                <col style="width:17%"/>
                <col style="width:8%"/>
            </colgroup>
            <tr>
                <th>Severity</th>
                <th>Error Description</th>
                <th>Error Group</th>
                <th>Line</th>
            </tr>
            <xsl:for-each select="key('files', @name)/error">
                <xsl:sort data-type="number" order="ascending" select="@line"/>
                <tr>
                    <xsl:call-template name="highlight-severity"/>
                    <td>
                        <xsl:value-of select="@severity"/>
                    </td>
                    <td>
                        <xsl:value-of select="@message"/>
                    </td>
                    <td>
                        <xsl:value-of
                                select="substring-after(string(@source), 'com.puppycrawl.tools.checkstyle.checks.')"/>
                    </td>
                    <td>
                        <xsl:value-of select="@line"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
        <a href="#top">Back to top</a>
    </xsl:template>
    <xsl:template name="alternated-row">
        <xsl:attribute name="class">
            <xsl:if test="position() mod 2 = 1">a</xsl:if>
            <xsl:if test="position() mod 2 = 0">b</xsl:if>
        </xsl:attribute>
    </xsl:template>
    <xsl:template name="highlight-severity">
        <xsl:attribute name="class">
            <xsl:if test="@severity ='error'">error</xsl:if>
            <xsl:if test="@severity ='warning'">warning</xsl:if>
            <xsl:if test="@severity ='info'">info</xsl:if>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>