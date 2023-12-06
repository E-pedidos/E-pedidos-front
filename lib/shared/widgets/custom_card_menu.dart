import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';

class CustomCardMenu extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String idItem;
  final String image;

  const CustomCardMenu(
      {super.key,
      required this.name,
      required this.description,
      required this.price,
      required this.idItem,
      required this.image});

  @override
  State<CustomCardMenu> createState() => _CustomCardMenuState();
}

class _CustomCardMenuState extends State<CustomCardMenu> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(54, 148, 178, 1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.name,
                      style:
                          const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.description,
                      style:
                          const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'R\$ ${widget.price}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(23, 160, 53, 1)),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  widget.image != null ?
                  Image.network(widget.image, fit: BoxFit.cover, width: 80, height: 80,)
                  : Image.asset('lib/assets/menu1.png'),
                  Positioned(
                    left: 0,
                    right: 15,
                    bottom: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomIconButton(
                            icon: Icons.remove,
                            backgroundColor:
                                const Color.fromRGBO(255, 148, 148, 1),
                            iconColor: const Color.fromRGBO(255, 0, 0, 1),
                            onTap: () {}),
                        const SizedBox(
                          width: 4,
                        ),
                        CustomIconButton(
                            icon: Icons.edit,
                            backgroundColor:
                                const Color.fromRGBO(54, 148, 178, 1),
                            iconColor: Colors.white,
                            onTap: () {}),
                      ],
                    ),
                  )
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
