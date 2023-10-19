import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableGreen extends StatelessWidget {
  const TableGreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(100, 255, 106, 1), 
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/table_green.svg',
            width: 32,
            height: 27,
          ),
          const SizedBox(height: 5),
          const Text(
            '01',
            style: TextStyle(
                color: Color.fromRGBO(23, 160, 53, 1),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
