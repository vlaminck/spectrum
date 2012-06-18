<%@ page import="spectrum.Artist" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<g:form>
    <div class="page-header">
        <span class="headerTitle">${artistInstance.fullName}</span>
        <g:hiddenField name="id" value="${artistInstance?.id}"/>
        <g:link class="btn" action="edit" id="${artistInstance?.id}">
            <i class="icon-pencil"></i>
            Edit Artist
        </g:link>

    </div>
    <g:render template="../flashMessages"/>
</g:form>
<g:render template="artworks"
          model="[
                  artworkInstanceList: artistInstance.artworks.sort {it.title.toLowerCase()}
                  , artworkInstanceTotal: artistInstance.artworks.size()
                  , artistInstance: artistInstance
          ]"/>

</body>
</html>
