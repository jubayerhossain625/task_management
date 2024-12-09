// To parse this JSON data, do
//
//     final taskCreateResponseModel = taskCreateResponseModelFromJson(jsonString);

import 'dart:convert';

TaskCreateResponseModel taskCreateResponseModelFromJson(String str) => TaskCreateResponseModel.fromJson(json.decode(str));

String taskCreateResponseModelToJson(TaskCreateResponseModel data) => json.encode(data.toJson());

class TaskCreateResponseModel {
  String? status;
  String? message;
  Data? data;

  TaskCreateResponseModel({
    this.status,
    this.message,
    this.data,
  });

  TaskCreateResponseModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      TaskCreateResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory TaskCreateResponseModel.fromJson(Map<String, dynamic> json) => TaskCreateResponseModel(
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
  String? title;
  String? description;
  String? creatorEmail;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.title,
    this.description,
    this.creatorEmail,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data copyWith({
    String? title,
    String? description,
    String? creatorEmail,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Data(
        title: title ?? this.title,
        description: description ?? this.description,
        creatorEmail: creatorEmail ?? this.creatorEmail,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    description: json["description"],
    creatorEmail: json["creator_email"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "creator_email": creatorEmail,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
