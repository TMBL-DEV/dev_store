import 'package:dev_store/models/hive/hive_product.dart';
import 'package:dev_store/models/product.dart';
import 'package:dev_store/services/cart_service.dart';
import 'package:dev_store/widgets/future_network_image.dart';
import 'package:flutter/material.dart';

class CartListItem extends StatefulWidget {
  final Product _product;
  const CartListItem(this._product, {super.key});

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  late FutureBuilder productImage;

  @override
  void initState() {
    super.initState();
    productImage = networkImageWithPlaceHolder(
      promisedUrl: widget._product.getPictureUrlFromKey(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    Product product = widget._product;
    int amountInCart =
        CartService().box.get(product.getId())?.amountInCart ?? 0;
    return ListTile(
      title: Text(
        product.name,
        style: const TextStyle(
          fontSize: 13,
        ),
        textAlign: TextAlign.center,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            child: const Icon(Icons.remove),
            onTap: () => changeAmountToOrder(product.getId(), -1),
          ),
          Text(amountInCart.toString()),
          InkWell(
            child: const Icon(Icons.add),
            onTap: () => changeAmountToOrder(product.getId(), 1),
          ),
        ],
      ),
      leading: productImage,
      onTap: () => showProduct(product),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            child: const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
            onTap: () {
              changeAmountToOrder(product.getId(),
                  -(CartService().box.get(product.getId())?.amountInCart ?? 0));
            },
          ),
          Text('€ ${product.basePrice}')
        ],
      ),
    );
  }

  void changeAmountToOrder(String productId, int amount) {
    HiveProduct? product = CartService().box.get(productId);
    product?.amountInCart += amount;

    if (product != null) {
      if (product.amountInCart <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('removed product from cart'),
        ));

        CartService().remove(productId);

        return;
      }

      CartService().box.put(productId, product);
    }
  }

  void showProduct(Product product) {
    Navigator.pushNamed(context, '/product', arguments: {'product': product});
  }
}
