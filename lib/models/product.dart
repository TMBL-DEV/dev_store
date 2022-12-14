import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_store/models/hive/hive_product.dart';
import 'package:dev_store/services/firebase_storage_service.dart';

class Product {
  String _id;
  String name;
  String description;
  List<String> imagePaths;
  double basePrice;

  Product(
    this._id, {
    required this.name,
    required this.description,
    required this.imagePaths,
    required this.basePrice,
  });

  String getId() {
    return _id;
  }

  factory Product.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    List paths = snapshot.get('imagePaths');

    return Product(
      snapshot.id,
      name: snapshot.get('name'),
      description: snapshot.get('description'),
      imagePaths: paths.map((item) => item as String).toList(),
      basePrice: snapshot.get('basePrice'),
    );
  }

  factory Product.fromHive(HiveProduct product) {
    return Product(
      product.getId(),
      name: product.name,
      description: product.description,
      imagePaths: product.imagePaths,
      basePrice: product.basePrice ?? 0,
    );
  }

  Future<String> getPictureUrlFromKey(int imagePathKey) {
    return FirebaseStorageService.instance
        .getDownloadUrlFromPath(path: imagePaths[imagePathKey]);
  }
}
