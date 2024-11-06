import 'package:sales_person_app/services/api/api_constants.dart';

class TliTaxAreasQuery {
  static String tliTaxAreasQuery() {
    return """tliTaxAreas(
    companyId: "${ApiConstants.POSH_ID}"
    page: 1
    perPage: 10000
  ) {
    message
    status
    success
    value {
      code
    }
  }""";
  }
}
