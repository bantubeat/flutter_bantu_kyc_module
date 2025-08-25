import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/kyc_submission_entity.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/user_entity.dart';
import 'package:image_picker/image_picker.dart' show XFile;

// MARK: Personal Info (from a first screen)
enum EGender { M, F, O }

class KycFormDataStep1 {
  final UserEntity currentUser;
  final String firstName;
  final String? lastName;
  final DateTime birthdate;
  final EGender gender;

  const KycFormDataStep1({
    required this.firstName,
    required this.lastName,
    required this.currentUser,
    required this.birthdate,
    required this.gender,
  });
}

// MARK: Address Info (from KycAddressScreen)
class KycFormDataStep2 {
  final KycFormDataStep1 previousData;
  final String street;
  final String city;
  final CountryCode country;
  final String postalCode;

  KycFormDataStep2({
    required this.previousData,
    required this.street,
    required this.city,
    required this.country,
    required this.postalCode,
  });
}

// MARK: ID Info (from KycIdTypeScreen & KycIdUploadScreen)
enum EVerificationMethod { passport, nationalCni, drivingLicense }

class KycFormDataStep3 {
  final KycFormDataStep2 step2Data;
  final EVerificationMethod verificationMethod;
  final CountryCode idCountry;
  final XFile rectoIdImage;
  final XFile versoIdImage;

  KycFormDataStep3({
    required this.step2Data,
    required this.verificationMethod,
    required this.idCountry,
    required this.rectoIdImage,
    required this.versoIdImage,
  });
}

class KycFormDataStep4 {
  final KycFormDataStep3 step3Data;

  KycFormDataStep4(this.step3Data);
}
// MARK: Payment Info (from KycPaymentScreen)

/*
enum EAccountType { mobile, bank }

typedef MobilePaymentAccountInfo = ({
  CountryCode paymentCountry,
  String mobileOperator,
  String mobileAccountNumber,
  String accountHolderName,
  XFile? otherDocument,
});
typedef BankPaymentAccountInfo = ({
  String bankName,
  String bankAccountNumber,
  String bankSwiftCode,
  String accountHolderName,
  XFile? bankDocument,
});

class KycFormDataStep4 {
  final KycFormDataStep3 step3Data;
  final EAccountType accountType;
  final MobilePaymentAccountInfo? mobileAccountInfo;
  final BankPaymentAccountInfo? bankAccountInfo;

  KycFormDataStep4.mobilePayment({
    required this.step3Data,
    required CountryCode paymentCountry,
    required String mobileOperator,
    required String mobileAccountNumber,
    required String accountHolderName,
    required XFile? otherDocument,
  }) : accountType = EAccountType.mobile,
       mobileAccountInfo = (
         paymentCountry: paymentCountry,
         mobileOperator: mobileOperator,
         mobileAccountNumber: mobileAccountNumber,
         accountHolderName: accountHolderName,
         otherDocument: otherDocument,
       ),
       bankAccountInfo = null;

  KycFormDataStep4.bankPayment({
    required this.step3Data,
    required String bankName,
    required String bankAccountNumber,
    required String bankSwiftCode,
    required String accountHolderName,
    required XFile? bankDocument,
  }) : accountType = EAccountType.bank,
       mobileAccountInfo = null,
       bankAccountInfo = (
         bankName: bankName,
         bankAccountNumber: bankAccountNumber,
         bankSwiftCode: bankSwiftCode,
         accountHolderName: accountHolderName,
         bankDocument: bankDocument,
       );
}
*/

// MARK: Selfies (from KycSelfieScreen)
class KycFormDataStep5 {
  final KycFormDataStep4 step4Data;
  final XFile selfieImage;

  KycFormDataStep5({required this.step4Data, required this.selfieImage});
}

class KycFormDataStep6 {
  final KycFormDataStep5 step5Data;
  final XFile selfieWithIdImage;

  KycFormDataStep6({required this.step5Data, required this.selfieWithIdImage});

  Future<KycSubmissionEntity> toSubmission() async {
    final step1Data = step5Data.step4Data.step3Data.step2Data.previousData;
    final step2Data = step5Data.step4Data.step3Data.step2Data;
    final step3Data = step5Data.step4Data.step3Data;
    return KycSubmissionEntity(
      firstName: step1Data.firstName,
      lastName: step1Data.lastName,
      address: step2Data.street,
      city: step2Data.city,
      country: step2Data.country.code ?? step1Data.currentUser.pays,
      zipCode: step2Data.postalCode,
      frontFaceImagePath: step3Data.rectoIdImage.path,
      backFaceImagePath: step3Data.versoIdImage.path,
      normalSelfieImagePath: step5Data.selfieImage.path,
      selfieWithIdCardImagePath: selfieWithIdImage.path,
      email: step1Data.currentUser.email,
      linkRs: null, // Assuming linkRs is not used in this context
    );
  }
}
