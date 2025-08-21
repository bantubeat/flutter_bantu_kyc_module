import 'package:equatable/equatable.dart';

import 'enums/kyc_status.dart';

class KycEntity extends Equatable {
  final String uuid;
  final EKycStatus status;
  final String firstName;
  final String? lastName;
  final String address;
  final String city;
  final String country;
  final String? zipCode;
  final String? frontFaceImageUrl;
  final String? backFaceImageUrl;
  final String? selfieWithIdCardImageUrl;
  final String? normalSelfieImageUrl;
  final String? adminMessage;
  final String? linkRs;
  final String? email;

  const KycEntity({
    required this.uuid,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.country,
    required this.zipCode,
    required this.frontFaceImageUrl,
    required this.backFaceImageUrl,
    required this.selfieWithIdCardImageUrl,
    required this.normalSelfieImageUrl,
    required this.adminMessage,
    required this.linkRs,
    required this.email,
  });

  @override
  List<Object?> get props => [uuid, status, firstName, lastName];
}
