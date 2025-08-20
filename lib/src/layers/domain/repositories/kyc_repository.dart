import 'package:dartz/dartz.dart';

import '../entities/kyc_entity.dart';
import '../entities/kyc_submission_entity.dart';
import '../value_objects/failure.dart';

abstract class KycRepository {
  /// Get your previously filled Kyc form data
  Future<Either<Failure, KycEntity>> getKycStatus();

  /// Submit your kyc
  Future<Either<Failure, Unit>> submitKyc(KycSubmissionEntity submission);

  /// Cancel (if exists) previously filled Kyc form data
  Future<Either<Failure, Unit>> cancelKyc();
}
