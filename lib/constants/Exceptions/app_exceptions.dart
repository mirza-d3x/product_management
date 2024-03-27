class UserNotFoundException implements Exception {}

class WeakPasswordException implements Exception {}

class WrongPasswordException implements Exception {}

class UserAlreadyExistsException implements Exception {}

class SignOutException implements Exception {}

class GenericAuthException implements Exception {}

class SecureStorageException implements Exception {
  final String message;
  SecureStorageException(this.message);
}
