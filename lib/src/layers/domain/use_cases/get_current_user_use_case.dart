import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<UserEntity> call() async {
    return await _repository.getCurrentUser();
  }
}
