import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';

class TasteSelectionWidget extends StatelessWidget {
  const TasteSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Taste:',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: 8),
        const Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            TasteOption(text: 'Sweet', selected: true),
            TasteOption(text: 'Sour'),
            TasteOption(text: 'Bitter'),
            TasteOption(text: 'Salty'),
            TasteOption(text: 'Umami'),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TasteOption extends StatelessWidget {
  final String text;
  final bool selected;
  const TasteOption({super.key, required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? secondaryColor
            : Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selected ? primaryColor : Theme.of(context).dividerColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? primaryColor : null,
        ),
      ),
    );
  }
}
