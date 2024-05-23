import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/controller/coupon_controller.dart';
import 'package:umash_user/controller/location_controller.dart';
import 'package:umash_user/controller/order_controller.dart';
import 'package:umash_user/controller/splash_controller.dart';
import 'package:umash_user/helper/date_converter.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/helper/price_converter.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import '../../../controller/cart_controller.dart';
import '../../../data/model/body/cart_model.dart';
import '../../../data/model/body/place_order_body.dart';
import 'order_successfull.dart';
import 'widget/additional_note_widget.dart';
import 'widget/coupn_widget.dart';
import 'widget/delivery_address_widget.dart';
import 'widget/receipt_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _noteController = TextEditingController();

  @override
  void initState() {
    OrderController.to.initializeTimeSlot();
    super.initState();
  }

  @override
  void dispose() {
    CouponController.to.removeCouponData(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: ListView(
        padding: pagePadding,
        children: [
          const DeliveryAddressWidget(),
          const CouponWidget(),
          AdditionalNoteWidget(controller: _noteController),
          const OrderReceiptWidget()
        ],
      ),
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        return GetBuilder<CartController>(builder: (cartController) {
          return Container(
            padding: pagePadding,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Hero(
              tag: 'nextButton',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  minimumSize: Size(100.sp, 70.sp),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          // rich text
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: PriceConverter.convertPrice(
                                      cartController.totalAmount),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                                TextSpan(
                                  text:
                                      ' (${cartController.cartList.length} items)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: null,
                      child: Wrap(
                        children: [
                          Text(
                            'Confirm Order'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  if (orderController.deliveryType == 'delivery' &&
                      orderController.address == null) {
                    showToast('Select Delivery Address'.tr);
                  } else if (CartController.to.totalAmount <
                      SplashController.to.configModel!.minimumOrderValue!) {
                    showToast(
                        'Minimum Order Amount is ${PriceConverter.convertPrice(SplashController.to.configModel!.minimumOrderValue)}');
                  } else {
                    _checkout();
                  }
                },
              ),
            ),
          );
        });
      }),
    );
  }

  _checkout() {
    final orderController = OrderController.to;
    String? couponCode = CouponController.to.code;
    List<Cart> carts = [];
    bool isAvailable = true;
    bool restaurantClosed = false;
    DateTime scheduleStartDate = DateTime.now();
    DateTime scheduleEndDate = DateTime.now();

    DateTime date = orderController.selectDateSlot == 0
        ? DateTime.now()
        : DateTime.now().add(const Duration(days: 1));
    if (orderController.timeSlots.isEmpty) {
      restaurantClosed = true;
    } else {
      DateTime startTime =
          orderController.timeSlots[orderController.selectTimeSlot].startTime!;
      DateTime endTime =
          orderController.timeSlots[orderController.selectTimeSlot].endTime!;

      scheduleStartDate = DateTime(date.year, date.month, date.day,
          startTime.hour, startTime.minute + 1);
      scheduleEndDate = DateTime(
          date.year, date.month, date.day, endTime.hour, endTime.minute + 1);

      for (CartModel? cart in CartController.to.cartList) {
        if (!DateConverter.isAvailable(
              cart!.product!.availableTimeStarts!,
              cart.product!.availableTimeEnds!,
              time: scheduleStartDate,
            ) &&
            !DateConverter.isAvailable(cart.product!.availableTimeStarts!,
                cart.product!.availableTimeEnds!,
                time: scheduleEndDate)) {
          isAvailable = false;
          break;
        }
      }
    }

    if (!isAvailable) {
      showToast('One or more items are not available at this time');
    } else if (restaurantClosed) {
      String time = DateConverter.convertTimeRange(
        SplashController
            .to.configModel!.restaurantScheduleTime!.first.openingTime,
        SplashController
            .to.configModel!.restaurantScheduleTime!.first.closingTime,
      );

      showToast(
        'We are closed at the moment. We accept orders between $time only.',
      );
    } else if (OrderController.to.calculatingDistance) {
      showToast('Calculating Distance'.tr);
    } else {
      for (int index = 0; index < CartController.to.cartList.length; index++) {
        CartModel cart = CartController.to.cartList[index];
        List<int?> addOnIdList = [];
        List<int?> addOnQtyList = [];
        List<OrderVariation> variations = [];

        for (var addOn in cart.addOnIds!) {
          addOnIdList.add(addOn.id);
          addOnQtyList.add(addOn.quantity);
        }

        for (int i = 0; i < cart.variation!.length; i++) {
          List<String> values = [];
          for (var item in cart.variation![i].variationValues!) {
            values.add(item.label!);
          }
          OrderVariationValue variationValue =
              OrderVariationValue(label: values);
          variations.add(OrderVariation(
            name: cart.variation![i].name!,
            values: variationValue,
          ));
        }

        carts.add(Cart(
          productId: cart.product!.id.toString(),
          quantity: cart.quantity,
          addOnIds: addOnIdList,
          price: cart.discountedPrice.toString(),
          variation: variations,
          discountAmount: cart.discountAmount,
          taxAmount: CartController.to.taxAmount,
          addOnQtys: addOnQtyList,
        ));
      }

      PlaceOrderBody placeOrderBody = PlaceOrderBody(
        cart: carts,
        couponDiscountAmount: CouponController.to.discount,
        couponDiscountTitle:
            couponCode != null && couponCode.isNotEmpty ? couponCode : null,
        deliveryAddressId: orderController.deliveryType == 'delivery'
            ? orderController.address!.id
            : 0,
        orderAmount: CartController.to.totalAmount,
        orderNote: _noteController.text.trim(),
        orderType: orderController.deliveryType,
        paymentMethod: orderController.selectedPaymentMethod.value,
        couponCode:
            couponCode != null && couponCode.isNotEmpty ? couponCode : null,
        distance: orderController.distance,
        branchId: orderController.deliveryType == 'delivery'
            ? LocationController.to.branchId
            : orderController.selectedBranch.id,
        deliveryDate: DateFormat('yyyy-MM-dd').format(scheduleStartDate),
        deliveryTime: (orderController.selectTimeSlot == 0 &&
                orderController.selectDateSlot == 0)
            ? 'now'
            : DateFormat('HH:mm').format(scheduleStartDate),
      );
      if (placeOrderBody.paymentMethod != 'cash_on_delivery' &&
          placeOrderBody.paymentMethod != 'wallet_payment') {
      } else {
        OrderController.to.placeOrder(placeOrderBody, _callback);
      }
    }
  }

  void _callback(bool isSuccess, String orderId) async {
    if (isSuccess) {
      CartController.to.clearCartList();
      launchScreen(OrderSuccessScreen(orderId: orderId), replace: true);
    }
  }
}
