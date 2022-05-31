import 'package:dionys/app/providers/addressProvider.dart';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/providers/checkoutProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class AddressSelection extends StatelessWidget {
  const AddressSelection({Key? key}) : super(key: key);

  Future<void> _showMyDialog(String message, context) async {
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        int? tempSelectedAddressId = checkoutProvider.selectedAddressId;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: addressProvider.addresses
                    .map((address) => Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: address.id,
                                groupValue: tempSelectedAddressId,
                                onChanged: (value) {
                                  setState(() {
                                    tempSelectedAddressId = value;
                                  });
                                },
                              ),
                              Flexible(
                                  child: Text(
                                (address.provinceName as String) +
                                    " " +
                                    (address.districtName as String) +
                                    " " +
                                    (address.wardName as String),
                                style: TextStyle(fontSize: 12),
                              ))
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Đồng ý'),
                onPressed: () {
                  Navigator.of(context).pop();

                  checkoutProvider.selectAddressId(tempSelectedAddressId);
                  checkoutProvider.reloadExpectedDeliveryTimeAndShippingCost(
                      cartProvider.cartGroups, authProvider.token as String);
                },
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    final addressProvider = Provider.of<AddressProvider>(context);
    final checkoutProvider = Provider.of<CheckoutProvider>(context);

    final selectedAddress = addressProvider.addresses.firstWhereOrNull(
      (address) => address.id == checkoutProvider.selectedAddressId,
    );

    if (selectedAddress == null) return Container();

    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      padding: EdgeInsets.all(maxWidth * 0.02),
      child: Row(children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.red,
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: maxWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Địa chỉ nhận hàng"),
              Text(selectedAddress.customerName +
                  " | " +
                  selectedAddress.phoneNumber),
              Text(selectedAddress.detail == null
                  ? ""
                  : selectedAddress.detail!),
              Text((selectedAddress.provinceName as String) +
                  ", " +
                  (selectedAddress.districtName as String) +
                  ", " +
                  (selectedAddress.wardName as String)),
            ],
          ),
        )),
        IconButton(
          onPressed: () {
            _showMyDialog("", context);
          },
          icon: Icon(Icons.arrow_forward_ios_rounded),
          color: Colors.grey,
        )
      ]),
    );
  }
}
