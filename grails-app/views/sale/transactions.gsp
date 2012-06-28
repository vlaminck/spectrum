<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="bootstrap"/>
    <title>Transaction List</title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'print.css')}" type="text/css" media="print">
    <style type="text/css" media="print">
        .span3 {
            display: none;
        }

        a {
            text-decoration: none;
        }

        .btn {
            display: none;
        }

        h1 {
            text-align: left;
        }
    </style>
</head>

<body>
<g:render template="../flashMessages"/>
<ul>
<g:each var="transaction" in="${transactions.sort{it.id}}">
    <g:render template="saleTransaction" model="[transaction: transaction, sale: sale]"/>
    <br/>
    <br/>
</g:each>
    </ul>
</body>
</html>