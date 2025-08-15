import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screen_controller/flutter_screen_controller.dart';

class KycSelfieController extends ScreenController {
  final bool isStep5;

  KycSelfieController(super.state, this.isStep5);

  XFile? selfieImage;
  late CameraController cameraController;
  late List<CameraDescription> cameras;
  bool isCameraInitialized = false;

  // --- Logic ---

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

  void onValidate() {
    if (isStep5) {
      Modular.get<KycRoutes>().step6a.push();
    } else {
      Modular.get<KycRoutes>().home.navigate();
    }
  }
}
