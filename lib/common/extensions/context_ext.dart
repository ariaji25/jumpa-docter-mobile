import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/size.dart';

import '../../domain/entities/patient/event_entities.dart';

extension SizeExtension on BuildContext {
  MediaQueryData get iMediaQuery => MediaQuery.of(this);
  Size get iSize => MediaQuery.of(this).size;

  double get padding0 => SizeConstants.margin / 2;
  double get padding1 => SizeConstants.margin * 1;
  double get padding2 => SizeConstants.margin * 2;
  double get padding3 => SizeConstants.margin * 3;
  double get padding4 => SizeConstants.margin * 4;
  double get padding5 => SizeConstants.margin * 5;
  double get padding6 => SizeConstants.margin * 6;
  double get padding7 => SizeConstants.margin * 7;
  double get padding8 => SizeConstants.margin * 8;
  double get padding9 => SizeConstants.margin * 9;
  double get padding10 => SizeConstants.margin * 10;

  Widget sbHeight({double? size}) {
    return SizedBox(height: size ?? padding2);
  }

  Widget sbWidth({double? size}) {
    return SizedBox(width: size ?? padding2);
  }
}

extension EventExt on EventEntities {
  String getElementValue(key) {
    final element = dataValues?.where((element) => element.dataElement == key);
    return (element?.isNotEmpty ?? false) ? element!.first.value! : "-";
  }
}
