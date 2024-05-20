import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/quantity_widget.dart';

class CustomizationView extends StatefulWidget {
  final List<AddOns> addOns;
  final List<int> selectedAddons;
  final Function()? onUpdate;
  const CustomizationView(
      {required this.addOns,
      required this.selectedAddons,
      required this.onUpdate,
      super.key});

  @override
  State<CustomizationView> createState() => _CustomizationViewState();
}

class _CustomizationViewState extends State<CustomizationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: pop,
          icon: const Icon(
            Iconsax.arrow_left_2,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Customization',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// total ingredients
              Container(
                width: double.infinity,
                height: 65.sp,
                decoration: BoxDecoration(
                  color: secondryColor,
                  borderRadius: BorderRadiusDirectional.circular(radius),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Ingredients:",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.red),
                      ),
                      Text(
                        widget.addOns.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Text(
                "Select Ingredients Quantity",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              SizedBox(height: 10.sp),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.addOns.length,
                separatorBuilder: (_, __) {
                  return SizedBox(height: 16.sp);
                },
                itemBuilder: (_, index) {
                  final addon = widget.addOns[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(vertical: -4),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 36.sp,
                          width: 36.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.sp),
                            child: CustomNetworkImage(url: addon.image),
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        Text(
                          addon.name ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    trailing: QuantityWidget(
                      quantity: widget.selectedAddons[index],
                      onAdd: () {
                        widget.selectedAddons[index]++;
                        setState(() {});
                        widget.onUpdate?.call();
                      },
                      onRemove: () {
                        if (widget.selectedAddons[index] > 0) {
                          widget.selectedAddons[index]--;
                          setState(() {});
                          widget.onUpdate?.call();
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: pagePadding,
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              onPressed: pop,
              child: Text(
                'Done',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
          )),
    );
  }
}
