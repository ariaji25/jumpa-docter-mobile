import 'package:flutter/material.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/domain/entities/payment/payment_entities.dart';
import 'package:jd_mobile/domain/usecases/payment/create_payment.dart';
import 'package:jd_mobile/domain/usecases/payment/get_payment_method.dart';
import 'package:jd_mobile/domain/usecases/payment/get_payment_status.dart';

class PaymentProvider extends ChangeNotifier {
  final GetPaymentMethod getPaymentMethod;
  final GetPaymentStatus getPaymentStatus;
  final CreatePayment createPayment;

  PaymentProvider({
    required this.getPaymentMethod,
    required this.getPaymentStatus,
    required this.createPayment,
  });

  String _errMsg = '';
  String get errMsg => _errMsg;

  RequestState _stateGetMethod = RequestState.Empty;
  RequestState get stateGetMethod => _stateGetMethod;

  PaymentEntites? _paymentEntites;
  PaymentEntites? get paymentEntites => _paymentEntites;
  
  Future<void> getPayment() async {
    _stateGetMethod = RequestState.Loading;
    notifyListeners();

    final ress = await getPaymentMethod();
    ress.fold(
    (l) {
      _errMsg = l.message;
      _stateGetMethod = RequestState.Error;
      notifyListeners();
    }, 
    (r) {
      _paymentEntites = r;
      _stateGetMethod = RequestState.Loaded;
      notifyListeners();
    });
  }
}