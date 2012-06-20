<div class="span9">

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
                <g:if test="${artworkInstanceList}">
                    <g:sortableColumn property="qtyToPurchase"
                                      title="Qty to Purchase"/>
                </g:if>
            </g:ifSale>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${artworkInstanceList}" var="artworkInstance">
            <tr>

                <td>${fieldValue(bean: artworkInstance, field: "title")}</td>

                <td><g:formatNumber number="${artworkInstance.price}" type="currency"
                                    maxFractionDigits="2" roundingMode="HALF_DOWN"/>
                </td>
                %{--<td>${fieldValue(bean: artworkInstance, field: "price")}</td>--}%

                <td>${fieldValue(bean: artworkInstance, field: "materials")}</td>


                <td>${fieldValue(bean: artworkInstance, field: "qtyAvailable")}</td>

                <td><g:link controller="artwork" action="edit" id="${artworkInstance.id}">Edit</g:link></td>

                <g:ifSale>
                    <td class="link">
                        <g:form controller="cart" action="addToCart" id="${artworkInstance.id}">
                            <g:if test="${artworkInstance.qtyAvailable == 0}">
                                <g:textField class="shortInput" name="qtyToPurchase" disabled=""/></g:if>
                            <g:else><g:textField class="shortInput" name="qtyToPurchase"/></g:else>
                            <input type="hidden" name="artistId" value="${artworkInstance.artist.id}">
                            <g:if test="${artworkInstance.qtyAvailable == 0}">
                                <g:submitButton class="btn btn-success" value="Add to Cart" name="submit"
                                                disabled=""/></g:if>
                            <g:else><g:submitButton class="btn btn-success" value="Add to Cart" name="submit"/></g:else>
                        </g:form>
                    </td>
                </g:ifSale>
            </tr>
        </g:each>
        <g:form controller="artist" action="addArtwork">
            <input type="hidden" name="artistId" value="${artistInstance.id}"/>
            <tr>
                <td><g:textField name="title" required="" placeholder="Enter title..."/></td>

                <td><g:textField class="shortInput" required="" name="price" placeholder="Enter price..."/></td>

                <td><g:textField name="materials" placeholder="Enter materials..."/></td>

                <td><g:textField class="shortInput" required="" name="qtyAvailable"
                                 placeholder="Enter quantity..."/></td>

                <td><g:submitButton name="newArtworkSubmit" value="Create" class="btn btn-primary"/></td>
            </tr>
        </g:form>
        </tbody>
    </table>

    <div class="pagination">
        <bootstrap:paginate total="${artworkInstanceTotal}"/>
    </div>
</div>