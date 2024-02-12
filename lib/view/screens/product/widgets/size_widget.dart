import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';

class SizeSelectionWidget extends StatelessWidget {
  SizeSelectionWidget({super.key});

  TasteSize selectedTasteSize = TasteSize.small;

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
              SizeOption(
                text: 'Small',
                price: 10,
                value: '7',
                selected: selectedTasteSize == TasteSize.small,
                onTap: () {
                  setState(() {
                    selectedTasteSize = TasteSize.small;
                  });
                },
              ),
              SizeOption(
                  text: 'Medium',
                  price: 20,
                  value: '9',
                  selected: selectedTasteSize == TasteSize.medium,
                  onTap: () {
                    setState(() {
                      selectedTasteSize = TasteSize.medium;
                    });
                  }),
              SizeOption(
                text: 'Large',
                price: 30,
                value: '11',
                selected: selectedTasteSize == TasteSize.large,
                onTap: () {
                  setState(() {
                    selectedTasteSize = TasteSize.large;
                  });
                },
              ),
            ],
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SizeOption extends StatelessWidget {
  final String text;
  final double price;
  final String value;
  final bool selected;
  final void Function()? onTap;
  const SizeOption({
    super.key,
    required this.text,
    this.selected = false,
    required this.price,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
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
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    selected ? secondaryColor : Theme.of(context).dividerColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                value,
                style: TextStyle(
                  color: selected ? primaryColor : null,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                color: selected ? primaryColor : null,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '\$$price',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

enum TasteSize { small, medium, large }
