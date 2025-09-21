import '../../domain/entities/payment_preference_entity.dart';
import '../../domain/repositories/balance_repository.dart';
import '../data_sources/kyc_bantubeat_api_data_source.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final KycBantubeatApiDataSource _apiDataSource;

  BalanceRepositoryImpl(this._apiDataSource);

  @override
  Future<List<PaymentPreferenceEntity>> getPaymentPreferences() {
    return _apiDataSource.get$paymentPreferences();
  }
}
