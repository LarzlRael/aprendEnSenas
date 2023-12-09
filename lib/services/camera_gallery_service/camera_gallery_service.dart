part of './../services.dart';

abstract class CameraGalleryService {
  Future<String?> takePhoto();
  Future<List<String>?> selectFromGallery();
  Future<List<String>?> selectMultiplePhotos();
}
