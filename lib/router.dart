import 'package:go_router/go_router.dart';
import 'presentation/screens/album_list_screen.dart';
import 'presentation/screens/album_detail_screen.dart';
import 'domain/entities/album.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const AlbumListScreen()),
    GoRoute(
      path: '/detail',
      builder: (_, state) {
        final album = state.extra as Album;
        return AlbumDetailScreen(album: album);
      },
    ),
  ],
);
