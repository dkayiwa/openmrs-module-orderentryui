<%@ include file="/WEB-INF/template/include.jsp" %>
<%@ include file="/WEB-INF/template/header.jsp" %>

<h2>
<c:if test="${param.action == 'REVISE'}">
Revise Drug Order
</c:if>
<c:if test="${param.action != 'REVISE'}">
	Write a new Drug Order
</c:if>
</h2>

<c:if test="${drugOrder.patient.patientId != null}">
	<a href="<openmrs:contextPath/>/patientDashboard.form?patientId=${drugOrder.patient.patientId}">
			<openmrs:message code="PatientDashboard.backToPatientDashboard"/>
	</a>
	<br/><br/>
</c:if>

<spring:hasBindErrors name="drugOrder">
    <openmrs_tag:errorNotify errors="${errors}" />
</spring:hasBindErrors>

<b class="boxHeader">Drug Order Details</b>
<div class="box">
	<form:form method="post" action="drugOrder.form" modelAttribute="drugOrder">
	
		<c:if test="${drugOrder.patient.patientId != null}">
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
				<th>Drug</th>
				<td>
					<spring:bind path="drug">
						<openmrs_tag:drugField formFieldName="${status.expression}" initialValue="${status.value}" drugs="${drugs}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
				<td>
					Patient Care Setting
					<form:radiobutton path="careSetting" value="2"/>In Patient
					<form:radiobutton path="careSetting" value="1"/> Out Patient
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
						<input type="text" name="dose" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Dose Units</th>
				<td>
					<spring:bind path="doseUnits">
						<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="doseUnits" initialValue="${status.value}" includeClasses="Units of Measure" />
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Route</th>
				<td>
					<spring:bind path="route">
						<select name="${status.expression}">
							<c:forEach items="${drugRoutes}" var="drugRoute">
					        	<option value="${drugRoute.conceptId}" <c:if test="${drugRoute.conceptId == status.value}">selected="selected"</c:if>>
					        		${drugRoute.name.name}
					        	</option>
					        </c:forEach>
						</select>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Quantity</th>
				<td>
					<spring:bind path="quantity">
						<input type="text" name="quantity" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Quantity Units</th>
				<td>
					<spring:bind path="quantityUnits">
						<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="quantityUnits" initialValue="${status.value}" includeClasses="Units of Measure" />
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Number of Refills</th>
				<td>
					<spring:bind path="numRefills">
						<input type="text" name="numRefills" value="${status.value}"/>
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
				<th>Instructions</th>
				<td>
					<spring:bind path="instructions">
						<input type="text" name="instructions" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Dosing Instructions</th>
				<td>
					<spring:bind path="dosingInstructions">
						<input type="text" name="dosingInstructions" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
		</table>
		
		<br/>

		<input type="submit" value='<openmrs:message code="general.save" />' /></td>
		<c:set var="cancelUrl" value="${pageContext.request.contextPath}/admin" scope="page"></c:set>
		<c:if test="${not empty param.patientId}">
			<c:set var="cancelUrl" value="${pageContext.request.contextPath}/patientDashboard.form?patientId=${param.patientId}" />
		</c:if>
		<input type="button" style="margin-left: 15px" value='<openmrs:message code="general.cancel" />' onclick='javascript:window.location="${cancelUrl}"' />
		
	</form:form>
</div>

<%@ include file="/WEB-INF/template/footer.jsp" %>