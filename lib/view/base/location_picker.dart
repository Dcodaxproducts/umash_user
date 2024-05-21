// ignore_for_file: depend_on_referenced_packages, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import '../../controller/location_controller.dart';
import '../../helper/navigation.dart';
import '../../utils/app_constants.dart';

locationPicker(Function(LatLng latLng, PickResult result) onPick) =>
    launchScreen(PlacePicker(
      useCurrentLocation: true,
      selectInitialPosition: true,
      apiKey: AppConstants.API_KEY,
      initialPosition: const LatLng(31.5204, 74.3587),
      onPlacePicked: (result) {
        pop();
        LatLng latlng = LatLng(
          result.geometry!.location.lat,
          result.geometry!.location.lng,
        );
        onPick(latlng, result);
      },
      selectedPlaceWidgetBuilder:
          (context, selectedPlace, state, isSearchBarFocused) {
        int isAvailable = -1;
        if (selectedPlace != null) {
          LatLng latLng = LatLng(
            selectedPlace.geometry!.location.lat,
            selectedPlace.geometry!.location.lng,
          );
          isAvailable = LocationController.to.inServiceArea(latLng);
        }
        return isSearchBarFocused
            ? Container()
            : FloatingCard(
                bottomPosition: 10.sp,
                leftPosition: 10.sp,
                rightPosition: 10.sp,
                height: 160.sp,
                borderRadius: BorderRadius.circular(12.sp),
                child: state == SearchingState.Searching
                    ? const Center(child: CircularProgressIndicator())
                    :
                    // isAvailable == -1
                    //     ? const Center(
                    //         child: Text('Service not available in this area'),
                    //       )
                    //     :
                    Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          children: [
                            Text(
                              selectedPlace?.formattedAddress ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.sp),
                            const Spacer(),
                            IconButton.filled(
                              onPressed: () {
                                pop();
                                LatLng latlng = LatLng(
                                  selectedPlace!.geometry!.location.lat,
                                  selectedPlace.geometry!.location.lng,
                                );
                                onPick(latlng, selectedPlace);
                              },
                              icon: Icon(Icons.check, size: 30.sp),
                            ),
                          ],
                        ),
                      ),
              );
      },
    ));
