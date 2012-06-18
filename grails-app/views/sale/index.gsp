<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="bootstrap"/>
    <title>Sale Statistics</title>
</head>

<body>
<div class="page-header">
    <span class="headerTitle">Sale Stats</span>
</div>
<g:render template="../flashMessages"/>
<g:elseSale><a class="btn btn-primary" data-toggle="modal" href="#myModal">Start New Sale</a></g:elseSale>

<g:ifSale><g:render template="saleStats" model="[saleInstance: saleInstance]"/></g:ifSale>
<g:elseSale>
    <h2>Previous Sales</h2>
    <ul>
    <g:each in="${saleList}" var="previousSale">
        <li><g:link controller="sale" action="show" id="${previousSale.id}">
            <g:formatDate format="yyyy-MM-dd" date="${previousSale.startDate}"/>
        </g:link></li>
    </g:each>
    </ul>
</g:elseSale>

<g:ifSale><g:link controller="sale" action="endSale" class="btn btn-danger">End Sale</g:link></g:ifSale>
<div class="modal hide" id="myModal">
    <g:form controller="sale" action="startSale">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>

            <h3>Modal header</h3>
        </div>

        <div class="modal-body">
            <label for="startingCash">Starting Cash</label>
            <g:textField name="startingCash" required="" placeholder="How much cash are you starting with?"/>

        </div>


        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Close</a>
            <g:submitButton class="btn btn-primary" name="startSale" value="Start Sale!"/>
        </div>
    </g:form>
</div>
</body>
</html>