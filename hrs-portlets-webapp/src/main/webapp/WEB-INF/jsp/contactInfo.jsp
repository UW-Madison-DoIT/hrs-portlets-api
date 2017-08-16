<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ include file="/WEB-INF/jsp/include.jsp"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>

<div id="${n}dl-contact-info" class="dl-contact-info">
  <div class="dl-banner-links">
    <div class="dl-help-link">
      <a href="${helpUrl}" target="_blank">Help</a>
    </div>
  </div>
  <hrs:notification/>
  <div class="contact-info-name">${fn:escapeXml(contactInformation.name)}</div>
  <div class="contact-info-job">
    <div class="contact-info-dept">
      <span class="label"><spring:message code="departmentLabel"/></span>
      <span> ${fn:escapeXml(contactInformation.primaryJob.departmentName)}</span>
    </div>
    <div class="contact-info-title">
      <span class="label"><spring:message code="titleLabel"/></span>
      <span> ${fn:escapeXml(contactInformation.primaryJob.title)}</span>
    </div>
  </div>
  <c:forEach var="otherJob" items="${contactInformation.jobs}">
    <c:if test="${contactInformation.primaryJob != otherJob}">
	    <div class="contact-info-other-job">
	      <div class="contact-info-dept">
	        <span class="label"><spring:message code="otherDepartmentLabel"/></span>
	        <span> ${fn:escapeXml(otherJob.departmentName)}</span>
	      </div>
	      <div class="contact-info-title">
	        <span class="label"><spring:message code="titleLabel"/></span>
	        <span> ${fn:escapeXml(otherJob.title)}</span>
	      </div>
	    </div>
    </c:if>
  </c:forEach>
  <hrs:addressOut messagePrefix="office" address="${contactInformation.officeAddress}" />
  <c:if test="${not empty contactInformation.officeAddress.otherPhone}">
    <div class="contact-info-phone">
      <span class="label"><spring:message code="otherPhoneLabel" /></span>
      <span> ${fn:escapeXml(contactInformation.officeAddress.otherPhone)}</span>
    </div>
  </c:if>
  <div class="business-email-details">
    <span class="label">Campus Business Email: </span>
    <!-- TODO switch to spring-sec role check? -->
    <span class="email-address">${fn:escapeXml(contactInformation.email)}</span>
    <c:if test="${showBusinessEmail and not empty preferredEmail.name}">
      <a href="javascript:;" class="change-business-email"> Change</a>
      <span class="email-error"></span>
    </c:if>
  </div>
  <%-- 
    showBusinessEmail=${showBusinessEmail}
    not empty preferredEmail.name=${not empty preferredEmail.name}
    not ut:equalsIgnoreCase(preferredEmail.email, contactInformation.email)=${not ut:equalsIgnoreCase(preferredEmail.email, contactInformation.email)}
    not empty preferredEmail.email=${not empty preferredEmail.email}
   --%>
  <c:set var="hideChangePending" value='style="display:none"' />
  <c:if test="${showBusinessEmail and not empty preferredEmail.name and not empty preferredEmail.email and not ut:equalsIgnoreCase(preferredEmail.email, contactInformation.email)}">
    <c:set var="hideChangePending" value='' />
  </c:if>
  <div class="business-email-change-pending" ${hideChangePending}>
    <span class="dl-label">Pending Change To: </span><span class="${n}business-email-address">${fn:escapeXml(preferredEmail.email)}</span>
  </div>
  <hrs:addressOut messagePrefix="home" address="${contactInformation.homeAddress}" />
  <div class="home-addr-release">
    <span class="label"><spring:message code="releaseHomeAddress"/></span>
    <c:choose>
      <c:when test="${contactInformation.homeAddress.releaseHomeAddress}">
        <span> <spring:message code="yes"/></span>
      </c:when>
      <c:otherwise>
        <span> <spring:message code="no"/></span>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="dl-contact-info-update">
    <a href="${hrsUrls['Personal Information']}" target="_blank"><spring:message code="updateInfoLink"/></a>
    <br/>
    Click to update Home Address, Phone, Release Home Address Release Information, Emergency Contacts, Marital Status and
    Coordination of Benefits.<br/><br/><b>Please contact your Payroll Office to update Business/Office Address.</b>
  </div>
  
  <div class="change-business-email-dialog" title="Change Campus Business Email">
    <div>
      Email address used for official campus communications, for the directory,and other authorized uses.
    </div>
    <form action="javascript:;" novalidate>
      <div>
        
      </div>
      <fieldset>
        <table>
          <tbody>
            <tr>
              <th class="dl-email-update-label">Current Campus Business Email:</th>
              <td class="${n}business-email-address">${fn:escapeXml(contactInformation.email)}</td>
            </tr>
            <tr>
              <th class="dl-email-update-label"><label class="label" for="email1">New Campus Business Email:</label></th>
              <td><input type="email" name="email1" required="required" /></td>
            </tr>
            <tr>
              <th class="dl-email-update-label"><label class="label" for="email2">Confirm Campus Business Email:</label></th>
              <td><input type="email" name="email2" required="required" /></td>
            </tr>
          </tbody>
        </table>
        <div>
          <input type="submit" value="Update"/> <input type="reset" value="Cancel"/>
        </div>
      </fieldset>
    </form>
  </div>
