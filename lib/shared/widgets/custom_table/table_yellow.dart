import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableYellow extends StatelessWidget {
  const TableYellow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 250, 118, 1), 
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/table_yellow.svg',
            width: 32,
            height: 27,
          ),
          const SizedBox(height: 5),
          const Text(
            '01',
            style: TextStyle(
                color: Color.fromRGBO(219, 184, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
