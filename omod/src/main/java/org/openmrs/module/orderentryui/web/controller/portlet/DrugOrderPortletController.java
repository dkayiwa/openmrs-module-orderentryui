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

import org.openmrs.DrugOrder;
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
	    OrderType orderType = Context.getOrderService().getOrderTypeByUuid("131168f4-15f5-102d-96e4-000c29c2a5d7");
	    List<DrugOrderModel> drugOrderModels = new ArrayList<DrugOrderModel>();
	    List<Order> orders = Context.getOrderService().getActiveOrders(patient, orderType, null, null);
	    for (Order order : orders) {
	    	drugOrderModels.add(new DrugOrderModel((DrugOrder)order));
	    }
	    model.put("orders", drugOrderModels);
    }
    
    private class DrugOrderModel extends DrugOrder {
    	
    	public DrugOrderModel(DrugOrder drugOrder) {
    		copyHelper(drugOrder);
    		setOrderId(drugOrder.getOrderId());
    	}
    	
    	public String getDrugOrder() {
    		StringBuilder builder = new StringBuilder();
    		builder.append(getDrug().getName());
    		
    		if (getDosingType() == DosingType.FREE_TEXT) {
    			builder.append(" ");
    			builder.append(getDosingInstructions());
    		}
    		else {
	    		if (getDose() != null) {
	    			builder.append(" ");
	    			builder.append(getDose());
	    			builder.append(getDoseUnits());
	    		}
	    		
	    		if (getRoute() != null) {
	    			builder.append(" ");
	    			builder.append(getRoute());
	    		}
	    		
	    		if (getFrequency() != null) {
	    			builder.append(" ");
	    			builder.append(getFrequency());
	    		}
	    		
	    		if (getAsNeeded()) {
	    			builder.append(" ");
	    			builder.append(getPrn());
	    			builder.append(getAsNeededCondition());
	    		}
	    		
	    		if (getDuration() != null) {
	    			builder.append(" ");
	    			builder.append(getDuration());
	    			builder.append(getDurationUnits());
	    		}
	    		
	    		if (getDosingInstructions() != null) {
	    			builder.append(" ");
	    			builder.append(getDosingInstructions());
	    		}
	    		
	    		if (getQuantity() != null) {
	    			builder.append(" ");
	    			builder.append("#");
	    			builder.append(getQuantity());
	    			builder.append(getQuantityUnits());
	    		}
	    		
	    		if (getNumRefills() != null) {
	    			builder.append(" (");
	    			builder.append(getNumRefills());
	    			builder.append(" refills)");
	    		}
    		}
    		
    		return builder.toString();
    	}
    }
}