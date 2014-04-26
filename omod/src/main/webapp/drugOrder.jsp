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
				<th>Care Setting</th>
				<td>
					<form:radiobutton path="careSetting" id="outpatient" value="1"/> <label for="outpatient">Outpatient</label>
					<form:radiobutton path="careSetting" id="inpatient" value="2"/> <label for="inpatient">Inpatient</label>
				</td>
			</tr>
			<tr>
				<th>Drug</th>
				<td>
					<spring:bind path="drug">
						<openmrs_tag:drugField formFieldName="${status.expression}" initialValue="${status.value}" drugs="${drugs}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th>Instruction Type</th>
				<td>
					<form:radiobutton path="dosingType" id="simpleDosing" value="SIMPLE"/> <label for="simpleDosing">Coded</label>
					<form:radiobutton path="dosingType" id="freeTextDosing" value="FREE_TEXT"/> <label for="freeTextDosing">Free Text</label>
				</td>
			</tr>
			<tr class="simple">
				<th>Dose</th>
				<td>
					<spring:bind path="dose">
						<input type="text" name="dose" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="simple">
				<th>Dose Units</th>
				<td>
					<spring:bind path="doseUnits">
						<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="doseUnits" initialValue="${status.value}" includeClasses="Unit of Measurement" />
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="simple">
				<th>Route</th>
				<td>
					<spring:bind path="route">
						<select name="${status.expression}">
							<option></option>
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
			<tr class="simple">
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
			<tr class="simple">
				<th>As Needed</th>
				<td>
					<form:checkbox path="asNeeded" id="asNeeded" value="0"/>
					<spring:bind path="asNeededCondition">
						<input type="text" name="asNeededCondition" id="asNeededCondition" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="simple">
				<th>Duration</th>
				<td>
					<spring:bind path="duration">
						<input type="text" name="duration" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="simple">
				<th>Duration Units</th>
				<td>
					<spring:bind path="durationUnits">
						<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="durationUnits" initialValue="${status.value}" includeClasses="Unit of Measurement" />
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr>
				<th><span class="simple">Administration </span>Instructions</th>
				<td>
					<spring:bind path="dosingInstructions">
						<input type="text" name="dosingInstructions" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="outpatient">
				<th>Quantity</th>
				<td>
					<spring:bind path="quantity">
						<input type="text" name="quantity" value="${status.value}"/>
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="outpatient">
				<th>Quantity Units</th>
				<td>
					<spring:bind path="quantityUnits">
						<openmrs_tag:conceptField formFieldName="${status.expression}" formFieldId="quantityUnits" initialValue="${status.value}" includeClasses="Unit of Measurement" />
						<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
					</spring:bind>
				</td>
			</tr>
			<tr class="outpatient">
				<th>Number of Refills</th>
				<td>
					<spring:bind path="numRefills">
						<input type="text" name="numRefills" value="${status.value}"/>
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
		<a style="margin-left: 15px" href='javascript:window.location="${cancelUrl}"'><openmrs:message code="general.cancel" /></a>
		
	</form:form>
</div>

<script>
function adjustToCareSetting() {
	if ($j('#outpatient').is(':checked'))
		$j('.outpatient').show();
	else
		$j('.outpatient').hide();
}
function adjustToDosingInstructionType() {
	if ($j('#simpleDosing').is(':checked'))
		$j('.simple').show();
	else
		$j('.simple').hide();
}
function adjustAsNeededCondition() {
	if ($j('#asNeeded').is(':checked'))
		$j('#asNeededCondition').removeAttr('disabled');
	else
		$j('#asNeededCondition').attr('disabled', 'disabled');
}
$j(document).ready(function() {
	$j('#outpatient, #inpatient').change(adjustToCareSetting);
	$j('#simpleDosing, #freeTextDosing').change(adjustToDosingInstructionType)
	$j('#asNeeded').change(adjustAsNeededCondition)
	adjustToCareSetting();
	adjustToDosingInstructionType();
	adjustAsNeededCondition();
})
</script>

<%@ include file="/WEB-INF/template/footer.jsp" %>