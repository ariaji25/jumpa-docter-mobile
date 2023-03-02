import 'package:jd_mobile/domain/usecases/use_case.dart';

import '../../repositories/order/order_repository.dart';

class GetClinics extends NoParamUseCase {
  final OrderRepository repository;

  GetClinics(this.repository);

  @override
  Future call() => repository.getClinics();
}
