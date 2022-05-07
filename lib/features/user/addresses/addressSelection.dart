import 'package:dionys/app/providers/addressProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressSelection extends StatefulWidget {
  const AddressSelection({Key? key}) : super(key: key);

  @override
  State<AddressSelection> createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  var wards = [
    "Phường An Khánh",
    "Phường An Phú",
    "Phường Bình Chiểu",
    "Phường Bình Thọ",
  ];

  renderSelection(maxWidth, AddressProvider addressProvider) {
    var currentAddress = addressProvider.currentAddress;

    if (currentAddress.provinceName == null) {
      return addressProvider.provinces
          .map((province) => InkWell(
                onTap: () {
                  currentAddress.provinceName = province.name;
                  currentAddress.provinceId = province.id;

                  addressProvider.loadDistricts(province.id);
                  addressProvider.notify();
                },
                child: Container(
                  height: maxWidth * 0.15,
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [Text(province.name)],
                  ),
                ),
              ))
          .toList();
    }

    if (currentAddress.districtName == null) {
      return addressProvider.districts
          .map((district) => InkWell(
                onTap: () {
                  currentAddress.districtName = district.name;
                  currentAddress.districtId = district.id;

                  addressProvider.loadWards(district.id);
                  addressProvider.notify();
                },
                child: Container(
                  height: maxWidth * 0.15,
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [Text(district.name)],
                  ),
                ),
              ))
          .toList();
    }

    if (currentAddress.wardName == null) {
      return addressProvider.wards
          .map((ward) => InkWell(
                onTap: () {
                  currentAddress.wardName = ward.name;
                  currentAddress.wardCode = ward.code;
                  addressProvider.isAddressEmpty = false;
                  addressProvider.notify();
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: maxWidth * 0.15,
                  margin: EdgeInsets.only(top: 2),
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [Text(ward.name)],
                  ),
                ),
              ))
          .toList();
    }

    return [Container()];
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);
      addressProvider.loadProvinces();
    });
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final addressProvider = Provider.of<AddressProvider>(context);
    var currentAddress = addressProvider.currentAddress;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70), // Set this height
            child: Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.grey)),
                  Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        "Chọn địa chỉ",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )),
        body: Container(
          color: const Color.fromRGBO(240, 240, 240, 1),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Khu vực được chọn"),
                            InkWell(
                              child: Text("Thiết lập lại"),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 2),
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (currentAddress.provinceName != null)
                                  Text(
                                    (currentAddress.provinceName as String) +
                                        ", ",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                if (currentAddress.districtName != null)
                                  Text(
                                    (currentAddress.districtName as String) +
                                        ", ",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                if (currentAddress.wardName != null)
                                  Text(
                                      (currentAddress.wardName as String) +
                                          ", ",
                                      style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            if (currentAddress.provinceName != null)
                              IconButton(
                                  onPressed: () {
                                    addressProvider.removeOneSelection();
                                  },
                                  icon: Icon(Icons
                                      .keyboard_double_arrow_left_outlined))
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10),
                      child: Text((currentAddress.provinceName == null)
                          ? "Tỉnh / Thành phố"
                          : (currentAddress.districtName == null)
                              ? "Quận / Huyện"
                              : (currentAddress.wardName == null)
                                  ? "Phường / Xã"
                                  : ""),
                    ),
                    Expanded(
                        child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: renderSelection(maxWidth, addressProvider),
                        ),
                      ),
                    ))
                  ],
                ),
              )),
        ));
  }
}
