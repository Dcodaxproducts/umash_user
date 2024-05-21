// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:umash_user/common/buttons.dart';
import 'package:umash_user/common/primary_button.dart';
import 'package:umash_user/common/textfield.dart';
import 'package:umash_user/controller/location_controller.dart';
import 'package:umash_user/data/model/response/address_model.dart';
import 'package:umash_user/helper/navigation.dart';
import 'package:umash_user/utils/app_constants.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/base/divider.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? address;
  final bool setLocation;
  const AddAddressScreen({this.address, this.setLocation = false, super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _address = TextEditingController();
  final _streetNumber = TextEditingController();
  final _houseNumber = TextEditingController();
  final _floorNumber = TextEditingController();
  final _name = TextEditingController();
  final _contact = TextEditingController();

  int selectedIndex = 0;
  late GoogleMapController mapController;
  Set<Marker> markers = const <Marker>{};
  LatLng? latLng;

  _getCurrentLocation() => LocationController.to.getCurrentPosition(
        (position) async {
          LatLng latlng = LatLng(position.latitude, position.longitude);
          // if (LocationController.to.inServiceArea(latlng) != -1) {
          _animateCameraAndSetCamera(latlng);
          _address.text =
              (await LocationController.to.getFormattedAddress(latlng));
          // } else {
          //   _address.text = '';
          // }
        },
      );

  _animateCameraAndSetCamera(LatLng latlng) {
    latLng = latlng;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latlng.latitude, latlng.longitude),
          zoom: 10,
        ),
      ),
    );

    setState(() {
      markers = {
        Marker(
          markerId: const MarkerId('current'),
          position: LatLng(latlng.latitude, latlng.longitude),
        ),
      };
    });
  }

  @override
  void initState() {
    if (widget.address != null) {
      _address.text = widget.address!.address;
      _streetNumber.text = widget.address!.streetNumber ?? '';
      _houseNumber.text = widget.address!.houseNumber ?? '';
      _floorNumber.text = widget.address!.floorNumber ?? '';
      _name.text = widget.address!.contactPersonName;
      _contact.text = widget.address!.contactPersonNumber;
      selectedIndex =
          AppConstants.addressLabels.indexOf(widget.address!.addressType);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomBackButton(),
        ),
        title: Text('Add Address'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(radius)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(radius),
                            child: Stack(
                              children: [
                                GoogleMap(
                                  mapType: MapType.normal,
                                  compassEnabled: false,
                                  zoomControlsEnabled: false,
                                  mapToolbarEnabled: false,
                                  myLocationEnabled: false,
                                  myLocationButtonEnabled: false,
                                  initialCameraPosition: const CameraPosition(
                                    target: LatLng(31.5204, 74.3587),
                                    zoom: 10,
                                  ),
                                  markers: markers,
                                  onMapCreated: (controller) {
                                    mapController = controller;
                                    if (widget.address != null) {
                                      _animateCameraAndSetCamera(
                                        LatLng(
                                          double.parse(
                                              widget.address!.latitude),
                                          double.parse(
                                              widget.address!.longitude),
                                        ),
                                      );
                                    } else {
                                      _getCurrentLocation();
                                    }
                                  },
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 0,
                                  child: InkWell(
                                    onTap: _getCurrentLocation,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.my_location,
                                        color: Theme.of(context).primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      LocationController.to
                                          .pickLocation((latLng, result) {
                                        _address.text =
                                            result.formattedAddress!;
                                        _animateCameraAndSetCamera(latLng);
                                      });
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      margin: const EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: const Icon(
                                        Icons.fullscreen,
                                        color: primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text('Label As'.tr,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: AppConstants.addressLabels.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                margin: const EdgeInsets.only(right: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: selectedIndex == index
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).highlightColor),
                                  color: selectedIndex == index
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).cardColor,
                                ),
                                child: Text(
                                  AppConstants.addressLabels[index].tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text('Delivery Address'.tr,
                            style: Theme.of(context).textTheme.bodyLarge),
                        const CustomDivider(),
                        CustomTextField(
                          padding: const EdgeInsets.only(top: 10),
                          labelText: 'Address Line'.tr,
                          hintText: '123 Main Street',
                          controller: _address,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter address';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          padding: const EdgeInsets.only(top: 10),
                          labelText: 'Sreet Number',
                          hintText: '123',
                          controller: _streetNumber,
                        ),
                        const SizedBox(height: 15),
                        Text('House/Flood Number'.tr),
                        Row(children: [
                          Expanded(
                            child: CustomTextField(
                              controller: _houseNumber,
                              hintText: 'House # 123',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: _floorNumber,
                              hintText: 'Floor # 123',
                            ),
                          ),
                        ]),
                        CustomTextField(
                          labelText: 'Contact Person Name',
                          hintText: 'Enter Contact Person Name',
                          controller: _name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Contact Person Name';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          labelText: 'Contact Person Number'.tr,
                          hintText: "Enter Contact Person Number",
                          keyboardType: TextInputType.phone,
                          controller: _contact,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Contact Person Number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                      ]),
                ),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              text: widget.address != null ? 'Update'.tr : 'Save'.tr,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  AddressModel addressModel = AddressModel(
                    addressType: AppConstants.addressLabels[selectedIndex],
                    address: _address.text,
                    streetNumber: _streetNumber.text,
                    houseNumber: _houseNumber.text,
                    floorNumber: _floorNumber.text,
                    contactPersonName: _name.text,
                    contactPersonNumber: _contact.text,
                    latitude: latLng!.latitude.toString(),
                    longitude: latLng!.longitude.toString(),
                  );

                  // add address
                  if (widget.address == null) {
                    LocationController.to
                        .addAddress(
                          addressModel,
                          setLocation: widget.setLocation,
                        )
                        .then((value) => pop());
                  }
                  // update address
                  else {
                    addressModel.id = widget.address!.id;
                    addressModel.userId = widget.address!.userId;
                    addressModel.method = 'put';
                    LocationController.to
                        .updateAddress(addressModel: addressModel)
                        .then((value) => pop());
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
