import 'package:flutter/material.dart';
import '../../domain/entities/album.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final VoidCallback onTap;
  const AlbumTile({super.key, required this.album, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final thumb =
        album.photos.isNotEmpty ? album.photos.first.thumbnailUrl : null;

    return ListTile(
      leading:
          thumb != null
              ? Image.network(thumb, width: 50, height: 50, fit: BoxFit.cover)
              : const SizedBox(width: 50, height: 50),
      title: Text(album.title),
      onTap: onTap,
    );
  }
}
