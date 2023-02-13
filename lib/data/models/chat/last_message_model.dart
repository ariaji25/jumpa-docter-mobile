import 'package:jd_mobile/data/models/chat/attachment_model.dart';
import 'package:jd_mobile/domain/entities/chat/attachment_entities.dart';

class LastMessageModel {
  LastMessageModel({
    required this.id,
    required this.message,
    required this.author,
    required this.attachment,
    required this.roomId,
    required this.sendAt,
  });

  String id;
  String message;
  String author;
  List<AttachmentEntities> attachment;
  String roomId;
  DateTime sendAt;

  factory LastMessageModel.fromJson(Map<String, dynamic> json) => LastMessageModel(
    id: json["id"],
    message: json["message"],
    author: json["author"],
    attachment: List<AttachmentEntities>.from(json["attachment"].map((x) => AttachmentModel.fromJson(x))),
    roomId: json["roomId"],
    sendAt: DateTime.parse(json["sendAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "author": author,
    "attachment": List<AttachmentEntities>.from(attachment.map((x) => x.toString())),
    "roomId": roomId,
    "sendAt": sendAt.toIso8601String(),
  };
}