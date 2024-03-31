import 'dart:io';

abstract class FirebaseStorageRepository {
  Future<String> uploadFile(
      {required File file, required String destinationPath});
  Future<void> deleteFile(String filePath);
}
