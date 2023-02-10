import 'package:jd_mobile/domain/entities/chat/attachment_entities.dart';

class LastMessageEntities {
  String? id;
  String? message;
  String? author;
  List<AttachmentEntities>? attachment;
  String? roomId;
  DateTime? sendAt;

  LastMessageEntities({
    this.id,
    this.message,
    this.author,
    this.attachment,
    this.roomId,
    this.sendAt,
  });
}
