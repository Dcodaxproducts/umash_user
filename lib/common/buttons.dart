import 'package:flutter/material.dart';
import 'package:umash_user/common/responsive.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';

class CustomBackButton extends StatelessWidget {
  final Function()? onPressed;
  const CustomBackButton({this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? pop,
      child: Container(
        width: 40,
        height: 30,
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AnimatedTabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  final Color? color;
  const AnimatedTabButton(
      {required this.text,
      this.onTap,
      this.selected = false,
      this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        duration: const Duration(milliseconds: 300),
        height: 40 + (ResponsiveWidget.isMobile() ? 0 : 25),
        decoration: BoxDecoration(
          color: selected ? color ?? primaryColor : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? color ?? primaryColor
                : Theme.of(context).dividerColor,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: selected ? Colors.white : Theme.of(context).hintColor,
                ),
          ),
        ),
      ),
    );
  }
}
