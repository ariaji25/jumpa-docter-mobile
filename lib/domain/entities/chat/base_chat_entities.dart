import 'package:jd_mobile/domain/entities/chat/page_entities.dart';

class BaseChatEntities {
  PageEntities? page;
  String? message;
  int? statusCode;

  BaseChatEntities({
    this.page,
    this.message,
    this.statusCode,
  });
}
