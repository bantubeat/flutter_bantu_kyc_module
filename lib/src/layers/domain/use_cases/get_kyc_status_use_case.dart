import 'package:dartz/dartz.dart';

import '../entities/kyc_entity.dart';
import '../repositories/kyc_repository.dart';
import '../value_objects/failure.dart';

class GetKycStatusUseCase {
  final KycRepository _repository;

  const GetKycStatusUseCase(this._repository);

  Future<Either<Failure, KycEntity>> call() async {
    return await _repository.getKycStatus();
  }
}
