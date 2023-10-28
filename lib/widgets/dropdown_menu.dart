import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final String? initialValue;
  final List<String> items;
  final String label;
  final TextEditingController controller;

  const DropDownMenu({
    Key? key,
    required this.initialValue,
    required this.items,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    String? selectedItem = widget.initialValue;

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.3,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
            labelText: widget.label,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.blue,
                ))),
        items: widget.items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        value: selectedItem,
        onChanged: (item) {
          setState(() {
            widget.controller.text = item!;
            selectedItem = item;
          });
        },
      ),
    );
  }
}
