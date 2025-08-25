import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Widget;
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_status/kyc_status_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/network/api_constants.dart';
import '../../core/network/my_http/my_http.dart';

import '../data/data_sources/bantubeat_api_data_source.dart';
import '../data/repositories/user_repository_impl.dart';
import '../data/repositories/balance_repository_impl.dart';
import '../data/repositories/kyc_repository_impl.dart';

import '../domain/repositories/balance_repository.dart';
import '../domain/repositories/kyc_repository.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/use_cases/get_current_user_use_case.dart';
import '../domain/use_cases/get_payment_preferences_use_case.dart';
import '../domain/use_cases/cancel_kyc_use_case.dart';
import '../domain/use_cases/get_kyc_status_use_case.dart';
import '../domain/use_cases/submit_kyc_use_case.dart';

import '../presentation/cubits/current_user_cubit.dart';
import '../presentation/cubits/kyc/kyc_cubit.dart';
import 'navigation/kyc_routes.dart';

import 'screens/kyc_step1_personal_infos/kyc_step1_personal_infos_screen.dart';
import 'screens/kyc_step2_address/kyc_step2_address_screen.dart';
import 'screens/kyc_step3_id_card/kyc_step3_id_card_screen.dart';
import 'screens/kyc_step5b_and_6b_selfie_camera/kyc_step5b_and_6b_selfie_camera_screen.dart';
import 'screens/kyc_step5a_and_6a_selfie_intro/kyc_step5a_and_6a_selfie_intro_screen.dart';

typedef OnKycFinishFn = void Function(bool? kycVerified);

class KycModule extends Module {
  static const _floatingMenuBuilderKey = 'KycModule._floatingMenuBuilder';
  static const _onFinishKey = 'KycModule._onFinishKey';
  static const _isProductionKey = 'KycModule._isProduction';

  final Widget Function() floatingMenuBuilder;
  final Future<String?> Function() getAccessToken;
  final KycRoutes _routes;
  final bool isProduction;
  final OnKycFinishFn onFinish;

  KycModule({
    required this.floatingMenuBuilder,
    required this.getAccessToken,
    required this.onFinish,
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

  static bool getIsProduction() {
    return Modular.get<bool>(key: _isProductionKey);
  }

  static Widget getFloatingMenuWidget() {
    return Modular.get<Widget>(key: _floatingMenuBuilderKey);
  }

  @override
  void binds(i) {
    const withCacheKey = 'with_cache_key';
    i.addLazySingleton<bool>(() => isProduction, key: _isProductionKey);
    // Core
    i.addLazySingleton<MyHttpClient>(
      _initMyHttpClient(withCache: false),
      config: BindConfig(onDispose: (client) => client.close()),
    );
    i.addLazySingleton<MyHttpClient>(
      _initMyHttpClient(withCache: true),
      config: BindConfig(onDispose: (client) => client.close()),
      key: withCacheKey,
    );

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
    i.addLazySingleton<KycRepository>(KycRepositoryImpl.new);
    i.addLazySingleton<UserRepository>(UserRepositoryImpl.new);

    // -- Domain Use Cases
    i.addLazySingleton(GetCurrentUserUseCase.new);
    i.addLazySingleton(GetPaymentPreferencesUseCase.new);
    i.addLazySingleton(GetKycStatusUseCase.new);
    i.addLazySingleton(SubmitKycUseCase.new);
    i.addLazySingleton(CancelKycUseCase.new);

    // Presentation layer dependencies
    i.addSingleton<CurrentUserCubit>(
      CurrentUserCubit.new,
      config: BindConfig(onDispose: (c) => c.close()),
    );
    i.addSingleton<KycCubit>(
      KycCubit.new,
      config: BindConfig(onDispose: (c) => c.close()),
    );
    i.addSingleton(floatingMenuBuilder, key: _floatingMenuBuilderKey);
    i.addSingleton<OnKycFinishFn>(() => onFinish, key: _onFinishKey);
    i.addInstance<KycRoutes>(_routes);
  }

  @override
  void routes(r) {
    r.redirect('/', to: _routes.home.wp);
    r.child(_routes.home.wp, child: (_) => const KycStatusScreen());
    r.child(
      _routes.step1.wp,
      child: (_) => KycStep1PersonalInfosScreen(currentUser: r.args.data),
    );
    r.child(
      _routes.step2.wp,
      child: (_) => KycStep2AddressScreen(previousData: r.args.data),
    );
    r.child(
      _routes.step3.wp,
      child: (_) => KycStep3IdCardScreen(step2Data: r.args.data),
    );
    //r.child(
    //  _routes.step4.wp,
    //  child: (_) => KycStep4PaymentAccountScreen(step3Data: r.args.data),
    //);
    r.child(
      _routes.step5a.wp,
      child: (_) => KycStep5aAnd6aSelfieIntroScreen(step4Data: r.args.data),
    );
    r.child(
      _routes.step5b.wp,
      child: (_) => KycStep5bAnd6bSelfieCameraScreen(step4Data: r.args.data),
    );
    r.child(
      _routes.step6a.wp,
      child: (_) => KycStep5aAnd6aSelfieIntroScreen(step5Data: r.args.data),
    );
    r.child(
      _routes.step6b.wp,
      child: (_) => KycStep5bAnd6bSelfieCameraScreen(step5Data: r.args.data),
    );
    r.wildcard(child: (_) => const KycStatusScreen());
  }
}
