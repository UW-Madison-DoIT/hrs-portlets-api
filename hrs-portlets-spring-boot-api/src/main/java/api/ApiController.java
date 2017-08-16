package api;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.wisc.hrs.dao.absbal.SoapAbsenceBalanceDaoFactory;
//import edu.wisc.portlet.hrs.web.timeabs.AbsenceBalanceDataController;
import edu.wisc.web.security.portlet.primaryattr.PrimaryAttributeUtils;

@RestController
public class ApiController {

    @Autowired
    private SoapAbsenceBalanceDaoFactory soapAbsenceBalanceDaoFactory;

    public void setSoapAbsenceBalanceDaoFactory(SoapAbsenceBalanceDaoFactory soapAbsenceBalanceDaoFactory){
        this.soapAbsenceBalanceDaoFactory = soapAbsenceBalanceDaoFactory;
    }
    
    @RequestMapping("/AbsenceBalance")
    public String getAbsBal() {
        SoapAbsenceBalanceDao soapAbsenceBalanceDao = soapAbsenceBalanceDaoFactorygetSoapAbsenceBalanceDao();
        final String emplid = PrimaryAttributeUtils.getPrimaryId();
       // AbsenceBalanceDataController absenceBalanceDataController = new AbsenceBalanceDataController();

        return emplid;
    } 

    @RequestMapping("/")
    public String index() {
        return "Greetings from Spring Boot!";
    }

//    private JsonObject getAbsenceBalance(List<AbsenceBalance> absenceBalances){
//        JsonBuilderFactory factory = Json.createBuilderFactory(null);
//        JsonArrayBuilder builder = factory.createArrayBuilder();

//        for(AbsenceBalance balance:absenceBalances){
//             builder.add(factory.createObjectBuilder().
//             add("Entitlement", balance.getEntitlement())
//                     .add("Balance", balance.getBalance())
//                     .add("Title", balance.getTitle())
//                     .build());
//        }

//        return builder.build();
//    }
    
}
