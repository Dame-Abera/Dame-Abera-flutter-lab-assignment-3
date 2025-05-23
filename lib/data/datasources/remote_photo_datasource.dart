import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

abstract class RemotePhotoDataSource {
  Future<List<PhotoModel>> fetchPhotos();
}

class RemotePhotoDataSourceImpl implements RemotePhotoDataSource {
  final http.Client client;
  RemotePhotoDataSourceImpl({required this.client});

  @override
  Future<List<PhotoModel>> fetchPhotos() async {
    final resp = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    if (resp.statusCode == 200) {
      final List data = json.decode(resp.body) as List;
      return data.map((j) => PhotoModel.fromJson(j)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
