import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_drawer.dart';

class CustomLayout extends StatelessWidget {
  final Widget child;

  const CustomLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(72, 0, 0, 0),
          child: Text(
            'EcoVibe Bistrô',
            style: TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            child,
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'lib/assets/bg_bottom.svg',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
