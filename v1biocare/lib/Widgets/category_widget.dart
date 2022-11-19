import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:iconly/iconly.dart';

import '../Screens/mainscreen.dart';
import '../models/category_Model.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: FirestoreListView<Category>(
                      scrollDirection: Axis.horizontal,
                      query: categoryCollection,
                      itemBuilder: (context, snapshot) {
                        Category category = snapshot.data();
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: ActionChip(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            backgroundColor:
                                _selectedCategory == category.catName
                                    ? Colors.green.shade900
                                    : Colors.grey,
                            label: Text(
                              category.catName!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: _selectedCategory == category.catName
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedCategory = category.catName;
                              });
                            },
                          ),
                        );
                        ;
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const MainScreen(index: 1),
                          ),
                        );
                      },
                      icon: const Icon(IconlyLight.arrow_down),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
