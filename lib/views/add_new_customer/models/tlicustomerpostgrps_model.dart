class TliCustomerPostGrps {
  bool? success;
  int? status;
  String? message;
  List<TliCustomerPostGrpsValue> value;

  TliCustomerPostGrps({
    this.success,
    this.status,
    this.message,
    required this.value,
  });

  factory TliCustomerPostGrps.fromJson(Map<String, dynamic> json) =>
      TliCustomerPostGrps(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        value: List<TliCustomerPostGrpsValue>.from(
            json["value"].map((x) => TliCustomerPostGrpsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class TliCustomerPostGrpsValue {
  String? code;

  TliCustomerPostGrpsValue({
    this.code,
  });

  factory TliCustomerPostGrpsValue.fromJson(Map<String, dynamic> json) =>
      TliCustomerPostGrpsValue(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
