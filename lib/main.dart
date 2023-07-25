import 'package:flutter/material.dart';
import 'package:my_shop/models/auth/auth.dart';
import 'package:my_shop/models/cart/cart.dart';
import 'package:my_shop/models/order/order_list.dart';
import 'package:my_shop/models/product/product_list.dart';
import 'package:my_shop/pages/auth/auth_or_home_page.dart';
import 'package:my_shop/pages/cart_page.dart';
import 'package:my_shop/pages/orders_page.dart';
import 'package:my_shop/pages/products/product_detail_page.dart';
import 'package:my_shop/pages/products/product_form_page.dart';
import 'package:my_shop/pages/products/products_page.dart';
import 'package:my_shop/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (ctx, auth, previousProductList) {
            return ProductList(
              auth.token ?? '',
              auth.userId ?? '',
              previousProductList?.items ?? [],
            );
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (ctx, auth, previousOrderList) {
            return OrderList(
              auth.token ?? '',
              auth.userId ?? '',
              previousOrderList?.items ?? [],
            );
          },
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
            primary: Colors.deepPurple,
            secondary: Colors.lightBlue,
          ),
          fontFamily: 'Lato',
          useMaterial3: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        // home: ProductsOverviewPage(),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHomePage(),
          AppRoutes.PRODUCTS: (ctx) => const ProductPage(),
          AppRoutes.PRODUCT_DETAIL: (ctx) => const ProductDetailPage(),
          AppRoutes.PRODUCT_FORM: (ctx) => const ProductFormPage(),
          AppRoutes.CART: (ctx) => const CartPage(),
          AppRoutes.ORDERS: (ctx) => const OrdersPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
