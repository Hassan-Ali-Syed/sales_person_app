import 'package:sales_person_app/services/api/api_constants.dart';

class TlicontactMutate {
  static String tliContactMutate(String name, String no, String customerNo,
      String address, String email, String phoneNo) {
    return """
    mutation createtliContact {  
      createtliContact(
        companyId: "${ApiConstants.POSH_ID}"
        requestData: {
          name: "$name"
          no: "$no"
          customerNo: "$customerNo"
          address: "$address"
          eMail: "$email"
          phoneNo: "$phoneNo"
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
