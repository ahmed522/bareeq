import 'package:flutter/material.dart';

class AppDropdownButton extends StatelessWidget {
  const AppDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
  });

  final List<String> items;
  final void Function(String? item) onChanged;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      icon: const Icon(Icons.arrow_drop_down_rounded),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
              ),
            ),
          )
          .toList(),
      onChanged: (selectedItem) => onChanged(selectedItem),
      value: value,
    );
  }
}
