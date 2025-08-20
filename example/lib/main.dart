import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb, kReleaseMode;
import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'widgets/my_bottom_navigation_bar.dart';

// Ben token
const _accessToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBpLmRldi5iYW50dWJlYXQuY29tL2FwaS9hdXRoL3NvY2lhbC9hdXRoZW50aWNhdGUiLCJpYXQiOjE3NDg4NjM5NzUsImV4cCI6MTc1MTI4MzE3NSwibmJmIjoxNzQ4ODYzOTc1LCJqdGkiOiJZR2RIcWNTTTh4ZkhvbkJkIiwic3ViIjoiMGVjZjk1ZjQtMmNlMy00ZGUwLTg4Y2YtMGY4MmU1YTkxMmZkIn0.om9SI9wWcb6XpfHnho5DiR-ABXIPrdwh-QSxF7o2Jdw';

// Production token
//const _accessToken =
//    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBpLXByb2QuYmFudHViZWF0LmNvbS9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTczNTYxOTk5MywiZXhwIjoxNzM4MDM5MTkzLCJuYmYiOjE3MzU2MTk5OTMsImp0aSI6IjhadjVRZXNQQVFFeWRqSlUiLCJzdWIiOiI3ZjkwYzg4MS0zY2QzLTQ0MGUtOTRmOS0zYmVjNDNmZTExZTEifQ.bI5S8GjTCEEkKco3q5aFAOpp35zyPFoEiet7zoB9Qds';

void main() async {
  // await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  if (!kIsWeb) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }

  const isProduction = false;
  runApp(
    ModularApp(
      module: KycModule(
        getAccessToken: () => Future.sync(() => _accessToken),
        floatingMenuBuilder: MyBottomNavigationBar.new,
        routes: KycRoutes(''.toLowerCase()),
        isProduction: isProduction,
        onFinish: (kycVerified) {},
      ),
      child: const AppWidget(),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const supportedLocales = [Locale('fr')];
    return EasyLocalization(
      path: kIsWeb ? 'i18n' : 'assets/i18n',
      saveLocale: false,
      useOnlyLangCode: true,
      useFallbackTranslations: kReleaseMode,
      supportedLocales: supportedLocales,
      fallbackLocale: supportedLocales.first,
      child: Builder(
        builder: (context) => MaterialApp.router(
          onGenerateTitle: (context) => tr('example', context: context),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFF9BF0D),
              primary: const Color(0xFFF9BF0D),
              // seedColor: const Color(0xFFFF9999),
              // primary: const Color(0xFFFF9999),
            ),
            textTheme: const TextTheme(),
          ),
          routerConfig: Modular.routerConfig,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            ...context.localizationDelegates,
            BantuKycLocalization.getDelegate(
              context.locale,
              context.supportedLocales,
            ),
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: BantuKycLocalization.init,
        ),
      ),
    );
  }
}
