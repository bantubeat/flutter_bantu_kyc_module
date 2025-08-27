/// A data enity for the KYC (Know Your Customer) form.
class KycSubmissionEntity {
  final String firstName;
  final String? lastName;
  final String address;
  final String city;
  final String country;
  final String? zipCode;
  final String frontFaceImagePath;
  final String backFaceImagePath;
  final String selfieWithIdCardImagePath;
  final String normalSelfieImagePath;
  final String? linkRs;
  final String email;

  final ({String name, String registrationNumber, String? tva})? company;
  final ({String registrationNumber})? particular;

  /// Creates a [KycSubmissionEntity] instance.
  ///
  /// Note that company-related fields are nullable as they are only
  /// relevant if [isCompany] is true.
  const KycSubmissionEntity({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.frontFaceImagePath,
    required this.backFaceImagePath,
    required this.selfieWithIdCardImagePath,
    required this.normalSelfieImagePath,
    required this.linkRs,
    required this.email,
    required this.company,
    required this.particular,
  });
}
