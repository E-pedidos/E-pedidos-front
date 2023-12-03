import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  XFile? photo = await picker.pickImage(source: ImageSource.gallery);

  if (photo != null) {
    return photo;
  }
   return;
}
