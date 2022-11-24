import 'package:flutter_demo_bloc/base/services/services.dart';

import '../model/Photo.dart';

class ListPhotoRespository {

  Future<List<Photo>?> getListPhoto() async{
     var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var response = await BaseServices.getMethod(
        'https://jsonplaceholder.typicode.com/photos', header);

    if (response != null) {
      return response.map<Photo>((json) => Photo.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}
