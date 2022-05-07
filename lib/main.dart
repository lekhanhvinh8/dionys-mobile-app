import 'package:dionys/app/providers/addressProvider.dart';
import 'package:dionys/app/providers/categories.dart';
import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:dionys/app/providers/productsFilterProvider.dart';
import 'package:dionys/features/cart/cartPage.dart';
import 'package:dionys/features/checkout/checkoutPage.dart';
import 'package:dionys/features/user/account/accountPage.dart';
import 'package:dionys/features/user/addresses/AddressesPage.dart';
import 'package:dionys/features/user/addresses/addressSelection.dart';
import 'package:dionys/features/user/addresses/newAddressPage.dart';
import 'package:dionys/features/user/userPage.dart';
import 'package:dionys/home.dart';
import 'package:dionys/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Categories()),
        ChangeNotifierProvider(create: (_) => ProductsFilterProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.purple,
          // textTheme: GoogleFonts.latoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
        ),
        debugShowCheckedModeBanner: false,
        title: "Home",
        //home: AddressSelection(),
        home: AddressesPage(),
        //home: NewAddressPage(),
        //home: AccountPage(),
        //home: Login(),
        //home: const Home(),
        // home: ProductDetail(
        //   productId: 5,
        // ),
        // home: const CartPage(),
        // home: const CheckoutPage(),
      ),
    ),
  );
}
