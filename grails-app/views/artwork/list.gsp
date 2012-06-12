
<%@ page import="spectrum.Artwork" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'artwork.label', default: 'Artwork')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="row-fluid">
			
			<div class="span3">
				<div class="well">
					<ul class="nav nav-list">
						<li class="nav-header">${entityName}</li>
						<li class="active">
							<g:link class="list" action="list">
								<i class="icon-list icon-white"></i>
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
					<h1><g:message code="default.list.label" args="[entityName]" /></h1>
				</div>

                <g:render template="../flashMessages"/>
				
				<table class="table table-striped">
					<thead>
						<tr>
						
							<g:sortableColumn property="title" title="${message(code: 'artwork.title.label', default: 'Title')}" />
						
							<g:sortableColumn property="price" title="${message(code: 'artwork.price.label', default: 'Price')}" />
						
							<g:sortableColumn property="materials" title="${message(code: 'artwork.materials.label', default: 'Materials')}" />
						
							<g:sortableColumn property="qtyAvailable" title="${message(code: 'artwork.qtyAvailable.label', default: 'Qty Available')}" />
						
							<th></th>
						</tr>
					</thead>
					<tbody>
					<g:each in="${artworkInstanceList}" var="artworkInstance">
						<tr>
						
							<td>${fieldValue(bean: artworkInstance, field: "title")}</td>
						
							<td>${fieldValue(bean: artworkInstance, field: "price")}</td>
						
							<td>${fieldValue(bean: artworkInstance, field: "materials")}</td>
						
							<td>${fieldValue(bean: artworkInstance, field: "qtyAvailable")}</td>
						
							<td class="link">
								<g:link action="show" id="${artworkInstance.id}" class="btn btn-small">Show &raquo;</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${artworkInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
