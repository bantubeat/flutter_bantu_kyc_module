import 'package:equatable/equatable.dart';
import 'package:flutter_bantu_kyc_module/src/layers/domain/entities/kyc_entity.dart';

abstract class KycState extends Equatable {
  const KycState();
  @override
  List<Object?> get props => [];
}

class KycInitial extends KycState {}

class KycLoading extends KycState {}

class KycStatusLoaded extends KycState {
  final KycEntity kyc;
  const KycStatusLoaded(this.kyc);
  @override
  List<Object?> get props => [kyc];
}

class KycNotSubmitted extends KycState {}

class KycSubmissionSuccess extends KycState {}

class KycError extends KycState {
  final String message;
  const KycError(this.message);
  @override
  List<Object?> get props => [message];
}
