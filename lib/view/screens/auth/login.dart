// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/auth/signup.dart';
import 'package:umash_user/view/screens/auth/verification.dart';
import 'package:umash_user/view/screens/dashboard/dashboard.dart';
import 'widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  _tooglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: pagePadding,
          children: [
            const SizedBox(height: 8),
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: _obscureText,
              suffixIcon: IconButton(
                onPressed: _tooglePassword,
                icon: Icon(
                  !_obscureText ? Iconsax.eye : Iconsax.eye_slash,
                  size: 20,
                ),
              ),
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            PrimaryButton(text: 'Login', onPressed: _signin),
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
      ),
    );
  }

  _signin() {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      AuthController.to.login(email, _passwordController.text).then((value) {
        if (value.isSuccess) {
          if (value.message == 'active') {
            launchScreen(VerificationScreen(emailAddress: email));
          } else {
            launchScreen(const DashboardScreen(), pushAndRemove: true);
          }
        }
      });
    }
  }
}
