import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAlert extends StatelessWidget {
  final String text;
  final Icon? icon;
  final Image? image;
  final SvgPicture? imageSvg;
  final Color backgroundColor;
  final Color colorText;

  const CustomAlert({
    Key? key,
    required this.text,
    this.icon,
    this.image,
    required this.backgroundColor,
    required this.colorText,
    this.imageSvg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 1,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (icon != null) ...{
              icon!,
              const SizedBox(width: 10.0),
            },
            if (image != null) ...{
              image!,
              const SizedBox(width: 10.0),
            },
            if (imageSvg != null) ...{
              imageSvg!,
              const SizedBox(width: 10.0),
            },
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                color: colorText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
