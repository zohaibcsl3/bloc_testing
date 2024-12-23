import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ImagePicker2State extends Equatable {
  final XFile? file;

  const ImagePicker2State({this.file});

  ImagePicker2State copyWith({XFile? file}) {
    return ImagePicker2State(file: file ?? this.file);
  }

  @override
  List<Object?> get props => [file]; // Correct implementation of props
}
