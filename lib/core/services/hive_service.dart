import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/album_model.dart';
import '../../data/models/photo_model.dart';

class HiveService {
  static const String albumBoxName = 'albums';
  static const String photoBoxName = 'photos';

  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    Hive.registerAdapter(AlbumModelAdapter());
    Hive.registerAdapter(PhotoModelAdapter());
    
    // Open boxes
    await Hive.openBox<AlbumModel>(albumBoxName);
    await Hive.openBox<PhotoModel>(photoBoxName);
  }

  static Box<AlbumModel> getAlbumBox() {
    return Hive.box<AlbumModel>(albumBoxName);
  }

  static Box<PhotoModel> getPhotoBox() {
    return Hive.box<PhotoModel>(photoBoxName);
  }
} 