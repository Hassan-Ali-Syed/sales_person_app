class TliCountrys {
  bool? success;
  int? status;
  String? message;
  List<TliCountrysValue> value;

  TliCountrys({
    this.success,
    this.status,
    this.message,
    required this.value,
  });

  factory TliCountrys.fromJson(Map<String, dynamic> json) => TliCountrys(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        value: List<TliCountrysValue>.from(
            json["value"].map((x) => TliCountrysValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class TliCountrysValue {
  String? companyId;
  String? description;
  String? code;

  TliCountrysValue({
    this.companyId,
    this.description,
    this.code,
  });

  factory TliCountrysValue.fromJson(Map<String, dynamic> json) =>
      TliCountrysValue(
        companyId: json["companyId"],
        description: json["description"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "description": description,
        "code": code,
      };
}
