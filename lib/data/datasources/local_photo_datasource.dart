import 'package:hive/hive.dart';
import '../models/photo_model.dart';

abstract class LocalPhotoDataSource {
  Future<List<PhotoModel>> getPhotos(int albumId);
  Future<void> cachePhotos(List<PhotoModel> photos);
}

class LocalPhotoDataSourceImpl implements LocalPhotoDataSource {
  final Box<PhotoModel> photoBox;

  LocalPhotoDataSourceImpl({required this.photoBox});

  @override
  Future<List<PhotoModel>> getPhotos(int albumId) async {
    try {
      return photoBox.values.where((photo) => photo.albumId == albumId).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> cachePhotos(List<PhotoModel> photos) async {
    try {
      // Clear only photos for the specific album
      final albumId = photos.first.albumId;
      final existingPhotos = photoBox.values.where((photo) => photo.albumId == albumId);
      for (var photo in existingPhotos) {
        await photoBox.deleteAt(photoBox.values.toList().indexOf(photo));
      }
      await photoBox.addAll(photos);
    } catch (e) {
      throw Exception('Failed to cache photos');
    }
  }
} 