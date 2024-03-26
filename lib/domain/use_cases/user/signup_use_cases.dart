import 'package:techwarelab/domain/entities/users/users.dart';

import '../../repositories/users/auth_repository.dart';

class SignUpUserUseCase {
  final AuthRepository _authRepository;

  SignUpUserUseCase(this._authRepository);

  Future<UserEntity> call(String email, String password) async {
    return await _authRepository.signUpWithEmailAndPassword(email, password);
  }
}
