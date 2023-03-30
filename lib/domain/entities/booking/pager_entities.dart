// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class PagerEntities extends Equatable {
  int? page;
  int? pageCount;
  int? total;
  int? pageSize;

  PagerEntities({
    this.page,
    this.pageCount,
    this.total,
    this.pageSize,
  });

  @override
  List<Object?> get props => [
        page,
        pageCount,
        total,
        pageSize,
      ];
}
