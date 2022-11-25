import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_demo_bloc/base/base_bloc_provider.dart';
import 'package:flutter_demo_bloc/bloc/detail_photo.dart';
import 'package:flutter_demo_bloc/model/Photo.dart';

class DetailPhoto extends StatefulWidget {
  const DetailPhoto({super.key});

  @override
  State<DetailPhoto> createState() => _DetailPhotoState();
}

class _DetailPhotoState extends State<DetailPhoto> {
  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<DetailPhotoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: StreamBuilder<Photo?>(
        stream: bloc.detailPhotoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return _buildPhotosDetail(photo: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildPhotosDetail({required Photo photo}) {
    return Column(
      children: [
        Text("${photo.title}")
      ],
    );
  }
}
