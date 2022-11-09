import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_store/models/product.dart';
import 'package:dev_store/models/supplier.dart';
import 'package:dev_store/widgets/customer/product_list_item.dart';
import 'package:dev_store/widgets/customer/supplier_list_item.dart';
import 'package:flutter/material.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("suppliers").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            return SupplierListItem(
              Supplier.fromDocumentSnapshot(document),
            );
          }).toList(),
        );
      },
    );
  }
}
