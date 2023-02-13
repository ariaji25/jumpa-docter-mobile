import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/data/datasources/patient/patient_api.dart';
import 'package:jd_mobile/domain/entities/patient/patient_entities.dart';

import '../../../domain/repositories/patient/patient_repositorty.dart';
import '../../models/patient/patient_model.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientApi api;

  PatientRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, String>> createPatient(PatientEntities data) async {
    try {
      final result =
          await api.createPatient(PatientModel.fromEntities(data).toJson());
      return Right(result["response"]["importSummaries"][0]["reference"]);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, String>> createPatientNrm(
      Map<String, dynamic> data) async {
    try {
      final result = await api.createPatientNrm(data);
      return Right(result["data"]["nrm"] ?? "");
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updatePatient(
      Map<String, dynamic> data) async {
    try {
      await api.updatePatient(data);
      return const Right("true");
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }

  @override
  Future<Either<Failure, String>> detailPatientByNrm(String phoneNumber) async {
    try {
      final result = await api.detailPatientByNrm(phoneNumber);
      return Right(jsonEncode(result));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? e.message));
    }
  }
}
