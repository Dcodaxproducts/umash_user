import 'package:flutter/material.dart';
import 'package:umash_user/common/icons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/controller/localization_controller.dart';
import 'package:umash_user/data/model/language.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/app_constants.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  final bool fromSplash;
  const LanguageScreen({this.fromSplash = false, super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomIcon(
                    icon: Icons.arrow_back,
                    iconSize: 24,
                    onTap: pop,
                  ),
                  Text('select_language'.tr,
                      style: FontStyles.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 30),
              // title,
              Text(
                'select_your_preferred_language'.tr,
                style: FontStyles.titleMedium,
              ),
              const SizedBox(height: 10),
              // subtitle,
              Text(
                'select_your_preferred_language_msg'.tr,
                style: FontStyles.bodySmall.copyWith(
                  color: Theme.of(context).hintColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GetBuilder<LocalizationController>(
                  builder: (con) {
                    return ListView.builder(
                      itemCount: con.languages.length,
                      itemBuilder: (context, index) {
                        LanguageModel language = AppConstants.languages[index];
                        bool selected = con.selectedIndex == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () {
                              con.setSelectIndex(index);
                              LocalizationController.to.setLanguage(Locale(
                                  language.languageCode, language.countryCode));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: selected
                                    ? primaryColor.withOpacity(0.2)
                                    : null,
                                border: selected
                                    ? null
                                    : Border.all(
                                        color: Theme.of(context).dividerColor,
                                      ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        language.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      language.languageName,
                                      style: FontStyles.titleSmall.copyWith(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  selected
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: primaryColor,
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: pagePadding,
        child: PrimaryButton(
          text: 'done'.tr,
          onPressed: () async {
            Get.back();
          },
        ),
      ),
    );
  }
}
