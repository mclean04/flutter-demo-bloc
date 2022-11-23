import 'package:flutter_aih/bloc/list_photo_providers.dart';
import 'package:flutter_aih/model/Photo.dart';

class ListPhotoRespository {
  var listPhotoProviders = ListPhotoProvider();

  Future<List<Photo>?> getListPhoto() {
    return listPhotoProviders.getListPhoto();
  }
}