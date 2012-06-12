<g:if test="${flash.message}">
    <bootstrap:alert class="alert-info">${flash.message}</bootstrap:alert>
</g:if>
<g:if test="${flash.warn}">
    <bootstrap:alert class="alert-warn">${flash.warn}</bootstrap:alert>
</g:if>
<g:if test="${flash.error}">
    <bootstrap:alert class="alert-error">${flash.error}</bootstrap:alert>
</g:if>
