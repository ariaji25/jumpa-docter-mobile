import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/data/datasources/patient/patient_api.dart';
import 'package:jd_mobile/data/models/patient_model.dart';

import 'package:jd_mobile/domain/entities/patient_entities.dart';

import '../../../domain/repositories/patient_repositorty.dart';

class PatientRepositoryImpl extends PatientRepository {
  final PatientApi api;

  PatientRepositoryImpl({required this.api});

  @override
  Future<Either<Failure, PatientEntities>> createPatient(
      PatientEntities model) async {
    try {
      final result =
          await api.createPatient(PatientModel.fromEntities(model).toJson());
      return Right(result);
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the network"));
    } on DioError catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
