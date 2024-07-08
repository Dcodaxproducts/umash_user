import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/icons.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/settings/settings.dart';
import '../../notification/notification_screen.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: pagePadding,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIcon(
                icon: Iconsax.category,
                onTap: () => launchScreen(const SettingScreen()),
              ),
              Text(
                'Home',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              CustomIcon(
                icon: Iconsax.notification,
                onTap: () => launchScreen(const NotificationScreen()),
              ),
            ],
          ),
          // const SizedBox(height: 40),
          // const CustomTextField(
          //   hintText: 'What will you like to eat?',
          //   prefix: Icon(Iconsax.search_normal),
          //   suffixIcon: Icon(
          //     Iconsax.setting_4,
          //     color: primaryColor,
          //   ),
          // ),
          // const SizedBox(height: 8),
        ],
      ),
    );
  }
}
