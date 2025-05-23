import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../../domain/usecases/get_albums_with_photos.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final GetAlbumsWithPhotos usecase;
  AlbumBloc({required this.usecase}) : super(AlbumInitial()) {
    on<LoadAlbumsEvent>((e, emit) async {
      emit(AlbumLoading());
      try {
        final data = await usecase();
        emit(AlbumLoaded(data));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
