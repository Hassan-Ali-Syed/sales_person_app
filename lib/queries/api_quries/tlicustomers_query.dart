import 'package:sales_person_app/services/api/api_constants.dart';

class TlicustomersQuery {
  static String tliCustomersQuery() {
    return """query MyQuery {
      tliCustomers(companyId: "${ApiConstants.POSH_ID}",
      page: 1,
      perPage: 10000,
      orderBy: { column: name, order: ASC })
      {
        message
        status
        success
        value {
          systemId
          name
          no
          address
          address2
        }
      }
    }""";
  }

  static String tliCustomerGetByIdQuery(String no) {
    return """query MyQuery {
        tliCustomers(
          companyId: "${ApiConstants.POSH_ID}"
          page: 1
          perPage: 10
          filter: "no eq '$no'"
        ) {
          message
          status
          success
          value {
            systemId
            no
            primaryContactNo
            tliContact {
              customerNo
              name
              no
              type
            }
            tliShipToAdds {
              code
              customerNo
              address
              address2
            }
          }
        }
      }""";
  }
}
