import 'package:flutter/material.dart';

import '../models/common.dart';

class LevelDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const LevelDropdown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      items: jlptLevels
          .map((level) => DropdownMenuItem(value: level, child: Text(level)))
          .toList(),
      onChanged: (level) {
        if (level != null) onChanged(level);
      },
    );
  }
}
