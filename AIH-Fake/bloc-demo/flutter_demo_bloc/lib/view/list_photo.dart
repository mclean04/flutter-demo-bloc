import 'package:flutter/material.dart';
import 'package:flutter_demo_bloc/base/base_bloc_provider.dart';
import 'package:flutter_demo_bloc/bloc/detail_photo.dart';
import 'package:flutter_demo_bloc/bloc/photo_bloc.dart';
import 'package:flutter_demo_bloc/model/Photo.dart';
import 'package:flutter_demo_bloc/view/detail_photo.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotosList extends StatelessWidget {
  const PhotosList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<PhotoBloc>(context);
    return StreamBuilder<List<Photo>?>(
      stream: bloc.photoStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          return _buildPhotosList(photos: snapshot.data!);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildPhotosList({required List<Photo> photos}) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BaseBlocProvider(
                        bloc: DetailPhotoBloc(photos[index].id ?? -1),
                        child: const DetailPhoto())));
          },
          child: Column(
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
          ),
        );
      },
    );
  }
}
