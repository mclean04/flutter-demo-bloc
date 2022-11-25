import 'package:flutter/material.dart';
import 'package:flutter_demo_bloc/base/base_bloc_provider.dart';
import 'package:flutter_demo_bloc/bloc/photo_bloc.dart';
import 'package:flutter_demo_bloc/extension/ultils.dart';
import 'package:flutter_demo_bloc/view/list_photo.dart';
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
          debugShowCheckedModeBanner: false,
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Testing"),
        ),
        body:const PhotosList(),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
