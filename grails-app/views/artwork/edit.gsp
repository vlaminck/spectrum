<%@ page import="spectrum.Artwork" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="bootstrap">
    <g:set var="entityName" value="${message(code: 'artwork.label', default: 'Artwork')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>


    <div class="span9">

        <div class="page-header">
            <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
        </div>

        <g:render template="../flashMessages"/>

        <g:hasErrors bean="${artworkInstance}">
            <bootstrap:alert class="alert-error">
                <ul>
                    <g:eachError bean="${artworkInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </bootstrap:alert>
        </g:hasErrors>

        <fieldset>
            <g:form class="form-horizontal" action="edit" id="${artworkInstance?.id}">
                <g:hiddenField name="version" value="${artworkInstance?.version}"/>
                <fieldset>
                    <div class="form-actions">
                        <g:render template="form" model="[artworkInstance: artworkInstance, artistInstance: artworkInstance.artist]"/>
                        <button type="submit" class="btn btn-primary">
                            <i class="icon-ok icon-white"></i>
                            <g:message code="default.button.update.label" default="Update"/>
                        </button>
                        <button type="submit" class="btn btn-danger" name="_action_delete" formnovalidate onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                            <i class="icon-trash icon-white"></i>
                            <g:message code="default.button.delete.label" default="Delete"/>
                        </button>
                    </div>
                </fieldset>
            </g:form>
        </fieldset>

    </div>


</body>
</html>
