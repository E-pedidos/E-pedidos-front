import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableRed extends StatelessWidget {
  const TableRed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(255, 85, 85, 1), 
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/table_red.svg',
            width: 32,
            height: 27,
          ),
          const SizedBox(height: 5),
          const Text(
            '01',
            style: TextStyle(
                color: Color.fromRGBO(154, 0, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
