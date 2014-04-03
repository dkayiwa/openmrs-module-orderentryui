package org.openmrs.module.orderentryui.extension.html;

import org.openmrs.module.Extension;
import org.openmrs.module.web.extension.PatientDashboardTabExt;


public class OrdersPatientDashboardTabExt  extends PatientDashboardTabExt{

	public Extension.MEDIA_TYPE getMediaType() {
		return Extension.MEDIA_TYPE.html;
	}
	
	@Override
	public String getTabName() {
		return "orderentryui.patientDashboard.orders";
	}
	
	@Override
	public String getRequiredPrivilege() {
		return "";
	}
	
	@Override
	public String getTabId() {
		return "patientOrders";
	}
	
	@Override
	public String getPortletUrl() {
		return "patientOrders";
	}	
}
