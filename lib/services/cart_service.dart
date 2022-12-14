import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_store/models/hive/hive_product.dart';
import 'package:dev_store/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class CartService {
  static final CartService instance = CartService._internal();

  late Box<HiveProduct> box;

  factory CartService() {
    return instance;
  }

  CartService._internal();

  Future openBox() async {
    box = await Hive.openBox('cart');
  }

  void add({required Product product}) {
    var foundProduct = box.get(product.getId());
    int amountInCart = 1;

    if (foundProduct != null) {
      amountInCart += foundProduct.amountInCart;
    }

    box.put(
      product.getId(),
      HiveProduct(product.getId(),
          name: product.name,
          description: product.description,
          imagePaths: product.imagePaths,
          amountInCart: amountInCart,
          basePrice: product.basePrice),
    );
  }

  void remove(String productId) {
    box.delete(productId);
  }

  double getTotalPrice(String productId) {
    // var totalPrice = 0;
    // var results = box.values.forEach((element) {
    //   totalPrice += element.
    // });
    return 0.00;
  }

  Future<String> placeOrder(List<HiveProduct> products) async {
    return (await FirebaseFirestore.instance.collection('orders').add({
      'userId': FirebaseAuth.instance.currentUser?.uid,
      'lines': products.map((prod) {
        return prod.toJson();
      }).toList(),
      'paymentState': 'OPEN',
      'paid_at': DateTime.now().toUtc(),
    }))
        .id;
  }
}
