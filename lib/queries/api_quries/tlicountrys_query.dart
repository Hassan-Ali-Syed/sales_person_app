import 'package:sales_person_app/services/api/api_constants.dart';

class TliCountrysQuery {
  static String tliCountrysQuery() {
    return """ query MyQuery {
              tliCountrys( companyId: "${ApiConstants.POSH_ID}"
               page: 1
                perPage: 1000
              ) {
                success
                status
                message
                value {
                  companyId
                  description
                  code
                }
              }
            }""";
  }
}
