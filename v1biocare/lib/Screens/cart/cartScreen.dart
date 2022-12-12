import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../Widgets/single_item.dart';
import '../../models/review_cart_model.dart';
import '../../providers/review_cart_provider.dart';
import '../../utils/utils.dart';
import 'delivery_details/delivery_details.dart';

//         title: Text('Your Cart'),
//       ),
//       body: Column(
//         children: [
//           Card(
//             margin: const EdgeInsets.all(20),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Total'),
//                   Spacer(),
//                   Chip(label: Text("${cart.totalToPay.toString()} \$")),
//                   TextButton(onPressed: () {}, child: Text("Order Now"))
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: cart.items.length,
//                 itemBuilder: (context, index) => CartItemTile(
//                       id: cart.items.values.toList()[index].id,
//                       title: cart.items.values.toList()[index].title,
//                       price: cart.items.values.toList()[index].price,
//                       qty: cart.items.values.toList()[index].qty,
//                       productId: cart.items.keys.toList()[index],
//                     )),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ReviewCart extends StatelessWidget {
  static const id = '/CartScreen';
  ReviewCartProvider? reviewCartProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider!.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you Sure you Want to delete this CartProduct?"),
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
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider!.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text(
          "UGX ${reviewCartProvider!.getTotalPrice()}",
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text(
              "Checkout",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            onPressed: () {
              if (reviewCartProvider!.getReviewCartDataList.isEmpty) {
                return Utils().toastMessage("No Cart Data Found");
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DeliveryDetails(),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: reviewCartProvider!.getReviewCartDataList.isEmpty
          ? Center(
              child: Image.asset('assets/images/empty cart.png'),

              //  Text("NO DATA"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider!.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider!.getReviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleItem(
                      isBool: true,
                      wishList: false,
                      productImage: data.cartImage,
                      productName: data.cartName,
                      productPrice: data.cartPrice,
                      productId: data.cartId,
                      productQuantity: data.cartQuantity,
                      productUnit: data.cartUnit,
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
