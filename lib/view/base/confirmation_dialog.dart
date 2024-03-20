import 'package:flutter/material.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/view/base/divider.dart';
import 'package:get/get.dart';

Future showConfirmationDialog({
  required String title,
  required String subtitle,
  required String actionText,
  required Function() onAccept,
  BuildContext? context,
}) {
  return showDialog(
    context: context ?? Get.context!,
    builder: (context) => ConfirmationDialog(
      title: title,
      subtitle: subtitle,
      actionText: actionText,
      onAccept: onAccept,
    ),
  );
}

class ConfirmationDialog extends StatelessWidget {
  final String title, subtitle, actionText;
  final Function() onAccept;
  const ConfirmationDialog({
    required this.title,
    required this.subtitle,
    required this.actionText,
    required this.onAccept,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.tr,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const CustomDivider(padding: 20),
            Text(
              subtitle.tr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: PrimaryButton(
                    text: 'Cancel',
                    onPressed: pop,
                    isOutline: true,
                    textColor: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: PrimaryButton(
                    text: actionText,
                    onPressed: onAccept,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
