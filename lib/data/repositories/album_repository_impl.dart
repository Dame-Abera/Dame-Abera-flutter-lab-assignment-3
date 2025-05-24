import '../../domain/entities/album.dart';
import '../../domain/repositories/album_repository.dart';
import '../datasources/remote_album_datasource.dart';
import '../datasources/remote_photo_datasource.dart';
import '../models/album_model.dart';
import '../../core/services/hive_service.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final RemoteAlbumDataSource albumDs;
  final RemotePhotoDataSource photoDs;

  AlbumRepositoryImpl({required this.albumDs, required this.photoDs});

  @override
  Future<List<Album>> getAlbumsWithPhotos() async {
    try {
      // Try to get data from cache
      final cachedAlbums = HiveService.getAlbumBox().values.toList();
      final cachedPhotos = HiveService.getPhotoBox().values.toList();

      // Only use cache if we have both albums and photos
      if (cachedAlbums.isNotEmpty && cachedPhotos.isNotEmpty) {
        try {
          return cachedAlbums
              .map((album) => album.toEntity(cachedPhotos))
              .toList();
        } catch (e) {
          // If there's an error with cached data, clear cache and fetch fresh
          await _clearCache();
        }
      }

      // Fetch fresh data from remote
      final albums = await albumDs.fetchAlbums();
      final photos = await photoDs.fetchPhotos();

      // Clear existing cache before storing new data
      await _clearCache();

      // Store fetched data in cache
      final albumModels =
          albums
              .map(
                (e) => AlbumModel(userId: e.userId, id: e.id, title: e.title),
              )
              .toList();

      await HiveService.getAlbumBox().addAll(albumModels);
      await HiveService.getPhotoBox().addAll(photos);

      return albumModels.map((album) => album.toEntity(photos)).toList();
    } catch (e) {
      // If everything fails, try one last time to fetch from remote
      final albums = await albumDs.fetchAlbums();
      final photos = await photoDs.fetchPhotos();

      final albumModels =
          albums
              .map(
                (e) => AlbumModel(userId: e.userId, id: e.id, title: e.title),
              )
              .toList();

      return albumModels.map((album) => album.toEntity(photos)).toList();
    }
  }

  Future<void> _clearCache() async {
    try {
      await HiveService.getAlbumBox().clear();
      await HiveService.getPhotoBox().clear();
    } catch (e) {
      // Ignore cache clearing errors
    }
  }
}
