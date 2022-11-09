import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_store/models/product.dart';
import 'package:dev_store/models/supplier.dart';
import 'package:dev_store/widgets/appbar.dart';
import 'package:dev_store/widgets/customer/product_list_item.dart';
import 'package:dev_store/widgets/default_page_container.dart';
import 'package:flutter/material.dart';

class SupplierProductsScreen extends StatefulWidget {
  // final Supplier supplier;
  const SupplierProductsScreen({super.key});

  @override
  State<SupplierProductsScreen> createState() => _SupplierProductsScreenState();
}

class _SupplierProductsScreenState extends State<SupplierProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    if (!arguments.containsKey('supplier')) {
      var arg = arguments['supplier'];
      return Scaffold(
        appBar: personalBar(title: 'DevStore supplier🔥'),
        body: defaultPageContainer(
          child: Text("a"),
        ),
      );
    }

    Supplier supplier = arguments['supplier'];

    return Scaffold(
      appBar: personalBar(title: "DevStore ${supplier.name}🔥"),
      body: defaultPageContainer(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("products")
              .where('supplierId', isEqualTo: supplier.getId())
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              // dragStartBehavior: ,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return ProductListItem(
                  Product.fromDocumentSnapshot(document),
                  buyable: true,
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
