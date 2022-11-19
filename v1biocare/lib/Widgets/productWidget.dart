import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../Screens/productDetails.dart';
import '../models/productModel.dart';
import '../providers/review_cart_provider.dart';

class ProductmodelWidget extends StatelessWidget {
  final String? selectedsubcat;
  const ProductmodelWidget({super.key, this.selectedsubcat});

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);

    return FirestoreQueryBuilder<ProductModel>(
      query: productCollection(selectedSubcat: selectedsubcat),
      builder: (context, snapshot, _) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }

        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: snapshot.docs.isEmpty ? 1 / .1 : 1 / 1.1,
          ),
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
            }
            var productIndex = snapshot.docs[index];
            ProductModel product = snapshot.docs[index].data();
            String productID = productIndex.id;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ProductDetailsScreen(
                      productId: productID,
                      product: product,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CachedNetworkImage(
                        imageUrl: product.image!,
                        placeholder: (context, _) {
                          return Container(
                            height: 90,
                            width: 100,
                            color: Colors.grey.shade300,
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    product.productname!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                  // IconButton(
                  //     onPressed: () {
                  //       cart.addItem(
                  //           productId: productID,
                  //           title: product.productname!,
                  //           price: product.productprice!);
                  //     },
                  //     icon: Icon(IconlyLight.plus))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
