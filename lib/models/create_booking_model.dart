// To parse this JSON data, do
//
//     final createBookingModel = createBookingModelFromJson(jsonString);

import 'dart:convert';

CreateBookingModel createBookingModelFromJson(String str) =>
    CreateBookingModel.fromJson(json.decode(str));

String createBookingModelToJson(CreateBookingModel data) =>
    json.encode(data.toJson());

class CreateBookingModel {
  int? userId;
  String? name;
  String? email;
  String? notes;
  List<dynamic>? guests;
  List<CustomInput>? customInputs;
  DateTime? start;
  DateTime? end;
  int? eventTypeId;
  String? eventTypeSlug;
  String? timeZone;
  String? language;
  String? user;
  String? location;
  Metadata? metadata;
  bool? hasHashedBookingLink;
  dynamic hashedLink;

  CreateBookingModel({
    this.userId,
    this.name,
    this.email,
    this.notes,
    this.guests,
    this.customInputs,
    this.start,
    this.end,
    this.eventTypeId,
    this.eventTypeSlug,
    this.timeZone,
    this.language,
    this.user,
    this.location,
    this.metadata,
    this.hasHashedBookingLink,
    this.hashedLink,
  });

  factory CreateBookingModel.fromJson(Map<String, dynamic> json) =>
      CreateBookingModel(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        notes: json["notes"],
        guests: json["guests"] == null
            ? []
            : List<dynamic>.from(json["guests"]!.map((x) => x)),
        customInputs: json["customInputs"] == null
            ? []
            : List<CustomInput>.from(
                json["customInputs"]!.map((x) => CustomInput.fromJson(x))),
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        eventTypeId: json["eventTypeId"],
        eventTypeSlug: json["eventTypeSlug"],
        timeZone: json["timeZone"],
        language: json["language"],
        user: json["user"],
        location: json["location"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        hasHashedBookingLink: json["hasHashedBookingLink"],
        hashedLink: json["hashedLink"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "notes": notes,
        "guests":
            guests == null ? [] : List<dynamic>.from(guests!.map((x) => x)),
        "customInputs": customInputs == null
            ? []
            : List<dynamic>.from(customInputs!.map((x) => x.toJson())),
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "eventTypeId": eventTypeId,
        "eventTypeSlug": eventTypeSlug,
        "timeZone": timeZone,
        "language": language,
        "user": user,
        "location": location,
        "metadata": metadata?.toJson(),
        "hasHashedBookingLink": hasHashedBookingLink,
        "hashedLink": hashedLink,
      };
}

class CustomInput {
  String? label;
  dynamic value;

  CustomInput({
    this.label,
    this.value,
  });

  factory CustomInput.fromJson(Map<String, dynamic> json) => CustomInput(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
