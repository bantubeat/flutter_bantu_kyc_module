import 'bantu_kyc_localization.dart';

/// Strings extension method for access to [tr()] and [plural()]
/// Example :
/// ```dart
/// 'title'.tr()
/// 'day'.plural(21)
/// ```
extension StringTranslateExtension on String {
  /// {@macro tr}
  String tr({Map<String, String>? namedArgs}) =>
      BantuKycLocalization.tr(this, namedArgs: namedArgs);

  /// {@macro plural}
  String plural(num value, {Map<String, String>? namedArgs}) =>
      BantuKycLocalization.plural(this, value, namedArgs: namedArgs);
}
