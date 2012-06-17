<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="bootstrap"/>
    <title>Sale Statistics</title>
</head>

<body>
<g:render template="../flashMessages"/>
<a class="btn" data-toggle="modal" href="#myModal">Start Sale</a>
<hr/>
<g:render template="saleStats" model="[saleInstance: saleInstance]"/>
<hr/>
<g:link controller="sale" action="endSale" class="btn btn-danger">End Sale</g:link>
<div class="modal hide" id="myModal">
    <g:form controller="sale" action="startSale">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">×</button>

            <h3>Modal header</h3>
        </div>

        <div class="modal-body">
            <label for="startingCash">Starting Cash</label>
                <g:textField name="startingCash" placeholder="How much cash are you starting with?"/>

        </div>


        <div class="modal-footer">
            <a href="#" class="btn" data-dismiss="modal">Close</a>
            <g:submitButton class="btn btn-primary" name="startSale" value="Start Sale!"/>
        </div>
    </g:form>
</div>
</body>
</html>