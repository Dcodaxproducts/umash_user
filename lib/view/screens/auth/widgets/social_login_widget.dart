import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/controller/splash_controller.dart';
import 'package:umash_user/data/model/body/social_login_model.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/images.dart';
import 'package:umash_user/view/base/divider.dart';
import 'package:umash_user/view/screens/dashboard/dashboard.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (splash) {
        return splash.configModel!.socialLogin != null
            ? GetBuilder<AuthController>(builder: (authController) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (splash.configModel!.socialLogin!.google ||
                        splash.configModel!.socialLogin!.facebook)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
                        child: Row(
                          children: [
                            const Expanded(child: CustomDivider()),
                            const SizedBox(width: 10),
                            Text(
                              'Or Continue With',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context).hintColor,
                                      fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(child: CustomDivider()),
                          ],
                        ),
                      ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        if (splash.configModel!.socialLogin!.google)
                          SocialLoginButton(
                            text: 'Google',
                            image: Images.google,
                            onPressed: () async {
                              try {
                                GoogleSignInAuthentication auth =
                                    await authController.googleLogin();
                                GoogleSignInAccount googleAccount =
                                    authController.googleAccount!;
                                authController.socialLogin(
                                  SocialLoginModel(
                                    email: googleAccount.email,
                                    token: auth.accessToken,
                                    uniqueId: googleAccount.id,
                                    medium: 'google',
                                  ),
                                  route,
                                );
                              } catch (er) {
                                debugPrint('access token error is : $er');
                              }
                            },
                          ),
                        if (splash.configModel!.socialLogin!.facebook)
                          SocialLoginButton(
                            text: 'Facebook',
                            image: Images.facebook,
                            onPressed: () async {
                              LoginResult result =
                                  await FacebookAuth.instance.login();

                              if (result.status == LoginStatus.success) {
                                Map userData =
                                    await FacebookAuth.instance.getUserData();

                                authController.socialLogin(
                                  SocialLoginModel(
                                    email: userData['email'],
                                    token: result.accessToken!.token,
                                    uniqueId: result.accessToken!.userId,
                                    medium: 'facebook',
                                  ),
                                  route,
                                );
                              }
                            },
                          ),
                        if (Platform.isIOS)
                          SocialLoginButton(
                            text: 'Apple',
                            image: Images.apple,
                            onPressed: _signinWithApple,
                          ),
                      ],
                    ),
                  ],
                );
              })
            : const SizedBox();
      },
    );
  }

  _signinWithApple() async {
    // Ensure any existing sign-in is cleared
    await FirebaseAuth.instance.signOut();

    // Request Apple ID credentials
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create a new OAuth credential for signing in with Firebase
    final oAuthProvider = OAuthProvider('apple.com');
    final firebaseCredential = oAuthProvider.credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in to Firebase with the Apple credentials
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(firebaseCredential);
    User user = userCredential.user!;

    // Retrieving user details
    // Note: Firebase may not always provide the email and displayName directly.
    // Email and displayName are only provided the first time the user signs in with Apple.
    String email =
        user.email ?? ''; // Fallback to an empty string if email is null
    String name = user.displayName ??
        ''; // Fallback to an empty string if displayName is null
    String uniqueId = user.uid;

    // The token is taken from the Apple credential, not the Firebase credential
    String token = appleCredential.identityToken ??
        ''; // Fallback to an empty string if identityToken is null

    final socialLogin = SocialLoginModel(
      email: email,
      token: token,
      uniqueId: uniqueId,
      medium: 'apple',
      name: name,
    );

    // Proceed with your social login logic
    AuthController.to.socialLogin(socialLogin, route);

    // Consider if you really want to delete the user immediately after sign-in
    user.delete();
  }

  void route(bool isRoute, String? token) async {
    if (isRoute) {
      if (token != null) {
        launchScreen(const DashboardScreen(), pushAndRemove: true);
      }
    }
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  const SocialLoginButton(
      {required this.image,
      required this.onPressed,
      required this.text,
      super.key,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onPressed,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: (backgroundColor ?? const Color(0xFFF2F2F2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
