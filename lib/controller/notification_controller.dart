import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data/model/response/notification_model.dart';
import '../data/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});
  static NotificationController get to => Get.find<NotificationController>();

  List<NotificationModel>? _notificationList;
  List<NotificationModel>? get notificationList => _notificationList != null
      ? _notificationList!.reversed.toList()
      : _notificationList;

  Future<void> initNotificationList() async {
    http.Response? response = await notificationRepo.getNotificationList();
    if (response != null) {
      _notificationList = [];
      var data = jsonDecode(response.body);
      data.forEach((notificatioModel) =>
          _notificationList!.add(NotificationModel.fromJson(notificatioModel)));
      update();
    }
  }
}
