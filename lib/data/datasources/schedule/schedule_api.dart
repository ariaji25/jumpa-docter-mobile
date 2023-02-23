import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'schedule_api.g.dart';

@RestApi()
abstract class ScheduleApi {
  @GET(
      "/api/events?trackedEntityInstance={patientId}&order=created:DESC&deleted=false&programStage=Aic2hFz57cE&fields=[*]")
  Future getHistoryEnrollments(@Path('patientId') String patientId);

  @GET(
      "/api/events?trackedEntityInstance={patientId}&filter=Sd9Z8lFBuQB:like:Pelayanan&filter=AfjUIoWVeER:ge:{currentTime}&deleted=false&fields=[event,dataValues]&totalPages=true")
  Future getEnrollments(
    @Path('patientId') String patientId,
    @Path('currentTime') String currentTime,
  );

  factory ScheduleApi(Dio dio, {String baseUrl}) = _ScheduleApi;
}
