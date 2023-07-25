import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_shop/components/auth/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 117, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 70,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-5.0),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black38,
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.deepOrange.shade700,
                      ),
                      child: const Text(
                        'Minha Loja',
                        style: TextStyle(
                          fontFamily: 'Anton',
                          fontSize: 45,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const AuthForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
