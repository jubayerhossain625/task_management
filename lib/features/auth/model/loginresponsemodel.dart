// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String? status;
  String? message;
  Data? data;

  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  LoginResponseModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      LoginResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  Data copyWith({
    User? user,
    String? token,
  }) =>
      Data(
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  int? activationCode;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.activationCode,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    int? activationCode,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        address: address ?? this.address,
        activationCode: activationCode ?? this.activationCode,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    address: json["address"],
    activationCode: json["activationCode"],
    isVerified: json["isVerified"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "address": address,
    "activationCode": activationCode,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
