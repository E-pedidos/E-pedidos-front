import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';

class CustomListCategory extends StatefulWidget {
  final String text;
  final bool isRemove;

  const CustomListCategory(
      {super.key, required this.text, required this.isRemove});

  @override
  State<CustomListCategory> createState() => _CustomListCategoryState();
}

class _CustomListCategoryState extends State<CustomListCategory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.isRemove
            ? CustomIconButton(
                icon: Icons.remove,
                backgroundColor: const Color.fromRGBO(255, 148, 148, 1),
                iconColor: const Color.fromRGBO(255, 0, 0, 1),
                onTap: () {})
            : Container(),
        widget.isRemove
            ? const SizedBox(
                width: 10,
              )
            : Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 1,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(54, 148, 178, 1)),
            ),
          ],
        ),
      ],
    );
  }
}
