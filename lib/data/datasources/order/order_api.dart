import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'order_api.g.dart';

@RestApi()
abstract class OrderApi {
  @GET(
      "/api/trackedEntityInstances?program=zuQhdRo8Rnn&ou={organisationUnitsId}")
  Future getDoctors(@Path('organisationUnitsId') String organisationUnitsId);

  @GET(
      "/api/organisationUnits?fields=all,id,description,displayName,path,address&filter=id:!eq:V7PEJohVXYL&filter=description:!eq:''&level=2")
  Future getClinics();

  @GET(
      "/api/organisationUnits?fields=id,parent,description,displayName,path,level&filter=id:!eq:V7PEJohVXYL&filter=parent.id:eq:{areaId}&paging=false")
  Future getClinicsByArea(@Path('areaId') String areaId);

  @GET(
      "/api/dataValueSets.json?period={period}&dataSet={dataSet}&orgUnit={orgUnit}")
  Future getPriceService(@Path('period') String period,@Path('dataSet') String dataSet,@Path('orgUnit') String orgUnit);

  factory OrderApi(Dio dio, {String baseUrl}) = _OrderApi;
}
