import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';

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
        // Align with circles
        margin: const EdgeInsets.only(top: 17, left: 5, right: 5),
      ),
    );

    var i = 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Step(
          step: ++i,
          currentStep: currentStep,
          title: LocaleKeys.kyc_module_stepper_step1.tr(),
        ),
        connector,
        _Step(
          step: ++i,
          currentStep: currentStep,
          title: LocaleKeys.kyc_module_stepper_step2.tr(),
        ),
        connector,
        _Step(
          step: ++i,
          currentStep: currentStep,
          title: LocaleKeys.kyc_module_stepper_step3.tr(),
        ),
        connector,
        _Step(
          step: ++i,
          currentStep: currentStep,
          title: LocaleKeys.kyc_module_stepper_step4.tr(),
        ),
        connector,
        _Step(
          step: ++i,
          currentStep: currentStep,
          title: LocaleKeys.kyc_module_stepper_step5.tr(),
        ),
        connector,
        _Step(
          step: ++i,
          currentStep: currentStep,
          title: LocaleKeys.kyc_module_stepper_step6.tr(),
        ),
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
