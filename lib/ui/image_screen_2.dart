import 'dart:io';

import 'package:bloc_testing/cubit/image_picker/image_picker_cubit.dart';
import 'package:bloc_testing/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/image_picker/image_picker_state.dart';

class ImageScreen2 extends StatefulWidget {
  const ImageScreen2({super.key});

  @override
  State<ImageScreen2> createState() => _ImageScreen2State();
}

class _ImageScreen2State extends State<ImageScreen2> {
  late ImagePickerCubit _imagePickerCubit;

  @override
  void initState() {
    _imagePickerCubit = ImagePickerCubit(ImagePickerUtils());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(
          "Image Picker using Cubit",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => _imagePickerCubit,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<ImagePickerCubit, ImagePicker2State>(
                builder: (context, state) {
                  return Container(
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    width: double.infinity,
                    decoration: state.file != null
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                File(
                                  state.file!.path.toString(),
                                ),
                              ),
                            ),
                          )
                        : const BoxDecoration(
                            color: Colors.grey,
                          ),
                    child: state.file == null
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                                "No image is Captured or selected kindly select any image from gallery or camera",
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: BlocBuilder<ImagePickerCubit, ImagePicker2State>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            context
                                .read<ImagePickerCubit>()
                                .pickImageFromCamera();
                          },
                          child: const Text("Pick Camera"));
                    },
                  )),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                      child: BlocBuilder<ImagePickerCubit, ImagePicker2State>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            context
                                .read<ImagePickerCubit>()
                                .pickImageFromGallery();
                          },
                          child: const Text("Pick Gallery"));
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
