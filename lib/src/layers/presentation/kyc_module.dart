import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Widget;
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/config/kyc_api_keys.dart';
import '../../core/network/api_constants.dart';
import '../../core/network/my_http/my_http.dart';

import '../../layers/data/data_sources/bantubeat_api_data_source.dart';
import '../../layers/data/repositories/exchange_repository_impl.dart';
import '../../layers/data/repositories/payment_repository_impl.dart';
import '../../layers/data/repositories/user_repository_impl.dart';
import '../../layers/data/repositories/balance_repository_impl.dart';
import '../../layers/data/repositories/public_repository_impl.dart';

import '../../layers/domain/repositories/exchange_repository.dart';
import '../../layers/domain/repositories/balance_repository.dart';
import '../../layers/domain/repositories/payment_repository.dart';
import '../../layers/domain/repositories/public_repository.dart';
import '../../layers/domain/repositories/user_repository.dart';
import '../../layers/domain/use_cases/check_withdrawal_eligibility_use_case.dart';
import '../../layers/domain/use_cases/convert_fiat_currency_use_case.dart';
import '../../layers/domain/use_cases/exchange_bzc_to_fiat_use_case.dart';
import '../../layers/domain/use_cases/get_bzc_currency_converter_use_case.dart';
import '../../layers/domain/use_cases/get_current_user_use_case.dart';
import '../../layers/domain/use_cases/get_exchange_bzc_packs_use_case.dart';
import '../../layers/domain/use_cases/get_payment_preferences_use_case.dart';
import '../../layers/domain/use_cases/get_transactions_history_use_case.dart';
import '../../layers/domain/use_cases/exchange_fiat_to_bzc_use_case.dart';
import '../../layers/domain/use_cases/get_all_currencies_use_case.dart';
import '../../layers/domain/use_cases/get_user_balance_use_case.dart';
import '../../layers/domain/use_cases/make_deposit_direct_payment_use_case.dart';
import '../../layers/domain/use_cases/request_deposit_payment_link_use_case.dart';

import '../../layers/presentation/cubits/current_user_cubit.dart';
import '../../layers/presentation/cubits/user_balance_cubit.dart';
import 'navigation/kyc_routes.dart';

import 'screens/kyc_step1_personal_infos/kyc_step1_personal_infos_screen.dart';
import 'screens/kyc_step2_address/kyc_step2_address_screen.dart';
import 'screens/kyc_step3_id_card/kyc_step3_id_card_screen.dart';
import 'screens/kyc_step4_payment_account/kyc_step4_payment_account_screen.dart';
import 'screens/kyc_step5_and_step6/kyc_selfie_camera_screen.dart';
import 'screens/kyc_step5_and_step6/kyc_selfie_intro_screen.dart';

class KycModule extends Module {
  static const floatingMenuBuilderKey = 'floatingMenuBuilder';
  static const isProductionKey = 'isProduction';

  final Widget Function() floatingMenuBuilder;
  final Future<String?> Function() getAccessToken;
  final KycRoutes _routes;
  final bool isProduction;
  final KycApiKeys kycApiKeys;

  KycModule({
    required this.floatingMenuBuilder,
    required this.getAccessToken,
    required this.kycApiKeys,
    required KycRoutes routes,
    this.isProduction = kReleaseMode,
  }) : _routes = routes;

  MyHttpClient Function() _initMyHttpClient({required bool withCache}) {
    return () {
      return MyHttpClientDioImplemenation(
        baseUrl: ApiConstants.baseUrl,
        cacheEnabled: withCache,
        getAccessToken: getAccessToken,
      );
    };
  }

  static Widget getFloatingMenuWidget() {
    return Modular.get<Widget>(key: floatingMenuBuilderKey);
  }

  @override
  void binds(i) {
    const withCacheKey = 'with_cache_key';
    i.addLazySingleton<bool>(() => isProduction, key: isProductionKey);
    // Core
    i.addLazySingleton<MyHttpClient>(_initMyHttpClient(withCache: false));
    i.addLazySingleton<MyHttpClient>(
      _initMyHttpClient(withCache: true),
      key: withCacheKey,
    );
    i.addInstance<KycApiKeys>(kycApiKeys);

    // Data layer dependencies
    i.addLazySingleton(
      () => BantubeatApiDataSource(
        client: Modular.get<MyHttpClient>(),
        cachedClient: Modular.get<MyHttpClient>(key: withCacheKey),
      ),
    );

    // Domain layer dependencies
    // -- Domain Reposities
    i.addLazySingleton<BalanceRepository>(BalanceRepositoryImpl.new);
    i.addLazySingleton<PublicRepository>(PublicRepositoryImpl.new);
    i.addLazySingleton<ExchangeRepository>(ExchangeRepositoryImpl.new);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new);
    i.addLazySingleton<PaymentRepository>(PaymentRepositoryImpl.new);

    // -- Domain Use Cases
    i.addLazySingleton(CheckWithdrawalEligibilityUseCase.new);
    i.addLazySingleton(ConvertFiatCurrencyUseCase.new);
    i.addLazySingleton(ExchangeBzcToFiatUseCase.new);
    i.addLazySingleton(ExchangeFiatToBzcUseCase.new);
    i.addLazySingleton(GetAllCurrenciesUseCase.new);
    i.addLazySingleton(GetBzcCurrencyConverterUseCase.new);
    i.addLazySingleton(GetCurrentUserUseCase.new);
    i.addLazySingleton(GetExchangeBzcPacksUseCase.new);
    i.addLazySingleton(GetPaymentPreferencesUseCase.new);
    i.addLazySingleton(GetTransactionsUseCase.new);
    i.addLazySingleton(GetUserBalanceUseCase.new);
    i.addLazySingleton(MakeDepositDirectPaymentUseCase.new);
    i.addLazySingleton(RequestDepositPaymentLinkUseCase.new);

    // Presentation layer dependencies
    i.addSingleton(CurrentUserCubit.new);
    i.addSingleton(UserBalanceCubit.new);
    i.addSingleton(floatingMenuBuilder, key: floatingMenuBuilderKey);
    i.addInstance<KycRoutes>(_routes);
  }

  @override
  void routes(r) {
    r.redirect('/', to: _routes.home.wp);
    r.redirect(_routes.home.wp, to: _routes.step1.wp);
    r.child(
      _routes.step1.wp,
      child: (_) => const KycStep1PersonalInfosScreen(),
    );
    r.child(_routes.step2.wp, child: (_) => const KycStep2AddressScreen());
    r.child(_routes.step3.wp, child: (_) => const KycStep3IdCardScreen());
    r.child(
      _routes.step4.wp,
      child: (_) => const KycStep4PaymentAccountScreen(),
    );
    r.child(
      _routes.step5a.wp,
      child: (_) => const KycSelfieIntroPage(isStep5: true),
    );
    r.child(
      _routes.step5b.wp,
      child: (_) => const KycSelfieCameraPage(isStep5: true),
    );
    r.child(
      _routes.step6a.wp,
      child: (_) => const KycSelfieIntroPage(isStep5: false),
    );
    r.child(
      _routes.step6b.wp,
      child: (_) => const KycSelfieCameraPage(isStep5: false),
    );
    r.wildcard(child: (_) => const KycStep1PersonalInfosScreen());
  }
}
