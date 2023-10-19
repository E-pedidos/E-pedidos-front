import 'package:flutter/material.dart';

class CustomAvatar extends StatefulWidget {
  const CustomAvatar({super.key});

  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
        height: 88,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 3.0,
            color: const Color.fromRGBO(255, 219, 126, 1)
          ),
        ),
    );
  }
}