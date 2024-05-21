import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/utils/style.dart';
import '../../../common/network_image.dart';
import '../../../controller/product_controller.dart';
import '../../../data/model/body/review_body_model.dart';
import '../../../data/model/response/product_model.dart';
import '../../../helper/price_converter.dart';

class ReviewBottomSheet extends StatefulWidget {
  final Product product;
  final String orderId;
  const ReviewBottomSheet(
      {required this.product, required this.orderId, super.key});

  @override
  State<ReviewBottomSheet> createState() => _ReviewBottomSheetState();
}

class _ReviewBottomSheetState extends State<ReviewBottomSheet> {
  int rating = 5;
  final TextEditingController _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 55.sp),
            padding: pagePadding.copyWith(top: 70.sp),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              // top shadow,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, -5), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.product.name ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5.0),

                  // discounted price
                  Text(
                    PriceConverter.convertPrice(
                      PriceConverter.convertWithDiscount(
                        widget.product.price,
                        widget.product.discount,
                        widget.product.discountType,
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 50,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Iconsax.star1,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rat) {
                      setState(() {
                        rating = rat.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'how_was_your_experience'.tr,
                    style: FontStyles.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'your_feecback_help_us_to_improve_our_service'.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'additional_comments'.tr,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Theme.of(context).hintColor),
                        enabledBorder: border(context),
                        disabledBorder: border(context),
                        focusedBorder: border(context,
                            color: Theme.of(context).primaryColor),
                        errorBorder: border(context,
                            color: Theme.of(context).colorScheme.error),
                        focusedErrorBorder: border(context),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                      ),
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyMedium,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter comment'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                      text: 'Submit Review'.tr,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ProductController.to.submitReview(ReviewBody(
                            productId: widget.product.id.toString(),
                            rating: rating.toString(),
                            comment: _commentController.text,
                            orderId: widget.orderId,
                          ));
                        }
                      }),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: SizedBox(
                  width: 150,
                  height: 110,
                  child: CustomNetworkImage(url: widget.product.image),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Theme.of(context).dividerColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(radius),
      );
}
