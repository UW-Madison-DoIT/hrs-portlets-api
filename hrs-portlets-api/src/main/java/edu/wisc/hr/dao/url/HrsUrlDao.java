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

package edu.wisc.hr.dao.url;

import java.util.Map;

/**
 * Gets a set of deep-links into the HRS system
 * 
 * @author Eric Dalquist
 * @version $Revision: 1.1 $
 */
public interface HrsUrlDao {



    /**
     * Map from expected keys identifying URLs to Strings representing those URLs.
     * The value Strings should be ready-to-render-to-users URLs, i.e., exactly what you want the hyperlink
     * target URL to be.
     *
     * Expected keys are documented as static fields on this class.
     *
     * @return a non-null Map from out-of-band defined String keys to Strings representing the URL values
     */
    public Map<String, String> getHrsUrls();
}
