
<%@ page import="spectrum.Artwork" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'artwork.label', default: 'Artwork')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
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
								<g:message code="default.list.label" args="[entityName]" />
							</g:link>
						</li>
						<li>
							<g:link class="create" action="create">
								<i class="icon-plus"></i>
								<g:message code="default.create.label" args="[entityName]" />
							</g:link>
						</li>
					</ul>
				</div>
			</div>
			
			<div class="span9">

				<div class="page-header">
					<h1><g:message code="default.show.label" args="[entityName]" /></h1>
				</div>

                <g:render template="../flashMessages"/>

				<dl>
				
					<g:if test="${artworkInstance?.title}">
						<dt><g:message code="artwork.title.label" default="Title" /></dt>
						
							<dd><g:fieldValue bean="${artworkInstance}" field="title"/></dd>
						
					</g:if>
				
					<g:if test="${artworkInstance?.price}">
						<dt><g:message code="artwork.price.label" default="Price" /></dt>
						
							<dd><g:fieldValue bean="${artworkInstance}" field="price"/></dd>
						
					</g:if>
				
					<g:if test="${artworkInstance?.materials}">
						<dt><g:message code="artwork.materials.label" default="Materials" /></dt>
						
							<dd><g:fieldValue bean="${artworkInstance}" field="materials"/></dd>
						
					</g:if>
				
					<g:if test="${artworkInstance?.qtyAvailable}">
						<dt><g:message code="artwork.qtyAvailable.label" default="Qty Available" /></dt>
						
							<dd><g:fieldValue bean="${artworkInstance}" field="qtyAvailable"/></dd>
						
					</g:if>
				
				</dl>

				<g:form>
					<g:hiddenField name="id" value="${artworkInstance?.id}" />
					<div class="form-actions">
						<g:link class="btn" action="edit" id="${artworkInstance?.id}">
							<i class="icon-pencil"></i>
							<g:message code="default.button.edit.label" default="Edit" />
						</g:link>
						<button class="btn btn-danger" type="submit" name="_action_delete">
							<i class="icon-trash icon-white"></i>
							<g:message code="default.button.delete.label" default="Delete" />
						</button>
					</div>
				</g:form>

			</div>

		</div>
	</body>
</html>
