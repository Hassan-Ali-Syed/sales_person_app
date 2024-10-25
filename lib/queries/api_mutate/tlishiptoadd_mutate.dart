import 'package:sales_person_app/services/api/api_constants.dart';

class TliShipToAddMutate {
  static String tliShipToAddMutate({
    required String customerNo,
    required String name,
    required String address,
    required String address2,
    required String postCode,
    required String city,
    required String countryRegionCode,
    required String county,
    required String code,
    required String phoneNo,
    required String email,
  }) {
    return """
        mutation createShipToAddress {
      createtliShipToAdd(
        companyId: "${ApiConstants.POSH_ID}"
        requestData: {
          customerNo: "$customerNo"
          name: "$name"
          eMail: "$email"
          phoneNo: "$phoneNo"
          code: "$code"
          address: "$address"
          address2: "$address2"
          city: "$city"
          countryRegionCode: "$countryRegionCode"
          county: "$county"
          postCode: "$postCode"
          locationCode: "SYOSSET"
          shipmentMethodCode: ""
          
        }
      ) {
        message
        status
        success
        value {
          companyId
          name
          phoneNo
          eMail
          address
          address2
          addressValidated
          city
          postCode
          countryRegionCode
          county
          contact
          customerPriceGroup
          locationCode
          paymentTermsCode
          shipmentMethodCode
          shippingAccountNo
          shippingAgentCode
          shippingAgentServiceCode
          systemCreatedAt
          systemCreatedBy
          systemModifiedAt
          systemId
          systemModifiedBy
          taxAreaCode
          taxLiable
          upsAccountNo
        }
      }
    }
    """;
  }
}
