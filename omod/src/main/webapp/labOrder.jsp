<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp" %>

<h2>
<c:if test="${param.action == 'REVISE'}">
Revise Lab Order
</c:if>
<c:if test="${param.action != 'REVISE'}">
	Write a new Lab Order
</c:if>
</h2>

<c:if test="${labOrder.patient.patientId != null}">
	<a href="<openmrs:contextPath/>/patientDashboard.form?patientId=${labOrder.patient.patientId}">
			<openmrs:message code="PatientDashboard.backToPatientDashboard"/>
	</a>
	<br/><br/>
</c:if>

<spring:hasBindErrors name="labOrder">
    <openmrs_tag:errorNotify errors="${errors}" />
</spring:hasBindErrors>

<b class="boxHeader">Test Order Details</b>
<div class="box">
	<form:form method="post" action="labOrder.form" modelAttribute="labOrder">
	
		<c:if test="${labOrder.patient.patientId != null}">
			<c:if test="${param.orderId != null}">
				<input type="hidden" name="orderId" value="${param.orderId}"/>
			</c:if>
			<c:if test="${param.patientId != null}">
				<input type="hidden" name="patientId" value="${param.patientId}"/>
			</c:if>
		</c:if>
		<c:if test="${param.action == 'REVISE'}">
			<input type="hidden" name="action" value="${param.action}"/>
		</c:if>
	
		<table class="left-aligned-th" cellpadding="3" cellspacing="3">
			<tr>
				<th>Care Setting</th>
				<td>
					<form:radiobutton id="outpatient" path="careSetting" value="1" /> <label for="outpatient">Outpatient</label>
					<form:radiobutton id="inpatient" path="careSetting" value="2"/> <label for="inpatient">Inpatient</label>
				</td>
			<tr>
				<th>Test</th>
				<td>
					<spring:bind path="concept">
						<openmrs_tag:conceptField formFieldName="${status.expression}" initialValue="${status.value}" />
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
				<td colspan="2">
					<em>Additional detail (include when appropriate)</em>
				</td>
			</tr>
			<tr>
				<th>Clinical History</th>
				<td>
					<spring:bind path="clinicalHistory">
						<input type="text" name="clinicalHistory" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Specimen Source</th>
				<td>
					<spring:bind path="specimenSource">
						<openmrs_tag:conceptField formFieldName="${status.expression}" initialValue="${status.value}" />
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Laterality</th>
				<td>
					<select name="laterality">
						<option value=""></option>
						<option value="LEFT">left</option>
						<option value="RIGHT">right</option>
						<option value="BILATERAL">bilateral</option>
					</select>
				</td>
			</tr>
		</table>
		
		<br/>

		<input type="submit" value='<openmrs:message code="general.save" />' /></td>
		<c:set var="cancelUrl" value="${pageContext.request.contextPath}/admin" scope="page"></c:set>
		<c:if test="${not empty param.patientId}">
			<c:set var="cancelUrl" value="${pageContext.request.contextPath}/patientDashboard.form?patientId=${param.patientId}" />
		</c:if>
		<a style="margin-left: 15px" href='javascript:window.location="${cancelUrl}"'><openmrs:message code="general.cancel" /></a>
		
	</form:form>
</div>

<%@ include file="/WEB-INF/template/footer.jsp" %>