import '../../domain/entities/photo.dart';
import 'package:hive/hive.dart';

part 'photo_model.g.dart';

@HiveType(typeId: 1)
class PhotoModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int albumId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final String thumbnailUrl;

  PhotoModel({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] as int,
      albumId: json['albumId'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'albumId': albumId,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  Photo toEntity() {
    return Photo(
      id: id,
      albumId: albumId,
      title: title,
      url: url,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
