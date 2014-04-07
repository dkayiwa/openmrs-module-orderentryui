package org.openmrs.module.orderentryui.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.CareSetting;
import org.openmrs.DrugOrder;
import org.openmrs.DrugOrder.DosingType;
import org.openmrs.Order;
import org.openmrs.OrderFrequency;
import org.openmrs.api.APIException;
import org.openmrs.api.context.Context;
import org.openmrs.module.orderentryui.propertyeditor.CareSettingEditor;
import org.openmrs.module.orderentryui.propertyeditor.DosingTypeEditor;
import org.openmrs.module.orderentryui.propertyeditor.OrderFrequencyEditor;
import org.openmrs.validator.DrugOrderValidator;
import org.openmrs.web.WebConstants;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DrugOrderFormController {
	
	@RequestMapping(value = "/module/orderentryui/drugOrder", method = RequestMethod.GET)
	public void showForm(ModelMap model) {
		
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
		
		model.put("frequencies", Context.getOrderService().getOrderFrequencies(true));
		
		return drugOrder;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(OrderFrequency.class, new OrderFrequencyEditor());
		binder.registerCustomEditor(DosingType.class, new DosingTypeEditor());
		//binder.registerCustomEditor(CareSetting.class, new CareSettingEditor());
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.POST, value = "/module/orderentryui/drugOrder")
	public String saveDrugOrder(HttpServletRequest request, @ModelAttribute("drugOrder") DrugOrder drugOrder, BindingResult result,
	        ModelMap model) {

		new DrugOrderValidator().validate(drugOrder, result);
		if (!result.hasErrors()) {
			try {
				Context.getOrderService().saveOrder(drugOrder, null);
				request.getSession().setAttribute(WebConstants.OPENMRS_MSG_ATTR, "DrugOrder.saved");
				
				return "redirect:" + "/patientDashboard.form?patientId=" + drugOrder.getPatient().getPatientId();
			}
			catch (APIException e) {
				request.getSession().setAttribute(WebConstants.OPENMRS_ERROR_ATTR, "DrugOrder.save.error");
			}
		}
		
		return null;
	}
}
