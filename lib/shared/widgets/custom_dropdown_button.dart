import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdownButton({
    super.key, 
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        items: items.map((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem),
          );
        }).toList(),
        onChanged: onChanged,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
        iconSize: 24.0,
      ),
    );
  }
}
