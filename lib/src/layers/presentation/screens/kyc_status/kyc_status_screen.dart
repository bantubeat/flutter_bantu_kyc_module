import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/enums/kyc_status.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/current_user_cubit.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_cubit.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_state.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/entities/user_entity.dart';

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
  }

  // Navigate to the start of the KYC flow
  void _navigateToKycStep1(UserEntity currentUser) {
    Modular.get<KycRoutes>().step1.navigate(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(LocaleKeys.kyc_module_status_screen_title.tr()),
      ),
      body: BlocBuilder<CurrentUserCubit, AsyncSnapshot<UserEntity>>(
        bloc: Modular.get(),
        builder: (context, userSnapshot) => Skeletonizer(
          enabled: userSnapshot.connectionState == ConnectionState.waiting,
          child: BlocBuilder<KycCubit, KycState>(
            bloc: Modular.get(),
            builder: (context, state) {
              final currentUser = userSnapshot.data;
              if (state is KycLoading || currentUser == null) {
                return Skeletonizer(
                  child: _KycStatusView(
                    icon: Icons.hourglass_empty,
                    iconColor: Colors.grey,
                    title: LocaleKeys.kyc_module_status_screen_pending_title
                        .tr(),
                    message: LocaleKeys.kyc_module_status_screen_pending_message
                        .tr(),
                    buttonText: LocaleKeys
                        .kyc_module_status_screen_pending_button_text
                        .tr(),
                    onButtonPressed: () {},
                  ),
                );
              } else if (state is KycStatusLoaded) {
                switch (state.kyc.status) {
                  case EKycStatus.success:
                    return _KycStatusView(
                      icon: Icons.check_circle,
                      iconColor: Colors.green,
                      title: LocaleKeys.kyc_module_status_screen_success_title
                          .tr(),
                      message: LocaleKeys
                          .kyc_module_status_screen_success_message
                          .tr(),
                      buttonText: LocaleKeys
                          .kyc_module_status_screen_success_button_text
                          .tr(),
                      onButtonPressed: () => Modular.get<OnKycFinishFn>()(true),
                    );
                  case EKycStatus.failed:
                    return _KycStatusView(
                      icon: Icons.cancel,
                      iconColor: Colors.red,
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
                      isFailed: true,
                    );
                  case EKycStatus.pending:
                    return _KycStatusView(
                      icon: Icons.hourglass_empty,
                      iconColor: Colors.orange,
                      title: LocaleKeys.kyc_module_status_screen_pending_title
                          .tr(),
                      message: LocaleKeys
                          .kyc_module_status_screen_pending_message
                          .tr(),
                      buttonText: LocaleKeys
                          .kyc_module_status_screen_pending_button_text
                          .tr(),
                      onButtonPressed: () {
                        // Implement cancellation logic
                        BlocProvider.of<KycCubit>(context).cancelKyc();
                      },
                    );
                  default:
                    return _KycStatusView(
                      icon: Icons.help_outline,
                      iconColor: Colors.grey,
                      title: LocaleKeys.kyc_module_status_screen_unknown_title
                          .tr(),
                      message: LocaleKeys
                          .kyc_module_status_screen_unknown_message
                          .tr(),
                      buttonText: LocaleKeys
                          .kyc_module_status_screen_unknown_button_text
                          .tr(),
                      onButtonPressed: () {},
                    );
                }
              } else if (state is KycNotSubmitted || state is KycError) {
                // This state would typically lead the user to start the KYC flow
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: state is KycError,
                        replacement: Text(
                          LocaleKeys.kyc_module_status_screen_kyc_not_submitted
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
                    ],
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
    );
  }
}
