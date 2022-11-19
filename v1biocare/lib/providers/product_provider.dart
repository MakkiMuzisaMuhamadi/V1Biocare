import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/productModel.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;

  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      image: element.get("image"),
      productname: element.get("productname"),
      productprice: element.get("productprice"),
      productDetails: element.get("productDetails"),
      subcategory: element.get("subcategory"),
      id: element.get("id"),
    );
    search.add(productModel!);
  }

//   /////////////// herbsProduct ///////////////////////////////
//   List<ProductModel> herbsProductList = [];

//   fatchHerbsProductData() async {
//     List<ProductModel> newList = [];

//     QuerySnapshot value =
//         await FirebaseFirestore.instance.collection("HerbsProduct").get();

//     value.docs.forEach(
//       (element) {
//         productModels(element);

//         newList.add(productModel);
//       },
//     );
//     herbsProductList = newList;
//     notifyListeners();
//   }

//   List<ProductModel> get getHerbsProductDataList {
//     return herbsProductList;
//   }

// //////////////// Fresh Product ///////////////////////////////////////
//   List<ProductModel> freshProductList = [];

//   fatchFreshProductData() async {
//     List<ProductModel> newList = [];

//     QuerySnapshot value =
//         await FirebaseFirestore.instance.collection("FreshProduct").get();

//     value.docs.forEach(
//       (element) {
//         productModels(element);
//         newList.add(productModel);
//       },
//     );
//     freshProductList = newList;
//     notifyListeners();
//   }

//   List<ProductModel> get getFreshProductDataList {
//     return freshProductList;
//   }

// //////////////// Root Product ///////////////////////////////////////
//   List<ProductModel> rootProductList = [];

//   fatchRootProductData() async {
//     List<ProductModel> newList = [];

//     QuerySnapshot value =
//         await FirebaseFirestore.instance.collection("RootProduct").get();

//     value.docs.forEach(
//       (element) {
//         productModels(element);
//         newList.add(productModel);
//       },
//     );
//     rootProductList = newList;
//     notifyListeners();
//   }

//   List<ProductModel> get getRootProductDataList {
//     return rootProductList;
//   }

  /////////////////// Search Return ////////////
  List<ProductModel> get gerAllProductSearch {
    return search;
  }
}
