import 'dart:async';

import 'package:flutter_demo_bloc/base/bloc.dart';
import 'package:flutter_demo_bloc/model/Photo.dart';

import 'list_photo_responsitory.dart';

class PhotoBloc implements BaseBloc {
  final _listPhoto = StreamController<List<Photo>>();

  Sink<List<Photo>> get listPhoto => _listPhoto.sink;

  late Stream<List<Photo>?> photoStream;

  final _respository = ListPhotoRespository();

  PhotoBloc() {
    fetchPhotos();
    photoStream = _listPhoto.stream;
  }

  fetchPhotos() async {
    // Use the compute function to run parsePhotos in a separate isolate.
    var info =
        await _respository.getListPhoto().timeout(const Duration(minutes: 5));
    try {
      if (info != null) {
        _listPhoto.sink.add(info);
      } else {
        _listPhoto.sink.addError("No data");
      }
    } catch (Err) {
      _listPhoto.sink.addError(Err.toString());
    }
  }

  @override
  void dispose() {
    _listPhoto.close();
  }
}
