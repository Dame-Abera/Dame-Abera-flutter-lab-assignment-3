import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';

abstract class RemoteAlbumDataSource {
  Future<List<AlbumModel>> fetchAlbums();
}

class RemoteAlbumDataSourceImpl implements RemoteAlbumDataSource {
  final http.Client client;
  RemoteAlbumDataSourceImpl({required this.client});

  @override
  Future<List<AlbumModel>> fetchAlbums() async {
    final resp = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );
    if (resp.statusCode == 200) {
      final List data = json.decode(resp.body) as List;
      return data.map((j) => AlbumModel.fromJson(j)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }
}
