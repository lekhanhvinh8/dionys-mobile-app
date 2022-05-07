import 'package:dionys/app/common/customSwitch.dart';
import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/providers/addressProvider.dart';
import 'package:dionys/features/user/addresses/addressSelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAddressPage extends StatefulWidget {
  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final _form = GlobalKey<FormState>();

  bool validate(AddressProvider addressProvider) {
    var currentAddress = addressProvider.currentAddress;
    if (_form.currentState?.validate() == false) return false;

    if (currentAddress.provinceName == null ||
        currentAddress.districtName == null ||
        currentAddress.wardName == null) {
      addressProvider.isAddressEmpty = true;
      addressProvider.notifyListeners();

      return false;
    }

    return true;
  }

  String? validateName(value) {
    if (value == "") {
      return "Tên không được để trống";
    }

    return null;
  }

  String? validatePhone(value) {
    if (value?.length != 10) {
      return 'Số điện thoại phải có độ dài bằng 10';
    }

    return null;
  }

  String? validateAddressDetail(value) {
    if (value == "") {
      return 'Không được để trống';
    }

    return null;
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
                        "Địa chỉ mới",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )),
        body: Container(
            color: const Color.fromRGBO(240, 240, 240, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Container(
                        child: Form(
                            key: _form,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.white,
                                  height: maxWidth * 0.14,
                                  child: Center(
                                    child: TextFormField(
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Họ và tên",
                                      ),
                                      onSaved: (value) {
                                        currentAddress.customerName =
                                            value as String;
                                      },
                                      validator: validateName,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.white,
                                  height: maxWidth * 0.14,
                                  child: Center(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Số điện thoại",
                                      ),
                                      onSaved: (value) {
                                        currentAddress.phoneNumber =
                                            value as String;
                                      },
                                      validator: validatePhone,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.all(10),
                                  height: maxWidth * 0.14,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: (addressProvider.isAddressEmpty)
                                          ? Border.all(color: Colors.red)
                                          : null),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddressSelection()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text((currentAddress.provinceName ==
                                                      null ||
                                                  currentAddress.districtName ==
                                                      null ||
                                                  currentAddress.wardName ==
                                                      null)
                                              ? "Tỉnh/Thành phố, Quận/Huyện, Phường/Xã"
                                              : (currentAddress.provinceName
                                                      as String) +
                                                  ", " +
                                                  (currentAddress.districtName
                                                      as String) +
                                                  ", " +
                                                  (currentAddress.wardName
                                                      as String)),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.grey,
                                            size: 14,
                                          )
                                        ],
                                      )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.white,
                                  height: maxWidth * 0.14,
                                  child: Center(
                                    child: TextFormField(
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Tên đường, tòa nhà, số nhà",
                                      ),
                                      onSaved: (value) {
                                        currentAddress.detail = value as String;
                                      },
                                      validator: validateAddressDetail,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  padding: EdgeInsets.all(10),
                                  color: Colors.white,
                                  height: maxWidth * 0.14,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Đặt làm địa chỉ mặc định"),
                                      CustomSwitch(
                                          value: currentAddress.isDefault,
                                          onChanged: (isTrue) {
                                            currentAddress.isDefault = isTrue;
                                            addressProvider.notify();
                                          })
                                    ],
                                  )),
                                ),
                              ],
                            )))),
                Container(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      final isValid = validate(addressProvider);

                      if (isValid) {
                        _form.currentState?.save();
                        addressProvider.addAddress(currentAddress);

                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                        height: maxWidth * 0.1,
                        width: maxWidth,
                        // color: isFormvalid
                        //     ? Colors.red
                        //     : Color.fromRGBO(230, 230, 230, 1),
                        color: Colors.red,
                        child: Center(
                          child: Text("Hoàn thành"),
                        )),
                  ),
                )
              ]),
            )));
  }
}
