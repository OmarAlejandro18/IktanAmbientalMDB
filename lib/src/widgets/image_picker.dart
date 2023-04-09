import 'package:image_picker/image_picker.dart';

Future<XFile?> cargarFotoFirestore() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

Future<XFile?> cargarFotoTermograficaFirestore() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}
