<div class="span9">

    <div class="page-header">
        <h1>Artworks</h1>
    </div>

    <table class="table table-striped">
        <thead>
        <tr>

            <g:sortableColumn property="title" title="${message(code: 'artwork.title.label', default: 'Title')}"/>

            <g:sortableColumn property="price" title="${message(code: 'artwork.price.label', default: 'Price')}"/>

            <g:sortableColumn property="materials"
                              title="${message(code: 'artwork.materials.label', default: 'Materials')}"/>

            <g:sortableColumn property="qtyAvailable"
                              title="${message(code: 'artwork.qtyAvailable.label', default: 'Qty Available')}"/>

            <th></th>

            <g:ifSale>
                <g:sortableColumn property="qtyToPurchase"
                                  title="Qty to Purchase"/>
            </g:ifSale>
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

                <td><g:link controller="artwork" action="edit" id="${artworkInstance.id}">Edit</g:link></td>

                <g:ifSale>
                    <td class="link">
                        <g:form controller="cart" action="addToCart" id="${artworkInstance.id}">
                            <g:textField name="qtyToPurchase"/>
                            <input type="hidden" name="artistId" value="${artworkInstance.artist.id}">
                            <g:submitButton value="Add to Cart" name="submit"/></g:form>
                    </td>
                </g:ifSale>
            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <bootstrap:paginate total="${artworkInstanceTotal}"/>
    </div>
</div>