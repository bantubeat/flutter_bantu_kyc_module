part of '../kyc_status_screen.dart';

class _KycStatusView extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isFailed;
  final bool showCancelButton;
  final VoidCallback? onCancelPressed;

  const _KycStatusView({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onButtonPressed,
    this.isFailed = false,
    this.showCancelButton = false,
    this.onCancelPressed,
  });

  /// Squelette affiché pendant le chargement (utilisé avec [Skeletonizer]).
  factory _KycStatusView.loading() {
    return _KycStatusView(
      icon: Icons.check,
      iconColor: Colors.black,
      title: 'Chargement du statut',
      message:
          'Merci de patienter pendant que nous récupérons les informations '
          'de votre dossier KYC.',
      buttonText: 'Continuer',
      onButtonPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CustomPaint(
                      painter: _ScallopPainter(color: iconColor),
                      child: Center(
                        child: Icon(icon, color: Colors.white, size: 160 * 0.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.chevron_left, size: 22),
                      const SizedBox(width: 4),
                      Text(
                        buttonText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (showCancelButton && onCancelPressed != null) ...[
                const SizedBox(height: 12),
                TextButton(
                  onPressed: onCancelPressed,
                  child: Text(
                    'Annuler',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ScallopPainter extends CustomPainter {
  final Color color;

  _ScallopPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2;
    final bumpCenterRadius = outerRadius * 0.82;
    final bumpRadius = outerRadius * 0.24;
    final coreRadius = outerRadius * 0.78;

    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: coreRadius));

    for (int i = 0; i < 14; i++) {
      final angle = (2 * math.pi / 14) * i;
      final bumpCenter = Offset(
        center.dx + bumpCenterRadius * math.cos(angle),
        center.dy + bumpCenterRadius * math.sin(angle),
      );
      path.addOval(Rect.fromCircle(center: bumpCenter, radius: bumpRadius));
    }

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _ScallopPainter oldDelegate) =>
      oldDelegate.color != color || 14 != 14;
}
