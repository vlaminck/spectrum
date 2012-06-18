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
    <tbody>
    <g:each in="${artistInstanceList}" var="artistInstance">
        <tr>

            <td>${fieldValue(bean: artistInstance, field: "fullName")}</td>

            <td class="link">
                <g:link action="show" id="${artistInstance.id}" class="btn btn-small">Go To Artworks &raquo;</g:link>
            </td>
        </tr>
    </g:each>

    </tbody>
</table>

<a class="btn btn-primary" data-toggle="modal" href="#myModal">Add Artist</a>

<div class="pagination">
    <bootstrap:paginate total="${artistInstanceTotal}"/>
</div>

<div class="modal hide" id="myModal">
    <g:form controller="artist" action="create">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>

            <h3>
                Add Artist &nbsp;&nbsp;

            </h3>
        </div>

        <div class="modal-body">
            <g:render template="form"/>
        </div>


        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Cancel</a>
            <g:submitButton class="btn btn-primary" name="addArtist" value="Add Artist"/>

        </div>
    </g:form>
</div>

</body>
</html>
