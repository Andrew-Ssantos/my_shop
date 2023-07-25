import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/models/order/order.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({
    super.key,
    required this.order,
  });

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final itemsHeigth = (widget.order.products.length * 24.0) + 15;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 225),
      height: _isExpanded ? itemsHeigth + 80 : 80,
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.date),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: const Icon(Icons.expand_more),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 225),
              height: _isExpanded ? itemsHeigth : 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: ListView(
                children: widget.order.products.map(
                  (product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name,
                            softWrap: true,
                            maxLines: 3,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.start,
                            '${product.quantity} x R\$ ${product.price}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
