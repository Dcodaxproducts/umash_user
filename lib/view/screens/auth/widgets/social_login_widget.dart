import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/utils/images.dart';
import 'package:umash_user/view/base/divider.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
          child: Row(
            children: [
              const Expanded(child: CustomDivider()),
              const SizedBox(width: 10),
              Text(
                'Or Continue With'.tr,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(width: 10),
              const Expanded(child: CustomDivider()),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: SocialLoginButton(
                text: 'Google',
                image: Images.google,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SocialLoginButton(
                  text: 'Facebook',
                  image: Images.facebook,
                  onPressed: () async {}),
            ),
          ],
        ),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPressed;
  const SocialLoginButton(
      {required this.image,
      required this.onPressed,
      required this.text,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onPressed,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: const Color(0xFFF2F2F2),
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
