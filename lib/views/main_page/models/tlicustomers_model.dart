import 'package:sales_person_app/views/main_page/models/tlicontacts_model.dart';
import 'package:sales_person_app/views/main_page/models/tlishiptoadds_model.dart';

class TliCustomers {
  String? message;
  int? status;
  bool? success;
  List<CustomerValue> value;

  TliCustomers({
    this.message,
    this.status,
    this.success,
    required this.value,
  });

  // From JSON
  factory TliCustomers.fromJson(Map<String, dynamic> json) {
    return TliCustomers(
      message: json['message'],
      status: json['status'],
      success: json['success'],
      value: List<CustomerValue>.from(
          json['value'].map((x) => CustomerValue.fromJson(x))),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'success': success,
      'value': value.map((v) => v.toJson()).toList(),
    };
  }
}

class CustomerValue {
  String? systemId;
  String? name;
  String? no;
  String? address;
  String? address2;
  String? contact;
  String? shipToCode;
  List<TliContact>? tliContact;
  List<TliShipToAddress>? tliShipToAdds;

  CustomerValue({
    this.systemId,
    this.name,
    this.no,
    this.address,
    this.address2,
    this.contact,
    this.shipToCode,
    this.tliContact,
    this.tliShipToAdds,
  });

  // From JSON
  factory CustomerValue.fromJson(Map<String, dynamic> json) {
    return CustomerValue(
      systemId: json['systemId'],
      name: json['name'],
      no: json['no'],
      address: json['address'],
      address2: json['address2'],
      contact: json['contact'],
      shipToCode: json['shipToCode'],
      tliContact: json['tliContact'] != null
          ? List<TliContact>.from(
              json['tliContact'].map((x) => TliContact.fromJson(x)))
          : null,
      tliShipToAdds: json['tliShipToAdds'] != null
          ? List<TliShipToAddress>.from(
              json['tliShipToAdds'].map((x) => TliShipToAddress.fromJson(x)))
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'systemId': systemId,
      'name': name,
      'no': no,
      'address': address,
      'address2': address2,
      'contact': contact,
      'shipToCode': shipToCode,
      'tliContact': tliContact?.map((v) => v.toJson()).toList(),
      'tliShipToAdds': tliShipToAdds?.map((v) => v.toJson()).toList(),
    };
  }
}




// class TliCustomers {
//   String message;
//   bool success;
//   List<CustomerValue> value;
//   int? status;

//   TliCustomers({
//     required this.message,
//     required this.success,
//     required this.value,
//     required this.status,
//   });

//   // fromJson method to parse JSON into TliCustomers object
//   factory TliCustomers.fromJson(Map<String, dynamic> json) {
//     return TliCustomers(
//       message: json['message'],
//       success: json['success'],
//       value: (json['value'] as List<dynamic>)
//           .map((v) => Value.fromJson(v))
//           .toList(),
//       status: json['status'],
//     );
//   }

//   // toJson method to convert TliCustomers object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'success': success,
//       'value': value.map((v) => v.toJson()).toList(),
//       'status': status,
//     };
//   }
// }

// class Value {
//   String? systemId; // Change to nullable
//   String? name; // Change to nullable
//   String? no; // Change to nullable
//   String? address;
//   String? address2;
//   String? companyId;

//   Value({
//     this.systemId, // Remove required if they can be null
//     this.name,
//     this.no,
//     this.address,
//     this.address2,
//     this.companyId,
//   });

//   factory Value.fromJson(Map<String, dynamic> json) {
//     return Value(
//       systemId: json['systemId'],
//       name: json['name'],
//       no: json['no'],
//       address: json['address'],
//       address2: json['address2'],
//       companyId: json['companyId'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'systemId': systemId,
//       'name': name,
//       'no': no,
//       'address': address,
//       'address2': address2,
//       'companyId': companyId,
//     };
//   }
// }
