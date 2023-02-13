import 'package:jd_mobile/domain/entities/chat/last_message_entities.dart';

class RoomChatEntities {
  String? id;
  String? dmToName;
  String? dmToId;
  String? roomType;
  DateTime? createdAt;
  LastMessageEntities? lastMessage;

  RoomChatEntities({
    this.id,
    this.dmToName,
    this.dmToId,
    this.roomType,
    this.createdAt,
    this.lastMessage,
  });
}
