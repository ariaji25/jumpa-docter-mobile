import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitities.dart';
import 'package:jd_mobile/domain/repositories/order/order_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class CreateBooking extends UseCase<Either<Failure, String>, BookingEntities> {
  CreateBooking(this.repository);
  final OrderRepository repository;
 
  @override
  Future<Either<Failure, String>> call(BookingEntities params) => repository.createBooking(params);
}