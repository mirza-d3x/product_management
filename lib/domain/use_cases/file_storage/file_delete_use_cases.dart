import 'package:techwarelab/domain/repositories/firebase_storage/firebase_storage_repo.dart';

class DeleteFileUseCase {
  final FirebaseStorageRepository _storageRepository;

  DeleteFileUseCase(this._storageRepository);

  Future<void> call(String filePath) async {
    return await _storageRepository.deleteFile(filePath);
  }
}
