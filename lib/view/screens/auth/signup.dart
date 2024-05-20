// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/data/model/response/signup_model.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/dashboard/dashboard.dart';
import 'verification.dart';
import 'widgets/social_login_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  _tooglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              'Sign Up',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              labelText: 'Name',
              hintText: 'Enter your name',
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
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
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            CustomTextField(
              labelText: 'Confirm Password',
              hintText: 'Enter password again',
              obscureText: _obscureText,
              suffixIcon: IconButton(
                onPressed: _tooglePassword,
                icon: Icon(
                  !_obscureText ? Iconsax.eye : Iconsax.eye_slash,
                  size: 20,
                ),
              ),
              controller: _confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                } else if (value != _passwordController.text) {
                  return 'Password does not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            PrimaryButton(
              text: 'Sign Up',
              onPressed: _signup,
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
      ),
    );
  }

  _signup() {
    if (_formKey.currentState!.validate()) {
      AuthController authController = AuthController.to;
      final email = _emailController.text.trim();
      final signpModel = SignUpModel(
        name: _nameController.text.trim(),
        email: email.trim(),
        password: _passwordController.text.trim(),
      );
      authController.registration(signpModel).then((value) async {
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
