import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jd_mobile/common/constants/app_const.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/data/models/booking/enrollment_model.dart';
import 'package:jd_mobile/data/models/patient/detail_patient_model.dart';
import 'package:jd_mobile/data/models/patient/patient_model.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitities.dart';
import 'package:jd_mobile/domain/entities/booking/enrollment_entities.dart';
import 'package:jd_mobile/domain/entities/booking/organisation_units_entities.dart';
import 'package:jd_mobile/domain/entities/booking/service_price_item_entities.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';
import 'package:jd_mobile/domain/usecases/order/create_booking.dart';
import 'package:jd_mobile/domain/usecases/order/get_clinics_by_area.dart';
import 'package:jd_mobile/domain/usecases/order/get_doctors.dart';
import 'package:jd_mobile/domain/usecases/order/get_price_service.dart';
import 'package:jd_mobile/domain/usecases/patient/detail_patient_by_nrm.dart';

import '../../../domain/entities/booking/clinic_entities.dart';
import '../../../domain/entities/patient/detail_patient_entities.dart';
import '../../../domain/usecases/order/create_enrollment.dart';
import '../../../domain/usecases/order/get_clinics.dart';
import '../../../domain/usecases/patient/create_patient.dart';
import '../../../domain/usecases/patient/create_patient_nrm.dart';
import '../../../domain/usecases/patient/detail_patient_by_nik.dart';

class OrderProvider extends ChangeNotifier {
  final DetailPatientByNrm detailPatientByNrm;
  final GetClinics getClinics;
  final GetClinicsByArea getClinicsByArea;
  final GetDoctors getDoctors;
  final GetPriceService getPriceService;
  final CreateBooking createBooking;
  final CreateEnrollment createEnrollment;
  final CreatePatientNrm createPatientNrm;
  final CreatePatient createPatient;
  final DetailPatientByNik detailPatientByNik;

  OrderProvider({
    required this.detailPatientByNrm,
    required this.getClinics,
    required this.getClinicsByArea,
    required this.getDoctors,
    required this.getPriceService,
    required this.createBooking,
    required this.createEnrollment,
    required this.createPatientNrm,
    required this.createPatient,
    required this.detailPatientByNik,
  });

  final storage = const FlutterSecureStorage();
  BookingEntities bookingEntities = BookingEntities();
  PatientEntities patientEntities = PatientEntities();
  EnrollmentEntities enrollmentEntities = EnrollmentEntities();
  DetailPatientEntities doctors = DetailPatientEntities();
  ClinicEntities clinics = ClinicEntities();
  ClinicEntities clinicsByArea = ClinicEntities();
  List<OrganisationUnitsEntities> filteredClinics =
      <OrganisationUnitsEntities>[];
  bool newPatientAlreadyExist = false;
  String organisationUnitsId = "";
  int serviceItemSelected = 0;
  List<DateTime>? dates;
  List<String>? times;
  DateTime? selectedDate;
  String? selectedTime;

  // For get price list
  String serviceId = "";
  String orgUnits = "";
  String dataSet = "";
  String price = "";

  // Check NIK Patient
  String _errorMessage = "";

  // Use phone number as wa number
  bool waNumberEqPhoneNumber = false;

  // Order ID
  String reference = "";

  final TextEditingController complaintCtrl = TextEditingController();
  final TextEditingController nik = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final TextEditingController phoneNumberCtrl = TextEditingController();

  int orderFor = 0;
  int? patientType;
  String search = "";

  String get errorMessage => _errorMessage;

  RequestState _requestState = RequestState.Empty;
  RequestState _requestDoctorsState = RequestState.Empty;
  RequestState _requestClinicsState = RequestState.Empty;
  RequestState _requestClinicsAreaState = RequestState.Empty;
  RequestState _requestPriceState = RequestState.Empty;
  RequestState _makeAppointmentState = RequestState.Empty;
  RequestState _requestCreateEnrollmentState = RequestState.Empty;
  RequestState _requestCreateNewPatientState = RequestState.Empty;
  RequestState _requestLoadPatientState = RequestState.Empty;

  RequestState get requestState => _requestState;

  RequestState get requestDoctorsState => _requestDoctorsState;

