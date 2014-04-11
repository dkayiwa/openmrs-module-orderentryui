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
package org.openmrs.module.orderentryui.web.controller.portlet;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.CareSetting;
import org.openmrs.Order;
import org.openmrs.OrderType;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.web.controller.PortletController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("**/drugOrders.portlet")
public class DrugOrderPortletController extends PortletController {

	/**
     * @see org.openmrs.web.controller.PortletController#populateModel(javax.servlet.http.HttpServletRequest, java.util.Map)
     */
    @Override
    protected void populateModel(HttpServletRequest request, Map<String, Object> model) {
	    super.populateModel(request, model);
	    
	    Patient patient = (Patient)model.get("patient");
	    OrderType orderType = Context.getOrderService().getOrderTypeByUuid("2ca568f3-a64a-11e3-9aeb-50e549534c5e");
	    List<Order> orders = new ArrayList<Order>();
	    List<CareSetting> careSettings = Context.getOrderService().getCareSettings(false);
	    for (CareSetting careSetting : careSettings) {
	    	orders.addAll(Context.getOrderService().getOrders(patient, careSetting, orderType, false));
	    }
	    model.put("orders", orders);
    }
}
