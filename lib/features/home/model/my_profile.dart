// To parse this JSON data, do
//
//     final myProfileResponseModel = myProfileResponseModelFromJson(jsonString);

import 'dart:convert';

MyProfileResponseModel myProfileResponseModelFromJson(String str) => MyProfileResponseModel.fromJson(json.decode(str));

String myProfileResponseModelToJson(MyProfileResponseModel data) => json.encode(data.toJson());

class MyProfileResponseModel {
  String? status;
  String? message;
  Data? data;

  MyProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  MyProfileResponseModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      MyProfileResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory MyProfileResponseModel.fromJson(Map<String, dynamic> json) => MyProfileResponseModel(
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
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? address;
  int? activationCode;
  bool? isVerified;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.address,
    this.activationCode,
    this.isVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? address,
    int? activationCode,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Data(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        address: address ?? this.address,
        activationCode: activationCode ?? this.activationCode,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
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
    "password": password,
    "address": address,
    "activationCode": activationCode,
    "isVerified": isVerified,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
