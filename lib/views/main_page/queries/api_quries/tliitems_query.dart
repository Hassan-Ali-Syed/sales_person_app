import 'package:sales_person_app/services/api/api_constants.dart';

class TliItemsQuery {
  static String tliItemsQuery(String no) {
    return """ query MyQuery {
        tliItems(
          companyId: "${ApiConstants.POSH_ID}"
          page: 1
          perPage: 10
          filter: "no eq '$no'"
          ) {
          value {
            description
            systemId
            unitPrice
            no
          }
        }
      }""";
  }
}
