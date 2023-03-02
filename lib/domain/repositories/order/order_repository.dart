import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/booking/clinic_entities.dart';
import 'package:jd_mobile/domain/entities/booking/doctor_entities.dart';
import 'package:jd_mobile/domain/entities/booking/service_price_entities.dart';

abstract class OrderRepository {
  Future<Either<Failure, DoctorEntities>> getDoctors(
    String organisationUnitsId,
  );

  Future<Either<Failure, ClinicEntities>> getClinics();

  Future<Either<Failure, ClinicEntities>> getClinicsByArea(
    String areaId,
  );

  Future<Either<Failure, ServicePriceEntities>> getPriceService(
      String period, String dataSet, String orgUnit);
}
