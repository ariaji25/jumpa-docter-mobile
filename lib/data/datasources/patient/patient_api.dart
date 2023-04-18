import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'patient_api.g.dart';

@RestApi()
abstract class PatientApi {
  @POST("/api/trackedEntityInstances")
  Future createPatient(@Body() Map<String, dynamic> data);

  @POST("/api/patient/generate/nrm/v2")
  Future createPatientNrm(@Body() Map<String, dynamic> data);

  @POST("/api/trackedEntityInstances")
  Future updatePatient(@Body() Map<String, dynamic> data);

  @GET(
      "/api/trackedEntityInstances?fields=[*]&program=El6a2lnac0D&ou=jp49nCFvI75&filter=x9tchw0swEu:eq:{phoneNumber}&programStatus=COMPLETED&ouMode=CAPTURE&filter=uNqxICAbPaK:eq:true")
  Future detailPatientByNrm(@Path('phoneNumber') String phoneNumber);

  @GET(
      "/api/trackedEntityInstances?program=El6a2lnac0D&ou=jp49nCFvI75&filter=xGjeKnsJobT:EQ:{nik}")
  Future detailPatientByNik(@Path('nik') String nik);

  @GET(
      "/api/trackedEntityInstances/query.json?ou=jp49nCFvI75&ouMode=ACCESSIBLE&program=El6a2lnac0D&attribute=xGjeKnsJobT:LIKE:{nik}")
  Future detailPatientByNikOther(@Path('nik') String nik);

  factory PatientApi(Dio dio, {String baseUrl}) = _PatientApi;
}
