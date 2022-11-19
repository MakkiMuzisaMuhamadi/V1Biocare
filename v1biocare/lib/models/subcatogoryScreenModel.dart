import '../firebaseServices/firebaseservice.dart';

class SubCategory {
  SubCategory({this.subcategoryname, this.category, this.image});

  SubCategory.fromJson(Map<String, Object?> json)
      : this(
          category: json['category']! as String,
          subcategoryname: json['subcategoryname']! as String,
          image: json['image']! as String,
        );

  final String? subcategoryname;
  final String? category;
  final String? image;

  Map<String, Object?> toJson() {
    return {
      'subcategoryname': subcategoryname,
      'image': image,
      'category': category,
    };
  }
}

FirebaseService _service = FirebaseService();
subcategoryCollection(selectedcat) {
  return _service.subcategory
      .where('approved', isEqualTo: true)
      .where('category', isEqualTo: selectedcat)
      .withConverter<SubCategory>(
        fromFirestore: (snapshot, _) => SubCategory.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );
}
