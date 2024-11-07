import 'package:sales_person_app/services/api/api_constants.dart';

class CreateCustomerMutation {
  static String createCustomerMutation({
    required String name,
    required String salespersonCode,
    required String address,
    String? address2,
    required String postCode,
    required String city,
    required String county,
    required String countryRegionCode,
    String? phoneNo,
    String? eMail,
    String? homePage,
    required String taxLiable,
    required String taxAreaCode,
    required String genBusPostingGroup,
    required String customerPostingGroup,
    required String customerPriceGroup,
  }) {
    return """
      mutation createCustomer {
      createtliCustomer(
        companyId: "${ApiConstants.POSH_ID}"
        requestData: {
          no: ""
          primaryContactNo: ""
          locationCode: "SYOSSET"
          name: $name
          salespersonCode: $salespersonCode
          address: $address
          address2: $address2
          postCode: $postCode
          city: $city
          county: $county
          countryRegionCode: $countryRegionCode
          phoneNo: $phoneNo
          eMail: $eMail
          homePage: $homePage
          taxLiable: $taxLiable
          taxAreaCode: $taxAreaCode
          genBusPostingGroup: $genBusPostingGroup
          customerPostingGroup: $customerPostingGroup
          customerPriceGroup: $customerPriceGroup
        }
      ) {
        message
        status
        success
        value {
          systemId
          no
          primaryContactNo
          locationCode
          name
          salespersonCode
          address
          address2
          postCode
          city
          county
          countryRegionCode
          phoneNo
          eMail
          homePage
          taxLiable
          taxAreaCode
          genBusPostingGroup
          customerPostingGroup
          customerPriceGroup
        }
      }
    }""";
  }
}
