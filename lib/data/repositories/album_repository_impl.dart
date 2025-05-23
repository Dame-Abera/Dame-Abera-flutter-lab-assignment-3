import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/remote_album_datasource.dart';
import '../datasources/remote_photo_datasource.dart';
import '../models/album_model.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final RemoteAlbumDataSource albumDs;
  final RemotePhotoDataSource photoDs;

  AlbumRepositoryImpl({required this.albumDs, required this.photoDs});

  @override
  Future<List<Album>> getAlbumsWithPhotos() async {
    final albums = await albumDs.fetchAlbums();
    final photos = await photoDs.fetchPhotos();
    return albums
        .map(
          (a) => AlbumModel(
            userId: a.userId,
            id: a.id,
            title: a.title,
            photos: [],
          ).toEntity(photos),
        )
        .toList();
  }
}
