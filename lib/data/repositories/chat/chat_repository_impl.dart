import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/data/datasources/chat/chat_api.dart';
import 'package:jd_mobile/domain/repositories/chat/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final ChatApi api;

  ChatRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, String>> getRooms(Map<String, dynamic> params) async {
    try {
      final result = await api.getRooms(
          params["page"].toString(), params["limit"].toString());
      return Right(jsonEncode(result));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
