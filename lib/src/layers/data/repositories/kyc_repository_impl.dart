import 'package:dartz/dartz.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/kyc_entity.dart';

import '../../domain/entities/kyc_submission_entity.dart';
import '../../domain/repositories/kyc_repository.dart';
import '../../domain/value_objects/failure.dart';
import '../data_sources/bantubeat_api_data_source.dart';

class KycRepositoryImpl implements KycRepository {
  final BantubeatApiDataSource _bantubeatApiDataSource;

  const KycRepositoryImpl(this._bantubeatApiDataSource);

  @override
  Future<Either<Failure, Unit>> cancelKyc() async {
    try {
      await _bantubeatApiDataSource.delete$accountKyc();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, KycEntity>> getKycStatus() async {
    try {
      final kycModel = await _bantubeatApiDataSource.get$accountKyc();
      return Right(kycModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitKyc(
    KycSubmissionEntity submission,
  ) async {
    try {
      await _bantubeatApiDataSource.post$accountKyc(
        firstName: submission.firstName,
        address: submission.address,
        city: submission.city,
        country: submission.country,
        frontFaceImageBytes: submission.frontFaceImage,
        backFaceImageBytes: submission.backFaceImage,
        normalSelfieImageBytes: submission.normalSelfieImage,
        selfieWithIdCardImageBytes: submission.selfieWithIdCardImage,
        linkRs: submission.linkRs,
        email: submission.email,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
