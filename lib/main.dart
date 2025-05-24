import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'router.dart';
import 'data/datasources/remote_album_datasource.dart';
import 'data/datasources/remote_photo_datasource.dart';
import 'data/repositories/album_repository_impl.dart';
import 'domain/usecases/get_albums_with_photos.dart';
import 'application/bloc/album_bloc.dart';
import 'core/services/hive_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await HiveService.init();

  final client = http.Client();
  final albumDs = RemoteAlbumDataSourceImpl(client: client);
  final photoDs = RemotePhotoDataSourceImpl(client: client);
  final repo = AlbumRepositoryImpl(albumDs: albumDs, photoDs: photoDs);
  
  final usecase = GetAlbumsWithPhotos(repo);

  runApp(
    BlocProvider(
      create: (_) => AlbumBloc(usecase: usecase),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Lab #3',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(secondary: Colors.orangeAccent),
        fontFamily: '.SF Pro Display',
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
