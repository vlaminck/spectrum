<%@ page import="spectrum.Transaction" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="bootstrap" name="layout"/>
    <title>Shopping Cart</title>
</head>

<body>
<div class="page-header">
    <span class="headerTitle">Shopping Cart</span>
    <g:link class="btn btn-danger" action="clearCart">Clear Cart</g:link>
</div>
<g:render template="../flashMessages"/>
<table class="table table-striped">
    <thead>
    <tr>

        <g:sortableColumn property="title" title="${message(code: 'artwork.title.label', default: 'Title')}"/>

        <g:sortableColumn property="artist" title="${message(code: 'artwork.artist.label', default: 'Artist')}"/>

        <g:sortableColumn property="price" title="${message(code: 'artwork.price.label', default: 'Price')}"/>

        <g:sortableColumn property="artworkQty"
                          title="${message(code: 'artwork.qtyAvailable.label', default: 'Qty')}"/>

        <g:sortableColumn property="totalPrice" title="Total Price"></g:sortableColumn>

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

            <td><g:formatNumber number="${artworkInstance.artworkQty * artworkInstance.price.round(2)}" type="currency"
                                currencyCode="USD"/></td>

            <td class="link">
                %{--<g:link controller="artist" action="show" id="${artworkInstance.artistId}" class="btn btn-small">Edit &raquo;</g:link>--}%
                <g:link action="removeFromCart" id="${artworkInstance.artworkId}"
                        class="btn btn-small">Remove from Cart</g:link>
            </td>
        </tr>
    </g:each>
    <tr>
        <td colspan="7">
            <hr/>
        </td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td class="rightAlign">Total Before Tax:</td>
        <td><g:formatNumber number="${total?.round(2)}" type="currency" currencyCode="USD"/></td>
        <td class="link">
        </td>
    </tr>
    <tr>
        <td></td>
        <td></td>
        <td></td>
        <td class="rightAlign">Total Tax:</td>
        <td><g:formatNumber number="${(totalWithTax - total)?.round(2)}" type="currency" currencyCode="USD"/></td>
        <td class="link">
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td></td>
        <td></td>
        <td class="bold rightAlign">Total Including Tax:</td>
        <td class="bold"><g:formatNumber number="${totalWithTax?.round(2)}" type="currency" currencyCode="USD"/></td>
        <td class="link">
            <a class="btn btn-success" data-toggle="modal" href="#myModal">Check Out</a>
        </td>
    </tr>
    </tbody>
</table>

<br/>

<div class="modal hide" id="myModal">
    <g:form controller="cart" action="checkOut">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>

            <h3>
                Check Out &nbsp;&nbsp;
                <span class="bold">
                    <g:formatNumber number="${totalWithTax?.round(2)}" type="currency" currencyCode="USD"/>
                </span>
            </h3>
        </div>

        <div class="modal-body">
            <ul>
                <li id="payment1">
                    <label for="paymentType1">Payment Type</label>
                    <g:select from="${Transaction.paymentTypes}" name="paymentType1"/>
                    <label for="paymentAmount1">Amount</label>
                    <g:textField name="paymentAmount1" required=""/>
                </li>
                <li id="payment2">
                    <label for="paymentType2">Payment Type</label>
                    <g:select from="${Transaction.paymentTypes}" name="paymentType2"/>
                    <label for="paymentAmount2">Amount</label>
                    <g:textField name="paymentAmount2"/>
                </li>
                <li id="payment3">
                    <label for="paymentType3">Payment Type</label>
                    <g:select from="${Transaction.paymentTypes}" name="paymentType3"/>
                    <label for="paymentAmount3">Amount</label>
                    <g:textField name="paymentAmount3"/>
                </li>
                <li id="addPaymentButton">
                    <a class="btn btn-info" href="javascript:addPaymentType();">Add Payment Type</a>
                </li>
            </ul>
        </div>


        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Cancel</a>
            <g:submitButton class="btn btn-primary" name="finalPayment" value="Authorize" disabled="disabled"/>
            <h3 id="paymentSum">
                <span class="amount-left">
                    Amount left:
                </span>
                <span class="change-due">
                    Change Due:
                </span>
                <span class="amount">
                    <g:formatNumber number="${totalWithTax}" type="currency" currencyCode="USD" maxFractionDigits="2"/>
                </span>
            </h3>
        </div>
        <input type="hidden" name="changeDue" value="0" id="change-due-input"/>
    </g:form>
