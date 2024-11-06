class TliTaxAreas {
  bool? success;
  int? status;
  String? message;
  List<TliTaxAreasValue> value;

  TliTaxAreas({
    this.success,
    this.status,
    this.message,
    required this.value,
  });

  factory TliTaxAreas.fromJson(Map<String, dynamic> json) => TliTaxAreas(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        value: List<TliTaxAreasValue>.from(
            json["value"].map((x) => TliTaxAreasValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class TliTaxAreasValue {
  String? code;

  TliTaxAreasValue({
    this.code,
  });

  factory TliTaxAreasValue.fromJson(Map<String, dynamic> json) =>
      TliTaxAreasValue(
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
      };
}
