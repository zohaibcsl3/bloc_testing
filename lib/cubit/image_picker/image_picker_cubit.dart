import 'package:bloc/bloc.dart';
import 'package:bloc_testing/cubit/image_picker/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/image_picker_utils.dart';

class ImagePickerCubit extends Cubit<ImagePicker2State> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerCubit(this.imagePickerUtils) : super(const ImagePicker2State());

  void pickImageFromCamera() async {
    final XFile? file = await imagePickerUtils.getImageByCamera();
    emit(
      state.copyWith(
        file: file,
      ),
    );
  }

  void pickImageFromGallery() async {
    final XFile? file = await imagePickerUtils.getImageFromGallery();
    emit(
      state.copyWith(
        file: file,
      ),
    );
  }
}
