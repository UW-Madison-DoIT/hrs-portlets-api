package edu.wisc.hrs.dao.absbal;

import org.springframework.beans.factory.annotation.Autowired;

public class SoapAbsenceBalanceDaoFactory{
    @Autowired
    private SoapAbsenceBalanceDao soapAbsenceBalanceDao;

    public SoapAbsenceBalanceDao getSoapAbsenceBalanceDao(){
        return this.soapAbsenceBalanceDao;
    }
    public void setSoapAbsenceBalanceDao(SoapAbsenceBalanceDao soapAbsenceBalanceDao){
        this.soapAbsenceBalanceDao = soapAbsenceBalanceDao;
    }
}