<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp" %>

<h2>Write a new Drug Order</h2>

<a href="<openmrs:contextPath/>/patientDashboard.form?patientId=${drugOrder.patient.patientId}">
		<openmrs:message code="PatientDashboard.backToPatientDashboard"/>
</a>

<br/><br/>

<b class="boxHeader">Drug Order Details</b>
<div class="box">
	<form:form method="post" action="drugOrder.form" modelAttribute="drugOrder">
	
		<table class="left-aligned-th" cellpadding="3" cellspacing="3">
			<tr>
				<th>Drug</th>
				<td>
					<spring:bind path="drug">
					<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="drug" initialValue="${status.value}" includeClasses="Drug"/>
					<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
				<td>
					Patient Care Setting
					<form:radiobutton path="dosingType" value="SIMPLE"/> In Patient
					<form:radiobutton path="dosingType" value="FREE_TEXT"/> Out Patient
				</td>
			</tr>
			<tr>
				<th>Type of dosage</th>
				<td>
					<form:radiobutton path="dosingType" value="SIMPLE"/> Simple
					<form:radiobutton path="dosingType" value="FREE_TEXT"/> Complex
				</td>
			</tr>
			<tr>
				<th>Dose</th>
				<td>
					<spring:bind path="dose">
					<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="drug" initialValue="${status.value}" includeClasses="Drug"/>
					<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Frequency</th>
				<td>
					<spring:bind path="frequency">
					
					<select name="${status.expression}">
						<c:forEach items="${frequencies}" var="frequency">
				        	<option value="${frequency.orderFrequencyId}" <c:if test="${frequency.orderFrequencyId == status.value}">selected="selected"</c:if>>
				        		${frequency.name}
				        	</option>
				        </c:forEach>
					</select>
					
					<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Dosing Instructions</th>
				<td>
					<spring:bind path="dosingInstructions">
					<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="drug" initialValue="${status.value}" includeClasses="Drug"/>
					<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Administration Instructions</th>
				<td>
					<spring:bind path="administrationInstructions">
					<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="drug" initialValue="${status.value}" includeClasses="Drug"/>
					<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
		</table>	
	</form:form>
</div>

<br/>

<input type="submit" value='<openmrs:message code="general.save" />' /></td>
<c:set var="cancelUrl" value="${pageContext.request.contextPath}/admin" scope="page"></c:set>
<c:if test="${not empty param.patientId}">
	<c:set var="cancelUrl" value="${pageContext.request.contextPath}/patientDashboard.form?patientId=${param.patientId}" />
</c:if>
<input type="button" style="margin-left: 15px" value='<openmrs:message code="general.cancel" />' onclick='javascript:window.location="${cancelUrl}"' />

<%@ include file="/WEB-INF/template/footer.jsp" %>