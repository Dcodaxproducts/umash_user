import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/utils/images.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/profile/widgets/header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ProfileHeaderWidget(),
          Expanded(
            child: ListView(
              padding: pagePadding,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: const CustomNetworkImage(
                          url: Images.user_placeholder),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'John Doe',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 32),
                const CustomTextField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                const CustomTextField(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                ),
                const CustomTextField(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: Icon(Iconsax.eye_slash, size: 20),
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Update Profile',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
