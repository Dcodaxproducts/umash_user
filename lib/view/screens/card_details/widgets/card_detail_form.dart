import 'package:flutter/material.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/utils/formatters.dart';

class CardDetailForm extends StatelessWidget {
  const CardDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),

        /// name
        Text(
          "Card holder name",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const CustomTextField(hintText: "John Doe"),

        const SizedBox(
          height: 10,
        ),

        ///
        Text(
          "Card Number",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        CustomTextField(
          hintText: "1111-11111-22222-3",
          keyboardType: TextInputType.number,
          inputFormatters: [CardNumberFormatter()],
        ),

        const SizedBox(
          height: 10,
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Expiry Date:",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      hintText: "DD/MM/YYYY",
                      keyboardType: TextInputType.number,
                      inputFormatters: [DateInputFormatter()],
                    ),
                  ]),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "CVV:",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const CustomTextField(
                      hintText: "123",
                      keyboardType: TextInputType.number,
                    ),
                  ]),
            )
          ],
        )
      ],
    ));
  }
}
