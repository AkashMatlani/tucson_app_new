import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';

import 'package:location/location.dart';
import 'package:toast/toast.dart';

getCurrentLatLongPosition() async {
  try {
    return await Location().getLocation();
  } catch (e) {
    return null;
  }
}

Future<Address?> fetchCurrentAddress(
    BuildContext context, Function() setLoaderVisibility) async {
  LocationData myLocation;
  try {
    myLocation = await getCurrentLatLongPosition();
    if (myLocation != null) {
      final coordinates =
      new Coordinates(myLocation.latitude, myLocation.longitude);
      var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
      Address currentAddress = addresses.first;
      setLoaderVisibility();
      return currentAddress;
    } else {
      setLoaderVisibility();
      return null;
    }
  } on PlatformException catch (e, s) {
    setLoaderVisibility();
    Toast.show(e.message, context);
    /*myLocation = null;
    setLoaderVisibility();*/
    return null;
  } catch (e) {
    /*setLoaderVisibility();
    Toast.show(e.toString(), context);
    myLocation = null;
    setLoaderVisibility();
    return null;*/
  }
}

Future<Address?> fetchCurrentAddress1(BuildContext context) async {
  LocationData myLocation;
  try {
    myLocation = await getCurrentLatLongPosition();
    if (myLocation != null) {
      final coordinates =
      new Coordinates(myLocation.latitude, myLocation.longitude);
      var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);
      Address currentAddress = addresses.first;
      return currentAddress;
    } else {
      return null;
    }
  } on PlatformException catch (e, s) {
    Toast.show(e.message, context);
    //myLocation = null;
    return null;
  } catch (e) {
    Toast.show(e.toString(), context);
    //myLocation = null;
    return null;
  }
}
