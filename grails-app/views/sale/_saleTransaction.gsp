<li>
    <h1>Transaction ${transaction.id}
            <g:link controller="sale" action="voidTransaction" params="[saleId: sale.id, transactionId: transaction.id]" class="btn btn-danger">Void Transaction</g:link>
    </h1>
    <table class="table table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="title" title="Title"/>

        <g:sortableColumn property="artist" title="Artist"/>

        <g:sortableColumn property="price" title="Price"/>

        <g:sortableColumn property="artworkQty"
                          title="Qty"/>

        <g:sortableColumn property="totalPrice" title="Total Price"></g:sortableColumn>

        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${transaction.transactionItems}" var="transactionItem">
        <g:set var="artworkInstance" value="${transactionItem.artwork}"/>
        <tr>

            <td>${artworkInstance.title}</td>

            <td>${artworkInstance.artist.fullName}</td>

            <td><g:formatNumber number="${transactionItem.priceEach.round(2)}" type="currency" currencyCode="USD"/></td>

            <td>${transactionItem.qtySold}</td>

            <td><g:formatNumber number="${transactionItem.totalPrice.round(2)}" type="currency"
                                currencyCode="USD"/></td>
        </tr>
    </g:each>
    <tr>
        <td colspan="5">
            <hr/>
        </td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td class="rightAlign">Total Before Tax:</td>
        <td><g:formatNumber number="${transaction.totalBeforeTax.round(2)}" type="currency" currencyCode="USD"/></td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td class="rightAlign">Total Tax:</td>
        <td><g:formatNumber number="${transaction.totalTax.round(2)}" type="currency" currencyCode="USD"/></td>
    </tr>
    <tr>
        <td>
        </td>
        <td></td>
        <td></td>
        <td class="bold rightAlign">Total Including Tax:</td>
        <td class="bold"><g:formatNumber number="${transaction.totalWithTax.round(2)}" type="currency"
                                         currencyCode="USD"/></td>

    </tr>
    </tbody>
</table>
</li>