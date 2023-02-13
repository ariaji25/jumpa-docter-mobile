import 'package:jd_mobile/domain/entities/chat/base_chat_entities.dart';
import 'package:jd_mobile/domain/entities/chat/room_chat_entities.dart';

class RoomChatEntities extends BaseChatEntities {
  RoomChatEntities({
    page,
    message,
    statusCode,
    this.data,
  }) : super();

  List<RoomChatEntities>? data;
}
