import 'package:flutter/material.dart';
import 'package:my_shop/models/auth/auth.dart';
import 'package:my_shop/pages/auth/auth_page.dart';
import 'package:my_shop/pages/products/products_overview_page.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text('Ocorreu um erro!'));
        } else {
          return auth.isAuth ? const ProductsOverviewPage() : const AuthPage();
        }
      },
    );
  }
}
