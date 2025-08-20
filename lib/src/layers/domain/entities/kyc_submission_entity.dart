import 'dart:typed_data' show Uint8List;

/// A data enity for the KYC (Know Your Customer) form.
class KycSubmissionEntity {
  final String firstName;
  final String? lastName;
  final String address;
  final String city;
  final String country;
  final String? zipCode;
  final Uint8List frontFaceImage;
  final Uint8List backFaceImage;
  final Uint8List selfieWithIdCardImage;
  final Uint8List normalSelfieImage;
  final String? linkRs;
  final String email;

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
    required this.frontFaceImage,
    required this.backFaceImage,
    required this.selfieWithIdCardImage,
    required this.normalSelfieImage,
    required this.linkRs,
    required this.email,
  });
}
