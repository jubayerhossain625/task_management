// To parse this JSON data, do
//
//     final taskDeleteResponseModel = taskDeleteResponseModelFromJson(jsonString);

import 'dart:convert';

TaskDeleteResponseModel taskDeleteResponseModelFromJson(String str) => TaskDeleteResponseModel.fromJson(json.decode(str));

String taskDeleteResponseModelToJson(TaskDeleteResponseModel data) => json.encode(data.toJson());

class TaskDeleteResponseModel {
  String? status;
  String? message;
  Data? data;

  TaskDeleteResponseModel({
    this.status,
    this.message,
    this.data,
  });

  TaskDeleteResponseModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      TaskDeleteResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory TaskDeleteResponseModel.fromJson(Map<String, dynamic> json) => TaskDeleteResponseModel(
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
  String? title;
  String? description;
  String? creatorEmail;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.id,
    this.title,
    this.description,
    this.creatorEmail,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data copyWith({
    String? id,
    String? title,
    String? description,
    String? creatorEmail,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Data(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        creatorEmail: creatorEmail ?? this.creatorEmail,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    creatorEmail: json["creator_email"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "creator_email": creatorEmail,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
