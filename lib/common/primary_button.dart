import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';

import 'responsive.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double? width, height;
  final Color? color;
  final Color? textColor;
  final bool isOutline;
  final IconData? iconData;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final String? subtitle;
  const PrimaryButton(
      {required this.text,
      this.onPressed,
      this.height = 50,
      this.width,
      this.color,
      this.isOutline = false,
      this.textColor,
      this.iconData,
      this.radius = 32,
      this.padding,
      this.subtitle,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width ?? (MediaQuery.sizeOf(context).width * 0.9),
          height: height! +
              (ResponsiveWidget.isMobile() ? 0 : 20) +
              (subtitle != null ? 5 : 0),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: isOutline ? null : (color ?? primaryColor),
            borderRadius: BorderRadius.circular(radius),
            border: isOutline
                ? Border.all(
                    color: Theme.of(context).dividerColor,
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconData != null) ...[
                Icon(
                  iconData,
                  size: 24,
                  color: isOutline ? null : textColor ?? Colors.white,
                ),
                const SizedBox(width: 8.0)
              ],
              Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: textColor ??
                          (isOutline
                              ? Theme.of(context).textTheme.bodyLarge?.color
                              : Colors.white),
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
