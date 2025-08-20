import '../../domain/entities/enums/kyc_status.dart';
import '../../domain/entities/kyc_entity.dart';

/// A data model for the KYC (Know Your Customer) form.
///
/// This class helps to serialize and deserialize KYC data from JSON format,
/// typically for use with REST APIs.
/// Data Transfer Object (DTO) that maps to the API response.
class KycModel extends KycEntity {
  const KycModel({
    required super.uuid,
    required super.status,
    required super.firstName,
    required super.lastName,
    required super.address,
    required super.city,
    required super.country,
    required super.zipCode,
    required super.frontFaceImageUrl,
    required super.backFaceImageUrl,
    required super.selfieWithIdCardImageUrl,
    required super.normalSelfieImageUrl,
    required super.linkRs,
    required super.email,
    required super.adminMessage,
  });

  factory KycModel.fromJson(Map<String, dynamic> json) {
    return KycModel(
      uuid: json['uuid'],
      status: _statusFromString(json['status']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      zipCode: json['zip_code'],
      frontFaceImageUrl: json['front_face_image_url'],
      backFaceImageUrl: json['back_face_image_url'],
      selfieWithIdCardImageUrl: json['selfie_with_id_card_image_url'],
      normalSelfieImageUrl: json['normal_selfie_image_url'],
      adminMessage: json['admin_message'],
      linkRs: json['link_rs'],
      email: json['email'],
    );
  }

  static EKycStatus _statusFromString(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return EKycStatus.pending;
      case 'SUCCESS':
        return EKycStatus.success;
      case 'FAILED':
        return EKycStatus.failed;
      default:
        return EKycStatus.unknow;
    }
  }

  /// Converts a [KycModel] instance to a JSON map.
  ///
  /// This is useful for sending data to an API.
  /*
  Map<String, dynamic> toJson() {
    return {
			'uuid': uuid, 
			'status': status,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'city': city,
      'country': country,
      'zip_code': zipCode,
      'front_face_image': frontFaceImageUrl,
      'back_face_image': backFaceImageUrl,
      'selfie_with_id_card_image': selfieWithIdCardImageUrl,
      'normal_selfie_image': normalSelfieImageUrl,
			'admin_message': adminMessage,
      'link_rs': linkRs,
      'email': email,
    };
  } */
}
