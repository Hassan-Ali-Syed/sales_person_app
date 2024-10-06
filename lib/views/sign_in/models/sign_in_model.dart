class SignInModel {
  bool? success;
  Data? data;
  String? msg;

  SignInModel({
    this.success,
    this.data,
    this.msg,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "msg": msg,
      };
}

class Data {
  String? token;
  String? name;
  String? email;
  // bool? azureUser;

  Data({
    this.token,
    this.name,
    this.email,
    // this.azureUser,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
        email: json["email"],
        // azureUser: json["azureUser"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "email": email,
        // "azureUser": azureUser,
      };
}
