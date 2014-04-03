package org.openmrs.module.orderentryui.web.controller;

import org.openmrs.DrugOrder;
import org.openmrs.Order;
import org.openmrs.api.context.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DrugOrderFormController {
	
	@RequestMapping(value = "/module/orderentryui/drugOrder", method = RequestMethod.GET)
	public void manage(ModelMap model) {
		
	}
	
	@ModelAttribute("drugOrder")
	public Order getDrugOrder(@RequestParam(value = "drugOrderId", required = false) Integer drugOrderId,
	        @RequestParam(value = "patientId", required = false) Integer patientId, ModelMap model) {
		Order drugOrder = null;
		if (drugOrderId != null)
			drugOrder = Context.getOrderService().getOrder(drugOrderId);
		else {
			drugOrder = new DrugOrder();
			if (patientId != null)
				drugOrder.setPatient(Context.getPatientService().getPatient(patientId));
		}
		return drugOrder;
	}
}
