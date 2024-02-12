import 'package:flutter/material.dart';

class TotalIngredientContainer extends StatelessWidget {
  const TotalIngredientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadiusDirectional.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              "5",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