  RequestState get requestClinicsState => _requestClinicsState;

  RequestState get requestClinicsAreaState => _requestClinicsAreaState;

  RequestState get requestPriceState => _requestPriceState;

  RequestState get makeAppointmentState => _makeAppointmentState;

  RequestState get requestCreateEnrollmentState =>
      _requestCreateEnrollmentState;

  RequestState get requestCreateNewPatientState =>
      _requestCreateNewPatientState;

  RequestState get requestLoadPatientState => _requestLoadPatientState;

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

  void setMakeAppointmentState(RequestState state) {
    _makeAppointmentState = state;
    notifyListeners();
  }

  void setRequestCreateEnrollmentState(RequestState state) {
    _requestCreateEnrollmentState = state;
    notifyListeners();
  }

  void setRequestCreateNewPatientState(RequestState state) {
    _requestCreateNewPatientState = state;
    notifyListeners();
  }

  void setRequestLoadPatientState(RequestState state) {
    _requestLoadPatientState = state;
    notifyListeners();
  }

  void setServiceId(String value) {
    serviceId = value;
    notifyListeners();
  }

  void setOrgUnits(String value) {
    bookingEntities.orgUnit = value;
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

  void updateBooking(BookingEntities bookingEntities) {
    this.bookingEntities = bookingEntities;
    notifyListeners();
  }

  void setDates(List<DateTime>? value) {
    dates = value;
    notifyListeners();
  }

  void setTimes(List<String>? value) {
    times = value;
    notifyListeners();
  }

  void setSelectedDate(DateTime? value) {
    selectedDate = value;
    notifyListeners();
  }

  void setSelectedTime(String? value) {
    selectedTime = value;
    notifyListeners();
  }

  void setErrorMessage(String value) {
    _errorMessage = value;
    notifyListeners();
  }

  void setOrderFor(int value) {
    orderFor = value;
    notifyListeners();
  }

  void setPatientType(int? value) {
    patientType = value;
    notifyListeners();
  }

  void setWaNumberEqPhoneNumber(bool value) {
    waNumberEqPhoneNumber = value;
    notifyListeners();
  }

  void updatePatient(PatientEntities patientEntities) {
    this.patientEntities = patientEntities;
    notifyListeners();
  }

  void setSearch(String value) {
    search = value;
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
      DetailPatientModel res = DetailPatientModel.fromJson(jsonDecode(r));
      final detailPatient = res.trackedEntityInstances?[0].attributes;

      final PatientModel dataPatient =
          PatientModel.fromAttributes(detailPatient ?? []);
      final teiRef = res.trackedEntityInstances![0].trackedEntityInstance;
      dataPatient.tei = teiRef;
      notifyListeners();
      _nikPatient = dataPatient.nik;
      notifyListeners();

      updatePatient(PatientModel.fromEntities(dataPatient));

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

  Future makeAppointment() async {
    setMakeAppointmentState(RequestState.Loading);
    String teiKey = await storage.read(key: AppConst.TEI_KEY) ?? "";
    bookingEntities.teiReference = teiKey;
    notifyListeners();
    final res = await createBooking(bookingEntities);
    res.fold((l) {
      setMakeAppointmentState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      reference = r;
      setMakeAppointmentState(RequestState.Loaded);
    });
  }

  Future createNewEnrollment() async {
    setRequestCreateEnrollmentState(RequestState.Loading);
    String enrollmentCurrentUserStorage =
        await storage.read(key: AppConst.ENROLLMENT_CURRENT_USER) ?? "";
    List<EnrollmentEntities> listEnrollmentCurrentUser = [];
    if (enrollmentCurrentUserStorage != "") {
      for (Map<String, dynamic> item
          in jsonDecode(enrollmentCurrentUserStorage)) {
        listEnrollmentCurrentUser.add(EnrollmentModel.fromJson(item));
      }
    }
    List<EnrollmentEntities> filteredListEnrollment =
        listEnrollmentCurrentUser.where((item) {
      return item.orgUnit == orgUnits;
    }).toList();
    if (filteredListEnrollment.isNotEmpty) {
      setRequestCreateEnrollmentState(RequestState.Loaded);
      bookingEntities.enrollment = filteredListEnrollment.first.enrollment;
      notifyListeners();
    } else {
      String teiKey = await storage.read(key: AppConst.TEI_KEY) ?? "";
      enrollmentEntities.program = "El6a2lnac0D";
      enrollmentEntities.orgUnit = orgUnits;
      enrollmentEntities.trackedEntityInstance = teiKey;
      enrollmentEntities.trackedEntityType = "MvJlDDrR78m";
      enrollmentEntities.status = "COMPLETED";
      notifyListeners();
      final res = await createEnrollment(enrollmentEntities);
      res.fold((l) {
        setRequestCreateEnrollmentState(RequestState.Error);
        _errorMessage = l.message;
        notifyListeners();
      }, (r) {
        setRequestCreateEnrollmentState(RequestState.Loaded);
        bookingEntities.enrollment = r;
        notifyListeners();
      });
    }
  }

  Future<void> createNRM() async {
    setRequestCreateNewPatientState(RequestState.Loading);

    final result = await createPatientNrm({
      "name": patientEntities.name,
      "orgUnit": "jp49nCFvI75",
    });
    result.fold((l) {
      setRequestCreateNewPatientState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (res) {
      final nrm = jsonDecode(res)["nrm"] ?? "";
      final isExist = jsonDecode(res)["isExist"] ?? false;

      newPatientAlreadyExist = isExist;
      notifyListeners();
      if (!isExist) {
        patientEntities.nrm = nrm;
        notifyListeners();
      }
    });
  }

  Future<void> createNewPatient() async {
    await createNRM();
    setRequestCreateNewPatientState(RequestState.Loading);
    if (patientEntities.nrm != null) {
      final result = await createPatient(patientEntities);
      result.fold((l) {
        setRequestCreateNewPatientState(RequestState.Error);
        _errorMessage = l.message;
        notifyListeners();
      }, (res) {
        patientEntities.tei = res;
        notifyListeners();
        setRequestCreateNewPatientState(RequestState.Loaded);
      });
    }
  }

  Future<void> getPatientByNIK({String? nik}) async {
    setRequestLoadPatientState(RequestState.Loading);
    patientEntities = PatientEntities();
    notifyListeners();

    final result = await detailPatientByNik(nik ?? search);
    result.fold((l) {
      setRequestLoadPatientState(RequestState.Error);
      _errorMessage = l.message;
      notifyListeners();
    }, (r) {
      // Wrap detail patient if any
      final res = DetailPatientModel.fromJson(jsonDecode(r));
      if (res.trackedEntityInstances != null &&
          res.trackedEntityInstances!.isNotEmpty &&
          res.trackedEntityInstances![0].trackedEntityInstance != null) {
        final teiRef = res.trackedEntityInstances![0].trackedEntityInstance;
        final patient = PatientModel.fromAttributes(
          res.trackedEntityInstances![0].attributes ?? [],
        );

        patient.tei = teiRef;
        notifyListeners();
        patientEntities = patient;
        notifyListeners();
      }
      setRequestLoadPatientState(RequestState.Loaded);
    });
  }

  clear() {
    bookingEntities = BookingEntities();
    doctors = DetailPatientEntities();
    clinics = ClinicEntities();
    clinicsByArea = ClinicEntities();
    filteredClinics = <OrganisationUnitsEntities>[];
    newPatientAlreadyExist = false;
    organisationUnitsId = "";
    serviceItemSelected = 0;
    orderFor = 0;
    patientType = null;
    search = "";
    dates = null;
    times = null;
    selectedDate = null;
    selectedTime = null;
    // For get price list
    serviceId = "";
    orgUnits = "";
    dataSet = "";
    price = "";

    // Booking ID
    reference = "";
    complaintCtrl.clear();

    // Check NIK Patient
    _errorMessage = "";
    _requestState = RequestState.Empty;
    _requestDoctorsState = RequestState.Empty;
    _requestClinicsState = RequestState.Empty;
    _requestClinicsAreaState = RequestState.Empty;
    _requestPriceState = RequestState.Empty;
    _requestCreateEnrollmentState = RequestState.Empty;
    _requestLoadPatientState = RequestState.Empty;
    notifyListeners();
  }
}
