import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/controller/splash_controller.dart';
import 'package:umash_user/helper/navigation.dart';
import '../../../../data/model/response/notification_model.dart';
import '../../../../utils/style.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationDialog({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: pagePadding,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(
        width: 400.sp,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: pagePadding.copyWith(top: 15.sp),
                  padding: pagePadding,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: 150.sp,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(radius),
                              child: CustomNetworkImage(
                                url:
                                    '${SplashController.to.configModel!.baseUrls!.notificationImageUrl}/${notificationModel.image}',
                              ))),
                      SizedBox(height: 15.sp),
                      Text(
                        notificationModel.title!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.sp),
                      Text(
                        notificationModel.description!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 0,
                right: 0,
                child: IconButton.filled(
                  style: IconButton.styleFrom(backgroundColor: Colors.red),
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: pop,
                )),
          ],
        ),
      ),
    );
  }
}
