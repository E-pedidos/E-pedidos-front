import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CustomAvatar extends StatefulWidget {
  const CustomAvatar({super.key});

  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

/* Image.network(
                'https://example.com/your_image_url.jpg', 
                fit: BoxFit.cover,
                )
 */
class _CustomAvatarState extends State<CustomAvatar> {
  XFile? photo;

  cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      print(croppedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: 3.0, color: const Color.fromRGBO(255, 219, 126, 1)),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipOval(
              child: Image.asset(
                'lib/assets/menu1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 50,
            right: 0,
            child: CustomIconButton(
              icon: Icons.edit,
              backgroundColor: const Color.fromRGBO(54, 148, 178, 1),
              iconColor: Colors.white,
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                photo = await _picker.pickImage(source: ImageSource.gallery);
                Navigator.of(context).pushReplacementNamed('/account');

                if (photo != null) {
                  cropImage(photo!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
