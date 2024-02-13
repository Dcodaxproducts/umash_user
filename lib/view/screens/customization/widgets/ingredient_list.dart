import 'package:flutter/material.dart';
import 'package:umash_user/common/network_image.dart';
import 'package:umash_user/view/base/quantity_widget.dart';

class IngredientList extends StatelessWidget {
  IngredientList({super.key});
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CustomNetworkImage(
                    url:
                        'https://t3.ftcdn.net/jpg/02/05/02/74/360_F_205027453_8Zor4CEdXTirIcxWVMtpzN4zFSdx0VFy.jpg'),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Olive",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            trailing: StatefulBuilder(builder: (context, setState) {
              return QuantityWidget(
                quantity: quantity,
                onAdd: () {
                  setState(() {
                    quantity++;
                  });
                },
                onRemove: () {
                  setState(() {
                    quantity--;
                  });
                },
              );
            }),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 10);
  }
}
