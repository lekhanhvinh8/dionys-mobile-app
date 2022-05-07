import 'dart:math';

import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/services/addressService.dart';
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

  initializePage() {
    var address = Address();
    address.id = 1;
    address.customerName = "Vinh";
    address.detail = "Số 2, Đường XYZ";
    address.phoneNumber = "0654563848";
    address.isDefault = true;
    address.provinceName = "TP Hồ Chí Minh";
    address.districtName = "Thành phố Thủ Đức";
    address.wardName = "Phường Linh Chiểu";

    var address1 = Address();
    address1.id = 2;
    address1.customerName = "Ten";
    address1.detail = "Số 21, Đường FGH";
    address1.phoneNumber = "6567543533";
    address1.isDefault = false;
    address1.provinceName = "Hà Nội";
    address1.districtName = "Nam Từ Liêm";
    address1.wardName =
        "Phường  Ddddddddddddddddddddddddddddddddddddddddddddddddddddd";

    addresses.add(address);
    addresses.add(address1);
    notifyListeners();
  }

  resetCurrentAddress() {
    currentAddress = Address();

    isAddressEmpty = false;
    provinces = [];
    districts = [];
    wards = [];
  }

  addAddress(Address address) {
    address.id = Random().nextInt(1000);
    addresses.add(address);

    if (address.isDefault) {
      addresses.forEach((address) {
        address.isDefault = false;
      });

      address.isDefault = true;
    }

    notifyListeners();
  }

  removeAddress(int id) {
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
