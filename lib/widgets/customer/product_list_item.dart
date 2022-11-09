import 'package:dev_store/models/product.dart';
import 'package:dev_store/services/cart_service.dart';
import 'package:dev_store/widgets/future_network_image.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatefulWidget {
  final Product _product;
  final bool buyable;
  const ProductListItem(this._product, {required this.buyable, super.key});

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  late FutureBuilder productImage;

  @override
  void initState() {
    super.initState();
    productImage = networkImageWithPlaceHolder(
      promisedUrl: widget._product.getPictureUrlFromKey(0),
    );
  }

  void addToCart(Product product) {
    const snackBar = SnackBar(
      content: Text('added to cart'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    CartService.instance.add(product: product);
  }

  @override
  Widget build(BuildContext context) {
    Product product = widget._product;
    bool buyable = widget.buyable;

    return ListTile(
      title: Text(product.name),
      subtitle: Text(product.description, maxLines: 1),
      leading: productImage,
      onTap: () => showProduct(product),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buyable
              ? InkWell(
                  child: const Icon(
                    Icons.add_box_rounded,
                    color: Colors.green,
                  ),
                  onTap: () => addToCart(product),
                )
              : InkWell(
                  child: const Icon(
                    Icons.add_box_rounded,
                    color: Colors.grey,
                  ),
                  onTap: () => null,
                ),
          Text("€${product.basePrice}")
        ],
      ),
    );
  }

  void showProduct(Product product) {
    Navigator.pushNamed(context, '/product', arguments: {'product': product});
  }
}
