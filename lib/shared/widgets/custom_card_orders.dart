import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardOrders extends StatefulWidget {
  final String clientName;
  final int tableNumber;
  final VoidCallback onTap;

  const CardOrders({
    Key? key,
    required this.clientName,
    required this.tableNumber,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CardOrders> createState() => _CardOrdersState();
}

class _CardOrdersState extends State<CardOrders> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color.fromRGBO(54, 148, 178, 1),
              width: 2.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.clientName} - Mesa ${widget.tableNumber}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              SvgPicture.asset('lib/assets/touch_icon.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
