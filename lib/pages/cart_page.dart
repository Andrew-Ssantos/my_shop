import 'package:flutter/material.dart';
import 'package:my_shop/components/widgets/cart_item_widget.dart';
import 'package:my_shop/models/cart/cart.dart';
import 'package:my_shop/models/order/order_list.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: const Text(
          'Meu carrinho',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i]),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .primaryTextTheme
                            .headlineLarge
                            ?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CartTextButton(cart: cart),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartTextButton extends StatefulWidget {
  const CartTextButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<CartTextButton> createState() => _CartTextButtonState();
}

class _CartTextButtonState extends State<CartTextButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: widget.cart.itemsCount == 0
                ? null
                : () async {
                    setState(() => _isLoading = true);
                    await Provider.of<OrderList>(
                      context,
                      listen: false,
                    ).addOrder(widget.cart);

                    widget.cart.clearCart();
                    setState(() => _isLoading = false);
                  },
            child: const Text('COMPRAR'),
          );
  }
}
