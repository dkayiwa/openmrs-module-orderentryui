package org.openmrs.module.orderentryui.web.controller.portlet;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.openmrs.Order;
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

	    model.put("orders", new ArrayList<Order>() /*Context.getOrderService().getOrders(patient, careSetting, null, false)*/);
    }
}
