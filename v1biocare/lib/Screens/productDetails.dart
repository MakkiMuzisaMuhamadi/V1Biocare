import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../Widgets/CustomAppBar.dart';
import '../Widgets/count.dart';
import '../Widgets/text_widgets.dart';
import '../firebaseServices/firebaseservice.dart';
import '../models/productModel.dart';
import '../providers/review_cart_provider.dart';
import '../providers/wishlist_provider.dart';
import 'cart/cartScreen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel? product;

  final String? productId;
  static const String id = 'product-screen';
  const ProductDetailsScreen({super.key, this.product, this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final FirebaseService _service = FirebaseService();
  bool wishListBool = false;

  getWishtListBool() {
    FirebaseFirestore.instance
        .collection("WishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(
                        () {
                          wishListBool = value.get("wishList");
                        },
                      ),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishtListBool();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: widget.product!.productname!,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.8,
                padding: const EdgeInsets.only(bottom: 30),
                width: double.infinity,
                child: CachedNetworkImage(imageUrl: widget.product!.image!),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text: 'BioCare', color: Colors.grey, textSize: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: widget.product!.productname!,
                          color: Colors.green,
                          textSize: 15,
                          isTitle: true,
                          maxLines: 3,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: wishListBool == false
                                  ? const Icon(IconlyLight.heart,
                                      color: Colors.grey)
                                  : Icon(
                                      IconlyBold.heart,
                                      color: Colors.red,
                                    ),
                              onPressed: () {
                                setState(() {
                                  wishListBool = !wishListBool;
                                });
                                if (wishListBool == true) {
                                  wishListProvider.addWishListData(
                                    wishListId: widget.product!.productname,
                                    wishListImage: widget.product!.image,
                                    wishListName: widget.product!.productname,
                                    wishListPrice: widget.product!.productprice,
                                    wishListQuantity: 2,
                                  );
                                } else {
                                  wishListProvider.deleteWishtList(
                                      widget.product!.productname!);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: widget.product!.productDetails!,
                      color: Colors.black,
                      textSize: 12,
                      maxLines: 20,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(color: Colors.grey),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'Price',
                            color: Colors.black,
                            textSize: 18,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: '\UGX ${widget.product!.productprice!}',
                            color: Colors.black,
                            textSize: 22,
                            isTitle: false,
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(height: 10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              const SizedBox(width: 5),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Icon(
                    Icons.store_mall_directory_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  TextWidget(
                    text: 'Store',
                    color: Theme.of(context).primaryColor,
                    textSize: 12,
                    isTitle: false,
                  )
                ],
              ),
              Container(
                height: 60,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: VerticalDivider(color: Colors.black),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Icon(
                    IconlyLight.chat,
                    color: Theme.of(context).primaryColor,
                  ),
                  TextWidget(
                    text: 'Chat',
                    color: Theme.of(context).primaryColor,
                    textSize: 12,
                    isTitle: false,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: VerticalDivider(color: Colors.grey),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange)),
                child: TextWidget(
                  text: 'Buy Now',
                  color: Colors.white,
                  textSize: 13,
                  isTitle: true,
                ),
                onPressed: () {},
              ),
              const SizedBox(
                width: 15,
              ),
              Count(
                productId: widget.product!.productname!,
                productImage: widget.product!.image!,
                productName: widget.product!.productname!,
                productPrice: widget.product!.productprice!,
                productUnit: widget.product!.productunit!,
              ),
              // ElevatedButton(
              //   child: TextWidget(
              //     text: 'Add to Cart',
              //     color: Colors.white,
              //     textSize: 13,
              //     isTitle: true,
              //   ),
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => ReviewCart(),
              //       ),
              //     );
              //     cart.addReviewCartData(
              //         cartId: widget.product!.productname!,
              //         cartName: widget.product!.productname!,
              //         cartPrice: widget.product!.productprice!);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
