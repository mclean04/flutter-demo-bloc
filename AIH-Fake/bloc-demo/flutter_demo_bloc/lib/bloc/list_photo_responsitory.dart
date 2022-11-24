import '../model/Photo.dart';
import 'list_photo_providers.dart';

class ListPhotoRespository {
  var listPhotoProviders = ListPhotoProvider();

  Future<List<Photo>?> getListPhoto() {
    return listPhotoProviders.getListPhoto();
  }
}
