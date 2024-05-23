import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/controller/splash_controller.dart';
import 'package:umash_user/controller/theme_controller.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/divider.dart';
import '../html/html_screen.dart';
import '../notification/notification_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: pagePadding,
        children: [
          CustomTile(
            icon: Iconsax.notification,
            text: 'Notifications',
            onPressed: () => launchScreen(const NotificationScreen()),
          ),
          const CustomTile(
            icon: Iconsax.moon,
            text: 'Dark Theme',
            theme: true,
          ),
          CustomTile(
            icon: Iconsax.info_circle,
            text: 'Abouts Us',
            onPressed: () => launchScreen(HtmlScreen(
                html: SplashController.to.configModel?.aboutUs ?? '')),
          ),
          CustomTile(
            icon: Iconsax.lock,
            text: 'Privacy Policy',
            onPressed: () => launchScreen(HtmlScreen(
                html: SplashController.to.configModel?.privacyPolicy ?? '')),
          ),
          CustomTile(
            icon: Iconsax.lock,
            text: 'Terms & Conditions',
            onPressed: () => launchScreen(HtmlScreen(
                html:
                    SplashController.to.configModel?.termsAndConditions ?? '')),
          ),
          CustomTile(
            icon: Iconsax.logout,
            text: 'Sign Out',
            isLast: true,
            onPressed: AuthController.to.socialLogout,
          ),
        ],
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onPressed;
  final bool theme, isLast;
  final Color? color;
  const CustomTile(
      {required this.icon,
      required this.text,
      this.onPressed,
      this.theme = false,
      this.color,
      this.isLast = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          visualDensity: const VisualDensity(horizontal: 4, vertical: 2),
          leading: Icon(
            icon,
            color: primaryColor,
            size: 26,
          ),
          title:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: theme
              ? GetBuilder<ThemeController>(builder: (themeController) {
                  return Switch.adaptive(
                    value: themeController.darkTheme,
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                  );
                })
              : null,
          onTap: onPressed,
        ),
        if (!isLast) const CustomDivider(),
      ],
    );
  }
}
