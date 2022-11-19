import 'package:v1biocare/Widgets/productWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../models/subcatogoryScreenModel.dart';

class SubCategoryWidget extends StatefulWidget {
  final String? selectedcat;
  const SubCategoryWidget({super.key, this.selectedcat});

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirestoreListView<SubCategory>(
        query: subcategoryCollection(widget.selectedcat),
        itemBuilder: (context, snapshot) {
          SubCategory subcategory = snapshot.data();
          return ExpansionTile(
            title: Text(subcategory.subcategoryname!),
            children: [
              ProductmodelWidget(
                selectedsubcat: subcategory.subcategoryname,
              )
            ],
          );
        },
      ),
    );
  }
}
