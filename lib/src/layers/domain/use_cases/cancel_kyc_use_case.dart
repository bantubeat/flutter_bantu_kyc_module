import 'package:dartz/dartz.dart';

import '../repositories/kyc_repository.dart';
import '../value_objects/failure.dart';

class CancelKycUseCase {
  final KycRepository _repository;

  const CancelKycUseCase(this._repository);

  Future<Either<Failure, Unit>> call() async {
    return await _repository.cancelKyc();
  }
}
