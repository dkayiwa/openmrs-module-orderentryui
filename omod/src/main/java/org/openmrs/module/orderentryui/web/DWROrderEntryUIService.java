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
package org.openmrs.module.orderentryui.web;

import java.util.Date;

import org.openmrs.Order;
import org.openmrs.api.context.Context;


public class DWROrderEntryUIService {
	
	public String discontinueOrder(Integer orderId) {
		try {
			Order order = Context.getOrderService().getOrder(orderId);
			Context.getOrderService().discontinueOrder(order, "Some reason", new Date(), order.getOrderer(), order.getEncounter());
		}
		catch (Exception ex) {
			return ex.getMessage();
		}

		return null;
	}
}
