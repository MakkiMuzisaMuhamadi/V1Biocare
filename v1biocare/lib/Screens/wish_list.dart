import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/single_item.dart';
import '../models/productModel.dart';
import '../providers/wishlist_provider.dart';

class WishLsit extends StatefulWidget {
  @override
  _WishLsitState createState() => _WishLsitState();
}

class _WishLsitState extends State<WishLsit> {
  WishListProvider? wishListProvider;
  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider!.deleteWishtList(delete.productname);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WishList Product"),
      content: Text("Are you devete on wishList Product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider!.getWishtListData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "WishList",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        itemCount: wishListProvider!.getWishList!.length,
        itemBuilder: (context, index) {
          ProductModel data = wishListProvider!.getWishList![index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleItem(
                isBool: true,
                productImage: data.image,
                productName: data.productname,
                productPrice: data.productprice,
                productId: data.id,
                productUnit: data.productunit,
                onDelete: () {
                  showAlertDialog(context, data);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
