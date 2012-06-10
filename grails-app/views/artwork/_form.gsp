<%@ page import="spectrum.Artwork" %>

<input type="hidden" name="artistId" value="${artistInstance.id}">

<div class="fieldcontain ${hasErrors(bean: artworkInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="artwork.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${artworkInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: artworkInstance, field: 'price', 'error')} required">
    <label for="price">
        <g:message code="artwork.price.label" default="Price"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field type="double" name="price" required="" value="${fieldValue(bean: artworkInstance, field: 'price')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: artworkInstance, field: 'materials', 'error')} ">
    <label for="materials">
        <g:message code="artwork.materials.label" default="Materials"/>

    </label>
    <g:textField name="materials" value="${artworkInstance?.materials}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: artworkInstance, field: 'qtyAvailable', 'error')} required">
    <label for="qtyAvailable">
        <g:message code="artwork.qtyAvailable.label" default="Qty Available"/>
        <span class="required-indicator">*</span>
    </label>
    <g:field type="number" name="qtyAvailable" required=""
             value="${fieldValue(bean: artworkInstance, field: 'qtyAvailable')}"/>
</div>

