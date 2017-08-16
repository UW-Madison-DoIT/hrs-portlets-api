/**
 * Licensed to Jasig under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Jasig licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package edu.wisc.portlet.hrs.web.timeabs;

import javax.portlet.PortletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.wisc.hr.dao.person.ContactInfoDao;
import edu.wisc.hr.dm.person.PersonInformation;
import edu.wisc.web.security.portlet.primaryattr.PrimaryAttributeUtils;
import edu.wisc.portlet.hrs.web.HrsControllerBase;

/**
 * 
 * 
 * @author Eric Dalquist
 */
@Controller
@RequestMapping("VIEW")
public class TimeAbsenceController extends HrsControllerBase {
    private ContactInfoDao contactInfoDao;
    
    @Autowired
    public void setContactInfoDao(ContactInfoDao contactInfoDao) {
        this.contactInfoDao = contactInfoDao;
    }
    
    @RequestMapping
    public String viewContactInfo(ModelMap model, PortletRequest request) {
        final String emplId = PrimaryAttributeUtils.getPrimaryId();
        
        final PersonInformation personalData = this.contactInfoDao.getPersonalData(emplId);
        model.addAttribute("personalData", personalData);
        
        return "timeAbsence";
    }
}
