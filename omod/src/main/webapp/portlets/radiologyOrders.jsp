<%@ include file="/WEB-INF/template/include.jsp" %>

<div id="portletRadiologyOrders">

	<div id="radiologyOrdersPortlet">
			&nbsp;<a
				href="<openmrs:contextPath />/module/orderentryui/radiologyOrder.form?patientId=${model.patient.patientId}"><openmrs:message
					code="orderentryui.add" /></a>
			<br />
			<br />
			<div>
				<table id="radiologyOrdersTable">
					<thead>
						<tr>
							<th>Order Type</th>
							<th>Medication</th>
							<th>Dose</th>
							<th>Frequency</th>
							<th>Instructions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${model.orders}" var="order">
				        	<tr>
				        		<td>Radiology Order</td>
				        		<td>${order.drug.name}</td>
				        		<td>${order.dose}</td>
				        		<td>${order.frequency}</td>
				        		<td>${order.dosingInstructions}</td>
				        	</tr>
				        </c:forEach>
					</tbody>
				</table>
			</div>
	</div>
	
</div>