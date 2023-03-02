import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/data/models/booking/booking_model.dart';
import 'package:jd_mobile/data/models/patient/detail_patient_model.dart';
import 'package:jd_mobile/data/models/patient/patient_model.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitites.dart';
import 'package:jd_mobile/domain/entities/booking/organisation_units_entities.dart';
import 'package:jd_mobile/domain/entities/booking/service_price_item_entities.dart';
import 'package:jd_mobile/domain/usecases/order/get_clinics_by_area.dart';
import 'package:jd_mobile/domain/usecases/order/get_doctors.dart';
import 'package:jd_mobile/domain/usecases/order/get_price_service.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nrm.dart';
import 'package:logger/logger.dart';

import '../../../domain/entities/booking/clinic_entities.dart';
import '../../../domain/entities/patient/detail_patient_entities.dart';
import '../../../domain/usecases/order/get_clinics.dart';

class OrderProvider extends ChangeNotifier {
  final DetailPatientByNrm detailPatientByNrm;
  final GetClinics getClinics;
  final GetClinicsByArea getClinicsByArea;
  final GetDoctors getDoctors;
  final GetPriceService getPriceService;

  OrderProvider(
      {required this.detailPatientByNrm,
      required this.getClinics,
      required this.getClinicsByArea,
      required this.getDoctors,
      required this.getPriceService});

  final storage = const FlutterSecureStorage();
  BookingEntites bookingEntities = BookingEntites();
  DetailPatientEntities doctors = DetailPatientEntities();
  ClinicEntities clinics = ClinicEntities();
  ClinicEntities clinicsByArea = ClinicEntities();
  bool loadClinic = false;
  List<OrganisationUnitsEntities> filteredClinics =
      <OrganisationUnitsEntities>[];
  bool newPatientAlreadyExist = false;
  String organisationUnitsId = "";
  int serviceItemSelected = 0;

  // For get price list
  String serviceId = "";
  String orgUnits = "";
  String dataSet = "";
  String price = "";

  // Check NIK Patient
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  RequestState _requestState = RequestState.Empty;
  RequestState _requestDoctorsState = RequestState.Empty;
  RequestState _requestClinicsState = RequestState.Empty;
  RequestState _requestClinicsAreaState = RequestState.Empty;
  RequestState _requestPriceState = RequestState.Empty;

  RequestState get requestState => _requestState;

  RequestState get requestDoctorsState => _requestDoctorsState;

  RequestState get requestClinicsState => _requestClinicsState;

  RequestState get requestClinicsAreaState => _requestClinicsAreaState;

  RequestState get requestPriceState => _requestPriceState;

  void setRequestDoctorsState(RequestState state) {
    _requestDoctorsState = state;
    notifyListeners();
  }

  void setRequestClinicsState(RequestState state) {
    _requestClinicsState = state;
    notifyListeners();
  }

  void setRequestClinicsAreaState(RequestState state) {
    _requestClinicsAreaState = state;
    notifyListeners();
  }

  void setRequestPriceState(RequestState state) {
    _requestPriceState = state;
    notifyListeners();
  }

  void setServiceId(String value) {
    serviceId = value;
    notifyListeners();
  }

  void setOrgUnits(String value) {
    orgUnits = value;
    notifyListeners();
  }

  void setDataSet(String value) {
    dataSet = value;
    notifyListeners();
  }

  void setPrice(String value) {
    price = value;
    notifyListeners();
  }

  void setOrganisationUnitsId(String value) {
    organisationUnitsId = value;
    notifyListeners();
  }

  void setServiceItemSelected(int value) {
    serviceItemSelected = value;
    notifyListeners();
  }

  void updateBooking(BookingEntites bookingEntities) {
    bookingEntities = bookingEntities;
    notifyListeners();
  }

  String? _nikPatient;

  String? get nikPatient => _nikPatient;

