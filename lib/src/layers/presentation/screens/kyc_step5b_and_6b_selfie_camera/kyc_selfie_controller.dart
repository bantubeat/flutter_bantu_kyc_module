import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

import '../../ui_models/kyc_form_data.dart';

class KycSelfieController extends ScreenController {
  final KycFormDataStep4? step4Data;
  final KycFormDataStep5? step5Data;

  KycSelfieController(super.state, this.step4Data, this.step5Data)
    : assert(
        step4Data != null || step5Data != null,
        'Either step4Data or step5Data must be provided',
      );

  XFile? selfieImage;
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;

  bool isLoading = false;

  // --- Logic ---

  bool get isStep5 => step5Data == null;

  @override
  @protected
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  @protected
  void onDispose() {
    cameraController.dispose();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    // Use the front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(frontCamera, ResolutionPreset.high);
    await cameraController.initialize();
    isCameraInitialized = true;
    refreshUI();
  }

  Future<void> takePicture() async {
    if (!cameraController.value.isInitialized) {
      return;
    }
    selfieImage = await cameraController.takePicture();
    refreshUI();
  }

  void retakePicture() {
    selfieImage = null;
    refreshUI();
  }

  void onValidate() async {
    final image = selfieImage;
    if (image == null) return;

    if (isStep5) {
      Modular.get<KycRoutes>().step6a.push(
        KycFormDataStep5(step4Data: step4Data!, selfieImage: image),
      );
    } else {
      isLoading = true;
      refreshUI();

      // Create the KYC form data for step 6
      final kycFormData = KycFormDataStep6(
        step5Data: step5Data!,
        selfieWithIdImage: image,
      );
      Modular.get<KycCubit>().submitKycForm(await kycFormData.toSubmission());
      Modular.get<KycRoutes>().home.navigate();
    }
  }
}
