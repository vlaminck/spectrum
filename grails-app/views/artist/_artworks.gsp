<div class="span9">

				<div class="page-header">
					<h1>Artworks</h1>
				</div>

				<g:if test="${flash.message}">
				<bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
				</g:if>

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