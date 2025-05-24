import 'package:hive/hive.dart';

part 'photo.g.dart';

@HiveType(typeId: 1)
class Photo {
  @HiveField(0)
  final int albumId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });
}
