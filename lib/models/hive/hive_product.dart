import 'dart:ffi';

import 'package:hive/hive.dart';
part 'hive_product.g.dart';

@HiveType(typeId: 0)
class HiveProduct extends HiveObject {
  @HiveField(0)
  final String _id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<String> imagePaths;
  @HiveField(4)
  int amountInCart;

  HiveProduct(
    this._id, {
    required this.name,
    required this.description,
    required this.imagePaths,
    this.amountInCart = 1,
  });

  String getId() {
    return _id;
  }

  // Float
}
