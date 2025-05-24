import '../../domain/entities/album.dart';
import 'photo_model.dart';
import 'package:hive/hive.dart';

part 'album_model.g.dart';

@HiveType(typeId: 0)
class AlbumModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int userId;

  @HiveField(2)
  final String title;

  AlbumModel({
    required this.id,
    required this.userId,
    required this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
    };
  }

  Album toEntity(List<PhotoModel> allPhotos) {
    final albumPhotos = allPhotos.where((p) => p.albumId == id).map((p) => p.toEntity()).toList();
    return Album(userId: userId, id: id, title: title, photos: albumPhotos);
  }
}
