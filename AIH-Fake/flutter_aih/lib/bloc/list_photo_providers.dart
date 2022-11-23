import 'dart:convert';

import 'package:flutter_aih/model/Photo.dart';
import 'package:flutter_aih/services/services.dart';
import 'package:http/http.dart';

class ListPhotoProvider {
  Client client = Client();
  Future<List<Photo>?> getListPhoto() async{
    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var response = await BaseServices.getMethod(
        'https://jsonplaceholder.typicode.com/photos', header);

        
    if (response != null){
      return response.map<Photo>((json)=> Photo.fromJson(json)).toList();
    } else return null;
  }
}