import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:umash_user/common/responsive.dart';
import 'package:umash_user/data/model/response/address_model.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/address/add_address.dart';

import '../../../../common/icons.dart';
import '../../../../controller/location_controller.dart';
import '../../../../utils/colors.dart';
import '../../../base/confirmation_dialog.dart';

class AddressWidget extends StatelessWidget {
  final AddressModel address;
  final bool fromHome;
  final Function()? onTap;
  const AddressWidget(
      {required this.address, this.fromHome = false, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(ResponsiveWidget.isMobile() ? 10 : 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Theme.of(context).cardColor),
      child: InkWell(
        onTap: fromHome
            ? onTap
            : () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                              onPressed: () {
                                pop();
                                launchScreen(
                                    AddAddressScreen(address: address));
                              },
                              child: Text(
                                'Update',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: primaryColor,
                                    ),
                              )),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              pop();
                              showDialog(
                                  context: context,
                                  builder: (_) => ConfirmationDialog(
                                        title: 'Delete Address',
                                        subtitle:
                                            'Are you sure you want to delete this address?',
                                        actionText: 'Delete',
                                        onAccept: () {
                                          pop();
                                          LocationController.to
                                              .deleteUserAddressByID(
                                            address.id,
                                          );
                                        },
                                      ));
                            },
                            child: Text(
                              'Delete',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.red),
                            ),
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: pop,
                          child: Text(
                            'Cancel',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: primaryColor),
                          ),
                        ),
                      );
                    });
              },
        child: Row(
          children: [
            const CustomIcon(iconSize: 26, icon: Icons.location_on_rounded),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.addressType.tr,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(address.address,
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
            ),
            const SizedBox(width: 10),
            if (!fromHome)
              CustomIcon(
                icon: Iconsax.more,
                color: Theme.of(context).scaffoldBackgroundColor,
                iconColor: Theme.of(context).primaryColor,
              )
          ],
        ),
      ),
    );
  }
}
