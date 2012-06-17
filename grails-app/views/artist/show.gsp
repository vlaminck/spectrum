<%@ page import="spectrum.Artist" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>
<div class="row-fluid">

    <div class="span3">
        <div class="well">
            <ul class="nav nav-list">
                <li class="nav-header">Menu</li>
                <li>
                    <g:link class="list" action="list">
                        <i class="icon-list"></i>
                        <g:message code="default.list.label" args="[entityName]"/>
                    </g:link>
                </li>
                <li>
                    <g:link class="create" action="create">
                        <i class="icon-plus"></i>
                        <g:message code="default.create.label" args="[entityName]"/>
                    </g:link>
                </li>
            </ul>
        </div>
    </div>

    <div class="span9">

        <g:form>
            <div class="page-header">
                <span class="headerTitle">${artistInstance.fullName}</span>
                <g:hiddenField name="id" value="${artistInstance?.id}"/>
                <g:link class="btn" action="edit" id="${artistInstance?.id}">
                    <i class="icon-pencil"></i>
                    Edit Artist
                </g:link>
                <g:ifSale>
                    <g:link class="shoppingCartButton btn btn-success" controller="cart"
                    action="show">Shopping Cart</g:link>
                </g:ifSale>
            </div>
            <g:render template="../flashMessages"/>
        </g:form>
        <g:render template="artworks"
                  model="[
                          artworkInstanceList: artistInstance.artworks.sort {it.title}
                          , artworkInstanceTotal: artistInstance.artworks.size()
                          , artistInstance: artistInstance
                  ]"/>

    </div>
</div>
</body>
</html>
