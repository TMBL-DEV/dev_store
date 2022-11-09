import 'package:dev_store/models/product.dart';
import 'package:dev_store/models/supplier.dart';
import 'package:flutter/material.dart';

class SupplierListItem extends StatefulWidget {
  final Supplier supplier;

  const SupplierListItem(this.supplier, {super.key});

  @override
  State<SupplierListItem> createState() => _SupplierListItemState();
}

class _SupplierListItemState extends State<SupplierListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Supplier supplier = widget.supplier;

    return ListTile(
      title: Text(supplier.name),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            child: const Icon(
              Icons.arrow_circle_right,
              color: Colors.green,
            ),
            onTap: () => Navigator.pushNamed(
              context,
              '/customer/supplier/products',
              arguments: {'supplier': supplier},
            ),
          )
        ],
      ),
      onTap: () => print(null),
    );
  }

  void showProduct(Product product) {
    Navigator.pushNamed(context, '/product', arguments: {'product': product});
  }
}
