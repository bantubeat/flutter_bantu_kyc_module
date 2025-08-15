import 'package:flutter/foundation.dart' show protected;

abstract class KycApiKeys {
  @protected
  final bool isProduction;

  const KycApiKeys({required this.isProduction});
}
