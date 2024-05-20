import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/icons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/snackbar.dart';
import 'package:umash_user/controller/auth_controller.dart';
import 'package:umash_user/controller/cart_controller.dart';
import 'package:umash_user/controller/product_controller.dart';
import 'package:umash_user/data/model/body/cart_model.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/helper/date_converter.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/helper/price_converter.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/customization/customization_view.dart';
import 'package:umash_user/view/screens/product/widgets/size_widget.dart';
import 'widgets/ingradients.dart';
import 'widgets/product_info.dart';
import 'widgets/product_slider.dart';
import 'widgets/taste_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final int? cartIndex;
  ProductDetailScreen({required this.product, this.cartIndex, super.key}) {
    ProductController.to.product = product;
  }

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<int> selectedAddons = [];
  int _selectedTaste = -1;
  List<List<int>> selectedVariation = [[]];

  CartModel? cartItem;

  //
  List<Variation> variations = [];
  List<AddOn> addOns = [];
  double priceWithVariation = 0;
  double variationPrice = 0;
  double priceWithDiscount = 0;
  double discount = 0;
  String discountType = 'percent';
  double addonsCost = 0;
  double finalPrice = 0;
  bool isAvailable = true;

  @override
  void initState() {
    selectedVariation.clear();
    for (int i = 0; i < widget.product.variations!.length; i++) {
      selectedVariation.add([-1]);
    }
    selectedAddons = List.generate(widget.product.addOns!.length, (index) => 1);

    initCartItem();
    super.initState();
  }

  _calculate() {
    variations = [];
    addOns = [];
    discount = widget.product.discount!;
    discountType = widget.product.discountType!;
    priceWithDiscount = PriceConverter.convertWithDiscount(
      widget.product.price!,
      discount,
      discountType,
    )!;
    variationPrice = 0;
    addonsCost = 0;

    // add selected variation to variations list
    for (int i = 0; i < widget.product.variations!.length; i++) {
      if (selectedVariation[i][0] != -1) {
        Variation selected =
            Variation.fromJson(widget.product.variations![i].toJson());
        selected.variationValues = [
          selected.variationValues![selectedVariation[i][0]]
        ];
        variations.add(selected);
        variationPrice =
            variationPrice + selected.variationValues![0].optionPrice!;
      }
    }

    // addons cost and tax
    for (int index = 0; index < widget.product.addOns!.length; index++) {
      double itemPrice =
          widget.product.addOns![index].price! * selectedAddons[index];
      addonsCost = addonsCost + itemPrice;
      if (selectedAddons[index] > 0) {
        addOns.add(AddOn(
          id: widget.product.addOns![index].id!,
          quantity: selectedAddons[index],
        ));
      } else {
        addOns.removeWhere((e) => e.id == widget.product.addOns![index].id);
      }
    }

    // price with variation
    priceWithVariation = widget.product.price! + variationPrice;

    finalPrice = priceWithVariation + addonsCost;

    // is available
    isAvailable = DateConverter.isAvailable(
      widget.product.availableTimeStarts!,
      widget.product.availableTimeEnds!,
    );
  }

  initCartItem() {
    if (widget.cartIndex != null) {
      CartModel cartItem = CartController.to.cartList[widget.cartIndex!];

      // set selected addons
      for (var item in cartItem.addOnIds!) {
        int index = widget.product.addOns!.indexWhere((e) => e.id == item.id);
        selectedAddons[index] = item.quantity;
      }

      // set selected variations (in cart item variation it have only selected options)
      for (int i = 0; i < widget.product.variations!.length; i++) {
        int index = widget.product.variations![i].variationValues!.indexWhere(
            (e) => e.label == cartItem.variation![i].variationValues![0].label);
        selectedVariation[i] = [index];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _calculate();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: pagePadding.copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomIcon(
                    icon: Iconsax.category,
                    onTap: pop,
                  ),
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  CustomIcon(
                    icon: Iconsax.heart,
                    onTap: () {},
                  ),
                ],
              ),
              Expanded(
                  child: ListView(
                children: [
                  const SizedBox(height: 32),
                  const ProductSlider(),
                  ProductInfo(finalPrice: finalPrice),
                  const IngredientsWidget(),
                  const SizedBox(height: 16),
                  TasteSelectionWidget(
                    seletctedTaste: _selectedTaste,
                    onSelect: (tagId) {
                      setState(() {
                        _selectedTaste = tagId;
                      });
                    },
                  ),
                  if (widget.product.variations!.isNotEmpty)
                    for (int index = 0;
                        index < widget.product.variations!.length;
                        index++)
                      SizeSelectionWidget(
                        variation: widget.product.variations![index],
                        selectedVariation: selectedVariation[index],
                        onSelected: () {
                          setState(() {});
                        },
                      ),
                ],
              ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: pagePadding,
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
                child: PrimaryButton(
              text: 'Customize',
              radius: 8,
              color: secondryColor,
              textColor: primaryColor,
              iconData: Iconsax.edit,
              onPressed: () => launchScreen(
                CustomizationView(
                  addOns: widget.product.addOns ?? [],
                  selectedAddons: selectedAddons,
                  onUpdate: () {
                    setState(() {});
                  },
                ),
              ),
            )),
            const SizedBox(width: 16),
            Expanded(
                child: PrimaryButton(
              text: 'Add to Cart',
              radius: 8,
              iconData: Iconsax.shopping_bag,
              onPressed: _addToCart,
            )),
          ],
        ),
      ),
    );
  }

  _addToCart() {
    if (!AuthController.to.isLoggedIn) {
      showToast('Please Login to continue');
      return;
    }
    if (_selectedTaste == -1) {
      showToast('Please select taste');
      return;
    }
    CartModel cartModel = CartModel(
      price: priceWithVariation,
      discountedPrice: priceWithDiscount,
      discountAmount: priceWithVariation -
          PriceConverter.convertWithDiscount(
            priceWithVariation,
            discount,
            discountType,
          )!,
      quantity: 1,
      addOnIds: addOns,
      variation: variations,
      product: widget.product,
      taste: widget.product.tags![_selectedTaste],
    );

    // check if user selected all required variation
    for (int i = 0; i < widget.product.variations!.length; i++) {
      if (widget.product.variations![i].isRequired!) {
        if (selectedVariation[i].first == -1) {
          showToast("'Please select' ${widget.product.variations![i].name}");
          return;
        }
      }
    }
    CartController.to.addToCart(cartModel, widget.cartIndex);
  }
}
