package org.openmrs.module.orderentryui.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.CareSetting.CareSettingType;
import org.openmrs.DrugOrder;
import org.openmrs.Order;
import org.openmrs.api.context.Context;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DrugOrderFormController {
	
	@RequestMapping(value = "/module/orderentryui/drugOrder", method = RequestMethod.GET)
	public void showForm(ModelMap model) {
		model.put("frequencies", Context.getOrderService().getOrderFrequencies(true));
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
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.POST, value = "/module/orderentryui/drugOrder")
	public String saveDrugOrder(HttpServletRequest request, @ModelAttribute("drugOrder") DrugOrder drugOrder, BindingResult result,
	        ModelMap model) {

		Context.getOrderService().saveOrder(drugOrder, null);
		
		return "/module/orderentryui/drugOrderForm";
	}
	
	public class DrugOderModel extends DrugOrder {
		
		private CareSettingType careSettingType;

		public DrugOderModel(DrugOrder order) {
			copyHelper(order);
		}
		
        /**
         * @return the careSettingType
         */
        public CareSettingType getCareSettingType() {
        	return careSettingType;
        }

		
        /**
         * @param careSettingType the careSettingType to set
         */
        public void setCareSettingType(CareSettingType careSettingType) {
        	this.careSettingType = careSettingType;
        }
	}
}
