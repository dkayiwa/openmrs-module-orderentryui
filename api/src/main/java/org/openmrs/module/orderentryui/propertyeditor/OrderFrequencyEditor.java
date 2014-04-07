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
package org.openmrs.module.orderentryui.propertyeditor;

import java.beans.PropertyEditorSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.OrderFrequency;
import org.openmrs.api.OrderService;
import org.openmrs.api.context.Context;
import org.springframework.util.StringUtils;


public class OrderFrequencyEditor extends PropertyEditorSupport {
	
	private Log log = LogFactory.getLog(this.getClass());
	
	/**
	 * @should set using id
	 * @should set using uuid
	 * 
	 * @see java.beans.PropertyEditorSupport#setAsText(java.lang.String)
	 */
	public void setAsText(String text) throws IllegalArgumentException {
		OrderService ps = Context.getOrderService();
		if (StringUtils.hasText(text)) {
			try {
				setValue(ps.getOrderFrequency(Integer.valueOf(text)));
			}
			catch (Exception ex) {
				OrderFrequency orderFrequency = ps.getOrderFrequencyByUuid(text);
				setValue(orderFrequency);
				if (orderFrequency == null) {
					log.error("Error setting text: " + text, ex);
					throw new IllegalArgumentException("OrderFrequency not found: " + ex.getMessage());
				}
			}
		} else {
			setValue(null);
		}
	}
	
	/**
	 * @see java.beans.PropertyEditorSupport#getAsText()
	 */
	public String getAsText() {
		OrderFrequency t = (OrderFrequency) getValue();
		if (t == null) {
			return "";
		} else {
			return t.getOrderFrequencyId().toString();
		}
	}
}
