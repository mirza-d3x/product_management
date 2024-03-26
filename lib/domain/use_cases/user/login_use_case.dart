import 'package:techwarelab/domain/entities/users/users.dart';

import '../../repositories/users/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository _authRepository;

  LoginUserUseCase(this._authRepository);

  Future<UserEntity> call(String email, String password) async {
    return await _authRepository.signInWithEmailAndPassword(email, password);
  }
}
