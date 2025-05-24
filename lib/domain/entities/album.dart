import 'package:hive/hive.dart';
import 'photo.dart';

part 'album.g.dart';

@HiveType(typeId: 0)
class Album {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final List<Photo> photos;

  Album({
    required this.userId,
    required this.id,
    required this.title,
    required this.photos,
  });
}
