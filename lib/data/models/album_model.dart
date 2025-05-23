import '../../domain/entities/album.dart';
import 'photo_model.dart';

class AlbumModel extends Album {
  AlbumModel({
    required super.userId,
    required super.id,
    required super.title,
    required List<PhotoModel> super.photos,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      photos: [], // fill later
    );
  }

  Album toEntity(List<PhotoModel> allPhotos) {
    final albumPhotos = allPhotos.where((p) => p.albumId == id).toList();
    return Album(userId: userId, id: id, title: title, photos: albumPhotos);
  }
}
