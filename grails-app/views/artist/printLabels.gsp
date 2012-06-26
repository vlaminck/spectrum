<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'print.css')}" type="text/css">
</head>

<body>
<g:each in="${artistInstanceList}" var="artistInstance"><g:render template="printLabels" model="[artistInstance: artistInstance]"/></g:each>
</body>
</html>