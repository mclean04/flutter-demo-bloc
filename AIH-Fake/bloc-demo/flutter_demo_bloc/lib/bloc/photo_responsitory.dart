import 'dart:ffi';

import 'package:flutter_demo_bloc/base/services/services.dart';
import 'package:flutter_demo_bloc/model/Photo.dart';



class PhotoRespository {

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


  Future<Photo?> getDetailPhoto(Int albumId) async{
     var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var response = await BaseServices.getMethodPath(
        'https://jsonplaceholder.typicode.com/photos', albumId.toString());

    if (response != null) {
      return response.map<Photo>((json) => Photo.fromJson(json)).toList();
    } else {
      return null;
    }
  }
}
