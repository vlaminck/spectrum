<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta content="bootstrap" name="layout"/>
    <title>Shopping Cart</title>
</head>

<body>
<g:each var="artworkItem" in="${artworkList}">
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

                <td>${artworkInstance.price}</td>

                <td>${artworkInstance.artworkQty}</td>

                <td class="link">
                    <g:link action="show" id="${artworkInstance.id}" class="btn btn-small">Show &raquo;</g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <br/></g:each>
<br/>
<g:link action="clearCart">Clear!</g:link>
</body>
</html>