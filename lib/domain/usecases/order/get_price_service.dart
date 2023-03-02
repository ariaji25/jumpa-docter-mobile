import 'package:dartz/dartz.dart';
import 'package:jd_mobile/common/utils/fialure.dart';
import 'package:jd_mobile/domain/entities/booking/service_price_entities.dart';
import 'package:jd_mobile/domain/repositories/order/order_repository.dart';
import 'package:jd_mobile/domain/usecases/use_case.dart';

class GetPriceService extends UseCase<Either<Failure, ServicePriceEntities>,
    Map<String, String>> {
  final OrderRepository repository;

  GetPriceService(this.repository);

  @override
  Future<Either<Failure, ServicePriceEntities>> call(params) =>
      repository.getPriceService(
          params["period"]!, params["dataSet"]!, params["orgUnit"]!);
}
