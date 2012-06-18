<ul>
    <li>Sale Start Date: ${saleInstance?.startDate}</li>
    <li>Sale End Date: ${saleInstance?.endDate}</li>
    <li>Total Sold: <g:formatNumber number="${saleInstance?.totalWithTax?.toDouble()?.round(2)}" type="currency" currencyCode="USD"/></li>
    <li>Total Before Tax: <g:formatNumber number="${saleInstance?.totalBeforeTax?.toDouble()?.round(2)}" type="currency" currencyCode="USD"/></li>
    <li>Total Tax: <g:formatNumber number="${saleInstance?.totalTax?.toDouble()?.round(2)}" type="currency" currencyCode="USD"/></li>
    <li>Total Cash Received: <g:formatNumber number="${saleInstance?.totalCash?.toDouble()?.round(2)}" type="currency" currencyCode="USD"/></li>
    <li>Starting Cash: <g:formatNumber number="${saleInstance?.startingCash?.toDouble()?.round(2)}" type="currency" currencyCode="USD"/></li>
    <li>Ending Cash: <g:formatNumber number="${saleInstance?.endingCash?.toDouble()?.round(2)}" type="currency" currencyCode="USD"/></li>
</ul>
<hr/>