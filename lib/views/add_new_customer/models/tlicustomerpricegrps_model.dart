class TliCustomerPriceGrps {
  bool? success;
  int? status;
  String? message;
  List<TliCustomerPriceGrpsValue> value;

  TliCustomerPriceGrps({
    this.success,
    this.status,
    this.message,
    required this.value,
  });

  factory TliCustomerPriceGrps.fromJson(Map<String, dynamic> json) =>
      TliCustomerPriceGrps(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        value: List<TliCustomerPriceGrpsValue>.from(
            json["value"].map((x) => TliCustomerPriceGrpsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class TliCustomerPriceGrpsValue {
  String? code;
  String? description;

  TliCustomerPriceGrpsValue({
    this.code,
    this.description,
  });

  factory TliCustomerPriceGrpsValue.fromJson(Map<String, dynamic> json) =>
      TliCustomerPriceGrpsValue(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
