import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/kyc_submission_entity.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/use_cases/cancel_kyc_use_case.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/use_cases/get_kyc_status_use_case.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/use_cases/submit_kyc_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/value_objects/failure.dart';
import 'kyc_state.dart';

class KycCubit extends Cubit<KycState> {
  final GetKycStatusUseCase _getKycStatusUseCase;
  final SubmitKycUseCase _submitKycUseCase;
  final CancelKycUseCase _cancelKycUseCase;

  KycCubit(
    this._getKycStatusUseCase,
    this._submitKycUseCase,
    this._cancelKycUseCase,
  ) : super(KycInitial());

  Future<void> checkKycStatus() async {
    emit(KycLoading());
    final result = await _getKycStatusUseCase();
    result.fold((failure) {
      // If the API returns 404, it means no KYC has been submitted.
      if (failure is ServerFailure && failure.statusCode == 404) {
        emit(KycNotSubmitted());
      } else {
        emit(KycError(failure.message));
      }
    }, (kyc) => emit(KycStatusLoaded(kyc)));
  }

  Future<void> submitKycForm(KycSubmissionEntity submission) async {
    emit(KycLoading());
    final result = await _submitKycUseCase(submission);
    result.fold(
      (failure) => emit(KycError(failure.message)),
      (_) => checkKycStatus(),
    );
  }

  Future<void> cancelKyc() async {
    emit(KycLoading());
    final result = await _cancelKycUseCase();
    result.fold((failure) {
      // If the API returns 404, it means no KYC has been submitted.
      if (failure is ServerFailure && failure.statusCode == 404) {
        emit(KycNotSubmitted());
      } else {
        emit(KycError(failure.message));
      }
    }, (_) => checkKycStatus());
  }
}
