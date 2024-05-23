import 'package:http/http.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class NotificationRepo {
  final ApiClient apiClient;
  NotificationRepo({required this.apiClient});

  Future<Response?> getNotificationList() async =>
      await apiClient.getData(AppConstants.notificationUri);
}
