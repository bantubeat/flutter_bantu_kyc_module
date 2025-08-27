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

// MARK: Fiscal Info (from KycFiscalInfoScreen)

class KycFormDataStep4 {
  final KycFormDataStep3 step3Data;
  final bool isCompany;
  final String companyRegistrationNumber;
  final String? companyTva;
  final String companyName;
  final XFile? fiscalDocument;

  const KycFormDataStep4({
    required this.step3Data,
    required this.isCompany,
    required this.companyRegistrationNumber,
    required this.companyName,
    required this.companyTva,
    required this.fiscalDocument,
  });
}

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
    final step4Data = step5Data.step4Data;
    final step3Data = step4Data.step3Data;
    final step2Data = step3Data.step2Data;
    final step1Data = step2Data.previousData;
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
      company: step4Data.isCompany
          ? (
              name: step4Data.companyName,
              registrationNumber: step4Data.companyRegistrationNumber,
              tva: step4Data.companyTva,
            )
          : null,
      particular: !step4Data.isCompany
          ? (registrationNumber: step4Data.companyRegistrationNumber)
          : null,
    );
  }
}
