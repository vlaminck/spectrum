<%@ page import="spectrum.Artist" %>



<div class="fieldcontain ${hasErrors(bean: artistInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="artist.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" required="" value="${artistInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: artistInstance, field: 'middleName', 'error')} ">
	<label for="middleName">
		<g:message code="artist.middleName.label" default="Middle Name" />
		
	</label>
	<g:textField name="middleName" value="${artistInstance?.middleName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: artistInstance, field: 'lastName', 'error')} ">
	<label for="lastName">
		<g:message code="artist.lastName.label" default="Last Name" />
		
	</label>
	<g:textField name="lastName" value="${artistInstance?.lastName}"/>
</div>



