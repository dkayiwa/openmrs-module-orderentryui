package org.openmrs.module.orderentryui.web.controller.portlet;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.CareSetting;
import org.openmrs.OrderType;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.web.controller.PortletController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("**/radiologyOrders.portlet")
public class RadiologyOrderPortletController extends PortletController {
	
	/**
     * @see org.openmrs.web.controller.PortletController#populateModel(javax.servlet.http.HttpServletRequest, java.util.Map)
     */
    @Override
    protected void populateModel(HttpServletRequest request, Map<String, Object> model) {
	    super.populateModel(request, model);
	    
	    Patient patient = (Patient)model.get("patient");
	    OrderType orderType = Context.getOrderService().getOrderType(1);
	    CareSetting careSetting = Context.getOrderService().getCareSetting(2);
	    model.put("orders", Context.getOrderService().getOrders(patient, careSetting, orderType, false));
    }
}
