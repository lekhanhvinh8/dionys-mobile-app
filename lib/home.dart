import 'dart:convert';
import 'package:dionys/app/models/category.dart';
import 'package:dionys/app/providers/categories.dart';
import 'package:dionys/app/services/categoriesService.dart';
import 'package:dionys/features/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Đơn mua',
      style: optionStyle,
    ),
    Text(
      'Index 2: Tôi',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void initializeCategories(Categories categoryProvider) async {
    final response =
        await CategoriesServices().get("http://localhost:5000/api/category");

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
            label: 'Đơn mua',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tôi',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
