import 'package:hive/hive.dart';
import '../models/album_model.dart';

abstract class LocalAlbumDataSource {
  Future<List<AlbumModel>> getAlbums();
  Future<void> cacheAlbums(List<AlbumModel> albums);
}

class LocalAlbumDataSourceImpl implements LocalAlbumDataSource {
  final Box<AlbumModel> albumBox;

  LocalAlbumDataSourceImpl({required this.albumBox});

  @override
  Future<List<AlbumModel>> getAlbums() async {
    try {
      return albumBox.values.toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> cacheAlbums(List<AlbumModel> albums) async {
    try {
      await albumBox.clear();
      await albumBox.addAll(albums);
    } catch (e) {
      throw Exception('Failed to cache albums');
    }
  }
} 