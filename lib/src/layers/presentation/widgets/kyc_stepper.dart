import 'package:flutter/material.dart';

class KycStepper extends StatelessWidget {
  final int currentStep;

  const KycStepper({required this.currentStep, super.key});

  @override
  Widget build(BuildContext context) {
    // for the line connecting the steps
    final connector = Expanded(
      child: Container(
        height: 2,
        color: Colors.grey[300],
        margin: const EdgeInsets.only(
          top: 17,
          left: 5,
          right: 5,
        ), // Align with circles
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Step(step: 1, title: 'Données personnelles', currentStep: currentStep),
        connector,
        _Step(step: 2, title: 'Residence', currentStep: currentStep),
        connector,
        _Step(step: 3, title: 'Carte Identité', currentStep: currentStep),
        connector,
        _Step(step: 4, title: 'Compte Paiement', currentStep: currentStep),
        connector,
        _Step(step: 5, title: 'Selfie', currentStep: currentStep),
        connector,
        _Step(step: 6, title: 'Selfie+ ID Card', currentStep: currentStep),
      ],
    );
  }
}

// for a single step in the stepper
class _Step extends StatelessWidget {
  final int step;
  final String title;
  final int currentStep;

  const _Step({
    required this.step,
    required this.title,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = step <= currentStep;
    return Flexible(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isActive ? colorScheme.primary : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Visibility(
                visible: step < currentStep,
                replacement: Text(
                  step.toString(),
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Icon(Icons.check, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FittedBox(
            child: Text(
              title.replaceAll(' ', '\n'), // Wrap text if needed
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.black : Colors.grey[600],
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
