import 'dart:async';
import 'dart:ffi';

import 'package:flutter_demo_bloc/base/bloc.dart';
import 'package:flutter_demo_bloc/model/Photo.dart';

import 'photo_responsitory.dart';

class PhotoBloc implements BaseBloc {
  final _listPhotoController = StreamController<List<Photo>>();

  Sink<List<Photo>> get listPhoto => _listPhotoController.sink;

  late Stream<List<Photo>?> photoStream;

  final _respository = PhotoRespository();

  PhotoBloc() {
    fetchPhotos();
    photoStream = _listPhotoController.stream;
  }

  fetchPhotos() async {
    // Use the compute function to run parsePhotos in a separate isolate.
    var info =
        await _respository.getListPhoto().timeout(const Duration(minutes: 5));
    try {
      if (info != null) {
        _listPhotoController.sink.add(info);
      } else {
        _listPhotoController.sink.addError("No data");
      }
    } catch (e) {
      _listPhotoController.sink.addError(e.toString());
    }
  }

  

  @override
  void dispose() {
    _listPhotoController.close();
  }
}
