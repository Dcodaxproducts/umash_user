import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/order_controller.dart';
import '../../../data/model/response/order_model.dart';
import '../../../utils/style.dart';
import '../../base/animations/animation_builder.dart';
import 'widgets/header.dart';
import 'widgets/order_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    OrderController.to.getOrderList();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Scaffold(
        body: Column(
          children: [
            const OrderHeaderWidget(),
            SizedBox(height: 10.sp),
            TabBar(
              controller: _tabController,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: AutoSizeText(
                    'Running Orders (${orderController.runningOrderList.length})',
                    maxLines: 1,
                  ),
                ),
                Tab(
                  child: AutoSizeText(
                    'Past Orders (${orderController.historyOrderList.length})',
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      OrderList(
                        orders: orderController.runningOrderList,
                        orderController: orderController,
                      ),
                      OrderList(
                        orders: orderController.historyOrderList,
                        orderController: orderController,
                      )
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final OrderController orderController;
  const OrderList(
      {required this.orders, required this.orderController, super.key});

  @override
  Widget build(BuildContext context) {
    return !orderController.loadingOrders && orders.isEmpty
        ? Center(
            child: Text('No order found'.tr),
          )
        : RefreshIndicator(
            onRefresh: () async => await orderController.getOrderList(),
            child: ListView.separated(
                itemCount: orderController.loadingOrders ? 10 : orders.length,
                padding: pagePadding,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  return orderController.loadingOrders
                      ? const OrderShimmer()
                      : CustomAnimationBuilder(
                          direction: index.isEven
                              ? AnimationDirection.fromLeft
                              : AnimationDirection.fromRight,
                          child: OrderWidget(
                            order: orders[index],
                          ),
                        );
                }),
          );
  }
}
