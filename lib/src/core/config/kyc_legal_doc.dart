import 'package:flutter/widgets.dart' show Locale;

/// Legal documents the KYC module may link to.
///
/// The module never hard-codes their addresses: the host application maps each
/// document to an URL through a [KycLegalUrlBuilder].
enum KycLegalDoc {
  /// Privacy policy.
  privacy,
}

/// Builds the URL of a legal [doc] for the given [locale].
typedef KycLegalUrlBuilder = String Function(KycLegalDoc doc, Locale locale);
