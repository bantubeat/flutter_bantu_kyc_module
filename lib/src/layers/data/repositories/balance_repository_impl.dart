import '../../domain/entities/payment_preference_entity.dart';
import '../../domain/repositories/balance_repository.dart';
import '../data_sources/bantubeat_api_data_source.dart';

class BalanceRepositoryImpl implements BalanceRepository {
  final BantubeatApiDataSource _apiDataSource;

  BalanceRepositoryImpl(this._apiDataSource);

  @override
  Future<List<PaymentPreferenceEntity>> getPaymentPreferences() {
    return _apiDataSource.get$paymentPreferences();
  }
}
