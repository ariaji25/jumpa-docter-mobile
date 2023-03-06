import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/booking/booking_enitites.dart';
import 'package:jd_mobile/domain/repositories/order/order_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class CreateBooking extends UseCase<Either<Failure, String>, BookingEntites> {
  CreateBooking(this.repository);
  final OrderRepository repository;
 
  @override
  Future<Either<Failure, String>> call(BookingEntites params) => repository.createBooking(params);
}