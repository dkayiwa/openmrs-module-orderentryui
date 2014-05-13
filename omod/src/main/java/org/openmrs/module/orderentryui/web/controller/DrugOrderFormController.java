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
package org.openmrs.module.orderentryui.web.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.CareSetting;
import org.openmrs.DrugOrder;
import org.openmrs.DrugOrder.DosingType;
import org.openmrs.Encounter;
import org.openmrs.Order;
import org.openmrs.Order.Urgency;
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
	public void showForm() {
		
	}
	
	@ModelAttribute("drugOrder")
	public Order getDrugOrder(@RequestParam(value = "orderId", required = false) Integer orderId,
	        @RequestParam(value = "patientId", required = false) Integer patientId, ModelMap model) {
		
		Order drugOrder = null;
		if (orderId != null)
			drugOrder = Context.getOrderService().getOrder(orderId).cloneForRevision();
		else {
			drugOrder = new DrugOrder();
			drugOrder.setUrgency(Urgency.ROUTINE);
			drugOrder.setCareSetting(Context.getOrderService().getCareSetting(1));
			if (patientId != null)
				drugOrder.setPatient(Context.getPatientService().getPatient(patientId));
		}
		
		model.put("frequencies", Context.getOrderService().getOrderFrequencies(true));
		model.put("drugs", Context.getConceptService().getAllDrugs());
		model.put("drugRoutes", Context.getOrderService().getDrugRoutes());
		model.put("doseUnitsOptions", Context.getOrderService().getDrugDosingUnits());
		model.put("durationUnitsOptions", Context.getOrderService().getDrugDurationUnits());
		model.put("quantityUnitsOptions", Context.getOrderService().getDrugDispensingUnits());
		
		return drugOrder;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(OrderFrequency.class, new OrderFrequencyEditor());
		binder.registerCustomEditor(DosingType.class, new DosingTypeEditor());
		binder.registerCustomEditor(CareSetting.class, new CareSettingEditor());
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(method = RequestMethod.POST, value = "/module/orderentryui/drugOrder")
	public String saveDrugOrder(HttpServletRequest request, @ModelAttribute("drugOrder") DrugOrder drugOrder,
	                            BindingResult result) {
		
		if (drugOrder.getOrderer() == null) {
			drugOrder.setOrderer(Context.getProviderService().getAllProviders().get(0));
			drugOrder.setConcept(drugOrder.getDrug().getConcept());
			
			Encounter encounter = new Encounter();
			encounter.setPatient(drugOrder.getPatient());
			encounter.setEncounterDatetime(drugOrder.getStartDate() != null ? drugOrder.getStartDate() : new Date());
			encounter.setEncounterType(Context.getEncounterService().getAllEncounterTypes().get(0));
			Context.getEncounterService().saveEncounter(encounter);
			drugOrder.setEncounter(encounter);
		}
        if(drugOrder.getPreviousOrder() != null){
            drugOrder.setCareSetting(drugOrder.getPreviousOrder().getCareSetting());
            drugOrder.setOrderType(drugOrder.getPreviousOrder().getOrderType());
        }
		
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