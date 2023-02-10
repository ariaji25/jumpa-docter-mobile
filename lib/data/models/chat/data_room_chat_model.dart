import 'package:jd_mobile/data/models/chat/page_model.dart';
import 'package:jd_mobile/domain/entities/chat/base_chat_entities.dart';
import 'package:jd_mobile/domain/entities/chat/data_room_chat_entities.dart';

class RoomChatModel extends BaseChatEntities {
  RoomChatModel({
    page,
    message,
    statusCode,
    this.data,
  }) : super();

  List<RoomChatEntities>? data;

  factory RoomChatModel.fromJson(Map<String, dynamic> json) => RoomChatModel(
        page: PageModel.fromJson(json['page']),
        message: json["message"],
        statusCode: json["statusCode"],
        data: List<RoomChatEntities>.from(
            json["data"].map((x) => RoomChatModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "message": message,
        "statusCode": statusCode,
        "data": List<dynamic>.from(data ?? [].map((x) => x.toJson())),
      };
}
