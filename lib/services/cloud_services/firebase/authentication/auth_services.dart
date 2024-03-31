import 'package:firebase_auth/firebase_auth.dart';
import 'package:techwarelab/constants/Exceptions/app_exceptions.dart';
import 'package:techwarelab/domain/entities/users/users.dart';
import 'package:techwarelab/utils/console_log.dart';

import '../../../../domain/repositories/users/auth_repository.dart';

class FirebaseAuthServices implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserEntity> signInWithEmailAndPassword(
      String email, String password) async {
    consoleLog("Signing With email: $email");
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      String? displayName = userCredential.user!.displayName ?? '';
      consoleLog("Display Name is : $displayName");
      return UserEntity(
        uid: userCredential.user!.uid,
        email: email,
        name: displayName,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // User not found, throw custom exception
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        // Wrong password, throw custom exception
        throw WrongPasswordException();
      } else {
        // Other FirebaseAuthException, throw generic exception
        throw GenericAuthException();
      }
    } catch (e) {
      // Catch any other unexpected exceptions and re-throw as generic exception
      throw GenericAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      consoleLog('Sign-out error: $e');
      throw SignOutException();
    }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
      String email, String password) async {
    consoleLog("Sign up With email: $email");
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? displayName = userCredential.user!.displayName ?? '';
      consoleLog("Display Name is : $displayName");
      return UserEntity(
        uid: userCredential.user!.uid,
        email: email,
        name: displayName,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // User already exists with the provided email, throw custom exception
        throw UserAlreadyExistsException();
      } else if (e.code == 'weak-password') {
        // Password provided is too weak, throw custom exception
        throw WeakPasswordException();
      } else {
        // Other FirebaseAuthException, throw generic exception
        throw GenericAuthException();
      }
    } catch (error, stackTrace) {
      consoleLog("Error signing up: ", error: error, stackTrace: stackTrace);
      throw GenericAuthException();
    }
  }

  // Function to check if the user is logged in
  Future<bool> isLoggedIn() async {
    // Simply check if FirebaseAuth's current user is logged in
    consoleLog("User Logged in:${_firebaseAuth.currentUser!.email!}");
    return _firebaseAuth.currentUser != null;
  }
}
