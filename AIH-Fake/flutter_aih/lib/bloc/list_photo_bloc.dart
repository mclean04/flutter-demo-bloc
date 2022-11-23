import 'dart:async';
import 'dart:convert';

import 'package:flutter_aih/bloc/list_photo_responsitory.dart';
import 'package:flutter_aih/model/Photo.dart';
import 'package:flutter_aih/services/services.dart';
import 'package:rxdart/rxdart.dart';

class PhotoBloc {
  var _listPhoto = PublishSubject<List<Photo>>();

  Stream<List<Photo>> get listPhoto => _listPhoto.stream;

  var _respository = ListPhotoRespository();

  fetchPhotos() async {
    // Use the compute function to run parsePhotos in a separate isolate.
    var info = await _respository.getListPhoto().timeout(Duration(minutes: 5));
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

  


  void dispose(){
      _listPhoto.close();
  }
}
