import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/divider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: const Text('Notifications'),
      ),
      body: ListView(
        padding: pagePadding,
        children: [
          for (var i = 0; i < 6; i++)
            const CustomTile(
              icon: Iconsax.truck_fast,
              text: 'Rider is on the way!',
              subtitle: 'Rider will arive in 10 minutes',
            ),
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String? subtitle;
  final Function()? onPressed;
  const CustomTile(
      {required this.icon,
      required this.text,
      required this.subtitle,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 8,
          visualDensity: const VisualDensity(horizontal: 4, vertical: 2),
          leading: Icon(
            icon,
            color: primaryColor,
            size: 26,
          ),
          title:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle!),
          trailing: const Text('9:56 AM'),
          onTap: onPressed,
        ),
        const CustomDivider(),
      ],
    );
  }
}
