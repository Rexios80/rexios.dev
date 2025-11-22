import 'package:flutter/material.dart';

class ItemStat extends StatelessWidget {
  final String label;
  final String value;

  const ItemStat({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Column(
      children: [
        Text(value),
        const SizedBox(height: 3),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(fontSize: 8),
        ),
      ],
    );
  }
}
