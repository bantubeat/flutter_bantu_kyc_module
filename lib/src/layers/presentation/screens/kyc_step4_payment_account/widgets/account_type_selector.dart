import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/screens/kyc_step4_payment_account/kyc_step4_payment_account_controller.dart';

class AccountTypeSelector extends StatelessWidget {
  final KycStep4PaymentAccountController controller;

  const AccountTypeSelector(this.controller);

  @override
  Widget build(BuildContext context) {
    final isMobile = controller.selectedAccountType == EAccountType.mobile;
    return GestureDetector(
      onTap: () => _showAccountTypeModal(context, controller.setAccountType),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isMobile
                  ? LocaleKeys.kyc_module_step4_mobile_payment.tr()
                  : LocaleKeys.kyc_module_step4_bank_account.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showAccountTypeModal(
    BuildContext context,
    void Function(EAccountType) onSelectAccountType,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.kyc_module_step4_add_payment_acconut.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _OptionModal(
                icon: Icons.phone_android,
                title: LocaleKeys.kyc_module_step4_mobile_payment.tr(),
                subtitle: LocaleKeys.kyc_module_step4_mobile_payment_way.tr(),
                onTap: () {
                  onSelectAccountType(EAccountType.mobile);
                  Navigator.pop(context);
                },
              ),
              const Divider(height: 24),
              _OptionModal(
                icon: Icons.account_balance,
                title: LocaleKeys.kyc_module_step4_bank_account.tr(),
                subtitle: LocaleKeys.kyc_module_step4_bank_account_way.tr(),
                onTap: () {
                  onSelectAccountType(EAccountType.bank);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OptionModal extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _OptionModal({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 30, color: Colors.black87),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
