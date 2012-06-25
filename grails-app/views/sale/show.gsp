<%@ page import="spectrum.Artist" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="page-header">
    <span class="headerTitle">Sale Stats</span>
        <g:link controller="sale" action="transactions" params="[saleId: saleInstance.id]" class="btn">Transaction List</g:link>
</div>
<g:render template="../flashMessages"/>
<g:render template="saleStats" model="[saleInstance: saleInstance]"/>
</body>
</html>
