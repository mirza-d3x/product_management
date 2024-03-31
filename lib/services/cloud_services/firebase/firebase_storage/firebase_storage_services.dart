import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:techwarelab/domain/repositories/firebase_storage/firebase_storage_repo.dart';
import 'package:techwarelab/utils/console_log.dart';

class FirebaseStorageService implements FirebaseStorageRepository {
  FirebaseStorageService() {
    init();
  }

  late FirebaseStorage _storage;

  void init() {
    _storage = FirebaseStorage.instance;
  }

  @override
  Future<String> uploadFile(
      {required File file, required String destinationPath}) async {
    try {
      consoleLog("Uploading File to: $destinationPath");
      await _storage
          .ref(destinationPath)
          .putFile(file, SettableMetadata(contentType: 'image/jpg'));
      return await _storage.ref(destinationPath).getDownloadURL();
    } catch (error, stacktrace) {
      consoleLog("Error uploading file: ",
          error: error, stackTrace: stacktrace);
      throw FirebaseException(
          plugin: "storage", message: error.toString(), stackTrace: stacktrace);
    }
  }

  @override
  Future<void> deleteFile(String filePath) async {
    try {
      await _storage.ref(filePath).delete();
    } catch (error, stacktrace) {
      consoleLog("Error deleting file: ", error: error, stackTrace: stacktrace);
      throw Exception('Error deleting file: $error');
    }
  }
}
