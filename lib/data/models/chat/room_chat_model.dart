import 'package:jd_mobile/domain/entities/chat/last_message_entities.dart';

import 'last_message_model.dart';

class RoomChatModel {
  RoomChatModel({
    this.id,
    this.dmToName,
    this.dmToId,
    this.roomType,
    this.createdAt,
    this.lastMessage,
  });

  String? id;
  String? dmToName;
  String? dmToId;
  String? roomType;
  DateTime? createdAt;
  LastMessageModel? lastMessage;

  factory RoomChatModel.fromJson(Map<String, dynamic> json) => RoomChatModel(
        id: json["id"],
        dmToName: json["dmToName"],
        dmToId: json["dmToID"],
        roomType: json["roomType"],
        createdAt: DateTime.parse(json["createdAt"]),
        lastMessage: LastMessageModel.fromJson(json["lastMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dmToName": dmToName,
        "dmToID": dmToId,
        "roomType": roomType,
        "createdAt": createdAt?.toIso8601String(),
        "lastMessage": lastMessage?.toJson(),
      };
}
