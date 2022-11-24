import 'package:flutter/material.dart';
import 'package:flutter_demo_bloc/base/base_bloc_provider.dart';
import 'package:flutter_demo_bloc/bloc/list_photo_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import 'model/Photo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BaseBlocProvider(
        bloc: PhotoBloc(),
        child: MaterialApp(
          title: 'Flutter Bloc Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MainHome(),
        ));
  }
}

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<PhotoBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Testing"),
        ),
        body: StreamBuilder<List<Photo>?>(
          stream: bloc.photoStream,
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: photos[index].thumbnailUrl ?? "",
            ),
            Flexible(
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    photos[index].title.toString(),
                    maxLines: 4,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  )),
            )
          ],
        );
      },
    );
  }
}
