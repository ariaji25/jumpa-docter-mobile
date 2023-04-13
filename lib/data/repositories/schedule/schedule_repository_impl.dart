import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jd_mobile/common/helpers/date_helper.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/data/models/patient/enrollment_model.dart';
import 'package:jd_mobile/domain/repositories/schedule/schedule_repository.dart';

import '../../../domain/entities/patient/event_entities.dart';
import '../../datasources/schedule/schedule_api.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleApi api;

  ScheduleRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, List<EventEntities>>> getHistoryEnrollments(
      String patientId) async {
    try {
      final result = await api.getHistoryEnrollments(patientId);
      return Right(EnrollmentModel.fromJson(result).events ?? []);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, List<EventEntities>>> getEnrollments(
      String patientId) async {
    try {
      String currentDate =
          DateHelper.changeFormatIdToDateTimeFormat(date: DateTime.now())!;
      final result = await api.getEnrollments(patientId, currentDate);
      return Right((EnrollmentModel.fromJson(result)).events ?? []);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, List<EventEntities>>> getDetailEnrollment(
      String data) async {
    try {
      final result = await api.getDetailEnrollment(data);
      return Right((EnrollmentModel.fromJson(result)).events ?? []);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }
}
