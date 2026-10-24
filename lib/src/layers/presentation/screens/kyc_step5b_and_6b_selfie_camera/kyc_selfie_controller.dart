import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bantu_kyc_module/flutter_bantu_kyc_module.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/cubits/kyc/kyc_cubit.dart';
import 'package:flutter_bantu_kyc_module/src/layers/presentation/helpers/ui_alert_helpers.dart';
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

  // États observables
  XFile? selfieImage;
  CameraController? cameraController;
  List<CameraDescription> cameras = [];
  bool isCameraInitialized = false;
  bool isLoading = false;
  String errorMessage = '';

  // --- Getters ---
  bool get isStep5 => step5Data == null;
  bool get hasPermission => _hasPermission;
  final bool _hasPermission = false;

  @override
  @protected
  void onInit() {
    super.onInit();
    _initCamera();
  }

  @override
  @protected
  void onDispose() {
    _disposeCamera();
    super.onDispose();
  }

  // --- Initialisation Sécurisée ---

  Future<void> _initCamera() async {
    try {
      isLoading = true;
      errorMessage = '';
      refreshUI();

      // 1. Vérifier les permissions
      final permissionGranted = await _checkCameraPermission();
      if (!permissionGranted) {
        errorMessage = 'Permission caméra refusée';
        isLoading = false;
        refreshUI();
        return;
      }

      // 2. Obtenir les caméras disponibles
      cameras = await availableCameras();

      if (cameras.isEmpty) {
        errorMessage = 'Aucune caméra disponible sur cet appareil';
        isLoading = false;
        refreshUI();
        return;
      }

      // 3. Sélectionner la caméra frontale avec fallback sécurisé
      final frontCamera = _getFrontCamera();
      if (frontCamera == null) {
        errorMessage = 'Impossible de sélectionner une caméra';
        isLoading = false;
        refreshUI();
        return;
      }

      // 4. Initialiser le contrôleur
      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      // 5. Attendre l'initialisation
      await cameraController!.initialize();

      // 6. Marquer comme initialisé
      isCameraInitialized = true;
      errorMessage = '';
    } catch (e) {
      errorMessage =
          "Erreur d'initialisation: ${_getUserFriendlyErrorMessage(e)}";
      isCameraInitialized = false;
      debugPrint('Camera initialization error: $e');
    } finally {
      isLoading = false;
      refreshUI();
    }
  }

  // --- Permission ---

  Future<bool> _checkCameraPermission() async {
    return true;
  }

  // --- Sélection Caméra ---

  CameraDescription? _getFrontCamera() {
    try {
      // Essayer d'abord la caméra frontale
      return cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first, // Fallback sur la première caméra
      );
    } catch (e) {
      // Si tout échoue, prendre la première caméra disponible
      return cameras.isNotEmpty ? cameras.first : null;
    }
  }

  // --- Prise de Photo ---

  Future<void> takePicture() async {
    // Vérifications de sécurité
    if (!_canTakePicture()) {
      return;
    }

    try {
      final XFile picture = await cameraController!.takePicture();
      selfieImage = picture;
      errorMessage = '';
      refreshUI();
    } catch (e) {
      errorMessage =
          'Erreur lors de la prise de photo: ${_getUserFriendlyErrorMessage(e)}';
      debugPrint('Take picture error: $e');
      refreshUI();
    }
  }

  bool _canTakePicture() {
    // Vérifier l'état de la caméra
    if (cameraController == null) {
      errorMessage = 'Caméra non initialisée';
      refreshUI();
      return false;
    }

    if (!isCameraInitialized) {
      errorMessage = 'Caméra non prête';
      refreshUI();
      return false;
    }

    if (!cameraController!.value.isInitialized) {
      errorMessage = 'Caméra non initialisée';
      refreshUI();
      return false;
    }

    if (cameraController!.value.isRecordingVideo) {
      errorMessage = "La caméra est en cours d'utilisation";
      refreshUI();
      return false;
    }

    return true;
  }

  // --- Actions ---

  void retakePicture() {
    selfieImage = null;
    errorMessage = '';
    refreshUI();
  }

  Future<void> onValidate() async {
    // Vérifier si une photo a été prise
    if (selfieImage == null) {
      errorMessage = 'Veuillez prendre une photo';
      refreshUI();
      return;
    }

    try {
      if (isStep5 && selfieImage != null) {
        // Navigation vers l'étape 6a
        Modular.get<KycRoutes>().step6a.push(
          KycFormDataStep5(step4Data: step4Data!, selfieImage: selfieImage!),
        );
      } else {
        // Soumission du formulaire
        await _submitKycForm();
      }
    } catch (e) {
      errorMessage = 'Erreur: ${_getUserFriendlyErrorMessage(e)}';
      refreshUI();
    }
  }

  Future<void> _submitKycForm() async {
    if (step5Data == null) {
      errorMessage = 'Données manquantes';
      refreshUI();
      return;
    }

    isLoading = true;
    refreshUI();

    try {
      final kycFormData = KycFormDataStep6(
        step5Data: step5Data!,
        selfieWithIdImage: selfieImage!,
      );

      await Modular.get<KycCubit>().submitKycForm(
        await kycFormData.toSubmission(),
      );

      Modular.get<KycRoutes>().home.navigate();
    } catch (e) {
      errorMessage =
          'Erreur lors de la soumission: ${_getUserFriendlyErrorMessage(e)}';
      debugPrint('Submit error: $e');
      UiAlertHelpers.showErrorToast(
        'Erreur lors de la soumission: ${_getUserFriendlyErrorMessage(e)}',
      );
    } finally {
      isLoading = false;
      refreshUI();
    }
  }

  // --- Utilitaires ---

  void _disposeCamera() {
    try {
      if (cameraController != null) {
        cameraController!.dispose();
        cameraController = null;
      }
    } catch (e) {
      debugPrint('Error disposing camera: $e');
    }
    isCameraInitialized = false;
  }

  String _getUserFriendlyErrorMessage(dynamic error) {
    if (error is CameraException) {
      switch (error.code) {
        case 'CameraAccessDenied':
          return 'Accès à la caméra refusé';
        case 'CameraAccessRestricted':
          return 'Accès à la caméra restreint';
        case 'CameraNotFound':
          return 'Caméra non trouvée';
        case 'InvalidCameraDescription':
          return 'Caméra invalide';
        default:
          return error.description ?? 'Erreur caméra';
      }
    }
    return 'Une erreur est survenue';
  }

  // --- Méthodes de rafraîchissement ---

  Future<void> retryInitialization() async {
    _disposeCamera();
    await _initCamera();
  }
}
