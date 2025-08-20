import '../entities/payment_preference_entity.dart';

abstract class BalanceRepository {
  Future<List<PaymentPreferenceEntity>> getPaymentPreferences();
}
