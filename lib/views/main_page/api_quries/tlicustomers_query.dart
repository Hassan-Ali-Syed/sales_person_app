import 'package:sales_person_app/services/api/api_constants.dart';

class TlicustomersQuery {
  static String tliCustomersQuery() {
    return """query MyQuery {
      tliCustomers(companyId: "${ApiConstants.POSH_ID}", page: 1, perPage: 10) {
        message
        status
        success
        value {
          systemId
          name
          no
          address
          address2
          contact
          shipToCode
          tliContact {
            systemId
            address
            address2
            customerNo
            name
            no
          }
          tliShipToAdds {
            systemId
            customerNo
            name
            address
            address2
            contact
          }
        }
      }
    }""";
  }
}
