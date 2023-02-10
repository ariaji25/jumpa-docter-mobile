import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_api.g.dart';

@RestApi()
abstract class ChatApi {

  @GET("/api/rooms?page={page}&limit={limit}")
  Future getRooms(@Path('page') String page,@Path('limit') String limit);

  factory ChatApi(Dio dio, {String baseUrl}) = _ChatApi;
}
