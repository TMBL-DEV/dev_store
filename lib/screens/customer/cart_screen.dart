import 'package:dev_store/models/product.dart';
import 'package:dev_store/services/cart_service.dart';
import 'package:dev_store/widgets/customer/cart_list_item.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void placeOrder() {
    CartService().placeOrder(CartService().box.values.toList()).then((value) {
      //todo some logic to clear your cart
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CartService.instance.box.listenable(),
      builder: (context, box, widget) {
        return box.values.isEmpty
            ? const Text('nothing in your cart')
            : Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      children: box.values.toList().map((e) {
                        return CartListItem(Product.fromHive(e));
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => placeOrder(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            "order",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
