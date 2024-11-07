import 'package:sales_person_app/services/api/api_constants.dart';

class TliCustomerPostGrpsQuery {
  static String tliCustomerPostGrpsQuery() {
    return """tliCustomerPostGrps(
    companyId: "${ApiConstants.POSH_ID}"
    page: 1
    perPage: 10000
  ) {
    message
    status
    success
    value {
      code
      description
    }
  }""";
  }
}
