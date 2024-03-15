import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';

class TasteSelectionWidget extends StatelessWidget {
  TasteSelectionWidget({super.key});

  Taste selectedTaste = Taste.sweet;

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
        StatefulBuilder(builder: (context, setState) {
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              TasteOption(
                text: 'Sweet',
                selected: selectedTaste == Taste.sweet,
                onTap: () {
                  setState(() {
                    selectedTaste = Taste.sweet;
                  });
                },
              ),
              TasteOption(
                  text: 'Sour',
                  selected: selectedTaste == Taste.sour,
                  onTap: () {
                    setState(() {
                      selectedTaste = Taste.sour;
                    });
                  }),
              TasteOption(
                  text: 'Bitter',
                  selected: selectedTaste == Taste.bitter,
                  onTap: () {
                    setState(() {
                      selectedTaste = Taste.bitter;
                    });
                  }),
              TasteOption(
                text: 'Salty',
                selected: selectedTaste == Taste.salty,
                onTap: () {
                  setState(() {
                    selectedTaste = Taste.salty;
                  });
                },
              ),
              TasteOption(
                  text: 'Umami',
                  selected: selectedTaste == Taste.umami,
                  onTap: () {
                    setState(() {
                      selectedTaste = Taste.umami;
                    });
                  }),
            ],
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}

class TasteOption extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  const TasteOption({
    super.key,
    required this.text,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? secondryColor
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
      ),
    );
  }
}

enum Taste { sweet, sour, bitter, salty, umami }
