import 'dart:io';

import 'package:techwarelab/domain/repositories/firebase_storage/firebase_storage_repo.dart';

class UploadFileUseCase {
  final FirebaseStorageRepository _storageRepository;

  UploadFileUseCase(this._storageRepository);

  Future<String> call(
      {required File file, required String destinationPath}) async {
    return await _storageRepository.uploadFile(
      file: file,
      destinationPath: destinationPath,
    );
  }
}
