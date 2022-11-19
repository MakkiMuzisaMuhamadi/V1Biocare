import 'package:flutter/cupertino.dart';

import '../firebaseServices/firebaseservice.dart';

class ProductModel with ChangeNotifier {
  ProductModel(
      {this.productname,
      this.id,
      this.subcategory,
      this.image,
      this.productprice,
      this.productDetails,
      this.productUnit});

  ProductModel.fromJson(Map<String, dynamic?> json)
      : this(
          subcategory: json['subcategory']! as String,
          // id: json['id'] as String,
          productname: json['productname']! as String,
          productDetails: json['productDetails']! as String,
          productprice: double.tryParse(json['productprice']) ?? 0.0,
          image: json['image']! as String,
        );

  final String? productname;
  final String? productDetails;
  final double? productprice;
  final String? subcategory;
  final String? image;
  final String? productUnit;
  final String? id;

  Map<String, Object?> toJson() {
    return {
      'productname': productname,
      'productDetails': productDetails,
      'productprice': productprice,
      'image': image,
      'subcategory': subcategory,
    };
  }
}

FirebaseService _service = FirebaseService();
productCollection({selectedSubcat}) {
  return _service.products
      .where('active', isEqualTo: true)
      .where('subcategory', isEqualTo: selectedSubcat)
      .withConverter<ProductModel>(
        fromFirestore: (snapshot, _) => ProductModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
