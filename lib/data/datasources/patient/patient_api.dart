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
      "/api/trackedEntityInstances?fields=[*]program=El6a2lnac0D&ou=jp49nCFvI75&filter=x9tchw0swEu:eq:{phoneNumber}")
  Future detailPatientByNrm(@Path('phoneNumber') String phoneNumber);

  @GET(
      "/api/trackedEntityInstances?program=El6a2lnac0D&ou=jp49nCFvI75&filter=xGjeKnsJobT:EQ:{nik}")
  Future detailPatientByNik(@Path('nik') String nik);

  factory PatientApi(Dio dio, {String baseUrl}) = _PatientApi;
}
