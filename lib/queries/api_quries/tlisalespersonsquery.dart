import 'package:sales_person_app/services/api/api_constants.dart';

class TliSalesPersonsQuery {
  static String tliSalesPersonsQuery() {
    return """tliSalespersons(
        companyId: "${ApiConstants.POSH_ID}"
        page: 1
        perPage: 10000
      ) {
        status
        success
        value {
          code
          description
        }
      }""";
  }
}