</div>

<script type="text/javascript">
    var amountLeft = parseFloat("${totalWithTax?.round(2)}");
    function addPaymentType()
    {
        if ($("#payment2").is(":hidden"))
        {
            $("#payment2").show();
        }
        else if ($("#payment3").is(":hidden"))
        {
            $("#payment3").show();
            $("#addPaymentButton").hide();
        }
        verifyPaymentTypes()
    }

    function calculatePayments()
    {
        var temp = amountLeft;
        if ($("#paymentAmount1").val() != "")
        {
            temp -= parseFloat($("#paymentAmount1").val());
        }
        if ($("#paymentAmount2").val() != "")
        {
            temp -= parseFloat($("#paymentAmount2").val());
        }

        if ($("#paymentAmount3").val() != "")
        {
            temp -= parseFloat($("#paymentAmount3").val());
        }
        return temp.toFixed(2);
    }

    function verifyPaymentTypes()
    {
        if ($("#payment1").find("select").val() == "Cash")
        {
            disableCash("#payment2");
            disableCash("#payment3");
        }
        else if ($("#payment2").find("select").val() == "Cash")
        {
            disableCash("#payment1");
            disableCash("#payment3");
        }
        else if ($("#payment3").find("select").val() == "Cash")
        {
            disableCash("#payment1");
            disableCash("#payment2");
        }
    }

    function disableCash(selectorId)
    {
        $(selectorId).find("option[value=Cash]").attr('disabled', 'disabled');
        $(selectorId).find("select").val("Check");
    }

    function enableCash(selectorId)
    {
        $(selectorId).find("option[value=Cash]").removeAttr('disabled');
    }

    function toggleDisabled()
    {
        var paymentAmount = calculatePayments()
        if (paymentAmount == 0.00)
        {
            $("#paymentSum").css({color:"transparent"});
            $("#finalPayment").removeAttr('disabled');
            $(".amount-left").show();
            $(".change-due").hide();
            $("#change-due-input").val(0);
        }
        else if (paymentAmount < 0.00)
        {
            $("#paymentSum").css({color:"green"});
            $("#finalPayment").removeAttr('disabled');
            $("#paymentSum").find("span.amount").text('$' + (calculatePayments() * -1).toFixed(2));
            $("#change-due-input").val((calculatePayments() * -1).toFixed(2));
            $(".amount-left").hide();
            $(".change-due").show();
        }
        else
        {
            $("#paymentSum").css({color:"red"});
            $("#finalPayment").attr('disabled', 'disabled');
            $("#change-due-input").val(0);
            $(".amount-left").show();
            $(".change-due").hide();
        }
        console.log($("#change-due-input").val());
    }

    function updateCheckoutForm()
    {
        $("#paymentSum").find("span.amount").text('$' + calculatePayments());
        toggleDisabled();
        verifyPaymentTypes();
    }

    function updateCheckoutSelects(elementId)
    {
        if ($("#" + elementId).val() == "Check")
        {
            if (elementId == "paymentType1")
            {
                enableCash("#paymentType2");
                enableCash("#paymentType3");
            }
            else if (elementId == "paymentType2")
            {
                enableCash("#paymentType1");
                enableCash("#paymentType3");
            }
            else if (elementId == "paymentType3")
            {
                enableCash("#paymentType1");
                enableCash("#paymentType2");
            }
        }
        else if ($("#" + elementId).val() == "Cash")
        {
            if (elementId == "paymentType1")
            {
                disableCash("#paymentType2");
                disableCash("#paymentType3");
            }
            else if (elementId == "paymentType2")
            {
                disableCash("#paymentType1");
                disableCash("#paymentType3");
            }
            else if (elementId == "paymentType3")
            {
                disableCash("#paymentType1");
                disableCash("#paymentType2");
            }
        }
    }
    $(document).ready(function ()
    {
        $("span.change-due").hide();
        $(".modal-body").find("input").change(function ()
                {
                    updateCheckoutForm();
                }
        );

        $(".modal-body").find("select").change(function ()
                {
                    updateCheckoutSelects(this.id);
                }
        );

    });
</script>
</body>
</html>