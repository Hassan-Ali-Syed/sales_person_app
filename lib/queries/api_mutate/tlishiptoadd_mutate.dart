import 'package:sales_person_app/services/api/api_constants.dart';

class TliShipToAddMutate {
  static String tliShipToAddMutate({
    required String customerNo,
    required String companyName,
    required String address,
    required String address2,
    required String postCode,
    required String city,
    required String countryRegionCode,
    required String county,
    required String code,
    required String phoneNo,
    required String email,
    required String contact,
  }) {
    return """
        mutation createShipToAddress {
      createtliShipToAdd(
        companyId: "${ApiConstants.POSH_ID}"
        requestData: {
          code: "$code"
          customerNo: "$customerNo"
          name: "$companyName"
          address: "$address"
          address2: "$address2"
          city: "$city"
          postCode: "$postCode"
          countryRegionCode: "$countryRegionCode"
          county: "$county"
          contact: "$contact"
          phoneNo: "$phoneNo"
          eMail: "$email"
        }
      ) {
        message
        status
        success
        value {
          companyId
          name
          address
          address2
          addressValidated
          city
          postCode
          countryRegionCode
          county
          contact
          phoneNo
          eMail
        }
      }
    }
    """;
  }
}
