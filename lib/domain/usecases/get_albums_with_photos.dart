import '../entities/album.dart';
import '../repositories/album_repository.dart';

class GetAlbumsWithPhotos {
  final AlbumRepository repository;
  GetAlbumsWithPhotos(this.repository);

  Future<List<Album>> call() => repository.getAlbumsWithPhotos();
}
