import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/bloc/album_bloc.dart';
import '../../application/bloc/album_event.dart';
import '../../application/bloc/album_state.dart';
import '../widgets/album_tile.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});
  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AlbumBloc>().add(LoadAlbumsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (_, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(state.message),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed:
                        () => context.read<AlbumBloc>().add(LoadAlbumsEvent()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder:
                  (_, i) => AlbumTile(
                    album: state.albums[i],
                    onTap: () => context.push('/detail', extra: state.albums[i]),
                  ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
