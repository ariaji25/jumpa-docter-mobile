import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'patient_api.g.dart';

@RestApi()
abstract class PatientApi {
  @POST("/api/trackedEntityInstances")
  Future createPatient(@Body() Map<String, dynamic> data);

  factory PatientApi(Dio dio, {String baseUrl}) = _PatientApi;
}
