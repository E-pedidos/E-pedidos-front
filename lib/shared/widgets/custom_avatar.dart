import 'dart:typed_data';

import 'package:e_pedidos_front/repositorys/user_repository.dart';
import 'package:e_pedidos_front/shared/utils/image_utils.dart';
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

  /* cropImage(XFile imageFile) async {
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
     var res = await userRepository.uploudAvatarUser(photo!);

      if(res.statusCode == 202){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(30),
            content: Text('${res.body}'),
            behavior: SnackBarBehavior.floating,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            padding: const EdgeInsets.all(30),
            content: Text('${res.body}'),
            behavior: SnackBarBehavior.floating,
        ));
      }
  
    }
  } */
class _CustomAvatarState extends State<CustomAvatar> {
  UserRepository userRepository = UserRepository();
  Uint8List? photo;

  void selectImage () async{
    Uint8List img = await pickImage(ImageSource.gallery);

    setState(() {
      photo = img;
    });

    await userRepository.uploudAvatarUser(photo!);
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
              onTap: selectImage,
            ),
          ),
        ],
      ),
    );
  }
}
