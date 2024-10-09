class TliShipToAddress {
  String? systemId;
  String? address;
  String? address2;
  String? customerNo;
  String? name;
  String? code;

  TliShipToAddress({
    this.systemId,
    this.address,
    this.address2,
    this.customerNo,
    this.name,
    this.code,
  });

  // From JSON
  factory TliShipToAddress.fromJson(Map<String, dynamic> json) {
    return TliShipToAddress(
      systemId: json['systemId'],
      address: json['address'],
      address2: json['address2'],
      customerNo: json['customerNo'],
      name: json['name'],
      code: json['code'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'systemId': systemId,
      'address': address,
      'address2': address2,
      'customerNo': customerNo,
      'name': name,
      'code': code,
    };
  }
}
