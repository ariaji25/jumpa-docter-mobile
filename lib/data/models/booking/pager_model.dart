// ignore_for_file: overridden_fields, annotate_overrides, must_be_immutable
import '../../../domain/entities/booking/pager_entities.dart';

class PagerModel extends PagerEntities {
  int? page;
  int? pageCount;
  int? total;
  int? pageSize;

  PagerModel({
    this.page,
    this.pageCount,
    this.total,
    this.pageSize,
  });

  PagerModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageCount = json['pageCount'];
    total = json['total'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['pageCount'] = pageCount;
    data['total'] = total;
    data['pageSize'] = pageSize;
    return data;
  }
}
