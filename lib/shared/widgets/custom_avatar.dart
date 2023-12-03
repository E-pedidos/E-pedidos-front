import 'dart:convert';

import 'package:e_pedidos_front/repositorys/user_repository.dart';
import 'package:e_pedidos_front/shared/utils/image_utils.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAvatar extends StatefulWidget {
  final String? linkImage;
  const CustomAvatar({super.key, this.linkImage});

  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  UserRepository userRepository = UserRepository();
  XFile? image;

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
            toolbarTitle: 'Foto de Perfil',
            toolbarColor: Colors.orange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Foto de Perfil',
        ),
      ],
    );
    if (croppedFile != null) {
      var photo = await croppedFile.readAsBytes();

      var res = await userRepository.uploudAvatarUser(photo);

      if (res.statusCode == 202) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> userData = jsonDecode(res.body);

        if (userData.containsKey('avatar_url')) {
          String data = userData['avatar_url'];

          await prefs.setString('avatar_url', data);
        }

        Navigator.of(context).popAndPushNamed('/account');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            padding: EdgeInsets.all(30),
            content: Text('Erro ao tentar cadastrar imagem'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void selectImage() async {
    XFile? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });

      cropImage(image!);
    }
    return;
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
                child: widget.linkImage == null
                    ? Image.asset(
                        'lib/assets/iconconta.png',
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        widget.linkImage!,
                        fit: BoxFit.cover,
                      )),
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
