import 'package:bloc/bloc.dart';
import 'package:bloc_testing/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_testing/bloc/image_picker/image_picker_state.dart';
import 'package:bloc_testing/utils/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {
    on<CameraCapture>(captureImageFromCamera);
    on<GalleryImagePicker>(captureImageFromGallery);
  }

  void captureImageFromCamera(
      CameraCapture event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.getImageByCamera();
    emit(
      state.copyWith(
        file: file,
      ),
    );
  }

  void captureImageFromGallery(
      GalleryImagePicker event, Emitter<ImagePickerState> emit) async {
    final XFile? file = await imagePickerUtils.getImageFromGallery();
    emit(
      state.copyWith(
        file: file,
      ),
    );
  }
}
