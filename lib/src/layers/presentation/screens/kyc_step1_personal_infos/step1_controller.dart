part of 'kyc_step1_personal_infos_screen.dart';

class Step1Controller extends ScreenController {
  final UserEntity currentUser;
  Step1Controller(super.state, this.currentUser);

  final surnameCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  EGender? selectedGender;
  DateTime? pickedBirthdate;

  @protected
  @override
  void onDispose() {
    surnameCtrl.dispose();
    nameCtrl.dispose();
  }

  void selectGender(EGender? newGender) {
    selectedGender = newGender;
    refreshUI();
  }

  void pickBirthdate() async {
    pickedBirthdate = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 30)),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
    );
  }

  void onNext() {
    final birthdate = pickedBirthdate;
    final gender = selectedGender;
    final firstName = surnameCtrl.text;
    final lastName = nameCtrl.text;
    if (birthdate != null &&
        gender != null &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      final kycFormData = KycFormDataStep1(
        currentUser: currentUser,
        firstName: firstName,
        lastName: lastName,
        birthdate: birthdate,
        gender: gender,
      );
      Modular.get<KycRoutes>().step2.push(kycFormData);
    } else {
      UiAlertHelpers.showErrorSnackBar(context, 'Tous les champs sont requis');
    }
  }
}
