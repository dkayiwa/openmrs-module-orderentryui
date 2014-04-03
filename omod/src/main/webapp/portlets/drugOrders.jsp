<%@ include file="/WEB-INF/template/include.jsp" %>

<div id="portletDrugOrders">

	<div id="drugOrdersPortlet">
			&nbsp;<a
				href="<openmrs:contextPath />/module/orderentryui/drugOrder.form?patientId=${model.patient.patientId}"><openmrs:message
					code="orderentryui.add" /></a>
			<br />
			<br />
			<div>
				<table id="drugOrdersTable">
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
					</tbody>
				</table>
			</div>
	</div>
	
</div>