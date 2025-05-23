import '../entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbumsWithPhotos();
}
