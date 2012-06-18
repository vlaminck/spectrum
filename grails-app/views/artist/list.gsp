<%@ page import="spectrum.Artist" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-header">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
</div>

<g:render template="../flashMessages"/>

<table class="table table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="firstName"
                          title="${message(code: 'artist.firstName.label', default: 'First Name')}"/>

        <g:sortableColumn property="middleName"
                          title="${message(code: 'artist.middleName.label', default: 'Middle Name')}"/>

        <g:sortableColumn property="lastName" title="${message(code: 'artist.lastName.label', default: 'Last Name')}"/>

        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${artistInstanceList}" var="artistInstance">
        <tr>

            <td>${fieldValue(bean: artistInstance, field: "firstName")}</td>

            <td>${fieldValue(bean: artistInstance, field: "middleName")}</td>

            <td>${fieldValue(bean: artistInstance, field: "lastName")}</td>

            <td class="link">
                <g:link action="show" id="${artistInstance.id}" class="btn btn-small">Go To Artworks &raquo;</g:link>
            </td>
        </tr>
    </g:each>
    <g:form controller="artist" action="create">
        <tr>
            <td><g:textField name="firstName" required="" placeholder="Enter first name..."/></td>

            <td><g:textField name="middleName" placeholder="Enter middle name..."/></td>

            <td><g:textField name="lastName" placeholder="Enter last name..."/></td>

            <td><g:submitButton name="artistSubmit" value="Add New Artist" class="btn btn-primary"/></td>
        </tr>
    </g:form>
    </tbody>
</table>

<div class="pagination">
    <bootstrap:paginate total="${artistInstanceTotal}"/>
</div>

</body>
</html>
