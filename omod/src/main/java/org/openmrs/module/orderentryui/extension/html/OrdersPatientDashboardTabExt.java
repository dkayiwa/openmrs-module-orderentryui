/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */
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
