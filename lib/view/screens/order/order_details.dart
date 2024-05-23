import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/buttons.dart';
import '../../../common/primary_button.dart';
import '../../../common/snackbar.dart';
import '../../../controller/order_controller.dart';
import '../../../helper/navigation.dart';
import '../../../helper/order_color_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/style.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/divider.dart';
import 'widgets/address_widget.dart';
import 'widgets/order_items.dart';
import 'widgets/order_status_widget.dart';
import 'widgets/receipt_widget.dart';

class OrderDetail extends StatelessWidget {
  final int orderId;
  const OrderDetail({required this.orderId, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomBackButton(),
          ),
          title: Text('Order Details'.tr),
        ),
        body: orderController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderStatusWidget(
                        orderDetails: orderController.orderDetails!),
                    const SeparaterWidget(),
                    if (orderController.orderDetails!.orderType ==
                        'delivery') ...[
                      OrderAddress(
                          deliveryAddress:
                              orderController.orderDetails!.deliveryAddress!),
                      const SeparaterWidget(),
                    ],
                    OrderItems(orderDetail: orderController.orderDetails!),
                    const SeparaterWidget(),
                    OrderDetailsReceipt(order: orderController.orderDetails!),
                  ],
                ),
              ),
        bottomNavigationBar: orderController.isLoading
            ? const SizedBox()
            : Padding(
                padding: pagePadding.copyWith(bottom: 20),
                child: orderController.orderDetails!.orderStatus ==
                            'delivered' ||
                        OrderColorHelper.getColorForStatus(
                                orderController.orderDetails!.orderStatus!) ==
                            Colors.red
                    ? const SizedBox()
                    : (AppConstants.orderStatus.contains(
                                orderController.orderDetails!.orderStatus) &&
                            orderIndex < 1
                        ? PrimaryButton(
                            color: Colors.grey[300],
                            textColor: Colors.black,
                            text: 'cancel'.tr,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => ConfirmationDialog(
                                        title: 'Cancel Order',
                                        subtitle:
                                            'Are you sure you want to cancel this order?',
                                        actionText: 'Yes',
                                        onAccept: () {
                                          pop();
                                          orderController.cancelOrder(
                                              orderController.orderDetails!.id
                                                  .toString(), (success) {
                                            if (success) {
                                              showToast(
                                                "Order cancelled successfully",
                                                success: true,
                                              );
                                            }
                                            pop();
                                          });
                                        },
                                      ));
                            },
                          )
                        : null),
              ),
      );
    });
  }

  int get orderIndex => AppConstants.orderStatus
      .indexOf(OrderController.to.orderDetails!.orderStatus!);
}
