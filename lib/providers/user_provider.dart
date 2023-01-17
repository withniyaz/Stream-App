import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:stream_app/models/stream/user_model.dart';
import 'package:stream_app/services/api_service.dart';
import 'package:stream_app/services/navigation_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService _provider = ApiService();
  final NavigationSerivce _navigation = NavigationSerivce();
  final storage = const FlutterSecureStorage();
  User? user;

  //Get Current User Session
  Future getSession() async {
    final Response res = await _provider.get('/auth/session');
    dynamic data = jsonDecode(res.body);
    if (res.statusCode == 200 && data["data"] != null) {
      user = User.fromJson(data['data']);
      return _navigation.pushNamedAndRemoveUntil(
        'Home',
      );
    } else {
      await storage.delete(key: 'token');
      return _navigation.pushNamedAndRemoveUntil('Login');
    }
  }

  //Update User Details
  updateUser(User data) {
    user = data;
    notifyListeners();
    return _navigation.pushNamedAndRemoveUntil('Home');
  }

  //Clear User Detaild
  clearUser() {
    user = null;
    notifyListeners();
  }
}
