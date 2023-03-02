import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/booking/doctor_entities.dart';

import '../../../domain/entities/booking/clinic_entities.dart';
import '../../../domain/entities/booking/service_price_entities.dart';
import '../../../domain/repositories/order/order_repository.dart';
import '../../datasources/order/order_api.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderApi api;

  OrderRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, DoctorEntities>> getDoctors(
      String organisationUnitsId) async {
    try {
      final result = await api.getDoctors(organisationUnitsId);
      return Right(result["data"]);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, ClinicEntities>> getClinics() async {
    try {
      final result = await api.getClinics();
      return Right(result['data']);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, ClinicEntities>> getClinicsByArea(
      String areaId) async {
    try {
      final result = await api.getClinicsByArea(areaId);
      return Right(result['data']);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, ServicePriceEntities>> getPriceService(
      String period, String dataSet, String orgUnit) async {
    try {
      final result = await api.getPriceService(period, dataSet, orgUnit);
      return Right(result['data']);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }
}
