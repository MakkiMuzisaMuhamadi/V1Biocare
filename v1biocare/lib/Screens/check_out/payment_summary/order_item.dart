import 'package:flutter/material.dart';

import '../../../models/review_cart_model.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel? e;
  OrderItem({this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e!.cartImage!,
        width: 60,
      ),
      title: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              e!.cartName!,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "\UGX ${e!.cartPrice}",
            ),
          ],
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                e!.cartUnit,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text("Quantity ${e!.cartQuantity.toString()}"),
            ],
          )
        ],
      ),
    );
  }
}
