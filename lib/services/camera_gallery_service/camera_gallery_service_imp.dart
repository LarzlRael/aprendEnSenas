part of './../services.dart';

class CamerGalleryServiceImp extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<List<String>?> selectFromGallery() async {
    final List<XFile> photos = await _picker.pickMultiImage(
      imageQuality: 80,
    );

    if (photos.isEmpty) {
      return null;
    }

    final List<String> photoPaths = photos.map((photo) => photo.path).toList();
    return photoPaths;
  }

  @override
  Future<List<String>?> selectMultiplePhotos() {
    // TODO: implement selectMultiplePhotohs
    throw UnimplementedError();
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;
    return photo.path;
  }
}
