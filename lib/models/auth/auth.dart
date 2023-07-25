import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/data/store.dart';
import 'package:my_shop/exceptions/auth_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _userId;
  DateTime? _expiresTokenDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiresTokenDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get userId {
    return isAuth ? _userId : null;
  }

  Future<void> _authenticate(
      String email, String password, String urlFrament) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFrament?key=AIzaSyD9gMy4GRMWz8AO45YsUTow95Jey9yd_Zo';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );

    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _userId = body['localId'];

      _expiresTokenDate = DateTime.now().add(
        Duration(seconds: int.parse(body['expiresIn'])),
      );

      Store.saveMap('userData', {
        'token': _token,
        'email': _email,
        'userId': _userId,
        'expiresTokenDate': _expiresTokenDate!.toIso8601String(),
      });

      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Store.getMap('userData');

    if (userData.isEmpty) return;

    final expireDate = DateTime.parse(userData['expiresTokenDate']);
    if (expireDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _userId = userData['userId'];
    _expiresTokenDate = expireDate;

    _autoLogout();
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  logout() {
    _token = null;
    _email = null;
    _userId = null;
    _expiresTokenDate = null;
    _clearLogoutTimer();
    Store.remove('userData').then((_) {
      notifyListeners();
    });
    notifyListeners();
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeToLogout =
        _expiresTokenDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToLogout ?? 0), logout);
  }
}
