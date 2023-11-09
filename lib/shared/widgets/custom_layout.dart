import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_drawer.dart';

class CustomLayout extends StatefulWidget {
  final Widget child;

  const CustomLayout({super.key, required this.child});

  @override
  State<CustomLayout> createState() => _CustomLayoutState();
}

class _CustomLayoutState extends State<CustomLayout> {
  SharedPreferencesUtils prefs = SharedPreferencesUtils();
  String? name;

  @override
  void initState() {
    super.initState();
    getNameEstablishment();
  }

  getNameEstablishment() {
    prefs.getUserData().then((value) {
      setState(() {
        name = value['name'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(72, 0, 0, 0),
          child: Text(
            '$name',
            style: const TextStyle(fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            widget.child,
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
