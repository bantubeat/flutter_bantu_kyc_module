part of '../kyc_status_screen.dart';

class _KycStatusView extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isFailed;

  const _KycStatusView({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.isFailed = false,
  });

  static _KycStatusView loading() {
    return _KycStatusView(
      icon: Icons.hourglass_empty,
      iconColor: Colors.grey,
      title: LocaleKeys.kyc_module_status_screen_pending_title.tr(),
      message: LocaleKeys.kyc_module_status_screen_pending_message.tr(),
      buttonText: LocaleKeys.kyc_module_status_screen_pending_button_text.tr(),
      onButtonPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 120),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            if (isFailed)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              )
            else
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            const Spacer(),
            KycFormPrimaryButton(label: buttonText, onPressed: onButtonPressed),
          ],
        ),
      ),
    );
  }
}
