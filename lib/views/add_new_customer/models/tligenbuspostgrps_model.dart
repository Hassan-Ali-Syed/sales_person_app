class TliGenBusPostGrps {
  bool? success;
  int? status;
  String? message;
  List<TliGenBusPostGrpsValue> value;

  TliGenBusPostGrps({
    this.success,
    this.status,
    this.message,
    required this.value,
  });

  factory TliGenBusPostGrps.fromJson(Map<String, dynamic> json) =>
      TliGenBusPostGrps(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        value: List<TliGenBusPostGrpsValue>.from(
            json["value"].map((x) => TliGenBusPostGrpsValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class TliGenBusPostGrpsValue {
  String? code;
  String? description;

  TliGenBusPostGrpsValue({
    this.code,
    this.description,
  });

  factory TliGenBusPostGrpsValue.fromJson(Map<String, dynamic> json) =>
      TliGenBusPostGrpsValue(
        code: json["code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "description": description,
      };
}
