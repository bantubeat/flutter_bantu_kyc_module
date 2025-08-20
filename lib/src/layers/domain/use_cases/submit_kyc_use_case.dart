import 'package:dartz/dartz.dart';

import '../entities/kyc_submission_entity.dart';
import '../repositories/kyc_repository.dart';
import '../value_objects/failure.dart';

class SubmitKycUseCase {
  final KycRepository _repository;

  const SubmitKycUseCase(this._repository);

  Future<Either<Failure, Unit>> call(KycSubmissionEntity submission) async {
    return await _repository.submitKyc(submission);
  }
}
