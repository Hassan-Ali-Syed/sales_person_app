class TliContact {
  String? systemId;
  String? address;
  String? address2;
  String? customerNo;
  String? name;
  String? no;
  String? type;

  TliContact(
      {this.systemId,
      this.address,
      this.address2,
      this.customerNo,
      this.name,
      this.no,
      this.type});

  // From JSON
  factory TliContact.fromJson(Map<String, dynamic> json) {
    return TliContact(
        systemId: json['systemId'],
        address: json['address'],
        address2: json['address2'],
        customerNo: json['customerNo'],
        name: json['name'],
        no: json['no'],
        type: json['type']);
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'systemId': systemId,
      'address': address,
      'address2': address2,
      'customerNo': customerNo,
      'name': name,
      'no': no,
      'type': type
    };
  }
}
