import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/controller/profile_controller.dart';
import 'package:umash_user/data/model/response/userinfo_model.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/images.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/profile/widgets/header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text =
        "${ProfileController.to.userInfoModel?.fName} ${ProfileController.to.userInfoModel?.lName}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
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
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: CachedNetworkImageProvider(
                            profileController.userInfoModel?.image ??
                                Images.user_placeholder,
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery)
                                  .then((value) {
                                if (value != null) {
                                  profileController.updateUserInfo(
                                      image: value);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Iconsax.image5,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "${profileController.userInfoModel?.fName} ${profileController.userInfoModel?.lName}",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      controller: _nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton(
                    text: 'Update Profile',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        List<String> name = splitFullName(_nameController.text);
                        UserInfoModel userInfoModel =
                            profileController.userInfoModel!.copyWith(
                          fName: name.first,
                          lName: name.last,
                        );
                        profileController.updateUserInfo(
                            updateUserModel: userInfoModel);
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
