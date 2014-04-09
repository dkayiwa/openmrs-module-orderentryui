<%@ include file="/WEB-INF/template/include.jsp" %>

<div id="portletLabOrders">

	<div id="labOrdersPortlet">
			&nbsp;<a
				href="<openmrs:contextPath />/module/orderentryui/labOrder.form?patientId=${model.patient.patientId}"><openmrs:message
					code="orderentryui.add" /></a>
			<br />
			<br />
			<div>
				<table id="labOrdersTable">
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
				        		<td><a href="">Lab Order</a></td>
				        		<td>${order.drug.name}</td>
				        		<td>${order.dose}</td>
				        		<td>${order.frequency}</td>
				        		<td>${order.dosingInstructions}</td>
				        		<td><a href="">Revise /</a></td>
				        		<td><a href="">Discontinue</a></td>
				        	</tr>
				        </c:forEach>
					</tbody>
				</table>
			</div>
	</div>
	
</div>