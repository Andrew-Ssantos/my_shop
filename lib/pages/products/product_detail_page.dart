import 'package:flutter/material.dart';
import 'package:my_shop/models/product/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          product.name,
          style: const TextStyle(color: Colors.white),
          softWrap: true,
          maxLines: 2,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'R\$ ${product.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
