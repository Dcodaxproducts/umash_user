// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/data/model/body/place_order_body.dart';
import 'package:umash_user/data/model/body/timeslote_model.dart';
import 'package:umash_user/data/model/payment_method.dart';
import 'package:umash_user/data/model/response/address_model.dart';
import 'package:umash_user/data/model/response/config_model.dart';
import 'package:umash_user/data/model/response/order_details_model.dart';
import 'package:umash_user/data/model/response/order_model.dart';
import 'package:umash_user/data/model/response/track_model.dart';
import 'package:umash_user/data/repository/order_repo.dart';
import 'package:umash_user/helper/date_converter.dart';
import 'auth_controller.dart';
import 'splash_controller.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  static OrderController get to => Get.find<OrderController>();

  String _deliveryType = 'delivery';
  Branches _selectedBranch = SplashController.to.configModel!.branches!.first;
  String _note = '';
  AddressModel? _address;
  PaymentMethod _selectedPaymentMethod = paymentMethodList.first;
  double _distance = -1;
  bool _calculatingDistance = false;
  List<TimeSlotModel> _timeSlots = [];
  List<TimeSlotModel> _allTimeSlots = [];
  int _selectDateSlot = 0;
  int _selectTimeSlot = 0;
  List<OrderModel> _runningOrderList = [];
  List<OrderModel> _historyOrderList = [];
  bool _loadingOrders = false;
  OrderDetailsModel? _orderDetails;
  bool _isLoading = false;

  String get deliveryType => _deliveryType;
  Branches get selectedBranch => _selectedBranch;
  String get note => _note;
  AddressModel? get address => _address;
  PaymentMethod get selectedPaymentMethod => _selectedPaymentMethod;
  double get distance => _distance;
  bool get calculatingDistance => _calculatingDistance;
  List<TimeSlotModel> get timeSlots => _timeSlots;
  List<TimeSlotModel> get allTimeSlots => _allTimeSlots;
  int get selectDateSlot => _selectDateSlot;
  int get selectTimeSlot => _selectTimeSlot;
  List<OrderModel> get runningOrderList => _runningOrderList;
  List<OrderModel> get historyOrderList => _historyOrderList;
  bool get loadingOrders => _loadingOrders;
  OrderDetailsModel? get orderDetails => _orderDetails;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  set loadingOrders(bool value) {
    _loadingOrders = value;
    update();
  }

  set deliveryType(String type) {
    _deliveryType = type;
    update();
  }

  set selectedPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    update();
  }

  setNote(String note) {
    _note = note;
    update();
  }

  set calculatingDistance(bool value) {
    _calculatingDistance = value;
    update();
  }

  set selectedBranch(Branches value) {
    _selectedBranch = value;
    update();
  }

  set address(AddressModel? address) {
    _address = address;
    _distance = -1;
    if (address != null) {
      calculatingDistance = true;
      // LocationController.to
      //     .getDistanceInMeter(LatLng(
      //         double.parse(address.latitude), double.parse(address.longitude)))
      //     .then((value) {
      _calculatingDistance = false;
      // _distance = value ?? -1;
      update();
      // });
    }
    update();
  }

  set distance(double distance) {
    _distance = distance;
    update();
  }

  double get deliveryFee {
    double deliveryCharge = 0.0;
    ConfigModel configModel = SplashController.to.configModel!;
    bool kmWiseCharge = configModel.deliveryManagement!.status == 1;
    bool takeAway = _deliveryType == 'take_away';
    if (takeAway) {
      deliveryCharge = 0.0;
    } else {
      if (kmWiseCharge) {
        deliveryCharge =
            _distance * configModel.deliveryManagement!.shippingPerKm!;
        if (deliveryCharge <
            configModel.deliveryManagement!.minShippingCharge!) {
          deliveryCharge =
              configModel.deliveryManagement!.minShippingCharge ?? 0.0;
        }
      } else {
        deliveryCharge = configModel.deliveryCharge ?? 0.0;
      }
    }
    return deliveryCharge;
  }

  Future<void> initializeTimeSlot() async {
    final scheduleTime =
        SplashController.to.configModel!.restaurantScheduleTime!;
    int? duration = SplashController.to.configModel!.scheduleOrderSlotDuration;
    _timeSlots = [];
    _allTimeSlots = [];
    _selectDateSlot = 0;
    int minutes = 0;
    DateTime now = DateTime.now();
    for (int index = 0; index < scheduleTime.length; index++) {
      DateTime openTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateConverter.convertStringTimeToDate(scheduleTime[index].openingTime)
            .hour,
        DateConverter.convertStringTimeToDate(scheduleTime[index].openingTime)
            .minute,
      );

      DateTime closeTime = DateTime(
        now.year,
        now.month,
        now.day,
        DateConverter.convertStringTimeToDate(scheduleTime[index].closingTime)
            .hour,
        DateConverter.convertStringTimeToDate(scheduleTime[index].closingTime)
            .minute,
      );

      if (closeTime.difference(openTime).isNegative) {
        minutes = openTime.difference(closeTime).inMinutes;
      } else {
        minutes = closeTime.difference(openTime).inMinutes;
      }
      if (duration! > 0 && minutes > duration) {
        DateTime time = openTime;
        for (;;) {
          if (time.isBefore(closeTime)) {
            DateTime start = time;
            DateTime end = start.add(Duration(minutes: duration));
            if (end.isAfter(closeTime)) {
              end = closeTime;
            }
            _timeSlots.add(TimeSlotModel(
                day: int.tryParse(scheduleTime[index].day),
                startTime: start,
                endTime: end));
            _allTimeSlots.add(TimeSlotModel(
                day: int.tryParse(scheduleTime[index].day),
                startTime: start,
                endTime: end));
            time = time.add(Duration(minutes: duration));
          } else {
            break;
          }
        }
      } else {
        _timeSlots.add(TimeSlotModel(
            day: int.tryParse(scheduleTime[index].day),
            startTime: openTime,
            endTime: closeTime));
        _allTimeSlots.add(TimeSlotModel(
            day: int.tryParse(scheduleTime[index].day),
            startTime: openTime,
            endTime: closeTime));
      }
    }
    validateSlot(_allTimeSlots, 0, notify: false);
  }

  void updateTimeSlot(int index) {
    _selectTimeSlot = index;
    update();
  }

  void updateDateSlot(int index) {
    _selectDateSlot = index;
    validateSlot(_allTimeSlots, index);
    update();
  }

  void validateSlot(List<TimeSlotModel> slots, int dateIndex,
      {bool notify = true}) {
    _timeSlots = [];
    int day = 0;
    if (dateIndex == 0) {
      day = DateTime.now().weekday;
    } else {
      day = DateTime.now().add(const Duration(days: 1)).weekday;
    }
    if (day == 7) {
      day = 0;
    }
    for (var slot in slots) {
      if (day == slot.day &&
          (dateIndex == 0 ? slot.endTime!.isAfter(DateTime.now()) : true)) {
        _timeSlots.add(slot);
      }
    }

    if (notify) {
      update();
    }
  }

  Future<void> placeOrder(
      PlaceOrderBody placeOrderBody, Function callback) async {
    showLoading();
    http.Response? response = await orderRepo.placeOrder(placeOrderBody);
    if (response != null) {
      var data = jsonDecode(response.body);
      // String? message = data['message'];
      String orderID = data['order_id'].toString();
      callback(true, orderID);
    } else {
      callback(false, '');
    }
  }

  Future<void> getOrderList() async {
    if (!AuthController.to.isLoggedIn) return;
    loadingOrders = true;
    http.Response? response = await orderRepo.getOrderList();
    if (response != null) {
      _runningOrderList = [];
      _historyOrderList = [];
      jsonDecode(response.body).forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'pending' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'out_for_delivery' ||
            orderModel.orderStatus == 'confirmed') {
          _runningOrderList.add(orderModel);
        } else if (orderModel.orderStatus == 'delivered' ||
            orderModel.orderStatus == 'returned' ||
            orderModel.orderStatus == 'failed' ||
            orderModel.orderStatus == 'canceled') {
          _historyOrderList.add(orderModel);
        }
      });
      _runningOrderList.sort((a, b) => b.id!.compareTo(a.id!));
      _historyOrderList.sort((a, b) => b.id!.compareTo(a.id!));
    }
    loadingOrders = false;
  }

  getOrderDetails(String orderID) async {
    _orderDetails = null;
    isLoading = true;
    http.Response? response = await orderRepo.trackOrder(orderID);
    if (response != null) {
      _orderDetails = OrderDetailsModel.fromJson(jsonDecode(response.body));
    }
    isLoading = false;
  }

  void cancelOrder(String orderID, Function callback) async {
    showLoading();
    http.Response? response = await orderRepo.cancelOrder(orderID);
    if (response != null) {
      OrderModel? orderModel;
      for (var order in _runningOrderList) {
        if (order.id.toString() == orderID) {
          orderModel = order;
        }
      }
      _runningOrderList.remove(orderModel);
      update();
      callback(true);
    } else {
      callback(false);
    }
  }

  Future<TrackModel?> trackDriver(int driverId, int orderId) async {
    http.Response? response =
        await orderRepo.getDeliveryManData(driverId, orderId);
    if (response != null) {
      var data = jsonDecode(response.body);
      return TrackModel.fromJson(data);
    }
    return null;
  }
}
