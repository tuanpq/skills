import 'package:flutter/material.dart';

import '../models/common.dart';

class Flashcard extends StatefulWidget {
  final Widget front;
  final Widget back;
  final String status;
  final ValueChanged<String> onStatusChange;

  const Flashcard({
    super.key,
    required this.front,
    required this.back,
    required this.status,
    required this.onStatusChange,
  });

  @override
  State<Flashcard> createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  bool _flipped = false;

  static const _statusColors = {
    'NEW': Colors.blueGrey,
    'LEARNING': Colors.amber,
    'MASTERED': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _flipped = !_flipped),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(minHeight: 120),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _flipped ? widget.back : widget.front,
                  const SizedBox(height: 8),
                  Text(
                    '(chạm để lật thẻ)',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Row(
            children: studyStatusLabels.entries.map((entry) {
              final selected = widget.status == entry.key;
              return Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: selected ? _statusColors[entry.key] : null,
                    foregroundColor: selected ? Colors.white : Colors.grey.shade700,
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () => widget.onStatusChange(entry.key),
                  child: Text(entry.value, style: const TextStyle(fontSize: 12)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
