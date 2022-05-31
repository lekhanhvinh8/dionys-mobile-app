import 'dart:core';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/checkoutProvider.dart';
import 'package:dionys/app/services/orderService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayment extends StatefulWidget {
  List<int> _cartIds;
  int _addressId;

  PaypalPayment(this._cartIds, this._addressId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String orderId = "";
  String? approvalUrl;
  String captureUrl =
      "https://api.sandbox.paypal.com/v2/checkout/orders/84085223FD281953T/capture";
  String executeUrl = "";

  String returnURL = 'https://github.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  Future<void> initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final orderService = OrderService(authProvider.token as String);

    try {
      final orderId = await orderService.createPaypalOrder(
          widget._cartIds, widget._addressId);

      if (orderId != null) {
        setState(() {
          this.orderId = orderId;
          approvalUrl =
              "https://www.sandbox.paypal.com/checkoutnow?token=" + orderId;
          executeUrl = "";
        });
      }
    } catch (e) {
      print('exception: ' + e.toString());
      // final snackBar = SnackBar(
      //   content: Text(e.toString()),
      //   duration: Duration(seconds: 10),
      //   action: SnackBarAction(
      //     label: 'Close',
      //     onPressed: () {
      //       // Some code to undo the change.
      //     },
      //   ),
      // );
      // _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final checkoutProvider =
        Provider.of<CheckoutProvider>(context, listen: false);

    if (approvalUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: approvalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              final token = uri.queryParameters['token'];

              Navigator.of(context).pop();

              // capture;
              checkoutProvider.captureOrder(
                  orderId, authProvider.token as String, context);
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }
}
