import '../entities/payment_preference_entity.dart';
import '../repositories/balance_repository.dart';

class GetPaymentPreferencesUseCase {
  final BalanceRepository _repository;

  const GetPaymentPreferencesUseCase(this._repository);

  Future<List<PaymentPreferenceEntity>> call() async {
    return await _repository.getPaymentPreferences();
  }
}
