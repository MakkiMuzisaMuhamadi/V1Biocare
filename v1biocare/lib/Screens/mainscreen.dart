import 'dart:async';

import 'package:badges/badges.dart';
import 'package:v1biocare/Screens/Screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({super.key, this.index});
  static const String id = 'main-Screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoriesScreen(),
    PrescriptionsScreen(),
    ReviewCart(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2
                  ? IconlyBold.calendar
                  : IconlyLight.calendar),
              label: 'Prescription',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Colors.white,
                child: Icon(
                    _selectedIndex == 3 ? IconlyBold.buy : IconlyLight.buy),
                badgeContent: Text(
                  "${reviewCartProvider.getReviewCartDataList.length}",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 4
                  ? CupertinoIcons.person_solid
                  : CupertinoIcons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