</div>

<c:if test="${showBusinessEmail}">

<portlet:resourceURL var="businessEmailAddressUrl" id="businessEmailAddress" escapeXml="false"/>

<script type="text/javascript" language="javascript">
<rs:compressJs>
(function($) {
    $(function() {
        var validatorConfig = {
            errorClass: 'dl-invalid-field',
            messageClass: 'dl-validator-error'
        };
        
        var form = $("#${n}dl-contact-info .change-business-email-dialog form").validator(validatorConfig);
        var validator = form.data("validator");
        

        
        var closeDialog = function(changeEmailDialog) {
            changeEmailDialog.data("closing", true);
            changeEmailDialog.dialog('close');
            form[0].reset();
        };
        
        var dialogCloseHandler = function(changeEmailDialog) {
            var email1 = form.find("input[name='email1']").val();
            var email2 = form.find("input[name='email2']").val();
            
            if ((email1 != undefined && email1 != "") || (email2 != undefined && email2 != "")) {
                var close = confirm("Close the Change Business Email Addres box?");
                if (!close) {
                    return false;
                }
            }
            
            closeDialog(changeEmailDialog);
        };
        
        var dialogSubmitHandler = function(e, changeEmailDialog) {
            //Always cancel the actual submit
            e.preventDefault();
            
            validator.checkValidity();

            var email1 = form.find("input[name='email1']").val();
            var email2 = form.find("input[name='email2']").val();
            
            $.log("Update email: " + email1 + " " + email2);
            
            if (email1 != email2) {
                validator.invalidate({
                    email2: "Email addresses must match"
                });
            }
            else if (email1 == undefined || $.trim(email1) == "") {
                validator.invalidate({
                    email1: "An email address must be provided"
                });
            }
            else {
                closeDialog(changeEmailDialog);
                
                var changeEmailLink = $("#${n}dl-contact-info .change-business-email");
                changeEmailLink.mask("Updating ...");
                $.ajax({
                    type: 'POST',
                    url: "${businessEmailAddressUrl}",
                    data: {
                        email: email1
                    },
                    dataType: "json",
                    success: function(data) {
                        changeEmailLink.unmask();
                        var businessEmail = $(".${n}business-email-address");
                        businessEmail.text(data.email);
                        $("#${n}dl-contact-info .business-email-details .email-error").text("");
                        $("#${n}dl-contact-info .business-email-change-pending").show();
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        changeEmailLink.unmask();
                        $("#${n}dl-contact-info .business-email-details .email-error").text("Failed to update email address");
                    }
                });
            }
        };
        
        
        var dialogParent = $("#${n}dl-contact-info");
        var changeEmailDialog = $("#${n}dl-contact-info .change-business-email-dialog").dialog({
            autoOpen: false,
            draggable: false,
            modal: true,
            resizable: false,
            position: {
                my: 'center',
                at: 'center',
                of: dialogParent
            },
            width: dialogParent.width(),
            beforeClose: function(e, ui) {
                var changeEmailDialog = $(e.target);
                
                var closing = changeEmailDialog.data("closing");
                if (!closing) {
                    dialogCloseHandler(changeEmailDialog);
                }
                changeEmailDialog.data("closing", false);
                changeEmailDialog.data("closed", true);
            },
            open: function(e) {
                $(e.target).data("closed", false);
            }
        });
        
        form.bind("reset", function(e) {
            var closing = changeEmailDialog.data("closing");
            var closed = changeEmailDialog.data("closed");
            if (!closing && !closed) {
                dialogCloseHandler(changeEmailDialog);
            }
        });
        
        form.submit(function(e) {
            dialogSubmitHandler(e, changeEmailDialog);
        });
        
        $("#${n}dl-contact-info .business-email-details a.change-business-email").click(function() {
            changeEmailDialog.dialog('open');
        });
    });    
})(dl_v1.jQuery);
</rs:compressJs>
</script>
</c:if>