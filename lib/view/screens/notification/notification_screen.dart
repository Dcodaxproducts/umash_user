import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/controller/splash_controller.dart';
import '../../../common/loading.dart';
import '../../../common/network_image.dart';
import '../../../controller/notification_controller.dart';
import '../../../data/model/response/notification_model.dart';
import '../../../helper/date_converter.dart';
import '../../../utils/style.dart';
import '../../base/divider.dart';
import 'widget/notification_dialog.dart';

// AIzaSyDhINLh6oC_AgCk6lnu96JzqoM7yGvONek
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    NotificationController.to.initNotificationList();

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: const Text('Notifications'),
      ),
      body: GetBuilder<NotificationController>(builder: (controller) {
        List<DateTime> dateTimeList = [];
        return controller.notificationList != null
            ? controller.notificationList!.isNotEmpty
                ? RefreshIndicator(
                    color: Colors.white,
                    onRefresh: () async => controller.initNotificationList(),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: pagePadding,
                        child: Column(
                          children: [
                            Center(
                              child: Container(
                                constraints: BoxConstraints(minHeight: height),
                                width: width,
                                child: ListView.separated(
                                    itemCount:
                                        controller.notificationList!.length,
                                    padding: EdgeInsets.zero,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    // separator builder
                                    separatorBuilder: (context, index) =>
                                        const CustomDivider(),

                                    // item builder
                                    itemBuilder: (context, index) {
                                      DateTime originalDateTime =
                                          DateConverter.isoStringToLocalDate(
                                        controller.notificationList![index]
                                            .createdAt!,
                                      );

                                      DateTime convertedDate = DateTime(
                                          originalDateTime.year,
                                          originalDateTime.month,
                                          originalDateTime.day);

                                      bool addTitle = false;

                                      if (!dateTimeList
                                          .contains(convertedDate)) {
                                        addTitle = true;
                                        dateTimeList.add(convertedDate);
                                      }
                                      return _notificationItem(
                                        context,
                                        controller.notificationList![index],
                                        addTitle,
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No notifications found',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Looks like you haven\'t received any notifications yet',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
            : const Loading();
      }),
    );
  }

  Widget _notificationItem(
      BuildContext context, NotificationModel notification, bool addTitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        addTitle
            ? Padding(
                padding: EdgeInsets.only(top: 10.sp, bottom: 2.sp),
                child: Text(
                  DateConverter.isoStringToLocalDateOnly(
                      notification.createdAt!),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ))
            : const SizedBox(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sp),
          child: InkWell(
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) =>
                  NotificationDialog(notificationModel: notification),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 50.sp,
                      width: 75.sp,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.sp),
                        child: CustomNetworkImage(
                          url:
                              '${SplashController.to.configModel!.baseUrls!.notificationImageUrl}/${notification.image}',
                        ),
                      ),
                    ),
                    SizedBox(width: 15.sp),
                    Expanded(
                      child: Text(
                        notification.title!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      DateConverter.isoStringToLocalTimeOnly(
                          notification.createdAt!),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
