import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/customization/widgets/ingredient_list.dart';
import 'package:umash_user/view/screens/customization/widgets/total_ingredient_container.dart';

class CustomizationView extends StatelessWidget {
  const CustomizationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {},
          icon: const Icon(
            Iconsax.category,
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
              const TotalIngredientContainer(),
              const SizedBox(
                height: 20,
              ),

              Text(
                "Select Ingredients Quantity",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(
                height: 10,
              ),
              IngredientList()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: pagePadding,
        child: MaterialButton(
            height: 50,
            onPressed: () {},
            color: primaryColor,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              "Done",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            )),
      ),
    );
  }
}
