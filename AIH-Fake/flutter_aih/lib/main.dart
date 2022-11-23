import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aih/bloc/list_photo_bloc.dart';
import 'package:flutter_aih/model/Photo.dart';
import 'package:flutter_aih/services/services.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainHome(),
    );
  }
}

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  var getList = PhotoBloc();
  @override
  void initState() {
    super.initState();
    getList.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing"),
      ),
      body: StreamBuilder<List<Photo>>(
        stream: getList.listPhoto,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    getList.dispose();
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(photos[index].thumbnailUrl ?? ""),
            Flexible(
              child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    photos[index].title.toString(),
                    maxLines: 4,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  )),
            )
          ],
        ));
      },
    );
  }
}