  Future<void> checkNikPatient() async {
    _requestState = RequestState.Loading;
    notifyListeners();

    String? phoneNumber = await storage.read(key: AppConst.PHONE_NUMBER_KEY);
    final result = await detailPatientByNrm(phoneNumber ?? "");
    result.fold((l) {
      _requestState = RequestState.Error;
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      final res = DetailPatientModel.fromJson(jsonDecode(r))
          .trackedEntityInstances?[0]
          .attributes;

      final PatientModel dataPatient = PatientModel.fromAttributes(res ?? []);
      _nikPatient = dataPatient.nik;

      _requestState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> getListDoctors(String organisationUnitsId) async {
    setRequestDoctorsState(RequestState.Loading);

    final result = await getDoctors(organisationUnitsId);
    result.fold((l) {
      setRequestDoctorsState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      doctors = r;
      notifyListeners();
      setRequestDoctorsState(RequestState.Loaded);
    });
  }

  Future<void> getListClinics() async {
    setRequestClinicsState(RequestState.Loading);

    final result = await getClinics();
    result.fold((l) {
      setRequestClinicsState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      clinics.organisationUnits?.clear();
      clinics = r;
      notifyListeners();
      setRequestClinicsState(RequestState.Loaded);
    });
  }

  Future<void> getListClinicsByArea(String areaId) async {
    setRequestClinicsAreaState(RequestState.Loading);

    final result = await getClinicsByArea(areaId);
    result.fold((l) {
      setRequestClinicsAreaState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      clinicsByArea.organisationUnits?.clear();
      clinicsByArea = r;
      notifyListeners();
      setRequestClinicsAreaState(RequestState.Loaded);
    });
  }

  Future filterClinicByArea(String area) async {
    filteredClinics.clear();
    if (clinics.organisationUnits != null) {
      final filtered = clinics.organisationUnits
          ?.where((e) => e.description?.toLowerCase() == area.toLowerCase());

      filteredClinics.addAll(filtered!);
    }
  }

  Future<void> getPrice() async {
    setRequestPriceState(RequestState.Loading);

    final result = await getPriceService(
        {"orgUnit": orgUnits, "dataSet": dataSet, "period": "2022"});
    result.fold((l) {
      setRequestPriceState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (res) {
      // Filter Price
      if (dataSet == AppConst.HOME_CARE) {
        // Filter service homecare
        ServicePriceItemEntities priceData = res.dataValues
                ?.where((e) => e.dataElement == serviceId.split("|")[0])
                .toList()
                .first ??
            ServicePriceItemEntities();

        price = priceData.value ?? "";
        notifyListeners();
      } else if (dataSet == AppConst.ONSITE) {
        // Filter service onsite
        ServicePriceItemEntities priceData = res.dataValues
                ?.where((e) => e.dataElement == serviceId.split("|")[1])
                .toList()
                .first ??
            ServicePriceItemEntities();

        price = priceData.value ?? "";
      }
      notifyListeners();
      setRequestPriceState(RequestState.Loaded);
    });
  }

  Future createBooking() async {
    log(bookingEntities.complaint.toString());
    Logger().d(BookingModel.formEntities(bookingEntities).toJson());
  }

  clear() {
    bookingEntities = BookingEntites();
    doctors = DetailPatientEntities();
    clinics = ClinicEntities();
    clinicsByArea = ClinicEntities();
    filteredClinics = <OrganisationUnitsEntities>[];
    newPatientAlreadyExist = false;
    organisationUnitsId = "";
    serviceItemSelected = 0;

    // For get price list
    serviceId = "";
    orgUnits = "";
    dataSet = "";
    price = "";

    // Check NIK Patient
    _errorMessage = "";
    _requestState = RequestState.Empty;
    _requestDoctorsState = RequestState.Empty;
    _requestClinicsState = RequestState.Empty;
    _requestClinicsAreaState = RequestState.Empty;
    _requestPriceState = RequestState.Empty;
  }
}
