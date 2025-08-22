part of 'kyc_step1_personal_infos_screen.dart';

class Step1Controller extends ScreenController {
  final UserEntity? _currentUser;

  Step1Controller(super.state, UserEntity? currentUser)
    : _currentUser = currentUser ?? Modular.get<CurrentUserCubit>().state.data;

  final surnameCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  EGender? selectedGender;
  DateTime? _pickedBirthdate;

  @protected
  @override
  void onDispose() {
    surnameCtrl.dispose();
    nameCtrl.dispose();
  }

  String get pickedBirthdate {
    final dt = _pickedBirthdate;
    if (dt == null) return '';
    return '${dt.year}-${dt.month}-${dt.day}';
  }

  void selectGender(EGender? newGender) {
    selectedGender = newGender;
    refreshUI();
  }

  void pickBirthdate() async {
    _pickedBirthdate = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 30)),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
    );
    refreshUI();
  }

  void onNext() {
    final birthdate = _pickedBirthdate;
    final gender = selectedGender;
    final firstName = surnameCtrl.text;
    final lastName = nameCtrl.text;
    final currentUser =
        _currentUser ?? Modular.get<CurrentUserCubit>().state.requireData;
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
      UiAlertHelpers.showErrorSnackBar(
        context,
        LocaleKeys.kyc_module_common_all_fields_required.tr(),
      );
    }
  }
}
