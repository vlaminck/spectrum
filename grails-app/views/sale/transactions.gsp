<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="bootstrap"/>
    <title>Transaction List</title>
</head>

<body>
<g:render template="../flashMessages"/>
<ul>
<g:each var="transaction" in="${sale.transactions.sort{it.id}}">
    <g:render template="saleTransaction" model="[transaction: transaction, sale: sale]"/>
    <br/>
    <br/>
</g:each>
    </ul>
</body>
</html>