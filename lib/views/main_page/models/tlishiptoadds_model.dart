class TliShipToAddress {
  String? systemId;
  String? address;
  String? address2;
  String? customerNo;
  String? name;
  String? contact;

  TliShipToAddress({
    this.systemId,
    this.address,
    this.address2,
    this.customerNo,
    this.name,
    this.contact,
  });

  // From JSON
  factory TliShipToAddress.fromJson(Map<String, dynamic> json) {
    return TliShipToAddress(
      systemId: json['systemId'],
      address: json['address'],
      address2: json['address2'],
      customerNo: json['customerNo'],
      name: json['name'],
      contact: json['contact'],
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
      'contact': contact,
    };
  }
}
