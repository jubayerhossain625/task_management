// To parse this JSON data, do
//
//     final otpVerifyResponseModel = otpVerifyResponseModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyResponseModel otpVerifyResponseModelFromJson(String str) => OtpVerifyResponseModel.fromJson(json.decode(str));

String otpVerifyResponseModelToJson(OtpVerifyResponseModel data) => json.encode(data.toJson());

class OtpVerifyResponseModel {
  String? status;
  String? message;

  OtpVerifyResponseModel({
    this.status,
    this.message,
  });

  OtpVerifyResponseModel copyWith({
    String? status,
    String? message,
  }) =>
      OtpVerifyResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) => OtpVerifyResponseModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
