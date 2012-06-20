<div class="well statsWell">
%{--${saleInstance?.startDate?.format("M/d/yyyy")}--}%
%{--<br/>--}%
    <g:if test="${saleInstance}">
        <h1>${saleInstance?.name}</h1>
    </g:if>
    <br/>

    <div>

        Total Sold: <g:formatNumber number="${saleInstance?.totalWithTax?.toDouble()?.round(2)}" type="currency"
                                    currencyCode="USD"/>

    </div>

    <div>

        Artworks Sold: ${saleInstance?.artworksSold ?: 0}

    </div>

</div>

<table class="table table-striped statsTable">
    <thead>
    <tr>
        <td colspan="2">
            <h3>Tax</h3>
        </td>
        <td colspan="2">
            <h3>Cash</h3>
        </td>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td>Total Before Tax:</td>
        <td><g:formatNumber number="${saleInstance?.totalBeforeTax?.toDouble()?.round(2)}"
                            type="currency"
                            currencyCode="USD"/></td>
        <td>Total Cash Received:</td>
        <td><g:formatNumber number="${saleInstance?.totalCash?.toDouble()?.round(2)}"
                            type="currency"
                            currencyCode="USD"/></td>
    </tr>
    <tr>
        <td>Total Tax:</td>
        <td><g:formatNumber number="${saleInstance?.totalTax?.toDouble()?.round(2)}" type="currency"
                            currencyCode="USD"/></td>
        <td>Starting Cash:</td>
        <td><g:formatNumber number="${saleInstance?.startingCash?.toDouble()?.round(2)}"
                            type="currency"
                            currencyCode="USD"/></td>
    </tr>
    <tr>
        <td>Total with Tax:</td>
        <td><g:formatNumber number="${saleInstance?.totalWithTax?.toDouble()?.round(2)}"
                            type="currency"
                            currencyCode="USD"/></td>
        <td>Ending Cash:</td>
        <td><g:formatNumber number="${saleInstance?.endingCash?.toDouble()?.round(2)}" type="currency"
                            currencyCode="USD"/></td>
    </tr>
    </tbody>
</table>
