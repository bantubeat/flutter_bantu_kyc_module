import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/enums/kyc_status.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/user_entity.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/current_user_cubit.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_cubit.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_state.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/navigation/kyc_routes.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/ui_models/kyc_form_data.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/account_type_modal.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'widgets/kyc_status_view.dart';

class KycStatusScreen extends StatefulWidget {
  const KycStatusScreen({super.key});

  @override
  State<KycStatusScreen> createState() => _KycStatusScreenState();
}

class _KycStatusScreenState extends State<KycStatusScreen> {
  @override
  void initState() {
    super.initState();
    Modular.get<CurrentUserCubit>().fetchCurrentUser(forceRefresh: false);
    Modular.get<KycCubit>().checkKycStatus();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  // Navigate to the start of the KYC flow
  Future<void> _navigateToKycStep1(UserEntity currentUser) async {
    final accountType = await AccountTypeModal.show(context);
    if (accountType == null || !mounted) return;
    Modular.get<KycRoutes>().step1.push(
      KycStartContext(currentUser: currentUser, accountType: accountType),
    );
  }

  void _goBack([bool? result]) {
    KycModule.getOnKycFinishFn()(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(LocaleKeys.kyc_module_status_screen_title.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100),
        child: BlocBuilder<CurrentUserCubit, AsyncSnapshot<UserEntity>>(
          bloc: Modular.get(),
          builder: (context, userSnapshot) => Skeletonizer(
            enabled: userSnapshot.connectionState == ConnectionState.waiting,
            child: BlocBuilder<KycCubit, KycState>(
              bloc: Modular.get(),
              builder: (context, state) {
                final currentUser = userSnapshot.data;
                if (state is KycLoading || currentUser == null) {
                  return Skeletonizer(child: _KycStatusView.loading());
                } else if (state is KycStatusLoaded) {
                  switch (state.kyc.status) {
                    case EKycStatus.success:
                      return _KycStatusView(
                        icon: Icons.check,
                        iconColor: Colors.black,
                        title: LocaleKeys.kyc_module_status_screen_success_title
                            .tr(),
                        message: LocaleKeys
                            .kyc_module_status_screen_success_message
                            .tr(),
                        buttonText: LocaleKeys
                            .kyc_module_status_screen_success_button_text
                            .tr(),
                        onButtonPressed: () => _goBack(true),
                        onCancelPressed: _goBack,
                      );
                    case EKycStatus.failed:
                      return _KycStatusView(
                        icon: Icons.close,
                        iconColor: Colors.red.shade700,
                        title: LocaleKeys.kyc_module_status_screen_failed_title
                            .tr(),
                        message: LocaleKeys
                            .kyc_module_status_screen_failed_message
                            .tr(
                              namedArgs: {
                                'message': state.kyc.adminMessage ?? 'N/A',
                              },
                            ),
                        buttonText: LocaleKeys
                            .kyc_module_status_screen_failed_button_text
                            .tr(),
                        onButtonPressed: () => _navigateToKycStep1(currentUser),
                        isFailed: false,
                        showCancelButton: true,
                        onCancelPressed: _goBack,
                      );
                    case EKycStatus.pending:
                      return _KycStatusView(
                        icon: Icons.hourglass_top,
                        iconColor: Colors.orange.shade700,
                        title: LocaleKeys.kyc_module_status_screen_pending_title
                            .tr(),
                        message: LocaleKeys
                            .kyc_module_status_screen_pending_message
                            .tr(),
                        buttonText: LocaleKeys
                            .kyc_module_status_screen_pending_button_text
                            .tr(),
                        showCancelButton: true,
                        onButtonPressed: () {
                          Modular.get<KycCubit>().cancelKyc();
                        },
                        onCancelPressed: _goBack,
                      );
                    default:
                      return _KycStatusView(
                        icon: Icons.question_mark,
                        iconColor: Colors.grey.shade700,
                        title: LocaleKeys.kyc_module_status_screen_unknown_title
                            .tr(),
                        message: LocaleKeys
                            .kyc_module_status_screen_unknown_message
                            .tr(),
                        buttonText: LocaleKeys
                            .kyc_module_status_screen_unknown_button_text
                            .tr(),
                        onButtonPressed: _goBack,
                        onCancelPressed: _goBack,
                      );
                  }
                } else if (state is KycNotSubmitted || state is KycError) {
                  // This state would typically lead the user to start the KYC flow
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: state is KycError,
                            replacement: Text(
                              LocaleKeys
                                  .kyc_module_status_screen_kyc_not_submitted
                                  .tr(),
                            ),
                            child: Text(
                              LocaleKeys.kyc_module_common_an_error_occur.tr(
                                namedArgs: {
                                  'message': state is KycError
                                      ? state.message
                                      : 'Aucune demande de KYC soumise.',
                                },
                              ),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          const SizedBox(height: 20),
                          KycFormPrimaryButton(
                            label: LocaleKeys
                                .kyc_module_status_screen_start_kyc_verification
                                .tr(),
                            onPressed: () => _navigateToKycStep1(currentUser),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => KycModule.getOnKycFinishFn()(null),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade200,
                              foregroundColor: Colors.black87,
                            ),
                            child: Text(
                              LocaleKeys
                                  .kyc_module_status_screen_success_button_text
                                  .tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text(
                    LocaleKeys.kyc_module_common_an_error_occur.tr(
                      namedArgs: {'message': 'Unknown state'},
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      // floatingActionButton: KycModule.getFloatingMenuWidget(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
