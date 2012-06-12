
<%@ page import="spectrum.Artist" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="bootstrap">
		<g:set var="entityName" value="${message(code: 'artist.label', default: 'Artist')}" />
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
						
							<g:sortableColumn property="firstName" title="${message(code: 'artist.firstName.label', default: 'First Name')}" />
						
							<g:sortableColumn property="middleName" title="${message(code: 'artist.middleName.label', default: 'Middle Name')}" />
						
							<g:sortableColumn property="lastName" title="${message(code: 'artist.lastName.label', default: 'Last Name')}" />
						
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
								<g:link action="show" id="${artistInstance.id}" class="btn btn-small">Show &raquo;</g:link>
							</td>
						</tr>
					</g:each>
					</tbody>
				</table>
				<div class="pagination">
					<bootstrap:paginate total="${artistInstanceTotal}" />
				</div>
			</div>

		</div>
	</body>
</html>
