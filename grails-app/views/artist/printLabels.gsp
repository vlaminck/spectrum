<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'print.css')}" type="text/css">
</head>

<body>
<ul class="outer">
    <g:each var="artworkInstance" in="${artistInstance.artworks.sort {it.title}}">
        <li class="outer">
            <ul>
                <li class="artist">
                    ${artistInstance.fullName}
                </li>
                <li class="title">
                    ${artworkInstance.title}
                </li>
                <li class="materials">
                    ${artworkInstance.materials}
                </li>
                <li class="price">
                    <g:formatNumber number="${artworkInstance.price}" type="currency"
                                    maxFractionDigits="2" roundingMode="HALF_DOWN"/>
                </li>
            </ul>
        </li>
        <li class="outer">
            <ul>
                <li class="artist">
                    ${artistInstance.fullName}
                </li>
                <li class="title">
                    ${artworkInstance.title}
                </li>
                <li class="materials">
                    ${artworkInstance.materials}
                </li>
                <li class="price">
                    <g:formatNumber number="${artworkInstance.price}" type="currency"
                                    maxFractionDigits="2" roundingMode="HALF_DOWN"/>
                </li>
            </ul>
        </li>
    </g:each>
</ul>
</body>
</html>