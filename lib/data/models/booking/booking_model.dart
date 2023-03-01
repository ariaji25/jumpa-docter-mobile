// ignore_for_file: overridden_fields, annotate_overrides

import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitites.dart';

class BookingModel extends BookingEntites {
  String? teiReference;
  String? visitDate;
  String? visitTime;
  String? doctorName;
  String? serviceType;
  String? service;
  String? orderType;
  String? complaint;
  String? statusPayment;
  String? statusBooking;
  String? clinicArea;
  String? clinicName;
  String? clinicAddress;
  String? refNIK;
  String? refNama;
  String? status;
  String? price;
  String? doctorId;

  BookingModel({
    this.teiReference,
    this.visitDate,
    this.visitTime,
    this.doctorName,
    this.serviceType,
    this.service,
    this.orderType,
    this.complaint,
    this.statusPayment,
    this.statusBooking,
    this.clinicArea,
    this.clinicName,
    this.clinicAddress,
    this.refNIK,
    this.refNama,
    this.status,
    this.price,
    this.doctorId,
  });

  factory BookingModel.formEntities(BookingEntites d) {
    return BookingModel(
      teiReference: d.teiReference,
      visitDate: d.visitDate,
      visitTime: d.visitTime,
      doctorName: d.doctorName,
      serviceType: d.serviceType,
      service: d.service,
      orderType: d.orderType,
      complaint: d.complaint,
      statusPayment: d.statusPayment,
      statusBooking: d.statusBooking,
      clinicArea: d.clinicArea,
      clinicName: d.clinicName,
      clinicAddress: d.clinicAddress,
      refNIK: d.refNIK,
      refNama: d.refNama,
      status: d.status,
      price: d.price,
      doctorId: d.doctorId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dataValues": [
        {"value": service, "dataElement": "o8Yd7t1qNk6"},
        {"value": serviceType, "dataElement": "Sd9Z8lFBuQB"},
        {"value": visitDate, "dataElement": "arxuhT0GhPy"},
        {"value": complaint, "dataElement": "Yh6ylx8D3tO"},
        {"value": orderType, "dataElement": "FebDwik7nQ5"},
        {"value": visitTime, "dataElement": "X7GUfsOErZh"},
        {"value": "Waiting", "dataElement": "a5xBShlsRo8"},
        {"value": "Need verification", "dataElement": "xLeRj3JlXLO"},
        {"value": doctorName, "dataElement": "WeZLKi92kyq"},
        {"value": clinicArea, "dataElement": "lzJQJ35mwDi"},
        {"value": clinicName, "dataElement": "MLMRJAh6nLA"},
        {"value": refNIK, "dataElement": 'GZi3X6d4lqu'},
        {"value": refNama, "dataElement": 'FwdxzpQ8w2I'},
        {"value": price, "dataElement": 'NwHWGOgcihm'},
        {"value": doctorId, "dataElement": 'Mu6xWeUWtWV'},
      ],
      "event": "null",
      "program": "El6a2lnac0D",
      "programStage": "Aic2hFz57cE",
      "orgUnit": "ZxIltg4P06f",
      "trackedEntityInstance": teiReference,
      "status": status ?? "ACTIVE",
      "dueDate": DateHelper.dhis2DateFormat(DateTime.now()),
      "eventDate": DateHelper.dhis2DateFormat(DateTime.now()),
      "completedDate": DateHelper.dhis2DateFormat(DateTime.now())
    };
  }
}
