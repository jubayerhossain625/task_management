// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) => RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) => json.encode(data.toJson());

class RegisterResponseModel {
  String? status;
  String? message;
  String? error;

  RegisterResponseModel({
    this.status,
    this.message,
    this.error,
  });

  RegisterResponseModel copyWith({
    String? status,
    String? message,
    String? error,
  }) =>
      RegisterResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        error: error ?? this.error,
      );

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
    status: json["status"],
    message: json["message"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "error": error,
  };
}
