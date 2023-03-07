// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class BookingEntites extends Equatable {
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
  String? enrollment;

  BookingEntites({
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
    this.enrollment,
  });

  @override
  List<Object?> get props => [
        teiReference,
        visitDate,
        visitTime,
        doctorName,
        serviceType,
        service,
        orderType,
        complaint,
        statusPayment,
        statusBooking,
        clinicArea,
        clinicName,
        clinicAddress,
        refNIK,
        refNama,
        status,
        price,
        doctorId,
        enrollment,
      ];
}
