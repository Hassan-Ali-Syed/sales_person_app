import 'package:sales_person_app/services/api/api_constants.dart';

class TliGenBusPostGrpsQuery {
  static String tliGenBusPostGrpsQuery() {
    return """tliGenBusPostGrps(
    companyId: "${ApiConstants.POSH_ID}"
    page: 1
    perPage: 10000
  ) {
    success
    status
    message
    value {
      code
    }
  }""";
  }
}
