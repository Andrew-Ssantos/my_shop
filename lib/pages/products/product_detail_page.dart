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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // iconTheme: Theme.of(context).iconTheme,
            backgroundColor: Theme.of(context).colorScheme.primary,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(product.name),
              background: Stack(
                fit: StackFit.passthrough,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 10),
                Text(
                  'R\$ ${product.price}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
