import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:iconly/iconly.dart';

import '../Widgets/SubCategoryScreenWidget.dart';
import '../models/category_Model.dart';
import 'SearchPage.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static const String id = 'categories-Screen';

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? selectedCategory;
  String title = 'Categories';

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          // ignore: prefer_if_null_operators
          selectedCategory == null ? title : selectedCategory!,
          style: const TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          // Navigate to the Search Screen
          IconButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SearchPage())),
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              IconlyBold.buy,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 90,
            // color: Colors.grey.shade400,
            child: FirestoreListView<Category>(
              query: categoryCollection,
              itemBuilder: (context, snapshot) {
                Category category = snapshot.data();
                return InkWell(
                  onTap: () {
                    setState(() {
                      title = category.catName!;
                      selectedCategory = category.catName;
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(imageUrl: category.image!),
                      ),
                      Text(
                        category.catName!,
                        style: TextStyle(
                            fontSize: 15,
                            color: selectedCategory == category.catName
                                ? Colors.green
                                : Colors.black,
                            fontWeight: selectedCategory == category.catName
                                ? FontWeight.bold
                                : FontWeight.w300,
                            fontStyle: selectedCategory == category.catName
                                ? FontStyle.italic
                                : FontStyle.normal),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SubCategoryWidget(
            selectedcat: selectedCategory,
          )
        ],
      ),
    );
  }
}
