import 'package:jd_mobile/domain/entities/patient/tracked_entity_instances_entities.dart';

import '../../domain/entities/patient/event_entities.dart';

extension EventExt on EventEntities {
  String getElementValue(key) {
    final element = dataValues?.where((element) => element.dataElement == key);
    return (element?.isNotEmpty ?? false) ? element!.first.value! : "-";
  }
}


extension TrackedEntityInstancesExt on TrackedEntityInstancesEntities {
  String getElementValue(key) {
    final element = attributes?.where((element) => element.attribute == key);
    return (element?.isNotEmpty ?? false) ? element!.first.value! : "-";
  }
}