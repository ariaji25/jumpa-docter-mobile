

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:dartz/dartz.dart';
import 'package:jd_mobile/data/datasources/payment/payment_api.dart';
import 'package:jd_mobile/data/models/payment/payment_response.dart';
import 'package:jd_mobile/data/models/payment/payment_url_response.dart';
import 'package:jd_mobile/domain/entities/payment/payment_url_enities.dart';
import 'package:jd_mobile/domain/entities/payment/payment_entities.dart';
import 'package:jd_mobile/domain/repositories/payment/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRespository {
  final PaymentApi api;

  PaymentRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, String>> checkPaymentStatus(String bookingId) async {
    try {
      final result = await api.checkPaymentStatus(bookingId);
      return Right(result["data"]["payment_status_code"]);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentUrlEntities>> genratePayment(Map<String, dynamic> data) async {
     try {
      final result = await api.generatePayment(data);
      return Right(PaymentUrlResponse.fromJson(result).data);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, PaymentEntites>> getPaymentMethod() async {
    try {
      final result = await api.getPaymentMethod();
      return Right(PaymentResponse.fromJson(result).data);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }
}
