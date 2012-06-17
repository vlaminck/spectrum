<%@ page import="spectrum.Transaction" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="bootstrap" name="layout"/>
    <title>Shopping Cart</title>
</head>

<body>
<table class="table table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="title" title="${message(code: 'artwork.title.label', default: 'Title')}"/>

        <g:sortableColumn property="artist" title="${message(code: 'artwork.artist.label', default: 'Artist')}"/>

        <g:sortableColumn property="price" title="${message(code: 'artwork.price.label', default: 'Price')}"/>

        <g:sortableColumn property="artworkQty"
                          title="${message(code: 'artwork.qtyAvailable.label', default: 'Qty')}"/>

        <th></th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${artworkList}" var="artworkInstance">
        <tr>

            <td>${artworkInstance.title}</td>

            <td>${artworkInstance.artist}</td>

            <td><g:formatNumber number="${artworkInstance.price.round(2)}" type="currency" currencyCode="USD"/></td>

            <td>${artworkInstance.artworkQty}</td>

            <td class="link">
            %{--<g:link controller="artist" action="show" id="${artworkInstance.artistId}" class="btn btn-small">Edit &raquo;</g:link>--}%
                <g:link action="removeFromCart" id="${artworkInstance.artworkId}"
                        class="btn btn-small">Remove from Cart &raquo;</g:link>
            </td>
        </tr>
    </g:each>
    <tr>
        <td colspan="5">
            <hr/>
        </td>
    </tr>
    <tr>
        <td class="bold">Total Including Tax:</td>
        <td></td>
        <td class="bold"><g:formatNumber number="${total?.round(2)}" type="currency" currencyCode="USD"/></td>
        <td></td>
        <td class="link">
            <a class="btn btn-success" data-toggle="modal" href="#myModal">Check Out</a>
        </td>
    </tr>
    </tbody>
</table>

<br/>
<g:link action="clearCart">Clear!</g:link>
<div class="modal hide" id="myModal">
    <g:form controller="cart" action="checkOut">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>

            <h3>Check Out</h3>
        </div>

        <div class="modal-body">
            <ul>
                <li>
                    <label for="paymentType1">Payment Type</label>
                    <g:select from="${Transaction.paymentTypes}" name="paymentType1"/>
                    <label for="paymentAmount1">Amount</label>
                    <g:textField name="paymentAmount1"/>
                </li>
                <li>
                    <label for="paymentType2">Payment Type</label>
                    <g:select from="${Transaction.paymentTypes}" name="paymentType2"/>
                    <label for="paymentAmount2">Amount</label>
                    <g:textField name="paymentAmount2"/>
                </li>
                <li>
                    <label for="paymentType3">Payment Type</label>
                    <g:select from="${Transaction.paymentTypes}" name="paymentType3"/>
                    <label for="paymentAmount3">Amount</label>
                    <g:textField name="paymentAmount3"/>
                </li>
            </ul>
        </div>


        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Close</a>
            <g:submitButton class="btn btn-primary" name="finalPayment" value="Authorize"/>
        </div>
    </g:form>
</div>
</body>
</html>