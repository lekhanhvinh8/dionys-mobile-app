import 'dart:convert';
import 'dart:math';

import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/services/addressService.dart';
import 'package:dionys/app/services/userService.dart';
import 'package:flutter/material.dart';

class SelectedVariantValue {
  int variantId;
  int variantValueId;

  SelectedVariantValue(this.variantId, this.variantValueId);
}

class AddressProvider with ChangeNotifier {
  Address currentAddress = Address();
  List<Address> addresses = [];
  bool isAddressEmpty = false;
  List<Province> provinces = [];
  List<District> districts = [];
  List<Ward> wards = [];

  notify() {
    notifyListeners();
  }

  initializePage(String token) async {
    addresses = await UserService(token).getAddresses();
    notifyListeners();
  }

  resetCurrentAddress() {
    currentAddress = Address();
    isAddressEmpty = false;
    clearAddressSelection();
    notifyListeners();
  }

  clearAddressSelection() {
    provinces = [];
    districts = [];
    wards = [];

    notifyListeners();
  }

  addAddress(Address address, String token) async {
    if (address.isDefault) {
      addresses.forEach((address) {
        address.isDefault = false;
      });
    }

    final newAddress = await UserService(token).addAddress(address);
    address.id = newAddress.id;
    addresses.add(address);

    resetCurrentAddress();
    notifyListeners();
  }

  removeAddress(int id, String token) async {
    await UserService(token).removeAddress(id);
    addresses.removeWhere((address) => address.id == id);
    notifyListeners();
  }

  removeOneSelection() {
    if (currentAddress.wardName != null) {
      currentAddress.wardName = null;
    } else if (currentAddress.districtName != null) {
      currentAddress.districtName = null;
    } else if (currentAddress.provinceName != null) {
      currentAddress.provinceName = null;
    }

    notify();
  }

  loadProvinces() async {
    var provinces = await AddressService().getProvices();
    this.provinces = provinces;
    notifyListeners();
  }

  loadDistricts(int provinceId) async {
    var districts = await AddressService().getDistricts(provinceId);
    this.districts = districts;
    notifyListeners();
  }

  loadWards(int districtId) async {
    var wards = await AddressService().getWards(districtId);
    this.wards = wards;
    notifyListeners();
  }
}
