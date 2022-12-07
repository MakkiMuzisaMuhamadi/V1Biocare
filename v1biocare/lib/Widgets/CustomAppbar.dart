import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../Screens/SearchPage.dart';
import '../Screens/cartScreen.dart';
import '../providers/product_provider.dart';
import '../providers/review_cart_provider.dart';

class CustomAppbar extends StatelessWidget with PreferredSizeWidget {
  ProductProvider? productProvider;

  CustomAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: Text(
            title,
            style: const TextStyle(letterSpacing: 2),
          ),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            // Navigate to the Search Screen
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Search(),
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
              icon: Badge(
                badgeColor: Colors.white,
                child: Icon(IconlyBold.buy),
                badgeContent: Text(
                  "${reviewCartProvider.getReviewCartDataList.length}",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
