import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/enums/kyc_status.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_cubit.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_state.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'widgets/kyc_status_view.dart';

class KycStatusScreen extends StatelessWidget {
  const KycStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => Modular.get<KycCubit>()..checkKycStatus(),
        child: BlocBuilder<KycCubit, KycState>(
          builder: (context, state) {
            if (state is KycLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is KycStatusLoaded) {
              switch (state.kyc.status) {
                case EKycStatus.success:
                  return _KycStatusView(
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    title: 'Données Validées',
                    message:
                        "Vous pouvez dès à présent utiliser l'application et introduire vos demandes de paiement.",
                    buttonText: 'Retour à l’accueil',
                    onButtonPressed: () {
                      // Navigate to home
                      Modular.get<OnKycFinishFn>()(true);
                    },
                  );
                case EKycStatus.failed:
                  return _KycStatusView(
                    icon: Icons.cancel,
                    iconColor: Colors.red,
                    title: 'Demande Refusée',
                    message:
                        state.kyc.adminMessage ??
                        'Nous constatons des incohérences dans les informations fournies.',
                    buttonText: 'Introduire une nouvelle demande',
                    onButtonPressed: () {
                      // Navigate to the start of the KYC flow
                      Modular.get<KycRoutes>().step1.navigate();
                    },
                    isFailed: true,
                  );
                case EKycStatus.pending:
                  return _KycStatusView(
                    icon: Icons.hourglass_empty,
                    iconColor: Colors.orange,
                    title: 'Demande en attente',
                    message:
                        'Vos documents sont en cours de vérification. Vous pouvez annuler cette demande si vous le souhaitez.',
                    buttonText: 'Annuler la demande',
                    onButtonPressed: () {
                      // Implement cancellation logic
                      BlocProvider.of<KycCubit>(context).cancelKyc();
                    },
                  );
                default:
                  return _KycStatusView(
                    icon: Icons.help_outline,
                    iconColor: Colors.grey,
                    title: 'Statut Inconnu',
                    message:
                        'Une erreur est survenue. Veuillez contacter le support.',
                    buttonText: 'Retour',
                    onButtonPressed: () {},
                  );
              }
            } else if (state is KycNotSubmitted) {
              // This state would typically lead the user to start the KYC flow
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Aucune demande de KYC n\'a été soumise.'),
                    const SizedBox(height: 20),
                    KycFormPrimaryButton(
                      label: 'Commencer la vérification',
                      onPressed: () {
                        // Navigate to the start of the KYC flow
                        Modular.get<KycRoutes>().step1.navigate();
                      },
                    ),
                  ],
                ),
              );
            } else if (state is KycError) {
              return Center(child: Text('Erreur: ${state.message}'));
            }
            return const Center(child: Text('Veuillez patienter...'));
          },
        ),
      ),
    );
  }
}
