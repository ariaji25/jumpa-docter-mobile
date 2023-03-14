// ignore_for_file: overridden_fields, annotate_overrides

import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import '../../../common/helpers/date_helper.dart';
import '../../../domain/entities/patient/attribute_entities.dart';

class PatientKeys {
  static String name = "HyfzjNVhlzM";
  static String phoneNumber = "NCLBUYYxnWU";
  static String address = "Q3tLvwl4Ttq";
  static String pob = "Qtjs7yonSYc";
  static String dob = "SSsiEz3cVbn";
  static String gender = "TlO4kdMfHqa";
  static String domicilieAddress = "aRHSGgFeOjr";
  static String religion = "k3TvJYe6jBT";
  static String nrm = "kOJUHSrbkBS";
  static String waNumber = "x9tchw0swEu";
  static String nik = "xGjeKnsJobT";
  static String coordinate = "H1ouX506oQO";
}

class PatientModel extends PatientEntities {
  String? nrm;
  String? name;
  String? nik;
  String? domicilieAddress;
  String? address;
  String? pob;
  String? dob;
  String? gender;
  String? religion;
  String? phoneNumber;
  String? waNumber;
  String? tei;
  String? coordinate;

  PatientModel({
    this.nrm,
    this.name,
    this.nik,
    this.domicilieAddress,
    this.address,
    this.pob,
    this.dob,
    this.gender,
    this.religion,
    this.phoneNumber,
    this.waNumber,
    this.tei,
    this.coordinate,
  });

  factory PatientModel.fromEntities(PatientEntities d) {
    return PatientModel(
      nrm: d.nrm,
      name: d.name,
      nik: d.nik,
      domicilieAddress: d.domicilieAddress,
      address: d.address,
      pob: d.pob,
      dob: d.dob,
      gender: d.gender,
      religion: d.religion,
      phoneNumber: d.phoneNumber,
      waNumber: d.waNumber,
      tei: d.tei,
      coordinate: d.coordinate,
    );
  }

  PatientModel.fromAttributes(List<AttributesEntities> attrs) {
    for (var val in attrs) {
      if (val.attribute == PatientKeys.name) {
        name = val.value;
      } else if (val.attribute == PatientKeys.phoneNumber) {
        phoneNumber = val.value;
      } else if (val.attribute == PatientKeys.address) {
        address = val.value;
      } else if (val.attribute == PatientKeys.pob) {
        pob = val.value;
      } else if (val.attribute == PatientKeys.dob) {
        dob = val.value;
      } else if (val.attribute == PatientKeys.gender) {
        gender = val.value;
      } else if (val.attribute == PatientKeys.domicilieAddress) {
        domicilieAddress = val.value;
      } else if (val.attribute == PatientKeys.religion) {
        religion = val.value;
      } else if (val.attribute == PatientKeys.nrm) {
        nrm = val.value;
      } else if (val.attribute == PatientKeys.waNumber) {
        waNumber = val.value;
      } else if (val.attribute == PatientKeys.nik) {
        nik = val.value;
      } else if (val.attribute == PatientKeys.coordinate) {
        coordinate = val.value;
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "trackedEntityType": "MvJlDDrR78m",
      "orgUnit": "jp49nCFvI75",
      "attributes": [
        {"attribute": PatientKeys.name, "value": name},
        {"attribute": PatientKeys.phoneNumber, "value": phoneNumber},
        {"attribute": PatientKeys.address, "value": address},
        {"attribute": PatientKeys.pob, "value": pob},
        {"attribute": PatientKeys.dob, "value": dob},
        {"attribute": PatientKeys.gender, "value": gender},
        {"attribute": PatientKeys.domicilieAddress, "value": domicilieAddress},
        {"attribute": PatientKeys.religion, "value": religion},
        {"attribute": PatientKeys.nrm, "value": nrm},
        {"attribute": PatientKeys.waNumber, "value": waNumber},
        {"attribute": PatientKeys.nik, "value": nik},
        {"attribute": PatientKeys.coordinate, "value": coordinate},
      ],
      "enrollments": [
        {
          "program": "El6a2lnac0D",
          "status": "ACTIVE",
          "orgUnit": "jp49nCFvI75",
          "enrollmentDate": DateHelper.dhis2DateFormat(DateTime.now()),
          "incidentDate": DateHelper.dhis2DateFormat(DateTime.now()),
          "events": [
            {
              "program": "El6a2lnac0D",
              "programStage": "Aic2hFz57cE",
              "orgUnit": "jp49nCFvI75",
              "dueDate": DateHelper.dhis2DateFormat(DateTime.now()),
              "eventDate": DateHelper.dhis2DateFormat(DateTime.now()),
              "status": "ACTIVE"
            }
          ]
        }
      ]
    };
  }

  Map<String, dynamic> toStorage() {
    return {
      "tei": tei,
      "name": name,
      "phoneNumber": phoneNumber,
      "address": address,
      "pob": pob,
      "dob": dob,
      "gender": gender,
      "domicilieAddress": domicilieAddress,
      "religion": religion,
      "nrm": nrm,
      "waNumber": waNumber,
      "nik": nik,
      "coordinate": coordinate,
    };
  }

  PatientModel.fromStorage(Map<String, dynamic> obj) {
    tei = obj["tei"];
    name = obj["name"];
    phoneNumber = obj["phoneNumber"];
    address = obj["address"];
    pob = obj["pob"];
    dob = obj["dob"];
    gender = obj["gender"];
    domicilieAddress = obj["domicilieAddress"];
    religion = obj["religion"];
    nrm = obj["nrm"];
    waNumber = obj["waNumber"];
    nik = obj["nik"];
    coordinate = obj["coordinate"];
  }

  bool get isValid => nrm != null;
}
