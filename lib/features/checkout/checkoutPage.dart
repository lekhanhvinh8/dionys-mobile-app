import 'package:dionys/app/providers/addressProvider.dart';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/providers/checkoutProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/checkout/addressSelection.dart';
import 'package:dionys/features/checkout/itemArea.dart';
import 'package:dionys/features/checkout/paypalPayment.dart';
import 'package:dionys/features/header/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    checkoutProvider.initializeCheckoutPage(addressProvider.addresses,
        cartProvider.cartGroups, authProvider.token as String);
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    if (checkoutProvider.pageReloading) {
      EasyLoading.show(status: 'đang tải...');
    } else {
      EasyLoading.dismiss();
    }

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70), // Set this height
            child: Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(child: Icon(Icons.arrow_back, color: Colors.grey)),
                  Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        "Thanh toán",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )),
        bottomNavigationBar: Container(
            color: Colors.white,
            height: maxWidth * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(maxWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Tổng thanh toán"),
                      Text(
                          Formator.formatMoney(checkoutProvider
                                  .getTotalCost(cartProvider.cartGroups)) +
                              "đ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.red)),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    EasyLoading.dismiss();

                    final List<int> checkedItemIds = [];

                    for (var group in cartProvider.cartGroups) {
                      for (var item in group.items) {
                        if (item.checked) {
                          checkedItemIds.add(item.id);
                        }
                      }
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => PaypalPayment(
                            checkedItemIds,
                            checkoutProvider.selectedAddressId!),
                      ),
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(maxWidth * 0.025),
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          "Đặt hàng",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )),
                )
              ],
            )),
        body: Container(
            color: const Color.fromRGBO(240, 240, 240, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 7),
            child: SingleChildScrollView(
              child: Column(children: [
                AddressSelection(),
                ItemArea(),
              ]),
            )));
  }
}
