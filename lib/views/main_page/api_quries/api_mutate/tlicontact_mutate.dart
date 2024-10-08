import 'package:sales_person_app/services/api/api_constants.dart';

class TlicontactMutate {
  static String tliContactMutate({
    required String name,
    required String customerNo,
    required String address,
    String? email,
    String? phoneNo,
  }) {
    return """
    mutation createtliContact {  
      createtliContact(
        companyId: "${ApiConstants.POSH_ID}"
        requestData: {
          name: "$name"
          no: ""
          customerNo: "$customerNo"
          address: "$address"
          eMail: "$email"
          phoneNo: "$phoneNo"
          type: "Person"
        }
      )
      {
        message
        status
        success
        value{
          address
          companyId
          customerNo
          eMail
          name
          no
          phoneNo
          systemId
          type
        } 
      }
    }
    """;
  }
}
