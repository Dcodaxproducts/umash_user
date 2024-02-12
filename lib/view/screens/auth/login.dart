// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/auth/signup.dart';
import 'package:umash_user/view/screens/dashboard/dashboard.dart';

import 'widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        leadingWidth: 70,
      ),
      body: ListView(
        padding: pagePadding,
        children: [
          const SizedBox(height: 8),
          Text(
            'Sign In',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 10),
          const CustomTextField(
            labelText: 'Email',
            hintText: 'Enter your email',
          ),
          const CustomTextField(
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: true,
            suffixIcon: Icon(Iconsax.eye, size: 20),
          ),
          const SizedBox(height: 40),
          PrimaryButton(
            text: 'Login',
            onPressed: () => launchScreen(const DashboardScreen()),
          ),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () => launchScreen(const SignupScreen()),
              child: RichText(
                  text: TextSpan(
                text: 'Don\'t have an account? ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ],
              )),
            ),
          ),
          const SizedBox(height: 32),
          const SocialLoginWidget(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
