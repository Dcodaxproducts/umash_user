// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/utils/style.dart';
import 'widgets/social_login_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
            'Sign Up',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 10),
          const CustomTextField(
            labelText: 'Full Name',
            hintText: 'Enter your name',
          ),
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
            text: 'Sign Up',
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: RichText(
                  text: TextSpan(
                text: 'Already have an account? ',
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Sign In',
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
