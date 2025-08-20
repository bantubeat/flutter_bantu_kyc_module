import '../../../flutter_bantu_kyc_module.dart';

final class ApiConstants {
  const ApiConstants._();

  static String get serverAddr => KycModule.getIsProduction()
      ? 'https://api-prod.bantubeat.com'
      : 'https://api.dev.bantubeat.com';

  static String get baseUrl => '$serverAddr/api';

  static String get websiteUrl => KycModule.getIsProduction()
      ? 'https://open.bantubeat.com'
      : 'https://test.dev.bantubeat.com';
}
