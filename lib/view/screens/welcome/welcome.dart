import 'package:flutter/material.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/images.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/auth/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.welcome),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.19,
                ),
                Text(
                  'Welcome to',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  'Umash',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your favourite foods delivered fast at your door.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const Spacer(),
                PrimaryButton(
                  text: 'Login',
                  onPressed: () => launchScreen(const LoginScreen()),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Continue as Guest',
                  onPressed: () {},
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
