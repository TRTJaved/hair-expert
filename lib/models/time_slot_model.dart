import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  Map<String, List<Slot>>? slots;

  TimeSlotModel({
    this.slots,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        slots: Map.from(json["slots"]!).map((k, v) =>
            MapEntry<String, List<Slot>>(
                k, List<Slot>.from(v.map((x) => Slot.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "slots": Map.from(slots!).map((k, v) => MapEntry<String, dynamic>(
            k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
}

class Slot {
  List<int>? userIds;
  DateTime? time;
  List<dynamic>? users;

  Slot({
    this.userIds,
    this.time,
    this.users,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        userIds: json["userIds"] == null
            ? []
            : List<int>.from(json["userIds"]!.map((x) => x)),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        users: json["users"] == null
            ? []
            : List<dynamic>.from(json["users"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userIds":
            userIds == null ? [] : List<dynamic>.from(userIds!.map((x) => x)),
        "time": time?.toIso8601String(),
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x)),
      };
}
