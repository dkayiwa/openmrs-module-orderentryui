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
							<th>Frequency</th>
							<th>Instructions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${model.orders}" var="order">
				        	<tr>
				        		<td><a href="">Radiology Order</a></td>
				        		<td>${order.frequency}</td>
				        		<td>${order.instructions}</td>
				        		<td><a href="">Revise /</a></td>
				        		<td><a href="">Discontinue</a></td>
				        	</tr>
				        </c:forEach>
					</tbody>
				</table>
			</div>
	</div>
	
</div>