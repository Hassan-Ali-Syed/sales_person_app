class TliSalesPersons {
  bool? success;
  int? status;
  String? message;
  List<TliSalesPersonsValue> value;

  TliSalesPersons({
    this.success,
    this.status,
    this.message,
    required this.value,
  });

  factory TliSalesPersons.fromJson(Map<String, dynamic> json) =>
      TliSalesPersons(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        value: List<TliSalesPersonsValue>.from(
            json["value"].map((x) => TliSalesPersonsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class TliSalesPersonsValue {
  String? code;
  String? description;

  TliSalesPersonsValue({
    this.code,
    this.description,
  });

  factory TliSalesPersonsValue.fromJson(Map<String, dynamic> json) =>
      TliSalesPersonsValue(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
