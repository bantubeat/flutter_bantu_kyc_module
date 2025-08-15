import 'package:flutter_bantu_kyc_module/src/core/config/kyc_api_keys.dart';
import 'package:flutter_modular/flutter_modular.dart';

final class MyApiKeys {
  const MyApiKeys._();

  static KycApiKeys get _apiKey => Modular.get<KycApiKeys>();
}
