import 'dart:async';

import 'package:flutter_demo_bloc/base/bloc.dart';
import 'package:flutter_demo_bloc/bloc/photo_responsitory.dart';
import 'package:flutter_demo_bloc/model/Photo.dart';

class DetailPhotoBloc implements BaseBloc {
   final _detailPhotoController = StreamController<Photo>();
   Sink<Photo> get detailPhoto => _detailPhotoController.sink;

  late Stream<Photo?> detailPhotoStream;

  final _respository = PhotoRespository();

  DetailPhotoBloc(int albumId){
    fetchDetail(albumId);
    detailPhotoStream = _detailPhotoController.stream;
  }

  fetchDetail(int albumId) async {
    var info = await _respository
        .getDetailPhoto(albumId)
        .timeout(const Duration(minutes: 5));
    try {
      if (info != null) {
        _detailPhotoController.sink.add(info);
      } else {
        _detailPhotoController.sink.addError("No data");
      }
    } catch (e) {
      _detailPhotoController.sink.addError(e.toString());
    }
  }
  
  @override
  void dispose() {
    _detailPhotoController.close();
  }
}