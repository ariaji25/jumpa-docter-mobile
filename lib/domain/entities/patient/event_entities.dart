import 'package:jd_mobile/domain/entities/patient/datavalue_entities.dart';
import 'package:jd_mobile/domain/entities/patient/element_entities.dart';
import '../../../data/models/patient/datavalue_model.dart';

class EventEntities extends ElementsEntities {
  List<DataValueEntities>? dataValues;
  String? bookingId;
  String? nrm;
  String? addressPatient;

  EventEntities({this.dataValues,this.nrm,this.addressPatient});

  EventEntities.fromJson(Map<String, dynamic> json) {
    if (json["dataValues"] != null) {
      dataValues = [];
      json["dataValues"].forEach((v) {
        dataValues?.add(DataValueModel.fromJson(v));
      });
    }

    bookingId = json["event"];
    nrm = json["nrm"];
    addressPatient = json["address_patient"];
  }
}
