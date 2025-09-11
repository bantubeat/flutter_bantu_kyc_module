import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bantu_kyc_module/src/core/generated/locale_keys.g.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/image_picker_helper.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/localization/string_translate_extension.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/widgets/kyc_form_primary_button.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../ui_models/kyc_form_data.dart';
import 'kyc_selfie_controller.dart';

/// 6. Selfie Camera Screen
class KycStep5bAnd6bSelfieCameraScreen extends StatelessWidget {
  final KycFormDataStep4? step4Data;
  final KycFormDataStep5? step5Data;

  const KycStep5bAnd6bSelfieCameraScreen({this.step4Data, this.step5Data})
    : assert(
        step4Data != null || step5Data != null,
        'Either step4Data or step5Data must be provided',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScreenControllerBuilder(
        create: (s) => KycSelfieController(s, step4Data, step5Data),
        builder: (context, controller) {
          return Stack(
            children: [
              // Camera Preview or Captured Image
              if (controller.isCameraInitialized)
                Center(
                  child: controller.selfieImage == null
                      ? CameraPreview(controller.cameraController)
                      : FutureBuilder(
                          future: controller.selfieImage!.toImageProvider(),
                          builder: (_, snap) => snap.hasData
                              ? Image(image: snap.requireData)
                              : const CircularProgressIndicator.adaptive(),
                        ),
                )
              else
                const Center(child: CircularProgressIndicator.adaptive()),

              // Top Bar
              /*
              Positioned(
                top: 50,
                left: 0,
                right: 30,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    if (controller.selfieImage == null) ...[
                      IconButton(
                        icon: const Icon(Icons.flash_on, color: Colors.white),
                        onPressed: () {
                          // Handle flash
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Handle camera flip
                        },
                      ),
                    ],
                  ],
                ),
              ),
							*/

              // Bottom Controls
              if (controller.selfieImage == null)
                _buildShutterButton(controller.takePicture)
              else
                _buildConfirmationButtons(
                  onRetakePicture: controller.retakePicture,
                  onValidate: controller.onValidate,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShutterButton(VoidCallback onTakePicture) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: onTakePicture,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: Center(
              child: Builder(
                builder: (context) => SizedBox(
                  height: 60,
                  width: 60,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey.shade900),
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationButtons({
    required VoidCallback onValidate,
    required VoidCallback onRetakePicture,
  }) {
    return Positioned(
      bottom: 40,
      left: 24,
      right: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton(
              onPressed: onRetakePicture,
              child: Text(
                LocaleKeys.kyc_module_common_try_again.tr(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(child: KycFormPrimaryButton(onPressed: onValidate)),
        ],
      ),
    );
  }
}
