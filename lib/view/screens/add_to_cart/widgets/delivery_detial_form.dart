import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/view/screens/add_to_cart/widgets/delivery_page_heading.dart';

class DeliveryDetailForm extends StatelessWidget {
  const DeliveryDetailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // select State drop down
        Text(
          "Select State",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(
          height: 10,
        ),
        DropdownButtonFormField<String>(
          value: "Item 1",
          onChanged: (String? newValue) {},
          validator: (String? value) {
            return null;
          },
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).hintColor,
                ),
            errorStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.red),
            enabledBorder: border(),
            disabledBorder: border(),
            focusedBorder: border(color: primaryColor),
            errorBorder: border(color: Theme.of(context).colorScheme.error),
            focusedErrorBorder: border(),
            contentPadding: const EdgeInsets.all(18),
            filled: true,
          ),
          items: <String>[
            'Item 1',
            'Item 2',
            'Item 3',
            'Item 4',
            'Item 5',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          style: Theme.of(context).textTheme.bodySmall,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        /// email field
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Email Address",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Row(
              children: [
                const Icon(
                  Iconsax.location,
                  color: primaryColor,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Find Me",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: primaryColor),
                  ),
                )
              ],
            )
          ],
        ),

        const CustomTextField(
          hintText: "Address",
        ),

        /// optional
        Text(
          "Binding Name / Number",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const CustomTextField(
          hintText: "Optional",
        ),

        /// save form check

        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            const Text("Save the address for the next time")
          ],
        ),
        const SizedBox(
          height: 20,
        ),

        /// Contect Details
        const DeliveryPageHeading(
          title: "Contect Details",
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Enter recipent phone number",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const CustomTextField(hintText: "+123"),

        Text(
          "Any Instructions you would like",
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              hintText: "Leave instructions here",
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              errorStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.red),
              enabledBorder: border(),
              disabledBorder: border(),
              focusedBorder: border(color: primaryColor),
              errorBorder: border(color: Theme.of(context).colorScheme.error),
              focusedErrorBorder: border(),
              contentPadding: const EdgeInsets.all(18),
              filled: true,
            )),
      ],
    ));
  }
}
