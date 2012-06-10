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
                <li class="nav-header">${entityName}</li>
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

        <div class="page-header">
            <h1><g:message code="default.show.label" args="[entityName]"/></h1>
        </div>

        <g:if test="${flash.message}">
            <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
        </g:if>

        <dl>

            <g:if test="${artistInstance?.firstName}">
                <dt><g:message code="artist.firstName.label" default="First Name"/></dt>

                <dd><g:fieldValue bean="${artistInstance}" field="firstName"/></dd>

            </g:if>

            <g:if test="${artistInstance?.middleName}">
                <dt><g:message code="artist.middleName.label" default="Middle Name"/></dt>

                <dd><g:fieldValue bean="${artistInstance}" field="middleName"/></dd>

            </g:if>

            <g:if test="${artistInstance?.lastName}">
                <dt><g:message code="artist.lastName.label" default="Last Name"/></dt>

                <dd><g:fieldValue bean="${artistInstance}" field="lastName"/></dd>

            </g:if>


        </dl>

        <g:form>
            <g:hiddenField name="id" value="${artistInstance?.id}"/>
            <div class="form-actions">
                <g:link class="btn" action="edit" id="${artistInstance?.id}">
                    <i class="icon-pencil"></i>
                    <g:message code="default.button.edit.label" default="Edit"/>
                </g:link>
                <button class="btn btn-danger" type="submit" name="_action_delete">
                    <i class="icon-trash icon-white"></i>
                    <g:message code="default.button.delete.label" default="Delete"/>
                </button>
            </div>
        </g:form>
        <g:render template="../artist/artworks"
                  model="[artworkInstanceList: artistInstance.artworks, artworkInstanceTotal: artistInstance.artworks.size()]"/>

    </div>
</div>
</body>
</html>
