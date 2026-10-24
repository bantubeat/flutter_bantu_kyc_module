import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/legal_links.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step3_id_card/kyc_step3_id_card_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

String _builder(KycLegalDoc doc, Locale locale) =>
    'https://example.com/${locale.languageCode}/${doc.name}';

KycModule _module({KycLegalUrlBuilder? legalUrlBuilder}) => KycModule(
  floatingMenuBuilder: () => const SizedBox(),
  getAccessToken: () async => null,
  onFinish: (_) {},
  routes: const KycRoutes('/kyc/'),
  legalUrlBuilder: legalUrlBuilder,
);

/// Only binds what the legal links need, not the HTTP clients of [KycModule].
class _LegalOnlyModule extends Module {
  final KycLegalUrlBuilder? legalUrlBuilder;

  _LegalOnlyModule(this.legalUrlBuilder);

  @override
  void binds(i) {
    if (legalUrlBuilder case final builder?) {
      i.addInstance<KycLegalUrlBuilder>(
        builder,
        key: KycModule.legalUrlBuilderKey,
      );
    }
  }
}

Widget _consent() => MaterialApp(
  home: Scaffold(
    body: KycIdConsentCheckbox(isChecked: false, onChanged: (_) {}),
  ),
);

/// The [TextSpan] displaying [text], if any.
TextSpan? _spanWithText(WidgetTester tester, String text) {
  TextSpan? found;
  for (final richText in tester.widgetList<RichText>(find.byType(RichText))) {
    richText.text.visitChildren((span) {
      if (span is TextSpan && span.text == text) found = span;
      return found == null;
    });
  }
  return found;
}

void main() {
  tearDown(Modular.destroy);

  test('KycModule keeps the legal URL builder of the host app', () {
    final module = _module(legalUrlBuilder: _builder);

    expect(
      module.legalUrlBuilder!(KycLegalDoc.privacy, const Locale('fr')),
      'https://example.com/fr/privacy',
    );
  });

  testWidgets('privacy link is displayed when a builder is provided', (
    tester,
  ) async {
    Modular.bindModule(_LegalOnlyModule(_builder));
    expect(LegalLinks.isAvailable, isTrue);

    await tester.pumpWidget(_consent());

    expect(
      find.textContaining(
        LocaleKeys.kyc_module_step3_warning,
        findRichText: true,
      ),
      findsOneWidget,
    );
    final link = _spanWithText(
      tester,
      LocaleKeys.kyc_module_step3_warning_privacy_link,
    );
    expect(link, isNotNull);
    expect(link!.recognizer, isNotNull);
    expect(
      _spanWithText(tester, LocaleKeys.kyc_module_step3_warning_privacy_intro),
      isNotNull,
    );
  });

  testWidgets('privacy sentence is hidden when no builder is provided', (
    tester,
  ) async {
    Modular.bindModule(_LegalOnlyModule(null));
    expect(LegalLinks.isAvailable, isFalse);

    await tester.pumpWidget(_consent());

    expect(
      find.textContaining(
        LocaleKeys.kyc_module_step3_warning,
        findRichText: true,
      ),
      findsOneWidget,
    );
    // The whole sentence holding the link is hidden, not only the link.
    for (final key in [
      LocaleKeys.kyc_module_step3_warning_privacy_intro,
      LocaleKeys.kyc_module_step3_warning_privacy_link,
      LocaleKeys.kyc_module_step3_warning_privacy_end,
    ]) {
      expect(_spanWithText(tester, key), isNull);
    }
  });
}
