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

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.web.client.ExtendedRestOperations.ProxyResponse;

public class MockProxyResponse implements ProxyResponse {
    private HttpStatus httpStatus;
    private HttpHeaders httpHeaders;
    private final ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
    
    @Override
    public void setHttpStatus(HttpStatus status) {
        this.httpStatus = status;
    }

    @Override
    public void setHttpHeaders(HttpHeaders headers) {
        this.httpHeaders = headers;
    }

    @Override
    public OutputStream getOutputStream() throws IOException {
        return outputStream;
    }
    
    public HttpStatus getHttpStatus() {
        return httpStatus;
    }

    public HttpHeaders getHttpHeaders() {
        return httpHeaders;
    }

    public byte[] getContentAsByteArray() {
        return this.outputStream.toByteArray();
    }
}
