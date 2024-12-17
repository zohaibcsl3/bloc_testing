import 'dart:io';

import 'package:bloc_testing/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_testing/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_testing/bloc/image_picker/image_picker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text(
          "Image Picker and show Screen",
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      // body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
      //   builder: (context, state) {
      //     if (state.file == null) {
      //       return Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           const Center(
      //             child: Text(
      //               "No image is Selected",
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 24.0,
      //           ),
      //           ElevatedButton(
      //             onPressed: () {
      //               context.read<ImagePickerBloc>().add(CameraCapture());
      //             },
      //             child: const Text(
      //               "Pick Image",
      //             ),
      //           )
      //         ],
      //       );
      //     } else {
      //       return Column(
      //         children: [
      //           Container(
      //             height: MediaQuery.of(context).size.height * 0.4,
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //               image: state.file != null
      //                   ? DecorationImage(
      //                       image: FileImage(File(state.file!.path)))
      //                   : null,
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 24.0,
      //           ),
      //           Row(
      //             children: [
      //               Expanded(
      //                 child: ElevatedButton(
      //                     onPressed: () {
      //                       context
      //                           .read<ImagePickerBloc>()
      //                           .add(GalleryImagePicker());
      //                     },
      //                     child: const Text("Remove Image")),
      //               ),
      //               const SizedBox(
      //                 width: 24.0,
      //               ),
      //               Expanded(
      //                 child: ElevatedButton(
      //                     onPressed: () {
      //                       context
      //                           .read<ImagePickerBloc>()
      //                           .add(CameraCapture());
      //                     },
      //                     child: const Text("Pick Image from Camera")),
      //               ),
      //             ],
      //           )
      //         ],
      //       );
      //     }
      //   },
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<ImagePickerBloc, ImagePickerState>(
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
                      : BoxDecoration(
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
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<ImagePickerBloc>().add(CameraCapture());
                        },
                        child: const Text("Pick Camera"))),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<ImagePickerBloc>()
                              .add(GalleryImagePicker());
                        },
                        child: const Text("Pick Gallery"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
