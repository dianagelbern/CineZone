import 'dart:io';

import 'package:cine_zone/bloc/image_pick_bloc/image_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class ImageSelectionPage extends StatefulWidget {
  const ImageSelectionPage({Key? key}) : super(key: key);

  @override
  State<ImageSelectionPage> createState() => _ImageSelectionPageState();
}

class _ImageSelectionPageState extends State<ImageSelectionPage> {
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return ImagePickBloc();
        },
        child: BlocConsumer<ImagePickBloc, ImagePickState>(
            listenWhen: (context, state) {
              return state is ImageSelectedSuccessState;
            },
            listener: (context, state) {},
            buildWhen: (context, state) {
              return state is ImagePickInitial ||
                  state is ImageSelectedSuccessState;
            },
            builder: (context, state) {
              if (state is ImageSelectedSuccessState) {
                print('PATH ${state.pickedFile.path}');
                return Column(children: [
                  Image.file(
                    File(state.pickedFile.path),
                    height: 100,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // TODO el evento que debeis crear en el BLoC para
                        // poder subir la imagen que tenemos guardada en
                        // state.pickedFile.path
                      },
                      child: const Text('Upload Image'))
                ]);
              }
              return Center(
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<ImagePickBloc>(context)
                            .add(const SelectImageEvent(ImageSource.gallery));
                      },
                      child: const Text('Select Image')));
            }),
      ),
    );
  }
}
