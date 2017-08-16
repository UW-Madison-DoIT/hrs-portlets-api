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

package edu.wisc.cypress.dm;

import static org.mockito.Mockito.mock;

import org.springframework.beans.factory.config.AbstractFactoryBean;


/**
 * Factory for creating Mocktio objects as beans.
 * 
 * @author Eric Dalquist
 * @version $Revision: 1.1 $
 */
public class MockitoFactoryBean<T> extends AbstractFactoryBean<T> {
    private final Class<? extends T> type;

    public MockitoFactoryBean(Class<? extends T> type) {
        this.type = type;
    }

    @Override
    public Class<? extends T> getObjectType() {
        return this.type;
    }

    @Override
    protected T createInstance() throws Exception {
        return mock(this.type);
    }

}
