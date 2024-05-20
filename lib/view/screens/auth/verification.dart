import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/dashboard/dashboard.dart';

class VerificationScreen extends StatelessWidget {
  final String emailAddress;
  const VerificationScreen({super.key, required this.emailAddress});

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
      body: Column(
        children: [
          Text('Welcome'.tr, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 10),
          Text('Please enter the 4 digit code send to  $emailAddress',
              style: Theme.of(context).textTheme.bodyMedium!),

          //
          SizedBox(height: 40.sp),

          Padding(
            padding: pagePadding.copyWith(bottom: 0),
            child: PinCodeTextField(
              length: 4,
              appContext: context,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldHeight: 60,
                fieldWidth: 60,
                borderWidth: 1,
                borderRadius: BorderRadius.circular(10),
                selectedColor: primaryColor,
                selectedFillColor: primaryColor.withOpacity(0.1),
                inactiveFillColor: Theme.of(context).cardColor,
                inactiveColor: Theme.of(context).dividerColor,
                activeColor: primaryColor,
                activeFillColor: primaryColor.withOpacity(0.1),
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              onChanged: AuthController.to.updateVerificationCode,
              beforeTextPaste: (text) {
                return true;
              },
            ),
          ),
          // resend code
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  // AuthController.to.checkEmail(emailAddress).then((value) {
                  //   if (value.isSuccess) {
                  //     showToast('Code Resent Successfully'.tr, success: true);
                  //   }
                  // });
                },
                child: Text('Resend Code',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Theme.of(context).primaryColor)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          PrimaryButton(
            text: 'Verify',
            onPressed: () {
              AuthController.to.verifyEmail(emailAddress).then((value) {
                if (value.isSuccess) {
                  launchScreen(const DashboardScreen(), pushAndRemove: true);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
