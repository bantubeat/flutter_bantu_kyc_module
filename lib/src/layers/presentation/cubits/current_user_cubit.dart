import 'package:flutter/material.dart' show AsyncSnapshot, ConnectionState;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/use_cases/get_current_user_use_case.dart';

class CurrentUserCubit extends Cubit<AsyncSnapshot<UserEntity>> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  CurrentUserCubit(this._getCurrentUserUseCase)
    : super(const AsyncSnapshot.nothing()) {
    fetchCurrentUser();
  }

  void fetchCurrentUser({bool forceRefresh = true}) async {
    if (!forceRefresh && state.hasData) return; // Already fetching or has data

    // Exit if Already fetching
    if (state.connectionState == ConnectionState.waiting) return;

    emit(state.inState(ConnectionState.waiting));

    try {
      final data = await _getCurrentUserUseCase.call();
      emit(AsyncSnapshot.withData(ConnectionState.done, data));
    } catch (error, stacktrace) {
      emit(AsyncSnapshot.withError(ConnectionState.none, error, stacktrace));
    }
  }
}
