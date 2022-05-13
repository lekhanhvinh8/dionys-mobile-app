import 'dart:math';

import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/features/auth/login.dart';
import 'package:dionys/features/cart/cartPage.dart';
import 'package:dionys/features/productDetail/productDetail.dart';
import 'package:dionys/features/user/addresses/addressesPage.dart';
import 'package:dionys/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    var result = await authProvider.setUser();

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    await cartProvider.loadCarts(authProvider.token as String);
    cartProvider.initializePage();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.isLoading) return Container();

    if (authProvider.isAuth) {
      //return Home();
      //return AddressesPage();
      //return ProductDetail(productId: 5);
      //home: AddressSelection(),
      //home: AddressesPage(),
      //home: NewAddressPage(),
      //home: AccountPage(),
      //home: Login(),
      //home: const Home(),
      return ProductDetail(
        productId: 5,
      );
      //return const CartPage();
      // home: const CheckoutPage(),

    }

    return Login();
  }
}
