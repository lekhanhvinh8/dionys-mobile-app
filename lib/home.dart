import 'dart:convert';
import 'package:dionys/app/models/category.dart';
import 'package:dionys/app/providers/categories.dart';
import 'package:dionys/app/services/categoriesService.dart';
import 'package:dionys/features/header/header.dart';
import 'package:dionys/features/home/homepage.dart';
import 'package:dionys/features/purchase/purchasePage.dart';
import 'package:dionys/features/user/userPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  int selectedIndex = 0;
  Home({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PurchasePage(),
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  void initializeCategories(Categories categoryProvider) async {
    final response = await CategoriesServices().get();

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var categories = Category.fromListJson(jsonDecode(response.body));
      categoryProvider.initializeCategories(categories);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<Categories>(context, listen: false);
    initializeCategories(categoriesProvider);

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Header(),
            Expanded(child: _widgetOptions.elementAt(_selectedIndex))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '????n mua',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'T??i',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
