// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/view/screens/address/add_address.dart';

import '../../../controller/location_controller.dart';
import 'widget/address_widget.dart';

class AddressScreen extends StatefulWidget {
  final bool fromHome;
  final Function()? onAddressSelect;
  const AddressScreen({this.fromHome = false, this.onAddressSelect, super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: Text('Saved Address'.tr),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(
                  width: null,
                  height: 40,
                  radius: 32,
                  text: 'Add New Address'.tr,
                  iconData: Icons.add,
                  onPressed: () => launchScreen(const AddAddressScreen()),
                )
              ],
            ),
            Expanded(
              child:
                  GetBuilder<LocationController>(builder: (locationController) {
                return ListView.builder(
                  itemBuilder: (context, index) => AddressWidget(
                    address: locationController.addressList[index],
                    fromHome: widget.fromHome,
                    onTap: () {
                      if (widget.fromHome) {
                        LatLng latLng = LatLng(
                          double.parse(
                              locationController.addressList[index].latitude),
                          double.parse(
                              locationController.addressList[index].longitude),
                        );
                        locationController.inServiceArea(latLng);
                        widget.onAddressSelect!();
                      }
                    },
                  ),
                  itemCount: locationController.addressList.length,
                );
              }),
            )
          ],
        ),
      )),
    );
  }
}
