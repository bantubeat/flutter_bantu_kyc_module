import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/kyc_bantubeat_api_data_source.dart';

class UserRepositoryImpl extends UserRepository {
  final KycBantubeatApiDataSource _apiDataSource;

  UserRepositoryImpl(this._apiDataSource);

  @override
  Future<UserEntity> getCurrentUser() => _apiDataSource.get$authUser();
}
